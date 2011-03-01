From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 01 Mar 2011 18:25:13 +0000
Subject: Re: [RFC/PATCH 4/6] FBDEV: JZ4740: Add Smart LCD controller support
Message-Id: <4D6D3A09.4020602@metafoo.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <56c410783be268e00d09e2c9450e56925bd815a8.1298980528.git.mcuelenaere@gmail.com>
In-Reply-To: <56c410783be268e00d09e2c9450e56925bd815a8.1298980528.git.mcuelenaere@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 03/01/2011 06:25 PM, Maurus Cuelenaere wrote:
>> On 03/01/2011 01:06 PM, Maurus Cuelenaere wrote:
>>> This patch adds SLCD support to the Ingenic Jz4740 framebuffer driver.
>>> Besides adding the new LCD types to the platform data, this adds chip select
>>> and register select active low support (SLCD only). Also, this exports some
>>> functions related to starting and stopping the SLCD image transfer and sending
>>> commands.
>>>
>>> A lot of this code was based on work by Maarten ter Huurne:
>>> https://github.com/mthuurne/opendingux-kernel/commit/3dba5b5e7a868b1067acae8d1b5a19121b77bc6a
>>>
>>> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
>> Looks mostly good :)
>>
>>> ---
>>>  arch/mips/include/asm/mach-jz4740/jz4740_fb.h |   33 ++
>>>  drivers/video/jz4740_fb.c                     |  435 ++++++++++++++++++++++---
>>>  2 files changed, 429 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_fb.h b/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
>>> index 6a50e6f..eaaac43 100644
>>> --- a/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
>>> +++ b/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
>>> @@ -30,6 +30,13 @@ enum jz4740_fb_lcd_type {
>>>  	JZ_LCD_TYPE_DUAL_COLOR_STN = 10,
>>>  	JZ_LCD_TYPE_DUAL_MONOCHROME_STN = 11,
>>>  	JZ_LCD_TYPE_8BIT_SERIAL = 12,
>>> +
>>> +	JZ_SLCD_TYPE_PARALLEL_8_BIT = 1 | (1 << 5),
>>> +	JZ_SLCD_TYPE_PARALLEL_16_BIT = 0 | (1 << 5),
>>> +	JZ_SLCD_TYPE_PARALLEL_18_BIT = 2 | (1 << 5),
>>> +	JZ_SLCD_TYPE_SERIAL_8_BIT = 1 | (3 << 5),
>>> +	JZ_SLCD_TYPE_SERIAL_16_BIT = 0 | (3 << 5),
>>> +	JZ_SLCD_TYPE_SERIAL_18_BIT = 2 | (3 << 5),
>> I would prefer
>> JZ_LCD_TYPE_SLCD_...
> 
> Ok.
> 
>>>  };
>> Maybe add
>> #define JZ_LCD_TYPE_SLCD (1 << 5)
>> #define JZ_LCD_TYPE_SLCD_SERIAL (JZ_LCD_TYPE_SLCD | (1 << 6))
> 
> Ok.
> 
>>
>>>  
>>>  #define JZ4740_FB_SPECIAL_TFT_CONFIG(start, stop) (((start) << 16) | (stop))
>>> @@ -62,6 +69,32 @@ struct jz4740_fb_platform_data {
>>>  
>>>  	unsigned pixclk_falling_edge:1;
>>>  	unsigned date_enable_active_low:1;
>>> +	unsigned chip_select_active_low:1;
>>> +	unsigned register_select_active_low:1;
>>>  };
>>>  
>>> +struct platform_device;
>>> +
>>> +/*
>>> + * JzFB SLCD related functions
>>> + *
>>> + * jz4740_fb_slcd_disable_transfer: disables the current image transfer going
>>> + *       on between memory and the LCD controller
>>> + * jz4740_fb_slcd_enable_transfer: the reverse operation of the above
>>> + * jz4740_fb_slcd_send_cmd: sends a command without any data to the LCD
>>> + *       controller
>>> + * jz4740_fb_slcd_send_cmd_data: sends a command with a data argument to the LCD
>>> + *       controller
>>> + *
>>> + * These functions can sleep and thus should not be called from an atomic
>>> + * context. Also, make sure you disable the SLCD image transfer *before* sending
>>> + * any commands and do not forget to re-enable it.
>>> + */
>>> +extern void jz4740_fb_slcd_disable_transfer(struct platform_device *pdev);
>>> +extern void jz4740_fb_slcd_enable_transfer(struct platform_device *pdev);
>>> +extern void jz4740_fb_slcd_send_cmd_data(struct platform_device *pdev,
>>> +					 unsigned int cmd, unsigned int data);
>>> +extern void jz4740_fb_slcd_send_cmd(struct platform_device *pdev,
>>> +				    unsigned int cmd);
>>> +
>>>  #endif
>>> diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
>>> index 2f3ea57..4064812 100644
>>> --- a/drivers/video/jz4740_fb.c
>>> +++ b/drivers/video/jz4740_fb.c
>>> @@ -26,6 +26,7 @@
>>>  
>>>  #include <linux/dma-mapping.h>
>>>  
>>> +#include <asm/mach-jz4740/dma.h>
>>>  #include <asm/mach-jz4740/jz4740_fb.h>
>>>  #include <asm/mach-jz4740/gpio.h>
>>>  
>>> @@ -107,6 +108,40 @@
>>>  
>>>  #define JZ_LCD_STATE_DISABLED BIT(0)
>>>  
>>> +#define JZ_REG_SLCD_CFG		0xA0
>>> +#define JZ_REG_SLCD_CTRL	0xA4
>>> +#define JZ_REG_SLCD_STATE	0xA8
>>> +#define JZ_REG_SLCD_DATA	0xAC
>>> +#define JZ_REG_SLCD_FIFO	0xB0
>>> +
>>> +#define JZ_SLCD_CFG_BURST_8_WORD	BIT(14)
>>> +#define JZ_SLCD_CFG_DWIDTH_MASK		(7 << 10)
>>> +#define JZ_SLCD_CFG_DWIDTH_18		(0 << 10)
>>> +#define JZ_SLCD_CFG_DWIDTH_16		(1 << 10)
>>> +#define JZ_SLCD_CFG_DWIDTH_8_x3		(2 << 10)
>>> +#define JZ_SLCD_CFG_DWIDTH_8_x2		(3 << 10)
>>> +#define JZ_SLCD_CFG_DWIDTH_8_x1		(4 << 10)
>>> +#define JZ_SLCD_CFG_DWIDTH_9_x2		(7 << 10)
>>> +#define JZ_SLCD_CFG_CWIDTH_MASK		(3 << 8)
>>> +#define JZ_SLCD_CFG_CWIDTH(n)		((n) << 8)
>>> +#define JZ_SLCD_CFG_CWIDTH_16BIT	(0 << 8)
>>> +#define JZ_SLCD_CFG_CWIDTH_8BIT		(1 << 8)
>>> +#define JZ_SLCD_CFG_CWIDTH_18BIT	(2 << 8)
>>> +#define JZ_SLCD_CFG_CS_ACTIVE_HIGH	BIT(4)
>>> +#define JZ_SLCD_CFG_RS_CMD_HIGH		BIT(3)
>>> +#define JZ_SLCD_CFG_CLK_ACTIVE_RISING	BIT(1)
>>> +#define JZ_SLCD_CFG_TYPE_SERIAL		BIT(0)
>>> +
>>> +#define JZ_SLCD_CTRL_DMA_EN		(1 << 0)
>>> +
>>> +#define JZ_SLCD_STATE_BUSY		(1 << 0)
>>> +
>>> +#define JZ_SLCD_DATA_RS_DATA		(0 << 31)
>>> +#define JZ_SLCD_DATA_RS_COMMAND		(1 << 31)
>>> +
>>> +#define JZ_SLCD_FIFO_RS_DATA		(0 << 31)
>>> +#define JZ_SLCD_FIFO_RS_COMMAND		(1 << 31)
>>> +
>>>  struct jzfb_framedesc {
>>>  	uint32_t next;
>>>  	uint32_t addr;
>>> @@ -118,6 +153,7 @@ struct jzfb {
>>>  	struct fb_info *fb;
>>>  	struct platform_device *pdev;
>>>  	void __iomem *base;
>>> +	phys_t phys_base;
>>>  	struct resource *mem;
>>>  	struct jz4740_fb_platform_data *pdata;
>>>  
>>> @@ -126,6 +162,7 @@ struct jzfb {
>>>  	dma_addr_t vidmem_phys;
>>>  	struct jzfb_framedesc *framedesc;
>>>  	dma_addr_t framedesc_phys;
>>> +	struct jz4740_dma_chan *slcd_dma;
>>>  
>>>  	struct clk *ldclk;
>>>  	struct clk *lpclk;
>>> @@ -136,6 +173,9 @@ struct jzfb {
>>>  	uint32_t pseudo_palette[16];
>>>  };
>>>  
>>> +#define JZFB_IS_SLCD(jzfb) ((jzfb)->pdata->lcd_type & (1 << 5))
>>> +#define JZFB_IS_SLCD_SERIAL_TYPE(jzfb) ((jzfb)->pdata->lcd_type & (2 << 5))
>> These two should be static inline bool.
> 
> Ok.
> 
>>> +static void send_panel_command(struct jzfb *jzfb, u32 cmd)
>> You've been using u{16,32} throughout the whole patch, since the existing code
>> uses uint_{16,32}t you should stick to them.
> 
> Ok, probably a restant from the original opendingux patch.
> 
>>> +{
>>> +	u16 slcd_cfg = readw(jzfb->base + JZ_REG_SLCD_CFG);
>>> +
>>> +	jzfb_slcd_wait(jzfb);
>>> +
>>> +	switch (slcd_cfg & JZ_SLCD_CFG_CWIDTH_MASK) {
>>> +	case JZ_SLCD_CFG_CWIDTH_8BIT:
>>> +		writel(JZ_SLCD_DATA_RS_COMMAND | ((cmd & 0xff00) >> 8),
>>> +		       jzfb->base + JZ_REG_SLCD_DATA);
>>> +		jzfb_slcd_wait(jzfb);
>>> +		writel(JZ_SLCD_DATA_RS_COMMAND | (cmd & 0xff),
>>> +		       jzfb->base + JZ_REG_SLCD_DATA);
>>> +		break;
>>> +
>>> +	case JZ_SLCD_CFG_CWIDTH_16BIT:
>>> +		writel(JZ_SLCD_DATA_RS_COMMAND | (cmd & 0xffff),
>>> +		       jzfb->base + JZ_REG_SLCD_DATA);
>>> +		break;
>>> +
>>> +	case JZ_SLCD_CFG_CWIDTH_18BIT:
>>> +		writel(JZ_SLCD_DATA_RS_COMMAND | ((cmd & 0xff00) << 2) |
>>> +		       ((cmd & 0xff) << 1), jzfb->base + JZ_REG_SLCD_DATA);
>>> +		break;
>>> +	}
>>> +}
>>> +
>>> +static void send_panel_data(struct jzfb *jzfb, u32 data)
>>> +{
>>> +	u16 slcd_cfg = readw(jzfb->base + JZ_REG_SLCD_CFG);
>>> +
>>> +	switch (slcd_cfg & JZ_SLCD_CFG_DWIDTH_MASK) {
>>> +	case JZ_SLCD_CFG_DWIDTH_18:
>>> +	case JZ_SLCD_CFG_DWIDTH_9_x2:
>>> +		data = ((data & 0xff) << 1) | ((data & 0xff00) << 2);
>>> +		data = ((data << 6) & 0xfc0000) | ((data << 4) & 0xfc00) |
>>> +		       ((data << 2) & 0x0000fc);
>>> +		break;
>>> +
>>> +	case JZ_SLCD_CFG_DWIDTH_16:
>>> +	default:
>>> +		data &= 0xffff;
>>> +		break;
>>> +	}
>>> +
>>> +	jzfb_slcd_wait(jzfb);
>>> +	writel(JZ_SLCD_DATA_RS_DATA | data, jzfb->base + JZ_REG_SLCD_DATA);
>>> +}
>>> +
>>> +void jz4740_fb_slcd_disable_transfer(struct platform_device *pdev)
>>> +{
>>> +	struct jzfb *jzfb = platform_get_drvdata(pdev);
>>> +
>>> +	mutex_lock(&jzfb->lock);
>>> +
>>> +	if (jzfb->is_enabled) {
>>> +		jz4740_dma_disable(jzfb->slcd_dma);
>>> +		jzfb_slcd_wait(jzfb);
>>> +	}
>>> +
>>> +	mutex_unlock(&jzfb->lock);
>>> +}
>>> +EXPORT_SYMBOL_GPL(jz4740_fb_slcd_disable_transfer);
>>> +
>>> +void jz4740_fb_slcd_enable_transfer(struct platform_device *pdev)
>>> +{
>>> +	struct jzfb *jzfb = platform_get_drvdata(pdev);
>>> +
>>> +	mutex_lock(&jzfb->lock);
>>> +
>>> +	if (jzfb->is_enabled)
>>> +		jzfb_slcd_start_dma(jzfb);
>>> +
>>> +	mutex_unlock(&jzfb->lock);
>>> +}
>>> +EXPORT_SYMBOL_GPL(jz4740_fb_slcd_enable_transfer);
>>> +
>>> +void jz4740_fb_slcd_send_cmd_data(struct platform_device *pdev,
>>> +				  unsigned int cmd, unsigned int data)
>>> +{
>>> +	struct jzfb *jzfb = platform_get_drvdata(pdev);
>>> +
>>> +	mutex_lock(&jzfb->lock);
>>> +
>>> +	if (!jzfb->is_enabled)
>>> +		clk_enable(jzfb->ldclk);
>>> +
>>> +	send_panel_command(jzfb, cmd);
>>> +	send_panel_data(jzfb, data);
>>> +
>>> +	if (!jzfb->is_enabled) {
>>> +		jzfb_slcd_wait(jzfb);
>>> +		clk_disable(jzfb->ldclk);
>>> +	}
>>> +
>>> +	mutex_unlock(&jzfb->lock);
>>> +}
>>> +EXPORT_SYMBOL_GPL(jz4740_fb_slcd_send_cmd_data);
>>> +
>>> +void jz4740_fb_slcd_send_cmd(struct platform_device *pdev, unsigned int cmd)
>>> +{
>>> +	struct jzfb *jzfb = platform_get_drvdata(pdev);
>>> +
>>> +	mutex_lock(&jzfb->lock);
>>> +
>>> +	if (!jzfb->is_enabled)
>>> +		clk_enable(jzfb->ldclk);
>>> +
>>> +	send_panel_command(jzfb, cmd);
>>> +
>>> +	if (!jzfb->is_enabled) {
>>> +		jzfb_slcd_wait(jzfb);
>>> +		clk_disable(jzfb->ldclk);
>>> +	}
>>> +
>>> +	mutex_unlock(&jzfb->lock);
>>> +}
>>> +EXPORT_SYMBOL_GPL(jz4740_fb_slcd_send_cmd);
>> jz4740_fb_slcd_send_cmd_data and jz4740_fb_slcd_send_cmd are almost identical
>> it might makes sense to merge them.
> 
> Something like
> void jz4740_fb_slcd_send_cmd(struct platform_device *pdev, unsigned int cmd,
> unsigned int data, bool with_data);
> ?
> 
> You can't use data = 0 as "do not send data" as this could be a valid parameter.
> 
>> I don't like the idea of adding a jzfb specific interface for talking to the
>> lcd panels, because it will tightly couple the panel driver to the framebuffer
>> driver and it won't be possible to reuse for some board using the same panel
>> but a different SoC.
>>

I've seen that you are writing quite a few registers at once in the G240400RTSW
driver. So it might makes sense to have a single function which takes an array
of uint32_t, with all these values instead of switching back and forth between
the framebuffer and panel driver.
You could encode whether a certain word is a command or data through the most
upper bit as it is done in the actual register as well.

Something like
void jz4740_fb_slcd_send_cmd(struct device *dev, const uint32_t *data, size_t num)
{
	struct jzfb *jzfb = dev_get_drvdata(dev);
	uint32_t d;

	mutex_lock(&jzfb->lock);

	if (!jzfb->is_enabled)
		clk_enable(jzfb->ldclk);

	for(; num; --num, ++data) {
		d = *data;
		if (d & JZ_SLCD_DATA_RS_CMD)
			d = jz4740_fb_slcd_panel_cmd(d);
		else
			d = jz4740_fb_slcd_panel_daya(d)
		jzfb_slcd_wait(jzfb);
		writel(d, jzfb->base + JZ_REG_SLCD_DATA);	
	}

	if (!jzfb->is_enabled) {
		jzfb_slcd_wait(jzfb);
		clk_disable(jzfb->ldclk);
	}

	mutex_unlock(&jzfb->lock);
}


> 
> Me neither, but the only "good" way forward I see is emulating an SPI interface
> over this..
> Do you think this is acceptable?
> 

Since the driver is not actually talking SPI over the bus I don't think this is
an option.
What might be an option is to provide a generic callback structure for the
panel driver.

struct panel_platform_data {
	void (*panel_write)(void *data, const uint32_t *data, size_t num);
	void *panel_data;
};

So that the panel driver doesn't reference the jzfb driver directly.

- Lars




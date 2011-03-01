From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Tue, 01 Mar 2011 19:00:00 +0000
Subject: Re: [RFC/PATCH 4/6] FBDEV: JZ4740: Add Smart LCD controller support
Message-Id: <4D6D4230.6050408@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <56c410783be268e00d09e2c9450e56925bd815a8.1298980528.git.mcuelenaere@gmail.com>
In-Reply-To: <56c410783be268e00d09e2c9450e56925bd815a8.1298980528.git.mcuelenaere@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

> On 03/01/2011 06:25 PM, Maurus Cuelenaere wrote:
>>> On 03/01/2011 01:06 PM, Maurus Cuelenaere wrote:
>>>> This patch adds SLCD support to the Ingenic Jz4740 framebuffer driver.
>>>> Besides adding the new LCD types to the platform data, this adds chip select
>>>> and register select active low support (SLCD only). Also, this exports some
>>>> functions related to starting and stopping the SLCD image transfer and sending
>>>> commands.
<snip>
>>>> +{
>>>> +	u16 slcd_cfg = readw(jzfb->base + JZ_REG_SLCD_CFG);
>>>> +
>>>> +	jzfb_slcd_wait(jzfb);
>>>> +
>>>> +	switch (slcd_cfg & JZ_SLCD_CFG_CWIDTH_MASK) {
>>>> +	case JZ_SLCD_CFG_CWIDTH_8BIT:
>>>> +		writel(JZ_SLCD_DATA_RS_COMMAND | ((cmd & 0xff00) >> 8),
>>>> +		       jzfb->base + JZ_REG_SLCD_DATA);
>>>> +		jzfb_slcd_wait(jzfb);
>>>> +		writel(JZ_SLCD_DATA_RS_COMMAND | (cmd & 0xff),
>>>> +		       jzfb->base + JZ_REG_SLCD_DATA);
>>>> +		break;
>>>> +
>>>> +	case JZ_SLCD_CFG_CWIDTH_16BIT:
>>>> +		writel(JZ_SLCD_DATA_RS_COMMAND | (cmd & 0xffff),
>>>> +		       jzfb->base + JZ_REG_SLCD_DATA);
>>>> +		break;
>>>> +
>>>> +	case JZ_SLCD_CFG_CWIDTH_18BIT:
>>>> +		writel(JZ_SLCD_DATA_RS_COMMAND | ((cmd & 0xff00) << 2) |
>>>> +		       ((cmd & 0xff) << 1), jzfb->base + JZ_REG_SLCD_DATA);
>>>> +		break;
>>>> +	}
>>>> +}
>>>> +
>>>> +static void send_panel_data(struct jzfb *jzfb, u32 data)
>>>> +{
>>>> +	u16 slcd_cfg = readw(jzfb->base + JZ_REG_SLCD_CFG);
>>>> +
>>>> +	switch (slcd_cfg & JZ_SLCD_CFG_DWIDTH_MASK) {
>>>> +	case JZ_SLCD_CFG_DWIDTH_18:
>>>> +	case JZ_SLCD_CFG_DWIDTH_9_x2:
>>>> +		data = ((data & 0xff) << 1) | ((data & 0xff00) << 2);
>>>> +		data = ((data << 6) & 0xfc0000) | ((data << 4) & 0xfc00) |
>>>> +		       ((data << 2) & 0x0000fc);
>>>> +		break;
>>>> +
>>>> +	case JZ_SLCD_CFG_DWIDTH_16:
>>>> +	default:
>>>> +		data &= 0xffff;
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	jzfb_slcd_wait(jzfb);
>>>> +	writel(JZ_SLCD_DATA_RS_DATA | data, jzfb->base + JZ_REG_SLCD_DATA);
>>>> +}
>>>> +
>>>> +void jz4740_fb_slcd_disable_transfer(struct platform_device *pdev)
>>>> +{
>>>> +	struct jzfb *jzfb = platform_get_drvdata(pdev);
>>>> +
>>>> +	mutex_lock(&jzfb->lock);
>>>> +
>>>> +	if (jzfb->is_enabled) {
>>>> +		jz4740_dma_disable(jzfb->slcd_dma);
>>>> +		jzfb_slcd_wait(jzfb);
>>>> +	}
>>>> +
>>>> +	mutex_unlock(&jzfb->lock);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(jz4740_fb_slcd_disable_transfer);
>>>> +
>>>> +void jz4740_fb_slcd_enable_transfer(struct platform_device *pdev)
>>>> +{
>>>> +	struct jzfb *jzfb = platform_get_drvdata(pdev);
>>>> +
>>>> +	mutex_lock(&jzfb->lock);
>>>> +
>>>> +	if (jzfb->is_enabled)
>>>> +		jzfb_slcd_start_dma(jzfb);
>>>> +
>>>> +	mutex_unlock(&jzfb->lock);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(jz4740_fb_slcd_enable_transfer);
>>>> +
>>>> +void jz4740_fb_slcd_send_cmd_data(struct platform_device *pdev,
>>>> +				  unsigned int cmd, unsigned int data)
>>>> +{
>>>> +	struct jzfb *jzfb = platform_get_drvdata(pdev);
>>>> +
>>>> +	mutex_lock(&jzfb->lock);
>>>> +
>>>> +	if (!jzfb->is_enabled)
>>>> +		clk_enable(jzfb->ldclk);
>>>> +
>>>> +	send_panel_command(jzfb, cmd);
>>>> +	send_panel_data(jzfb, data);
>>>> +
>>>> +	if (!jzfb->is_enabled) {
>>>> +		jzfb_slcd_wait(jzfb);
>>>> +		clk_disable(jzfb->ldclk);
>>>> +	}
>>>> +
>>>> +	mutex_unlock(&jzfb->lock);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(jz4740_fb_slcd_send_cmd_data);
>>>> +
>>>> +void jz4740_fb_slcd_send_cmd(struct platform_device *pdev, unsigned int cmd)
>>>> +{
>>>> +	struct jzfb *jzfb = platform_get_drvdata(pdev);
>>>> +
>>>> +	mutex_lock(&jzfb->lock);
>>>> +
>>>> +	if (!jzfb->is_enabled)
>>>> +		clk_enable(jzfb->ldclk);
>>>> +
>>>> +	send_panel_command(jzfb, cmd);
>>>> +
>>>> +	if (!jzfb->is_enabled) {
>>>> +		jzfb_slcd_wait(jzfb);
>>>> +		clk_disable(jzfb->ldclk);
>>>> +	}
>>>> +
>>>> +	mutex_unlock(&jzfb->lock);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(jz4740_fb_slcd_send_cmd);
>>> jz4740_fb_slcd_send_cmd_data and jz4740_fb_slcd_send_cmd are almost identical
>>> it might makes sense to merge them.
>> Something like
>> void jz4740_fb_slcd_send_cmd(struct platform_device *pdev, unsigned int cmd,
>> unsigned int data, bool with_data);
>> ?
>>
>> You can't use data = 0 as "do not send data" as this could be a valid parameter.
>>
>>> I don't like the idea of adding a jzfb specific interface for talking to the
>>> lcd panels, because it will tightly couple the panel driver to the framebuffer
>>> driver and it won't be possible to reuse for some board using the same panel
>>> but a different SoC.
>>>
> I've seen that you are writing quite a few registers at once in the G240400RTSW
> driver. So it might makes sense to have a single function which takes an array
> of uint32_t, with all these values instead of switching back and forth between
> the framebuffer and panel driver.
> You could encode whether a certain word is a command or data through the most
> upper bit as it is done in the actual register as well.
>
> Something like
> void jz4740_fb_slcd_send_cmd(struct device *dev, const uint32_t *data, size_t num)
> {
> 	struct jzfb *jzfb = dev_get_drvdata(dev);
> 	uint32_t d;
>
> 	mutex_lock(&jzfb->lock);
>
> 	if (!jzfb->is_enabled)
> 		clk_enable(jzfb->ldclk);
>
> 	for(; num; --num, ++data) {
> 		d = *data;
> 		if (d & JZ_SLCD_DATA_RS_CMD)
> 			d = jz4740_fb_slcd_panel_cmd(d);
> 		else
> 			d = jz4740_fb_slcd_panel_daya(d)
> 		jzfb_slcd_wait(jzfb);
> 		writel(d, jzfb->base + JZ_REG_SLCD_DATA);	
> 	}
>
> 	if (!jzfb->is_enabled) {
> 		jzfb_slcd_wait(jzfb);
> 		clk_disable(jzfb->ldclk);
> 	}
>
> 	mutex_unlock(&jzfb->lock);
> }
>

Right, now if this would also do mdelay (e.g. (BIT(30) | 5) means mdelay(5)), I
could do away with jz4740_fb_slcd_{en,dis}able_transfer() :)

That probably shouldn't be done in the framebuffer driver though, so I'll just
stick to something like this:

struct panel_platform_data {
    void (*lock)(void *);
    void (*unlock)(void *);
    void (*write)(const uint32_t *data, size_t num, void *);

    void *platform_data;
};

>> Me neither, but the only "good" way forward I see is emulating an SPI interface
>> over this..
>> Do you think this is acceptable?
>>
> Since the driver is not actually talking SPI over the bus I don't think this is
> an option.
> What might be an option is to provide a generic callback structure for the
> panel driver.
>
> struct panel_platform_data {
> 	void (*panel_write)(void *data, const uint32_t *data, size_t num);
> 	void *panel_data;
> };
>
> So that the panel driver doesn't reference the jzfb driver directly.
>
>
>
>

Right, but that still doesn't make the LCD panel driver any less tightly coupled
with the Jz4740 SLCD format.

Looking at the Renesas R61509 datasheet, they call this "80-system 8/9/16/18-bit
interface", an x-bit parallel interface with CS, WR, RD and RS (register select).

So SPI doesn't fit the bill, but I can't seem to find any other Linux driver bus
better-suited to do this (apart from creating a new one).

I guess using a generic callback is the best solution, so next patch iteration
will include this unless someone else comes up with something better.

-- 
Maurus Cuelenaere


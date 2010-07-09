From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Fri, 09 Jul 2010 01:26:38 +0000
Subject: Re: [PATCH v2 16/26] fbdev: Add JZ4740 framebuffer driver
Message-Id: <AANLkTikwGwXeCpwL8KfLVB3b9IoWoUJwaTStTwr8iR8z@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
        <1276924111-11158-17-git-send-email-lars@metafoo.de>
        <4C310ACD.6040604@metafoo.de>
In-Reply-To: <4C310ACD.6040604@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-fbdev@vger.kernel.org

On Mon, Jul 5, 2010 at 6:27 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Hi Andrew
>
> v2 of this patch has been around for two weeks without any comments. I've=
 fixed all
> the issues you had with v1. If you this version is ok, an Acked-By would =
be nice :)
>
> Thanks
> - Lars
>
> Lars-Peter Clausen wrote:
>> This patch adds support for the LCD controller on JZ4740 SoCs.

Hi Lars, Andrew,

I think this driver looks okay but I had some quick questions:

>> +config FB_JZ4740
>> + =A0 =A0 tristate "JZ4740 LCD framebuffer support"
>> + =A0 =A0 depends on FB
>> + =A0 =A0 select FB_SYS_FILLRECT
>> + =A0 =A0 select FB_SYS_COPYAREA
>> + =A0 =A0 select FB_SYS_IMAGEBLIT

Out of curiosity, why FB_SYS and not FB_CFB? The users of FB_SYS are
drivers that use virtual memory for their framebuffer. I didn't see
any vmalloc in this driver.

>> + =A0 =A0 help
>> + =A0 =A0 =A0 Framebuffer support for the JZ4740 SoC.
>> +
>> =A0source "drivers/video/omap/Kconfig"
>> =A0source "drivers/video/omap2/Kconfig"
>>
>> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
>> index 3c3bf86..fd2df57 100644
>> --- a/drivers/video/Makefile
>> +++ b/drivers/video/Makefile
>> @@ -132,6 +132,7 @@ obj-$(CONFIG_FB_CARMINE) =A0 =A0 =A0 =A0 =A0+=3D car=
minefb.o
>> =A0obj-$(CONFIG_FB_MB862XX) =A0 =A0 =A0 +=3D mb862xx/
>> =A0obj-$(CONFIG_FB_MSM) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D msm/
>> =A0obj-$(CONFIG_FB_NUC900) =A0 =A0 =A0 =A0 =A0 +=3D nuc900fb.o
>> +obj-$(CONFIG_FB_JZ4740) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D jz4740_fb.o

Just a minor nit, the typical naming in fbdev appears to be
controllerfb.c as opposed to controller_fb.c .

>>
>> =A0# Platform or fallback drivers go here
>> =A0obj-$(CONFIG_FB_UVESA) =A0 =A0 =A0 =A0 =A0 =A0+=3D uvesafb.o
>> diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
>> new file mode 100644
>> index 0000000..8d03181
>> --- /dev/null
>> +++ b/drivers/video/jz4740_fb.c
>> @@ -0,0 +1,817 @@
>> +/*
>> + * =A0Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
>> + * =A0 JZ4740 SoC LCD framebuffer driver
>> + *
>> + * =A0This program is free software; you can redistribute it and/or mod=
ify it
>> + * =A0under =A0the terms of =A0the GNU General Public License as publis=
hed by the
>> + * =A0Free Software Foundation; =A0either version 2 of the License, or =
(at your
>> + * =A0option) any later version.
>> + *
>> + * =A0You should have received a copy of the GNU General Public License=
 along
>> + * =A0with this program; if not, write to the Free Software Foundation,=
 Inc.,
>> + * =A0675 Mass Ave, Cambridge, MA 02139, USA.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +
>> +#include <linux/console.h>
>> +#include <linux/fb.h>
>> +
>> +#include <linux/dma-mapping.h>
>> +
>> +#include <linux/jz4740_fb.h>

I see a lot of register defines below. Is there any reason why they
shouldn't go in above j*fb.h? Also, I'm not sure if linux/j*.h is the
best place. I think most fbdev drivers place their headers in
drivers/video itself unless they need to share something driver
specific with userspace which is rare. Is there a specific reason why
you put it in include/linux?


>> +#include <asm/mach-jz4740/gpio.h>
>> +
>> +#define JZ_REG_LCD_CFG =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00
>> +#define JZ_REG_LCD_VSYNC =A0 =A0 0x04
>> +#define JZ_REG_LCD_HSYNC =A0 =A0 0x08
>> +#define JZ_REG_LCD_VAT =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0C
>> +#define JZ_REG_LCD_DAH =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x10
>> +#define JZ_REG_LCD_DAV =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x14
>> +#define JZ_REG_LCD_PS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x18
>> +#define JZ_REG_LCD_CLS =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1C
>> +#define JZ_REG_LCD_SPL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x20
>> +#define JZ_REG_LCD_REV =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x24
>> +#define JZ_REG_LCD_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A00x30
>> +#define JZ_REG_LCD_STATE =A0 =A0 0x34
>> +#define JZ_REG_LCD_IID =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x38
>> +#define JZ_REG_LCD_DA0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x40
>> +#define JZ_REG_LCD_SA0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x44
>> +#define JZ_REG_LCD_FID0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x48
>> +#define JZ_REG_LCD_CMD0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x4C
>> +#define JZ_REG_LCD_DA1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x50
>> +#define JZ_REG_LCD_SA1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x54
>> +#define JZ_REG_LCD_FID1 =A0 =A0 =A0 =A0 =A0 =A0 =A00x58
>> +#define JZ_REG_LCD_CMD1 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5C
>> +
>> +#define JZ_LCD_CFG_SLCD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(=
31)
>> +#define JZ_LCD_CFG_PS_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(23)
>> +#define JZ_LCD_CFG_CLS_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(22)
>> +#define JZ_LCD_CFG_SPL_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(21)
>> +#define JZ_LCD_CFG_REV_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(20)
>> +#define JZ_LCD_CFG_HSYNCM =A0 =A0 =A0 =A0 =A0 =A0BIT(19)
>> +#define JZ_LCD_CFG_PCLKM =A0 =A0 =A0 =A0 =A0 =A0 BIT(18)
>> +#define JZ_LCD_CFG_INV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(=
17)
>> +#define JZ_LCD_CFG_SYNC_DIR =A0 =A0 =A0 =A0 =A0BIT(16)
>> +#define JZ_LCD_CFG_PS_POLARITY =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(15)
>> +#define JZ_LCD_CFG_CLS_POLARITY =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(14)
>> +#define JZ_LCD_CFG_SPL_POLARITY =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(13)
>> +#define JZ_LCD_CFG_REV_POLARITY =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(12)
>> +#define JZ_LCD_CFG_HSYNC_ACTIVE_LOW =A0BIT(11)
>> +#define JZ_LCD_CFG_PCLK_FALLING_EDGE BIT(10)
>> +#define JZ_LCD_CFG_DE_ACTIVE_LOW =A0 =A0 BIT(9)
>> +#define JZ_LCD_CFG_VSYNC_ACTIVE_LOW =A0BIT(8)
>> +#define JZ_LCD_CFG_18_BIT =A0 =A0 =A0 =A0 =A0 =A0BIT(7)
>> +#define JZ_LCD_CFG_PDW =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (BIT=
(5) | BIT(4))
>> +#define JZ_LCD_CFG_MODE_MASK 0xf
>> +
>> +#define JZ_LCD_CTRL_BURST_4 =A0 =A0 =A0 =A0 =A0(0x0 << 28)
>> +#define JZ_LCD_CTRL_BURST_8 =A0 =A0 =A0 =A0 =A0(0x1 << 28)
>> +#define JZ_LCD_CTRL_BURST_16 =A0 =A0 =A0 =A0 (0x2 << 28)
>> +#define JZ_LCD_CTRL_RGB555 =A0 =A0 =A0 =A0 =A0 BIT(27)
>> +#define JZ_LCD_CTRL_OFUP =A0 =A0 =A0 =A0 =A0 =A0 BIT(26)
>> +#define JZ_LCD_CTRL_FRC_GRAYSCALE_16 (0x0 << 24)
>> +#define JZ_LCD_CTRL_FRC_GRAYSCALE_4 =A0(0x1 << 24)
>> +#define JZ_LCD_CTRL_FRC_GRAYSCALE_2 =A0(0x2 << 24)
>> +#define JZ_LCD_CTRL_PDD_MASK =A0 =A0 =A0 =A0 (0xff << 16)
>> +#define JZ_LCD_CTRL_EOF_IRQ =A0 =A0 =A0 =A0 =A0BIT(13)
>> +#define JZ_LCD_CTRL_SOF_IRQ =A0 =A0 =A0 =A0 =A0BIT(12)
>> +#define JZ_LCD_CTRL_OFU_IRQ =A0 =A0 =A0 =A0 =A0BIT(11)
>> +#define JZ_LCD_CTRL_IFU0_IRQ =A0 =A0 =A0 =A0 BIT(10)
>> +#define JZ_LCD_CTRL_IFU1_IRQ =A0 =A0 =A0 =A0 BIT(9)
>> +#define JZ_LCD_CTRL_DD_IRQ =A0 =A0 =A0 =A0 =A0 BIT(8)
>> +#define JZ_LCD_CTRL_QDD_IRQ =A0 =A0 =A0 =A0 =A0BIT(7)
>> +#define JZ_LCD_CTRL_REVERSE_ENDIAN =A0 BIT(6)
>> +#define JZ_LCD_CTRL_LSB_FISRT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(5)
>> +#define JZ_LCD_CTRL_DISABLE =A0 =A0 =A0 =A0 =A0BIT(4)
>> +#define JZ_LCD_CTRL_ENABLE =A0 =A0 =A0 =A0 =A0 BIT(3)
>> +#define JZ_LCD_CTRL_BPP_1 =A0 =A0 =A0 =A0 =A0 =A00x0
>> +#define JZ_LCD_CTRL_BPP_2 =A0 =A0 =A0 =A0 =A0 =A00x1
>> +#define JZ_LCD_CTRL_BPP_4 =A0 =A0 =A0 =A0 =A0 =A00x2
>> +#define JZ_LCD_CTRL_BPP_8 =A0 =A0 =A0 =A0 =A0 =A00x3
>> +#define JZ_LCD_CTRL_BPP_15_16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x4
>> +#define JZ_LCD_CTRL_BPP_18_24 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5
>> +
>> +#define JZ_LCD_CMD_SOF_IRQ BIT(15)
>> +#define JZ_LCD_CMD_EOF_IRQ BIT(16)
>> +#define JZ_LCD_CMD_ENABLE_PAL BIT(12)
>> +
>> +#define JZ_LCD_SYNC_MASK 0x3ff
>> +
>> +#define JZ_LCD_STATE_DISABLED BIT(0)
>> +
>> +struct jzfb_framedesc {
>> + =A0 =A0 uint32_t next;
>> + =A0 =A0 uint32_t addr;
>> + =A0 =A0 uint32_t id;
>> + =A0 =A0 uint32_t cmd;
>> +} __packed;
>> +
>> +struct jzfb {
>> + =A0 =A0 struct fb_info *fb;
>> + =A0 =A0 struct platform_device *pdev;
>> + =A0 =A0 void __iomem *base;
>> + =A0 =A0 struct resource *mem;
>> + =A0 =A0 struct jz4740_fb_platform_data *pdata;
>> +
>> + =A0 =A0 size_t vidmem_size;
>> + =A0 =A0 void *vidmem;
>> + =A0 =A0 dma_addr_t vidmem_phys;
>> + =A0 =A0 struct jzfb_framedesc *framedesc;
>> + =A0 =A0 dma_addr_t framedesc_phys;
>> +
>> + =A0 =A0 struct clk *ldclk;
>> + =A0 =A0 struct clk *lpclk;
>> +
>> + =A0 =A0 unsigned is_enabled:1;

Out of curiosity, why the bitfield?

>> + =A0 =A0 struct mutex lock;
>> +
>> + =A0 =A0 uint32_t pseudo_palette[16];
>> +};
>> +
>> +static const struct fb_fix_screeninfo jzfb_fix __devinitdata =3D {
>> + =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D "JZ4740 FB",
>> + =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D FB_TYPE_PACKED_PIXELS,
>> + =A0 =A0 .visual =A0 =A0 =A0 =A0 =3D FB_VISUAL_TRUECOLOR,
>> + =A0 =A0 .xpanstep =A0 =A0 =A0 =3D 0,
>> + =A0 =A0 .ypanstep =A0 =A0 =A0 =3D 0,
>> + =A0 =A0 .ywrapstep =A0 =A0 =A0=3D 0,
>> + =A0 =A0 .accel =A0 =A0 =A0 =A0 =A0=3D FB_ACCEL_NONE,
>> +};
>> +
>> +static const struct jz_gpio_bulk_request jz_lcd_ctrl_pins[] =3D {
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_PCLK),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_HSYNC),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_VSYNC),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DE),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_PS),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_REV),
>> +};
>> +
>> +static const struct jz_gpio_bulk_request jz_lcd_data_pins[] =3D {
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA0),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA1),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA2),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA3),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA4),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA5),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA6),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA7),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA8),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA9),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA10),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA11),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA12),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA13),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA14),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA15),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA16),
>> + =A0 =A0 JZ_GPIO_BULK_PIN(LCD_DATA17),
>> +};
>> +
>> +static unsigned int jzfb_num_ctrl_pins(struct jzfb *jzfb)
>> +{
>> + =A0 =A0 unsigned int num;
>> +
>> + =A0 =A0 switch (jzfb->pdata->lcd_type) {
>> + =A0 =A0 case JZ_LCD_TYPE_GENERIC_16_BIT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 num =3D 4;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case JZ_LCD_TYPE_GENERIC_18_BIT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 num =3D 4;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case JZ_LCD_TYPE_8BIT_SERIAL:
>> + =A0 =A0 =A0 =A0 =A0 =A0 num =3D 3;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;

The lcd type serial looks interesting to me. It'd be nice to have some
descriptive comments so that we know what its used with.

>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 num =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> + =A0 =A0 return num;
>> +}
>> +
>> +static unsigned int jzfb_num_data_pins(struct jzfb *jzfb)
>> +{
>> + =A0 =A0 unsigned int num;
>> +
>> + =A0 =A0 switch (jzfb->pdata->lcd_type) {
>> + =A0 =A0 case JZ_LCD_TYPE_GENERIC_16_BIT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 num =3D 16;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case JZ_LCD_TYPE_GENERIC_18_BIT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 num =3D 18;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case JZ_LCD_TYPE_8BIT_SERIAL:
>> + =A0 =A0 =A0 =A0 =A0 =A0 num =3D 8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 num =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> + =A0 =A0 return num;
>> +}
>> +
>> +/* Based on CNVT_TOHW macro from skeletonfb.c */
>> +static inline uint32_t jzfb_convert_color_to_hw(unsigned val,
>> + =A0 =A0 struct fb_bitfield *bf)
>> +{
>> + =A0 =A0 return (((val << bf->length) + 0x7FFF - val) >> 16) << bf->off=
set;
>> +}
>> +
>> +static int jzfb_setcolreg(unsigned regno, unsigned red, unsigned green,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned blue, unsigned transp=
, struct fb_info *fb)
>> +{
>> + =A0 =A0 uint32_t color;
>> +
>> + =A0 =A0 if (regno >=3D 16)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 color =3D jzfb_convert_color_to_hw(red, &fb->var.red);
>> + =A0 =A0 color |=3D jzfb_convert_color_to_hw(green, &fb->var.green);
>> + =A0 =A0 color |=3D jzfb_convert_color_to_hw(blue, &fb->var.blue);
>> + =A0 =A0 color |=3D jzfb_convert_color_to_hw(transp, &fb->var.transp);
>> +
>> + =A0 =A0 ((uint32_t *)(fb->pseudo_palette))[regno] =3D color;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int jzfb_get_controller_bpp(struct jzfb *jzfb)
>> +{
>> + =A0 =A0 switch (jzfb->pdata->bpp) {
>> + =A0 =A0 case 18:
>> + =A0 =A0 case 24:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 32;
>> + =A0 =A0 case 15:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 16;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return jzfb->pdata->bpp;
>> + =A0 =A0 }
>> +}
>> +
>> +static struct fb_videomode *jzfb_get_mode(struct jzfb *jzfb,
>> + =A0 =A0 struct fb_var_screeninfo *var)
>> +{
>> + =A0 =A0 size_t i;
>> + =A0 =A0 struct fb_videomode *mode =3D jzfb->pdata->modes;
>> +
>> + =A0 =A0 for (i =3D 0; i < jzfb->pdata->num_modes; ++i, ++mode) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (mode->xres =3D var->xres && mode->yres =3D=
 var->yres)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mode;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return NULL;
>> +}
>> +
>> +static int jzfb_check_var(struct fb_var_screeninfo *var, struct fb_info=
 *fb)
>> +{
>> + =A0 =A0 struct jzfb *jzfb =3D fb->par;
>> + =A0 =A0 struct fb_videomode *mode;
>> +
>> + =A0 =A0 if (var->bits_per_pixel !=3D jzfb_get_controller_bpp(jzfb) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->bits_per_pixel !=3D jzfb->pdata->bpp)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 mode =3D jzfb_get_mode(jzfb, var);
>> + =A0 =A0 if (mode =3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 fb_videomode_to_var(var, mode);
>> +
>> + =A0 =A0 switch (jzfb->pdata->bpp) {
>> + =A0 =A0 case 8:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 15:
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->red.offset =3D 10;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->red.length =3D 5;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->green.offset =3D 6;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->green.length =3D 5;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->blue.offset =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->blue.length =3D 5;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 16:
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->red.offset =3D 11;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->red.length =3D 5;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->green.offset =3D 5;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->green.length =3D 6;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->blue.offset =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->blue.length =3D 5;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 18:
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->red.offset =3D 16;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->red.length =3D 6;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->green.offset =3D 8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->green.length =3D 6;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->blue.offset =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->blue.length =3D 6;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->bits_per_pixel =3D 32;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 32:
>> + =A0 =A0 case 24:
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->transp.offset =3D 24;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->transp.length =3D 8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->red.offset =3D 16;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->red.length =3D 8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->green.offset =3D 8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->green.length =3D 8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->blue.offset =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->blue.length =3D 8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 var->bits_per_pixel =3D 32;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int jzfb_set_par(struct fb_info *info)
>> +{
>> + =A0 =A0 struct jzfb *jzfb =3D info->par;
>> + =A0 =A0 struct fb_var_screeninfo *var =3D &info->var;
>> + =A0 =A0 struct fb_videomode *mode;
>> + =A0 =A0 uint16_t hds, vds;
>> + =A0 =A0 uint16_t hde, vde;
>> + =A0 =A0 uint16_t ht, vt;
>> + =A0 =A0 uint32_t ctrl;
>> + =A0 =A0 uint32_t cfg;
>> + =A0 =A0 unsigned long rate;
>> +
>> + =A0 =A0 mode =3D jzfb_get_mode(jzfb, var);
>> + =A0 =A0 if (mode =3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 if (mode =3D info->mode)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 info->mode =3D mode;
>> +
>> + =A0 =A0 hds =3D mode->hsync_len + mode->left_margin;
>> + =A0 =A0 hde =3D hds + mode->xres;
>> + =A0 =A0 ht =3D hde + mode->right_margin;
>> +
>> + =A0 =A0 vds =3D mode->vsync_len + mode->upper_margin;
>> + =A0 =A0 vde =3D vds + mode->yres;
>> + =A0 =A0 vt =3D vde + mode->lower_margin;
>> +
>> + =A0 =A0 ctrl =3D JZ_LCD_CTRL_OFUP | JZ_LCD_CTRL_BURST_16;
>> +
>> + =A0 =A0 switch (jzfb->pdata->bpp) {
>> + =A0 =A0 case 1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D JZ_LCD_CTRL_BPP_1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 2:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D JZ_LCD_CTRL_BPP_2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 4:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D JZ_LCD_CTRL_BPP_4;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 8:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D JZ_LCD_CTRL_BPP_8;
>> + =A0 =A0 break;
>> + =A0 =A0 case 15:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D JZ_LCD_CTRL_RGB555; /* Falltrough */
>> + =A0 =A0 case 16:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D JZ_LCD_CTRL_BPP_15_16;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 18:
>> + =A0 =A0 case 24:
>> + =A0 =A0 case 32:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D JZ_LCD_CTRL_BPP_18_24;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 cfg =3D JZ_LCD_CFG_PS_DISABLE | JZ_LCD_CFG_CLS_DISABLE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 JZ_LCD_CFG_SPL_DISABLE | JZ_LCD_CFG_REV_DISABL=
E;
>> +
>> + =A0 =A0 if (!(mode->sync & FB_SYNC_HOR_HIGH_ACT))
>> + =A0 =A0 =A0 =A0 =A0 =A0 cfg |=3D JZ_LCD_CFG_HSYNC_ACTIVE_LOW;
>> +
>> + =A0 =A0 if (!(mode->sync & FB_SYNC_VERT_HIGH_ACT))
>> + =A0 =A0 =A0 =A0 =A0 =A0 cfg |=3D JZ_LCD_CFG_VSYNC_ACTIVE_LOW;
>> +
>> + =A0 =A0 if (jzfb->pdata->pixclk_falling_edge)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cfg |=3D JZ_LCD_CFG_PCLK_FALLING_EDGE;
>> +
>> + =A0 =A0 if (jzfb->pdata->date_enable_active_low)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cfg |=3D JZ_LCD_CFG_DE_ACTIVE_LOW;
>> +
>> + =A0 =A0 if (jzfb->pdata->lcd_type =3D JZ_LCD_TYPE_GENERIC_18_BIT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cfg |=3D JZ_LCD_CFG_18_BIT;
>> +
>> + =A0 =A0 cfg |=3D jzfb->pdata->lcd_type & 0xf;
>> +
>> + =A0 =A0 if (mode->pixclock) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 rate =3D PICOS2KHZ(mode->pixclock) * 1000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mode->refresh =3D rate / vt / ht;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (jzfb->pdata->lcd_type =3D JZ_LCD_TYPE_8BIT=
_SERIAL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rate =3D mode->refresh * (vt +=
 2 * mode->xres) * ht;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rate =3D mode->refresh * vt * =
ht;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 mode->pixclock =3D KHZ2PICOS(rate / 1000);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mutex_lock(&jzfb->lock);
>> + =A0 =A0 if (!jzfb->is_enabled)
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(jzfb->ldclk);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D JZ_LCD_CTRL_ENABLE;
>> +
>> + =A0 =A0 writel(mode->hsync_len, jzfb->base + JZ_REG_LCD_HSYNC);
>> + =A0 =A0 writel(mode->vsync_len, jzfb->base + JZ_REG_LCD_VSYNC);
>> +
>> + =A0 =A0 writel((ht << 16) | vt, jzfb->base + JZ_REG_LCD_VAT);
>> +
>> + =A0 =A0 writel((hds << 16) | hde, jzfb->base + JZ_REG_LCD_DAH);
>> + =A0 =A0 writel((vds << 16) | vde, jzfb->base + JZ_REG_LCD_DAV);
>> +
>> + =A0 =A0 writel(cfg, jzfb->base + JZ_REG_LCD_CFG);
>> +
>> + =A0 =A0 writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
>> +
>> + =A0 =A0 if (!jzfb->is_enabled)
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(jzfb->ldclk);
>> +
>> + =A0 =A0 mutex_unlock(&jzfb->lock);
>> +
>> + =A0 =A0 clk_set_rate(jzfb->lpclk, rate);
>> + =A0 =A0 clk_set_rate(jzfb->ldclk, rate * 3);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void jzfb_enable(struct jzfb *jzfb)
>> +{
>> + =A0 =A0 uint32_t ctrl;
>> +
>> + =A0 =A0 clk_enable(jzfb->ldclk);
>> +
>> + =A0 =A0 jz_gpio_bulk_resume(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb)=
);
>> + =A0 =A0 jz_gpio_bulk_resume(jz_lcd_data_pins, jzfb_num_data_pins(jzfb)=
);
>> +
>> + =A0 =A0 writel(0, jzfb->base + JZ_REG_LCD_STATE);
>> +
>> + =A0 =A0 writel(jzfb->framedesc->next, jzfb->base + JZ_REG_LCD_DA0);
>> +
>> + =A0 =A0 ctrl =3D readl(jzfb->base + JZ_REG_LCD_CTRL);
>> + =A0 =A0 ctrl |=3D JZ_LCD_CTRL_ENABLE;
>> + =A0 =A0 ctrl &=3D ~JZ_LCD_CTRL_DISABLE;
>> + =A0 =A0 writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
>> +}
>> +
>> +static void jzfb_disable(struct jzfb *jzfb)
>> +{
>> + =A0 =A0 uint32_t ctrl;
>> +
>> + =A0 =A0 ctrl =3D readl(jzfb->base + JZ_REG_LCD_CTRL);
>> + =A0 =A0 ctrl |=3D JZ_LCD_CTRL_DISABLE;
>> + =A0 =A0 writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D readl(jzfb->base + JZ_REG_LCD_STATE);
>> + =A0 =A0 } while (!(ctrl & JZ_LCD_STATE_DISABLED));
>> +
>> + =A0 =A0 jz_gpio_bulk_suspend(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb=
));
>> + =A0 =A0 jz_gpio_bulk_suspend(jz_lcd_data_pins, jzfb_num_data_pins(jzfb=
));
>> +
>> + =A0 =A0 clk_disable(jzfb->ldclk);
>> +}
>> +
>> +static int jzfb_blank(int blank_mode, struct fb_info *info)
>> +{
>> + =A0 =A0 struct jzfb *jzfb =3D info->par;
>> +
>> + =A0 =A0 switch (blank_mode) {
>> + =A0 =A0 case FB_BLANK_UNBLANK:
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&jzfb->lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (jzfb->is_enabled) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&jzfb->lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 jzfb_enable(jzfb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 jzfb->is_enabled =3D 1;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&jzfb->lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&jzfb->lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!jzfb->is_enabled) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&jzfb->lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 jzfb_disable(jzfb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 jzfb->is_enabled =3D 0;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&jzfb->lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int jzfb_alloc_devmem(struct jzfb *jzfb)
>> +{
>> + =A0 =A0 int max_videosize =3D 0;
>> + =A0 =A0 struct fb_videomode *mode =3D jzfb->pdata->modes;
>> + =A0 =A0 void *page;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 for (i =3D 0; i < jzfb->pdata->num_modes; ++mode, ++i) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (max_videosize < mode->xres * mode->yres)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_videosize =3D mode->xres *=
 mode->yres;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 max_videosize *=3D jzfb_get_controller_bpp(jzfb) >> 3;
>> +
>> + =A0 =A0 jzfb->framedesc =3D dma_alloc_coherent(&jzfb->pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 sizeof(*jzfb->framedesc),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 &jzfb->framedesc_phys, GFP_KERNEL);
>> +
>> + =A0 =A0 if (!jzfb->framedesc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 jzfb->vidmem_size =3D PAGE_ALIGN(max_videosize);
>> + =A0 =A0 jzfb->vidmem =3D dma_alloc_coherent(&jzfb->pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 jzfb->vidmem_size,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 &jzfb->vidmem_phys, GFP_KERNEL);
>> +
>> + =A0 =A0 if (!jzfb->vidmem)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_framedesc;
>> +
>> + =A0 =A0 for (page =3D jzfb->vidmem;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0page < jzfb->vidmem + PAGE_ALIGN(jzfb->vidm=
em_size);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0page +=3D PAGE_SIZE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 SetPageReserved(virt_to_page(page));
>> + =A0 =A0 }

It'd be nice to know the reasoning for the SetPageReserved.

Thanks,
jaya

From: InKi Dae <daeinki@gmail.com>
Subject: Re: [PATCH 2/2] S5PV210: Add MIPI-DSI Driver.
Date: Sat, 3 Jul 2010 03:08:07 +0900
Message-ID: <AANLkTim-H2mwYdbMYezfRlRgsUAg5GTgUykCLYJxMesN@mail.gmail.com>
References: <4C29AF72.6090200@samsung.com> <4C29C766.7010901@samsung.com>
	<4C2DA889.5010809@samsung.com> <4C2DF1C7.9000208@simtec.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4C2DF1C7.9000208@simtec.co.uk>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ben Dooks <ben@simtec.co.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, InKi Dae <inki.dae@samsung.com>, Ben Dooks <ben-linux@fluff.org>, kmpark@infradead.org, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org

Most of you pointed out would be modified.
Code cleanup and code review was the lack of

Thank you, Ben.


2010/7/2 Ben Dooks <ben@simtec.co.uk>:
> On 02/07/10 09:51, InKi Dae wrote:
>> this patch addes MIPI-DSI Driver.
>>
>> to use this driver, some structures below should be added to machine
>> specific file.
>>
>> struct dsim_config
>> - define clock info, data lane count and video mode info for MIPI-DSI
>> Controller.
>>
>> struct dsim_lcd_config
>> - define interface mode, channel ID, Pixel format and so on.
>>
>> struct s5p_platform_dsim
>> - define callbacks for initializing D-PHY, MIPI reset and trigger
>> releated interfaces of s3c-fb.c file.
>>
>> Signed-off-by: InKi Dae <inki.dae@samsung.com <mailto:p.osciak@samsung.c=
om>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com
>> <mailto:kyungmin.park@samsung.com>>
>> ---
>>
>> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h b/arch/arm/=
mach-s5pv210/include/mach/regs-clock.h
>> index 2a25ab4..f716678 100644
>> --- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
>> +++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
>> @@ -162,6 +162,7 @@
>>
>> =A0/* MIPI */
>> =A0#define S5P_MIPI_DPHY_EN =A0 =A0 =A0 =A0 =A0 =A0 (3)
>> +#define S5P_MIPI_M_RESETN =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
>>
>> =A0/* S5P_DAC_CONTROL */
>> =A0#define S5P_DAC_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1)
>> diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Make=
file
>> index b1d82cc..3cd43f2 100644
>> --- a/arch/arm/plat-samsung/Makefile
>> +++ b/arch/arm/plat-samsung/Makefile
>> @@ -49,6 +49,9 @@ obj-$(CONFIG_S3C_DEV_RTC) =A0 +=3D dev-rtc.o
>> =A0obj-$(CONFIG_SAMSUNG_DEV_ADC) =A0 =A0 =A0 =A0+=3D dev-adc.o
>> =A0obj-$(CONFIG_SAMSUNG_DEV_TS) +=3D dev-ts.o
>>
>> +# Device setup - MIPI-DSI
>> +obj-$(CONFIG_S5P_MIPI_DSI) =A0+=3D setup-dsim.o
>> +
>> =A0# DMA support
>>
>> =A0obj-$(CONFIG_S3C_DMA) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D dma.o
>> diff --git a/arch/arm/plat-samsung/include/plat/dsim.h b/arch/arm/plat-s=
amsung/include/plat/dsim.h
>> new file mode 100644
>> index 0000000..28bc595
>> --- /dev/null
>> +++ b/arch/arm/plat-samsung/include/plat/dsim.h
>> @@ -0,0 +1,470 @@
>
>
>> + * driver structure for mipi-dsi based lcd panel.
>> + *
>> + * this structure should be registered by lcd panel driver.
>> + * mipi-dsi driver seeks lcd panel registered through name field
>> + * and calls these callback functions in appropriate time.
>> + */
>> +struct mipi_lcd_driver {
>> + =A0 =A0 s8 =A0 =A0 =A0name[64];
>
> how about an 'char *' here instead of reserving 64bytes?
>

Ok, 'char *' is better.

>> + =A0 =A0 s32 =A0 =A0 (*init)(struct device *dev);
>> + =A0 =A0 void =A0 =A0(*display_on)(struct device *dev);
>> + =A0 =A0 s32 =A0 =A0 (*set_link)(struct mipi_ddi_platform_data *pd);
>> + =A0 =A0 s32 =A0 =A0 (*probe)(struct device *dev);
>> + =A0 =A0 s32 =A0 =A0 (*remove)(struct device *dev);
>> + =A0 =A0 void =A0 =A0(*shutdown)(struct device *dev);
>> + =A0 =A0 s32 =A0 =A0 (*suspend)(struct device *dev, pm_message_t mesg);
>> + =A0 =A0 s32 =A0 =A0 (*resume)(struct device *dev);
>> +};
>
> Some of this should be already covered under the existing
> lcd interface?
>

you mean, lcd class(lcd.c)?
these callbacks would be registered to master driver (s5p-dsim.c).
Could you explain in more detail?

>> diff --git a/arch/arm/plat-samsung/include/plat/mipi_ddi.h b/arch/arm/pl=
at-samsung/include/plat/mipi_ddi.h
>> new file mode 100644
>> index 0000000..57ed613
>> --- /dev/null
>> +++ b/arch/arm/plat-samsung/include/plat/mipi_ddi.h
>> @@ -0,0 +1,98 @@
>> +/* linux/arm/arch/mach-s5pc110/include/mach/mipi_ddi.h
>> + *
>> + * definitions for DDI based MIPI-DSI.
>> + *
>> + * Copyright (c) 2009 Samsung Electronics
>> + * InKi Dae <inki.dae@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#ifndef _MIPI_DDI_H
>> +#define _MIPI_DDI_H
>> +
>> +enum mipi_ddi_interface {
>> + =A0 =A0 RGB_IF =3D 0x4000,
>> + =A0 =A0 I80_IF =3D 0x8000,
>> + =A0 =A0 YUV_601 =3D 0x10000,
>> + =A0 =A0 YUV_656 =3D 0x20000,
>> + =A0 =A0 MIPI_VIDEO =3D 0x1000,
>> + =A0 =A0 MIPI_COMMAND =3D 0x2000,
>> +};
>> +
>> +enum mipi_ddi_panel_select {
>> + =A0 =A0 DDI_MAIN_LCD =3D 0,
>> + =A0 =A0 DDI_SUB_LCD =3D 1,
>> +};
>> +
>> +enum mipi_ddi_model {
>> + =A0 =A0 S6DR117 =3D 0,
>> +};
>> +
>> +enum mipi_ddi_parameter {
>> + =A0 =A0 /* DSIM video interface parameter */
>> + =A0 =A0 DSI_VIRTUAL_CH_ID =3D 0,
>> + =A0 =A0 DSI_FORMAT =3D 1,
>> + =A0 =A0 DSI_VIDEO_MODE_SEL =3D 2,
>> +};
>> +
>> +struct lcd_device;
>> +struct fb_info;
>> +
>> +struct mipi_ddi_platform_data {
>> + =A0 =A0 void *dsim_data;
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* it is used for command mode lcd panel and
>> + =A0 =A0 =A0* when all contents of framebuffer in panel module are tran=
sfered
>> + =A0 =A0 =A0* to lcd panel it occurs te signal.
>> + =A0 =A0 =A0*
>> + =A0 =A0 =A0* note:
>> + =A0 =A0 =A0* - in case of command mode(cpu mode), it should be trigger=
ed only
>> + =A0 =A0 =A0* =A0 when TE signal of lcd panel and frame done interrupt =
of display
>> + =A0 =A0 =A0* =A0 controller or mipi controller occurs.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 unsigned int te_irq;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* it is used for PM stable time at te interrupt handler and
>> + =A0 =A0 =A0* could be used according to lcd panel characteristic or no=
t.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 unsigned int resume_complete;
>> +
>> + =A0 =A0 int (*lcd_reset) (struct lcd_device *ld);
>> + =A0 =A0 int (*lcd_power_on) (struct lcd_device *ld, int enable);
>> + =A0 =A0 int (*backlight_on) (int enable);
>> +
>> + =A0 =A0 /* transfer command to lcd panel at LP mode. */
>> + =A0 =A0 int (*cmd_write) (void *dsim_data, unsigned int data_id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int data0, unsigned int data1);
>> + =A0 =A0 int (*cmd_read) (void *dsim_data, unsigned int data_id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int data0, unsigned int data1);
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* get the status that all screen data have been transferred
>> + =A0 =A0 =A0* to mipi-dsi.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 int (*get_dsim_frame_done) (void *dsim_data);
>> + =A0 =A0 int (*clear_dsim_frame_done) (void *dsim_data);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* changes mipi transfer mode to LP or HS mode.
>> + =A0 =A0 =A0*
>> + =A0 =A0 =A0* LP mode needs when some commands like gamma values transf=
ers
>> + =A0 =A0 =A0* to lcd panel.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 int (*change_dsim_transfer_mode) (int mode);
>> +
>> + =A0 =A0 /* get frame done status of display controller. */
>> + =A0 =A0 int (*get_fb_frame_done) (struct fb_info *info);
>> + =A0 =A0 /* trigger display controller in case of cpu mode. */
>> + =A0 =A0 void (*trigger) (struct fb_info *info);
>> +
>> + =A0 =A0 unsigned int reset_delay;
>> + =A0 =A0 unsigned int power_on_delay;
>> + =A0 =A0 unsigned int power_off_delay;
>> +};
>> +
>> +#endif /* _MIPI_DDI_H */
>> diff --git a/arch/arm/plat-samsung/include/plat/regs-dsim.h b/arch/arm/p=
lat-samsung/include/plat/regs-dsim.h
>> new file mode 100644
>> index 0000000..dc83089
>> --- /dev/null
>> +++ b/arch/arm/plat-samsung/include/plat/regs-dsim.h
>> @@ -0,0 +1,281 @@
> =A0+
>> +/* S5P_DSIM_TIMEOUT */
>> +#define DSIM_LPDR_TOUT_SHIFT (0)
>> +#define DSIM_BTA_TOUT_SHIFT =A0(16)
>> +#define DSIM_LPDR_TOUT(x) =A0 =A0(((x) & 0xffff) << DSIM_LPDR_TOUT_SHIF=
T)
>> +#define DSIM_BTA_TOUT(x) =A0 =A0 (((x) & 0xff) << DSIM_BTA_TOUT_SHIFT)
>> +
>> +/* S5P_DSIM_CLKCTRL */
>> +#define DSIM_ESC_PRESCALER_SHIFT =A0 =A0 (0)
>> +#define DSIM_LANE_ESC_CLKEN_SHIFT =A0 =A0(19)
>> +#define DSIM_BYTE_CLKEN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(24)
>> +#define DSIM_BYTE_CLK_SRC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0(25)
>> +#define DSIM_PLL_BYPASS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(27)
>> +#define DSIM_ESC_CLKEN_SHIFT =A0 =A0 =A0 =A0 (28)
>> +#define DSIM_TX_REQUEST_HSCLK_SHIFT =A0(31)
>> +#define DSIM_ESC_PRESCALER(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(((x) & 0x=
ffff) << \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 DSIM_ESC_PRESCALER_SHIFT)
>> +#define DSIM_LANE_ESC_CLKEN(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((x) & 0x1f=
) << \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 DSIM_LANE_ESC_CLKEN_SHIFT)
>> +#define DSIM_BYTE_CLK_ENABLE =A0 =A0 =A0 =A0 (1 << DSIM_BYTE_CLKEN_SHIF=
T)
>> +#define DSIM_BYTE_CLK_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0 << DSIM=
_BYTE_CLKEN_SHIFT)
>> +#define DSIM_BYTE_CLKSRC(x) =A0 =A0 =A0 =A0 =A0(((x) & 0x3) << DSIM_BYT=
E_CLK_SRC_SHIFT)
>> +#define DSIM_PLL_BYPASS_PLL =A0 =A0 =A0 =A0 =A0(0 << DSIM_PLL_BYPASS_SH=
IFT)
>> +#define DSIM_PLL_BYPASS_EXTERNAL =A0 =A0 (1 << DSIM_PLL_BYPASS_SHIFT)
>> +#define DSIM_ESC_CLKEN_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << DSIM=
_ESC_CLKEN_SHIFT)
>> +#define DSIM_ESC_CLKEN_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0 << DSIM_E=
SC_CLKEN_SHIFT)
>
>
>> +
>> +#include <plat/dsim.h>
>> +#include <plat/clock.h>
>> +#include <plat/regs-dsim.h>
>> +
>> +static int s5p_dsim_enable_d_phy(struct dsim_global *dsim, unsigned int=
 enable)
>
> I suppose enable should be bool,
>
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "dsim is NULL.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>
> Is it likely to be NULL? If unlikely then a simple warning and return
> -EFAULT.
>

NULL in the code development process, the problem is to know it.
it would be cleanned.

>> +
>> + =A0 =A0 reg =3D (readl(S5P_MIPI_CONTROL)) & ~(1 << 0);
>
> extra () not really needed
>

>> + =A0 =A0 reg |=3D (enable << 0);
>> + =A0 =A0 writel(reg, S5P_MIPI_CONTROL);
>> +
>> + =A0 =A0 dev_dbg(dsim->dev, "%s : %x\n", __func__, reg);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int s5p_dsim_enable_dsi_master(struct dsim_global *dsim,
>> + =A0 =A0 unsigned int enable)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "dsim is NULL.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 reg =3D (readl(S5P_MIPI_CONTROL)) & ~(1 << 2);
>> + =A0 =A0 reg |=3D (enable << 2);
>> + =A0 =A0 writel(reg, S5P_MIPI_CONTROL);
>> +
>> + =A0 =A0 dev_dbg(dsim->dev, "%s : %x\n", __func__, reg);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_dsim_part_reset(struct dsim_global *dsim)
>> +{
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "dsim is NULL.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 writel(S5P_MIPI_M_RESETN, S5P_MIPI_PHY_CON0);
>> +
>> + =A0 =A0 dev_dbg(dsim->dev, "%s\n", __func__);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_dsim_init_d_phy(struct dsim_global *dsim)
>> +{
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "dsim is NULL.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* enable D-PHY */
>> + =A0 =A0 s5p_dsim_enable_d_phy(dsim, 1);
>> +
>> + =A0 =A0 /* enable DSI master block */
>> + =A0 =A0 s5p_dsim_enable_dsi_master(dsim, 1);
>
> you ould probably have omitted the comments on these.
>

I will add more comments.


>> +
>> + =A0 =A0 dev_dbg(dsim->dev, "%s\n", __func__);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_dsim_mipi_power(struct dsim_global *dsim, void *p_mipi_1_1v,
>> + =A0 =A0 void *p_mipi_1_8v, int enable)
>
> enable could be bool.
>

ok.

>> +{
>> + =A0 =A0 struct regulator *r_mipi_1_1v =3D NULL, *r_mipi_1_8v =3D NULL;
>
> No need to init to NULL when you just cast them a few lines done.
>

ok.

>> + =A0 =A0 int ret =3D -1;
>> +
>> + =A0 =A0 r_mipi_1_1v =3D (struct regulator *) p_mipi_1_1v;
>> + =A0 =A0 r_mipi_1_8v =3D (struct regulator *) p_mipi_1_8v;
>
> It would be better just to call these regulators and stick with one type
> for these.
>
Okay, I'll even clean up the code

>
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "dsim is NULL.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>
> this is getting repetitive, is it really necessary?
>
>
>> +
>> + =A0 =A0 if (IS_ERR(r_mipi_1_1v) || IS_ERR(r_mipi_1_8v)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev, "r_mipi_1_1v or r_mipi_1_8v=
 is NULL.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (r_mipi_1_1v)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D regulator_enable(r_mip=
i_1_1v);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to ena=
ble regulator mipi_1_1v.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (r_mipi_1_8v)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D regulator_enable(r_mip=
i_1_8v);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to ena=
ble regulator mipi_1_8v.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (r_mipi_1_1v)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D regulator_force_disabl=
e(r_mipi_1_1v);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to dis=
able regulator mipi_1_1v.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (r_mipi_1_8v)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D regulator_force_disabl=
e(r_mipi_1_8v);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to dis=
able regulator mipi_1_8v.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>> index 3d94a14..c916ac1 100644
>> --- a/drivers/video/Kconfig
>> +++ b/drivers/video/Kconfig
>> @@ -1930,7 +1930,7 @@ config FB_TMIO_ACCELL
>>
>> =A0config FB_S3C
>> =A0 =A0 =A0 tristate "Samsung S3C framebuffer support"
>> - =A0 =A0 depends on FB && ARCH_S3C64XX
>> + =A0 =A0 depends on FB && (ARCH_S3C64XX || ARCH_S5PV210)
>> =A0 =A0 =A0 select FB_CFB_FILLRECT
>> =A0 =A0 =A0 select FB_CFB_COPYAREA
>> =A0 =A0 =A0 select FB_CFB_IMAGEBLIT
>> @@ -1975,6 +1975,13 @@ config FB_S3C2410_DEBUG
>> =A0 =A0 =A0 =A0 Turn on debugging messages. Note that you can set/unset =
at run time
>> =A0 =A0 =A0 =A0 through sysfs
>>
>> +config S5P_MIPI_DSI
>> + =A0 =A0 tristate "Samsung SoC MIPI-DSI support."
>> + =A0 =A0 depends on FB_S3C && ARCH_S5PV210
>> + =A0 =A0 default n
>> + =A0 =A0 ---help---
>> + =A0 =A0 =A0 This enables support for MIPI-DSI device.
>> +
>> =A0config FB_NUC900
>> =A0 =A0 =A0 =A0 =A0bool "NUC900 LCD framebuffer support"
>> =A0 =A0 =A0 =A0 =A0depends on FB && ARCH_W90X900
>> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
>> index ddc2af2..d841433 100644
>> --- a/drivers/video/Makefile
>> +++ b/drivers/video/Makefile
>> @@ -115,6 +115,8 @@ obj-$(CONFIG_FB_SH7760) =A0 =A0 =A0 =A0 =A0 =A0 +=3D=
 sh7760fb.o
>> =A0obj-$(CONFIG_FB_IMX) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D imxfb.o
>> =A0obj-$(CONFIG_FB_S3C) =A0 =A0 =A0 =A0 =A0 +=3D s3c-fb.o
>> =A0obj-$(CONFIG_FB_S3C2410) =A0 =A0 =A0 +=3D s3c2410fb.o
>> +obj-$(CONFIG_S5P_MIPI_DSI) =A0 =A0 +=3D s5p-dsim.o s5p_dsim_common.o \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 s5p_dsim_lowlevel.o
>> =A0obj-$(CONFIG_FB_FSL_DIU) =A0 =A0 =A0 +=3D fsl-diu-fb.o
>> =A0obj-$(CONFIG_FB_COBALT) =A0 =A0 =A0 =A0 =A0 +=3D cobalt_lcdfb.o
>> =A0obj-$(CONFIG_FB_PNX4008_DUM) =A0 +=3D pnx4008/
>> diff --git a/drivers/video/s5p-dsim.c b/drivers/video/s5p-dsim.c
>> new file mode 100644
>> index 0000000..96893bc
>> --- /dev/null
>> +++ b/drivers/video/s5p-dsim.c
>> @@ -0,0 +1,483 @@
>> +/* linux/drivers/video/samsung/s5p-dsim.c
>> + *
>> + * Samsung MIPI-DSIM driver.
>> + *
>> + * InKi Dae, <inki.dae@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/errno.h>
>> +#include <linux/clk.h>
>> +#include <linux/mutex.h>
>> +#include <linux/wait.h>
>> +#include <linux/fs.h>
>> +#include <linux/mm.h>
>> +#include <linux/fb.h>
>> +#include <linux/ctype.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/memory.h>
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kthread.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/notifier.h>
>> +
>> +#include <plat/fb.h>
>> +#include <plat/regs-dsim.h>
>> +#include <plat/dsim.h>
>> +#include <plat/mipi_ddi.h>
>> +
>> +#include <mach/map.h>
>> +
>> +#include "s5p_dsim_common.h"
>> +
>> +struct mipi_lcd_info {
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0list;
>> + =A0 =A0 struct mipi_lcd_driver =A0*mipi_drv;
>> +};
>> +
>> +static LIST_HEAD(lcd_info_list);
>> +static DEFINE_MUTEX(mipi_lock);
>> +
>> +struct dsim_global dsim;
>> +
>> +struct s5p_platform_dsim *to_dsim_plat(struct device *dev)
>> +{
>> + =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev);
>> +
>> + =A0 =A0 return (struct s5p_platform_dsim *)pdev->dev.platform_data;
>> +}
>
> that's return dev->platform_data.
>
>> +/*
>> + * notifier callback function for fb_blank
>> + * - this function would be called by device specific fb_blank.
>> + */
>> +static int s5p_dsim_notifier_callback(struct notifier_block *self,
>> + =A0 =A0 unsigned long event, void *data)
>> +{
>> + =A0 =A0 pm_message_t pm;
>> +
>> + =A0 =A0 pm.event =3D 0;
>
> do we really need to produce this pm structure.
>

It's unnecessary code, entered by mistake.
it will be removed.

>> + =A0 =A0 switch (event) {
>> + =A0 =A0 case FB_BLANK_UNBLANK:
>> + =A0 =A0 case FB_BLANK_NORMAL:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim.pd->mipi_power)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim.pd->mipi_power(&dsim, (vo=
id *) dsim.r_mipi_1_1v,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *) dsim.=
r_mipi_1_8v, 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(dsim.clock);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim.mipi_drv->resume)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim.mipi_drv->resume(dsim.dev=
);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_init_dsim(&dsim);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_init_link(&dsim);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_hs_enable(&dsim);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_data_transfer_mode(&dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSIM_TRANSFER_BYCPU, 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* it needs delay for stabilization */
>> + =A0 =A0 =A0 =A0 =A0 =A0 mdelay(dsim.pd->delay_for_stabilization);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim.mipi_drv->init)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim.mipi_drv->init(dsim.dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim.dev, "init func =
is null.\n");
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_display_mode(&dsim, dsim.dsim_lcd=
_info, NULL);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TR=
ANSFER_BYLCDC, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim.mipi_ddi_pd->resume_complete =3D 1;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim.dev, "FB_BLANK_NORMAL or UNBLANK.=
\n");
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FB_BLANK_POWERDOWN:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim.mipi_ddi_pd->resume_complete =3D 0;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim.mipi_drv->suspend)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim.mipi_drv->suspend(dsim.de=
v, pm);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(dsim.clock);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim.pd->mipi_power)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim.pd->mipi_power(&dsim, (vo=
id *) dsim.r_mipi_1_1v,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *) dsim.=
r_mipi_1_8v, 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim.dev, "FB_BLANK_POWERDOWN.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim.dev, "unknown FB_BLANK command.\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int s5p_dsim_register_notif(struct device *dev)
>> +{
>> + =A0 =A0 memset(&dsim.s3cfb_notif, 0, sizeof(struct notifier_block));
>> + =A0 =A0 dsim.s3cfb_notif.notifier_call =3D s5p_dsim_notifier_callback;
>> +
>> + =A0 =A0 return 0/*s3cfb_register_client(&dsim.s3cfb_notif)*/;
>> +}
>> +
>> +static irqreturn_t s5p_dsim_interrupt_handler(int irq, void *dev_id)
>> +{
>> + =A0 =A0 disable_irq(irq);
>> +
>> + =A0 =A0 /* additional work. */
>> +
>> + =A0 =A0 enable_irq(irq);
>> +
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>
> ?
>
>> +
>> +int s5p_dsim_register_lcd_driver(struct mipi_lcd_driver *lcd_drv)
>> +{
>> + =A0 =A0 struct mipi_lcd_info =A0 =A0*lcd_info =3D NULL;
>> +
>> + =A0 =A0 lcd_info =3D kmalloc(sizeof(struct mipi_lcd_info), GFP_KERNEL);
>> + =A0 =A0 if (lcd_info =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 lcd_info->mipi_drv =3D kmalloc(sizeof(struct mipi_lcd_driver),
>> + =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
>> + =A0 =A0 if (lcd_info->mipi_drv =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> +
>> + =A0 =A0 memcpy(lcd_info->mipi_drv, lcd_drv, sizeof(struct mipi_lcd_dri=
ver));
>> +
>> + =A0 =A0 mutex_lock(&mipi_lock);
>> + =A0 =A0 list_add_tail(&lcd_info->list, &lcd_info_list);
>> + =A0 =A0 mutex_unlock(&mipi_lock);
>> +
>> + =A0 =A0 dev_dbg(dsim.dev, "registered panel driver(%s) to mipi-dsi dri=
ver.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 lcd_drv->name);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * This function is wrapper for changing transfer mode.
>> + * It is used to in panel driver before and after changing gamma value.
>> + */
>> +static int s5p_dsim_change_transfer_mode(int mode)
>> +{
>> + =A0 =A0 if (mode < 0 || mode > 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim.dev, "mode range should be 0 or 1=
.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (mode =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_data_transfer_mode(&dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSIM_TRANSFER_BYCPU, mode);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_data_transfer_mode(&dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSIM_TRANSFER_BYLCDC, mode);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +struct mipi_lcd_driver *scan_mipi_driver(const char *name)
>> +{
>> + =A0 =A0 struct mipi_lcd_info *lcd_info;
>> + =A0 =A0 struct mipi_lcd_driver *mipi_drv =3D NULL;
>> +
>> + =A0 =A0 mutex_lock(&mipi_lock);
>> +
>> + =A0 =A0 dev_dbg(dsim.dev, "find lcd panel driver(%s).\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 name);
>> +
>> + =A0 =A0 list_for_each_entry(lcd_info, &lcd_info_list, list) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mipi_drv =3D lcd_info->mipi_drv;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((strcmp(mipi_drv->name, name)) =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&mipi_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim.dev, "found!!!(%s=
).\n", mipi_drv->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mipi_drv;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dev_warn(dsim.dev, "failed to find lcd panel driver(%s).\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 name);
>> +
>> + =A0 =A0 mutex_unlock(&mipi_lock);
>> +
>> + =A0 =A0 return NULL;
>> +}
>> +
>> +static int s5p_dsim_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct resource *res;
>> + =A0 =A0 int ret =3D -1;
>> +
>> + =A0 =A0 dsim.pd =3D to_dsim_plat(&pdev->dev);
>> + =A0 =A0 dsim.dev =3D &pdev->dev;
>> +
>> + =A0 =A0 /* set dsim config data, dsim lcd config data and lcd panel da=
ta. */
>> + =A0 =A0 dsim.dsim_info =3D dsim.pd->dsim_info;
>> + =A0 =A0 dsim.dsim_lcd_info =3D dsim.pd->dsim_lcd_info;
>> + =A0 =A0 dsim.lcd_panel_info =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 (struct fb_videomode *) dsim.dsim_lcd_info->lc=
d_panel_info;
>
> why isn't this in the correct type to begin with.
>
I used 'void *' type to avoid including header.


>> + =A0 =A0 dsim.mipi_ddi_pd =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 (struct mipi_ddi_platform_data *)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim.dsim_lcd_info->mipi_ddi_p=
d;
>
> and again.
>

also.

>> + =A0 =A0 dsim.mipi_ddi_pd->resume_complete =3D 0;
>> +
>> + =A0 =A0 dsim.r_mipi_1_1v =3D regulator_get(&pdev->dev, "VMIPI_1.1V");
>> + =A0 =A0 if (IS_ERR(dsim.r_mipi_1_1v)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get regulator V=
MIPI_1.1V.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto regulator_get_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dsim.r_mipi_1_8v =3D regulator_get(&pdev->dev, "VMIPI_1.8V");
>> + =A0 =A0 if (IS_ERR(dsim.r_mipi_1_8v)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get regulator V=
MIPI_1.8V.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto regulator_get_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* clock */
>> + =A0 =A0 dsim.clock =3D clk_get(&pdev->dev, dsim.pd->clk_name);
>> + =A0 =A0 if (IS_ERR(dsim.clock)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get dsim clock =
source\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 clk_enable(dsim.clock);
>> +
>> + =A0 =A0 /* io memory */
>> + =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + =A0 =A0 if (!res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get io memory r=
egion\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk_disable;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* request mem region */
>> + =A0 =A0 res =3D request_mem_region(res->start,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res->end - =
res->start + 1, pdev->name);
> resource_size()
>

ok.

>> + =A0 =A0 if (!res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to request io memo=
ry region\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk_disable;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* ioremap for register block */
>> + =A0 =A0 dsim.reg_base =3D (unsigned int) ioremap(res->start,
>> + =A0 =A0 =A0 =A0 =A0 =A0 res->end - res->start + 1);
>
> ARGH. dsim.reg_base should be 'void __iomem *'
>

ok, it would be modified.

>> + =A0 =A0 if (!dsim.reg_base) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to remap io region=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk_disable;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* it is used for MIPI-DSI based lcd panel driver. */
>> + =A0 =A0 dsim.mipi_ddi_pd->dsim_data =3D (void *)&dsim;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* it uses frame done interrupt handler
>> + =A0 =A0 =A0* only in case of MIPI Video mode.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (dsim.dsim_lcd_info->e_interface =3D=3D DSIM_VIDEO) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim.irq =3D platform_get_irq(pdev, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (request_irq(dsim.irq, s5p_dsim_interrupt_h=
andler,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_TRIGGER_R=
ISING, "mipi-dsi", &dsim)) {
>
> do internal interrupts really need a trigger flag?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "request_i=
rq failed.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_trigger_irq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (dsim.pd->mipi_power)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim.pd->mipi_power(&dsim, (void *) dsim.r_mip=
i_1_1v,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *) dsim.r_mipi_1_8v, 1);
>> + =A0 =A0 else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "mipi_power is NULL.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto mipi_power_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* find lcd panel driver registered to mipi-dsi driver. */
>> + =A0 =A0 dsim.mipi_drv =3D scan_mipi_driver(dsim.pd->lcd_panel_name);
>> + =A0 =A0 if (dsim.mipi_drv =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "mipi_drv is NULL.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto mipi_drv_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* register callback functions that lcd panel driver needs. */
>> + =A0 =A0 dsim.mipi_ddi_pd->cmd_write =3D s5p_dsim_wr_data;
>> + =A0 =A0 dsim.mipi_ddi_pd->cmd_read =3D NULL;
>> + =A0 =A0 dsim.mipi_ddi_pd->get_dsim_frame_done =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_get_frame_done_status;
>> + =A0 =A0 dsim.mipi_ddi_pd->clear_dsim_frame_done =3D s5p_dsim_clear_fra=
me_done;
>> + =A0 =A0 dsim.mipi_ddi_pd->change_dsim_transfer_mode =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_change_transfer_mode;
>> + =A0 =A0 dsim.mipi_ddi_pd->get_fb_frame_done =3D dsim.pd->get_fb_frame_=
done;
>> + =A0 =A0 dsim.mipi_ddi_pd->trigger =3D dsim.pd->trigger;
>
> this looks like it should have been in a struture to be copied.
>

ok, it's good point. it would be modified.

>> + =A0 =A0 /* set lcd panel driver link */
>> + =A0 =A0 ret =3D dsim.mipi_drv->set_link(dsim.mipi_ddi_pd);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to set link.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto mipi_drv_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dsim.mipi_drv->probe(&pdev->dev);
>> +
>> + =A0 =A0 s5p_dsim_init_dsim(&dsim);
>> + =A0 =A0 s5p_dsim_init_link(&dsim);
>> +
>> + =A0 =A0 s5p_dsim_set_hs_enable(&dsim);
>> + =A0 =A0 s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TRANSFER_BYCPU, 1);
>> +
>> + =A0 =A0 /* it needs delay for stabilization */
>> + =A0 =A0 mdelay(dsim.pd->delay_for_stabilization);
>> +
>> + =A0 =A0 /* initialize lcd panel */
>> + =A0 =A0 if (dsim.mipi_drv->init)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim.mipi_drv->init(&pdev->dev);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&pdev->dev, "init func is null.\n");
>> +
>> + =A0 =A0 if (dsim.mipi_drv->display_on)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim.mipi_drv->display_on(&pdev->dev);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&pdev->dev, "display_on func is null.=
\n");
>> +
>> + =A0 =A0 s5p_dsim_set_display_mode(&dsim, dsim.dsim_lcd_info, NULL);
>> +
>> + =A0 =A0 s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TRANSFER_BYLCDC, 1=
);
>> +
>> + =A0 =A0 s5p_dsim_register_notif(&pdev->dev);
>> +
>> + =A0 =A0 /* in case of command mode, trigger. */
>> + =A0 =A0 if (dsim.dsim_lcd_info->e_interface =3D=3D DSIM_COMMAND) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim.pd->trigger)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim.pd->trigger(registered_fb=
[0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&pdev->dev, "trigger =
is null.\n");
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dev_info(&pdev->dev, "mipi-dsi driver(%s mode) has been probed=
.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim.dsim_lcd_info->e_interface =3D=3D DSIM_C=
OMMAND) ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CPU" : "RGB");
>> +
>> + =A0 =A0 return 0;
>> +
>> +err_trigger_irq:
>> +mipi_drv_err:
>> + =A0 =A0 dsim.pd->mipi_power(&dsim, (void *) dsim.r_mipi_1_1v,
>> + =A0 =A0 =A0 =A0 =A0 =A0 (void *) dsim.r_mipi_1_8v, 0);
>> +
>> +mipi_power_err:
>> + =A0 =A0 iounmap((void __iomem *) dsim.reg_base);
>> +
>> +err_clk_disable:
>> + =A0 =A0 clk_disable(dsim.clock);
>> +
>> +regulator_get_err:
>> +
>> + =A0 =A0 return ret;
>> +
>> +}
>> +
>> +static int s5p_dsim_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +int s5p_dsim_suspend(struct platform_device *pdev, pm_message_t state)
>> +{
>> + =A0 =A0 dsim.mipi_ddi_pd->resume_complete =3D 0;
>> +
>> + =A0 =A0 if (dsim.mipi_drv->suspend)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim.mipi_drv->suspend(&pdev->dev, state);
>> +
>> + =A0 =A0 clk_disable(dsim.clock);
>> +
>> + =A0 =A0 if (dsim.pd->mipi_power)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim.pd->mipi_power(&dsim, (void *) dsim.r_mip=
i_1_1v,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *) dsim.r_mipi_1_8v, 0);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_dsim_resume(struct platform_device *pdev)
>> +{
>> + =A0 =A0 if (dsim.pd->mipi_power)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim.pd->mipi_power(&dsim, (void *) dsim.r_mip=
i_1_1v,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *) dsim.r_mipi_1_8v, 1);
>> +
>> + =A0 =A0 clk_enable(dsim.clock);
>> +
>> + =A0 =A0 if (dsim.mipi_drv->resume)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim.mipi_drv->resume(&pdev->dev);
>> +
>> + =A0 =A0 s5p_dsim_init_dsim(&dsim);
>> + =A0 =A0 s5p_dsim_init_link(&dsim);
>> +
>> + =A0 =A0 s5p_dsim_set_hs_enable(&dsim);
>> + =A0 =A0 s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TRANSFER_BYCPU, 1);
>> +
>> + =A0 =A0 /* it needs delay for stabilization */
>> + =A0 =A0 mdelay(dsim.pd->delay_for_stabilization);
>> +
>> + =A0 =A0 /* initialize lcd panel */
>> + =A0 =A0 if (dsim.mipi_drv->init)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim.mipi_drv->init(&pdev->dev);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&pdev->dev, "init func is null.\n");
>> +
>> + =A0 =A0 s5p_dsim_set_display_mode(&dsim, dsim.dsim_lcd_info, NULL);
>> +
>> + =A0 =A0 s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TRANSFER_BYLCDC, 1=
);
>> +
>> + =A0 =A0 dsim.mipi_ddi_pd->resume_complete =3D 1;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +#else
>> +#define s5p_dsim_suspend NULL
>> +#define s5p_dsim_resume NULL
>> +#endif
>> +
>> +static struct platform_driver s5p_dsim_driver =3D {
>> + =A0 =A0 .probe =3D s5p_dsim_probe,
>> + =A0 =A0 .remove =3D s5p_dsim_remove,
>> + =A0 =A0 .suspend =3D s5p_dsim_suspend,
>> + =A0 =A0 .resume =3D s5p_dsim_resume,
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "s5p-dsim",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
>> + =A0 =A0 },
>> +};
>> +
>> +static int s5p_dsim_register(void)
>> +{
>> + =A0 =A0 platform_driver_register(&s5p_dsim_driver);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void s5p_dsim_unregister(void)
>> +{
>> + =A0 =A0 platform_driver_unregister(&s5p_dsim_driver);
>> +}
>> +
>> +module_init(s5p_dsim_register);
>> +module_exit(s5p_dsim_unregister);
>> +
>> +MODULE_AUTHOR("InKi Dae <inki.dae@samsung.com>");
>> +MODULE_DESCRIPTION("Samusung MIPI-DSIM driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/video/s5p_dsim_common.c b/drivers/video/s5p_dsim_co=
mmon.c
>> new file mode 100644
>> index 0000000..77724dc
>> --- /dev/null
>> +++ b/drivers/video/s5p_dsim_common.c
>> @@ -0,0 +1,753 @@
>> +/* linux/drivers/video/samsung/s5p_dsim_common.c
>> + *
>> + * Samsung MIPI-DSIM common driver.
>> + *
>> + * InKi Dae, <inki.dae@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/errno.h>
>> +#include <linux/mutex.h>
>> +#include <linux/wait.h>
>> +#include <linux/fs.h>
>> +#include <linux/mm.h>
>> +#include <linux/fb.h>
>> +#include <linux/ctype.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +#include <linux/memory.h>
>> +#include <linux/delay.h>
>> +#include <linux/kthread.h>
>> +
>> +#include <plat/fb.h>
>> +#include <plat/regs-dsim.h>
>> +
>> +#include <mach/map.h>
>> +#include <plat/dsim.h>
>> +#include <plat/mipi_ddi.h>
>> +
>> +#include "s5p_dsim_lowlevel.h"
>> +
>> +static void s5p_dsim_long_data_wr(struct dsim_global *dsim, unsigned in=
t data0,
>> + =A0 =A0 unsigned int data1)
>> +{
>> + =A0 =A0 unsigned int data_cnt =3D 0, payload =3D 0;
>> +
>> + =A0 =A0 /* in case that data count is more then 4 */
>> + =A0 =A0 for (data_cnt =3D 0; data_cnt < data1; data_cnt +=3D 4) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* after sending 4bytes per one time,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* send remainder data less then 4.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((data1 - data_cnt) < 4) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((data1 - data_cnt) =3D=3D =
3) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 payload =3D *(=
u8 *)(data0 + data_cnt) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*(u8 =
*)(data0 + (data_cnt + 1))) << 8 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (*(u8 *)(data0 + (data_cnt + 2))) << 16;
>
> Erm, why wheren't these types kept as 'u8 *', this amount of casting
> should be ringing alarm bells all over the place.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev, "count =3D =
3 payload =3D %x, %x %x %x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 payload, *(u8 =
*)(data0 + data_cnt),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 1)),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 2)));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if ((data1 - data_cnt) =
=3D=3D 2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 payload =3D *(=
u8 *)(data0 + data_cnt) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (*(u8 *)(data0 + (data_cnt + 1))) << 8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "count =3D 2 p=
ayload =3D %x, %x %x\n", payload,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ data_cnt),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 1)));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if ((data1 - data_cnt) =
=3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 payload =3D *(=
u8 *)(data0 + data_cnt);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_wr_tx_data(dsim, payl=
oad);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* send 4bytes per one time. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 payload =3D *(u8 *)(data0 + da=
ta_cnt) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*(u8 *)(data0=
 + (data_cnt + 1))) << 8 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*(u8 *)(data0=
 + (data_cnt + 2))) << 16 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*(u8 *)(data0=
 + (data_cnt + 3))) << 24;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "count =3D 4 p=
ayload =3D %x, %x %x %x %x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 payload, *(u8 =
*)(data0 + data_cnt),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 1)),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 2)),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 3)));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_wr_tx_data(dsim, payl=
oad);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +}
>> +
>> +int s5p_dsim_wr_data(void *dsim_data, unsigned int data_id,
>> + =A0 =A0 unsigned int data0, unsigned int data1)
>> +{
>> + =A0 =A0 struct dsim_global *dsim =3D NULL;
>> + =A0 =A0 unsigned int timeout =3D 5000 * 2;
>> + =A0 =A0 unsigned long delay_val, udelay;
>> + =A0 =A0 unsigned char check_rx_ack =3D 0;
>> +
>> + =A0 =A0 dsim =3D (struct dsim_global *)dsim_data;
>> +
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev, "dsim_data is NULL.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> +
>> + =A0 =A0 if (dsim->state =3D=3D DSIM_STATE_ULPS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev, "state is ULPS.\n");
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 delay_val =3D 1000000 / dsim->dsim_info->esc_clk;
>> + =A0 =A0 udelay =3D 10 * delay_val;
>> +
>> + =A0 =A0 mdelay(udelay);
>> +
>> + =A0 =A0 /* only if transfer mode is LPDT, wait SFR becomes empty. */
>> + =A0 =A0 if (dsim->state =3D=3D DSIM_STATE_STOP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 while (!(s5p_dsim_get_fifo_state(dsim) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SFR_HEADER_EMP=
TY)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((timeout--) > 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->=
dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "SRF header fifo is not empty.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 switch (data_id) {
>> + =A0 =A0 /* short packet types of packet types for command. */
>> + =A0 =A0 case GEN_SHORT_WR_NO_PARA:
>> + =A0 =A0 case GEN_SHORT_WR_1_PARA:
>> + =A0 =A0 case GEN_SHORT_WR_2_PARA:
>> + =A0 =A0 case DCS_WR_NO_PARA:
>> + =A0 =A0 case DCS_WR_1_PARA:
>> + =A0 =A0 case SET_MAX_RTN_PKT_SIZE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_wr_tx_header(dsim, (unsigned char) da=
ta_id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned char) data0, (unsign=
ed char) data1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (check_rx_ack)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* process response func shoul=
d be implemented */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /* general command */
>> + =A0 =A0 case CMD_OFF:
>> + =A0 =A0 case CMD_ON:
>> + =A0 =A0 case SHUT_DOWN:
>> + =A0 =A0 case TURN_ON:
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_wr_tx_header(dsim, (unsigned char) da=
ta_id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned char) data0, (unsign=
ed char) data1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (check_rx_ack)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* process response func shoul=
d be implemented. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /* packet types for video data */
>> + =A0 =A0 case VSYNC_START:
>> + =A0 =A0 case VSYNC_END:
>> + =A0 =A0 case HSYNC_START:
>> + =A0 =A0 case HSYNC_END:
>> + =A0 =A0 case EOT_PKT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 /* short and response packet types for command */
>> + =A0 =A0 case GEN_RD_1_PARA:
>> + =A0 =A0 case GEN_RD_2_PARA:
>> + =A0 =A0 case GEN_RD_NO_PARA:
>> + =A0 =A0 case DCS_RD_NO_PARA:
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_clear_interrupt(dsim, 0xffffffff);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_wr_tx_header(dsim, (unsigned char) da=
ta_id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned char) data0, (unsign=
ed char) data1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* process response func should be implemented=
. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 /* long packet type and null packet */
>> + =A0 =A0 case NULL_PKT:
>> + =A0 =A0 case BLANKING_PKT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 case GEN_LONG_WR:
>> + =A0 =A0 case DCS_LONG_WR:
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int size, data_cnt =3D 0, payload =3D=
 0;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 size =3D data1 * 4;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* if data count is less then 4, then send 3by=
tes data. =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (data1 < 4) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 payload =3D *(u8 *)(data0) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ 1) << 8 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ 2) << 16;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_wr_tx_data(dsim, payl=
oad);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev, "count =3D =
%d payload =3D %x,%x %x %x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data1, payload,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ data_cnt),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 1)),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 2)));
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* in case that data count is more then 4 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_long_data_wr(dsim, da=
ta0, data1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* put data into header fifo */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_wr_tx_header(dsim, (unsigned char) da=
ta_id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned char) (((unsigned sh=
ort) data1) & 0xff),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned char) ((((unsigned s=
hort) data1) & 0xff00) >>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8));
>> +
>> + =A0 =A0 }
>> + =A0 =A0 if (check_rx_ack)
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* process response func should be implemented=
. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /* packet typo for video data */
>> + =A0 =A0 case RGB565_PACKED:
>> + =A0 =A0 case RGB666_PACKED:
>> + =A0 =A0 case RGB666_LOOSLY:
>> + =A0 =A0 case RGB888_PACKED:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (check_rx_ack)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* process response func shoul=
d be implemented. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "data id %x is not supported c=
urrent DSI spec.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_id);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_dsim_init_header_fifo(struct dsim_global *dsim)
>> +{
>> + =A0 =A0 unsigned int cnt;
>> +
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "dsim_global pointer is NULL.\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 for (cnt =3D 0; cnt < DSIM_HEADER_FIFO_SZ; cnt++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->header_fifo_index[cnt] =3D -1;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_dsim_pll_on(struct dsim_global *dsim, unsigned char enable)
>
> how about 'bool' for enable.
>

ok, it would be modified.

>> +{
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "dsim_global pointer is NULL.\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int sw_timeout =3D 1000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_clear_interrupt(dsim, DSIM_PLL_STABLE=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_pll(dsim, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 while (1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sw_timeout--;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s5p_dsim_is_pll_stable(dsi=
m))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sw_timeout =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_pll(dsim, 0);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +unsigned long s5p_dsim_change_pll(struct dsim_global *dsim,
>> + =A0 =A0 unsigned char pre_divider, unsigned short main_divider,
>> + =A0 =A0 unsigned char scaler)
>> +{
>> + =A0 =A0 unsigned long dfin_pll, dfvco, dpll_out;
>> + =A0 =A0 unsigned char freq_band;
>> +
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "dsim_global pointer is NULL.\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dfin_pll =3D (MIPI_FIN / pre_divider);
>> +
>> + =A0 =A0 if (dfin_pll < 6 * 1000 * 1000 || dfin_pll > 12 * 1000 * 1000)=
 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev, "warning!!\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev, "fin_pll range is 6MHz ~ 1=
2MHz\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev, "fin_pll of mipi dphy pll =
is %luMHz\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dfin_pll / 1000000));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_afc(dsim, 0, 0);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dfin_pll < 7 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_afc(dsim, 1, 0=
x1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (dfin_pll < 8 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_afc(dsim, 1, 0=
x0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (dfin_pll < 9 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_afc(dsim, 1, 0=
x3);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (dfin_pll < 10 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_afc(dsim, 1, 0=
x2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (dfin_pll < 11 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_afc(dsim, 1, 0=
x5);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_afc(dsim, 1, 0=
x4);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dfvco =3D dfin_pll * main_divider;
>> + =A0 =A0 dev_dbg(dsim->dev, "dfvco =3D %lu, dfin_pll =3D %lu, main_divi=
der =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 dfvco, dfin_pll, main_divider);
>> + =A0 =A0 if (dfvco < 500000000 || dfvco > 1000000000) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev, "Caution!!\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev, "fvco range is 500MHz ~ 10=
00MHz\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev, "fvco of mipi dphy pll is =
%luMHz\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dfvco / 1000000));
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dpll_out =3D dfvco / (1 << scaler);
>> + =A0 =A0 dev_dbg(dsim->dev, "dpll_out =3D %lu, dfvco =3D %lu, scaler =
=3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 dpll_out, dfvco, scaler);
>> + =A0 =A0 if (dpll_out < 100 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0x0;
>> + =A0 =A0 else if (dpll_out < 120 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0x1;
>> + =A0 =A0 else if (dpll_out < 170 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0x2;
>> + =A0 =A0 else if (dpll_out < 220 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0x3;
>> + =A0 =A0 else if (dpll_out < 270 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0x4;
>> + =A0 =A0 else if (dpll_out < 320 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0x5;
>> + =A0 =A0 else if (dpll_out < 390 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0x6;
>> + =A0 =A0 else if (dpll_out < 450 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0x7;
>> + =A0 =A0 else if (dpll_out < 510 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0x8;
>> + =A0 =A0 else if (dpll_out < 560 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0x9;
>> + =A0 =A0 else if (dpll_out < 640 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0xa;
>> + =A0 =A0 else if (dpll_out < 690 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0xb;
>> + =A0 =A0 else if (dpll_out < 770 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0xc;
>> + =A0 =A0 else if (dpll_out < 870 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0xd;
>> + =A0 =A0 else if (dpll_out < 950 * 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0xe;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D 0xf;
>
> something says a divide down before the ompatr would have been
> a good idea, it is almost a table.
>
>> + =A0 =A0 dev_dbg(dsim->dev, "freq_band =3D %d\n", freq_band);
>> +
>> + =A0 =A0 s5p_dsim_pll_freq(dsim, pre_divider, main_divider, scaler);
>> +
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 unsigned char temp0, temp1;
>> +
>> + =A0 =A0 =A0 =A0 temp0 =3D 0;
>> + =A0 =A0 =A0 =A0 s5p_dsim_hs_zero_ctrl(dsim, temp0);
>> + =A0 =A0 =A0 =A0 temp1 =3D 0;
>> + =A0 =A0 =A0 =A0 s5p_dsim_prep_ctrl(dsim, temp1);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Freq Band */
>> + =A0 =A0 s5p_dsim_pll_freq_band(dsim, freq_band);
>> +
>> + =A0 =A0 /* Stable time */
>> + =A0 =A0 s5p_dsim_pll_stable_time(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->dsim_info->pll_stable_time);
>> +
>> + =A0 =A0 /* Enable PLL */
>> + =A0 =A0 dev_dbg(dsim->dev, "FOUT of mipi dphy pll is %luMHz\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dpll_out / 1000000));
>> +
>> + =A0 =A0 return dpll_out;
>> +}
>> +
>> +int s5p_dsim_set_clock(struct dsim_global *dsim,
>> + =A0 =A0 unsigned char byte_clk_sel, unsigned char enable)
>> +{
>> + =A0 =A0 unsigned int esc_div;
>> + =A0 =A0 unsigned long esc_clk_error_rate;
>> +
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "dsim_global pointer is NULL.\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>
> again, how about making this code WARN_ON?
>
>
>> + =A0 =A0 if (enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->e_clk_src =3D byte_clk_sel;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Escape mode clock and byte clock source */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_byte_clock_src(dsim, byte_clk_sel=
);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* DPHY, DSIM Link : D-PHY clock out */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (byte_clk_sel =3D=3D DSIM_PLL_OUT_DIV8) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->hs_clk =3D s5p_dsim_chan=
ge_pll(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->dsim_inf=
o->p, dsim->dsim_info->m,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->dsim_inf=
o->s);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dsim->hs_clk =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->=
dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "failed to get hs clock.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->byte_clk =3D dsim->hs_cl=
k / 8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_pll_bypass(dsi=
m, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_pll_on(dsim, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* DPHY : D-PHY clock out, DSIM link : externa=
l clock out */
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (byte_clk_sel =3D=3D DSIM_EXT_CLK_DI=
V8)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "this project =
is not support \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 external clock=
 source for MIPI DSIM\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (byte_clk_sel =3D=3D DSIM_EXT_CLK_BYPA=
SS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "this project =
is not support \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 external clock=
 source for MIPI DSIM\n");
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* escape clock divider */
>> + =A0 =A0 =A0 =A0 =A0 =A0 esc_div =3D dsim->byte_clk / (dsim->dsim_info-=
>esc_clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "esc_div =3D %d, byte_clk =3D =
%lu, esc_clk =3D %lu\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 esc_div, dsim->byte_clk, dsim-=
>dsim_info->esc_clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((dsim->byte_clk / esc_div) >=3D 20000000 ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dsim->byte_clk / esc_div) > d=
sim->dsim_info->esc_clk)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 esc_div +=3D 1;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->escape_clk =3D dsim->byte_clk / esc_div;
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "escape_clk =3D %lu, byte_clk =
=3D %lu, esc_div =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->escape_clk, dsim->byte_c=
lk, esc_div);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* enable escclk on lane
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* in case of evt0, DSIM_TRUE is enable and
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* DSIM_FALSE is enable for evt1.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim->pd->platform_rev =3D=3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_byte_clock(dsi=
m, DSIM_FALSE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_byte_clock(dsi=
m, DSIM_TRUE);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* enable byte clk and escape clock */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_esc_clk_prs(dsim, 1, esc_div);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* escape clock on lane */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_esc_clk_on_lane(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DSIM_LANE_CLOCK | dsim->data_=
lane), 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev, "byte clock is %luMHz\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dsim->byte_clk / 1000000));
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev, "escape clock that user's n=
eed is %lu\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dsim->dsim_info->esc_clk / 10=
00000));
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev, "escape clock divider is %x=
\n", esc_div);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev, "escape clock is %luMHz\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((dsim->byte_clk / esc_div) / =
1000000));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((dsim->byte_clk / esc_div) > dsim->escape_=
clk) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 esc_clk_error_rate =3D dsim->e=
scape_clk /
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dsim->byte_cl=
k / esc_div);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev, "error rat=
e is %lu over.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (esc_clk_error=
_rate / 100));
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if ((dsim->byte_clk / esc_div) < (dsim-=
>escape_clk)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 esc_clk_error_rate =3D (dsim->=
byte_clk / esc_div) /
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->escape_c=
lk;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev, "error rat=
e is %lu under.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (esc_clk_error=
_rate / 100));
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_esc_clk_on_lane(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DSIM_LANE_CLOCK | dsim->data_=
lane), 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_esc_clk_prs(dsim, 0, 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* in case of evt0, DSIM_FALSE is disable and
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* DSIM_TRUE is disable for evt1.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim->pd->platform_rev =3D=3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_byte_clock(dsi=
m, DSIM_TRUE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_byte_clock(dsi=
m, DSIM_FALSE);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (byte_clk_sel =3D=3D DSIM_PLL_OUT_DIV8)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_pll_on(dsim, 0);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_dsim_init_dsim(struct dsim_global *dsim)
>> +{
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "dsim_global pointer is NULL.\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (dsim->pd->init_d_phy)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->pd->init_d_phy(dsim);
>> +
>> + =A0 =A0 dsim->state =3D DSIM_STATE_RESET;
>> +
>> + =A0 =A0 switch (dsim->dsim_info->e_no_data_lane) {
>> + =A0 =A0 case DSIM_DATA_LANE_1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->data_lane =3D DSIM_LANE_DATA0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case DSIM_DATA_LANE_2:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->data_lane =3D DSIM_LANE_DATA0 | DSIM_LAN=
E_DATA1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case DSIM_DATA_LANE_3:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->data_lane =3D DSIM_LANE_DATA0 | DSIM_LAN=
E_DATA1 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSIM_LANE_DATA2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case DSIM_DATA_LANE_4:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->data_lane =3D DSIM_LANE_DATA0 | DSIM_LAN=
E_DATA1 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSIM_LANE_DATA2 | DSIM_LANE_DA=
TA3;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dsim->dev, "data lane is invalid.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 };
>> +
>> + =A0 =A0 s5p_dsim_init_header_fifo(dsim);
>> + =A0 =A0 s5p_dsim_sw_reset(dsim);
>> + =A0 =A0 s5p_dsim_dp_dn_swap(dsim, dsim->dsim_info->e_lane_swap);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_dsim_enable_frame_done_int(struct dsim_global *dsim, int enable)
>> +{
>> + =A0 =A0 /* enable only frame done interrupt */
>> + =A0 =A0 s5p_dsim_set_interrupt_mask(dsim, INTMSK_FRAME_DONE, enable);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_dsim_set_display_mode(struct dsim_global *dsim,
>> + =A0 =A0 struct dsim_lcd_config *main_lcd, struct dsim_lcd_config *sub_=
lcd)
>> +{
>> + =A0 =A0 struct fb_videomode *mlcd_video =3D NULL;
>> + =A0 =A0 struct fb_cmdmode *mlcd_command =3D NULL;
>> + =A0 =A0 struct s3c_fb_pd_win *pd;
>> + =A0 =A0 unsigned int width =3D 0, height =3D 0;
>> +
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "dsim_global pointer is NULL.\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 pd =3D (struct s3c_fb_pd_win *)main_lcd->lcd_panel_info;
>> +
>> + =A0 =A0 /* in case of VIDEO MODE (RGB INTERFACE) */
>> + =A0 =A0 if (dsim->dsim_lcd_info->e_interface =3D=3D (u32) DSIM_VIDEO) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mlcd_video =3D (struct fb_videomode *)&pd->win=
_mode;
>> + =A0 =A0 =A0 =A0 =A0 =A0 width =3D mlcd_video->xres;
>> + =A0 =A0 =A0 =A0 =A0 =A0 height =3D mlcd_video->yres;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim->dsim_info->auto_vertical_cnt =3D=3D =
DSIM_FALSE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_main_disp_vporch(=
dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mlcd_video->up=
per_margin,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mlcd_video->lo=
wer_margin, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_main_disp_hporch(=
dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mlcd_video->le=
ft_margin,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mlcd_video->ri=
ght_margin);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_main_disp_sync_ar=
ea(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mlcd_video->vs=
ync_len,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mlcd_video->hs=
ync_len);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else { =A0 =A0 =A0 =A0/* in case of COMMAND MODE (CPU or I80=
 INTERFACE) */
>> + =A0 =A0 =A0 =A0 =A0 =A0 mlcd_command =3D (struct fb_cmdmode *)&pd->cmd=
_mode;
>> + =A0 =A0 =A0 =A0 =A0 =A0 width =3D mlcd_command->xres;
>> + =A0 =A0 =A0 =A0 =A0 =A0 height =3D mlcd_command->yres;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 s5p_dsim_set_main_disp_resol(dsim, height, width);
>> +
>> + =A0 =A0 if (sub_lcd !=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev, "sub lcd i=
sn't supported yet.\n");
>> +
>> + =A0 =A0 s5p_dsim_display_config(dsim, dsim->dsim_lcd_info, NULL);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_dsim_init_link(struct dsim_global *dsim)
>> +{
>> + =A0 =A0 unsigned int time_out =3D 100;
>> +
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "dsim_global pointer is NULL.\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 switch (dsim->state) {
>> + =A0 =A0 case DSIM_STATE_RESET:
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_sw_reset(dsim);
>> + =A0 =A0 case DSIM_STATE_INIT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_init_fifo_pointer(dsim, 0x1f);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* dsi configuration */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_init_config(dsim, dsim->dsim_lcd_info,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, dsim->dsim_info);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_lane(dsim, DSIM_LANE_CLOCK, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_lane(dsim, dsim->data_lane, 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* set clock configuration */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_clock(dsim, dsim->dsim_info->e_by=
te_clk,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* check clock and data lane state is stop sta=
te */
>> + =A0 =A0 =A0 =A0 =A0 =A0 while (!(s5p_dsim_is_lane_state(dsim, DSIM_LAN=
E_CLOCK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D DSIM_LANE_STATE=
_STOP) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(s5p_dsim_is_lane_state(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->data_lan=
e) =3D=3D DSIM_LANE_STATE_STOP)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 time_out--;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_out =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dsim-=
>dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "DSI Master is not stop state.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dsim-=
>dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "Check initialization process\n");
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (time_out !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "initializatio=
n of DSI Master is successful\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dsim->dev, "DSI Maste=
r state is stop state\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->state =3D DSIM_STATE_STOP;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* BTA sequence counters */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_stop_state_counter(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->dsim_info->stop_holding_=
cnt);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_bta_timeout(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->dsim_info->bta_timeout);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_lpdr_timeout(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->dsim_info->rx_timeout);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* default LPDT by both cpu and lcd controller=
 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_data_mode(dsim, DSIM_TRANSFER_BOT=
H,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSIM_STATE_STOP);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dsim->dev, "DSI Master is already ini=
t.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_dsim_set_hs_enable(struct dsim_global *dsim)
>> +{
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "dsim_global pointer is NULL.\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (dsim->state =3D=3D DSIM_STATE_STOP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim->e_clk_src !=3D DSIM_EXT_CLK_BYPASS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->state =3D DSIM_STATE_HSC=
LKEN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_data_mode(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSIM_TRANSFER_=
BOTH, DSIM_STATE_HSCLKEN);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_enable_hs_clock(dsim,=
 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "clock source =
is external bypass.\n");
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev, "DSIM is not stop state.\n=
");
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_dsim_set_data_transfer_mode(struct dsim_global *dsim,
>> + =A0 =A0 unsigned char data_path, unsigned char hs_enable)
>> +{
>> + =A0 =A0 int ret =3D -1;
>> +
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "dsim_global pointer is NULL.\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (hs_enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim->state =3D=3D DSIM_STATE_HSCLKEN) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_data_mode(dsim, d=
ata_path,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSIM_STATE_HSC=
LKEN);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev, "HS Clock l=
ane is not enabled.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim->state =3D=3D DSIM_STATE_INIT || dsim=
->state =3D=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSIM_STATE_ULPS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "DSI Master is=
 not STOP or HSDT state.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_dsim_set_data_mode(dsim, d=
ata_path,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSIM_STATE_STO=
P);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +int s5p_dsim_get_frame_done_status(void *dsim_data)
>> +{
>> + =A0 =A0 struct dsim_global *dsim =3D NULL;
>> +
>> + =A0 =A0 dsim =3D (struct dsim_global *)dsim_data;
>> +
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev, "dsim_global pointer is NUL=
L.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return _s5p_dsim_get_frame_done_status(dsim);
>> +}
>> +
>> +int s5p_dsim_clear_frame_done(void *dsim_data)
>> +{
>> + =A0 =A0 struct dsim_global *dsim =3D NULL;
>> +
>> + =A0 =A0 dsim =3D (struct dsim_global *)dsim_data;
>> +
>> + =A0 =A0 if (dsim =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev, "dsim_global pointer is NUL=
L.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 _s5p_dsim_clear_frame_done(dsim);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +MODULE_AUTHOR("InKi Dae <inki.dae@samsung.com>");
>> +MODULE_DESCRIPTION("Samusung MIPI-DSIM common driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/video/s5p_dsim_common.h b/drivers/video/s5p_dsim_co=
mmon.h
>> new file mode 100644
>> index 0000000..deefca1
>> --- /dev/null
>> +++ b/drivers/video/s5p_dsim_common.h
>> @@ -0,0 +1,38 @@
>> +/* linux/drivers/video/samsung/s5p_dsim_common.h
>> + *
>> + * Header file for Samsung MIPI-DSI common driver.
>> + *
>> + * Copyright (c) 2009 Samsung Electronics
>> + * InKi Dae <inki.dae@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#ifndef _S5P_DSIM_COMMON_H
>> +#define _S5P_DSIM_COMMON_H
>> +
>> +extern int s5p_dsim_wr_data(void *dsim_data, unsigned int data_id,
>> + =A0 =A0 unsigned int data0, unsigned int data1);
>> +extern int s5p_dsim_init_header_fifo(struct dsim_global *dsim);
>> +extern int s5p_dsim_pll_on(struct dsim_global *dsim, unsigned char enab=
le);
>> +extern unsigned long s5p_dsim_change_pll(struct dsim_global *dsim,
>> + =A0 =A0 unsigned char pre_divider, unsigned short main_divider,
>> + =A0 =A0 unsigned char scaler);
>> +extern int s5p_dsim_set_clock(struct dsim_global *dsim,
>> + =A0 =A0 unsigned char byte_clk_sel, unsigned char enable);
>> +extern int s5p_dsim_init_dsim(struct dsim_global *dsim);
>> +extern int s5p_dsim_set_display_mode(struct dsim_global *dsim,
>> + =A0 =A0 struct dsim_lcd_config *main_lcd, struct dsim_lcd_config *sub_=
lcd);
>> +extern int s5p_dsim_init_link(struct dsim_global *dsim);
>> +extern int s5p_dsim_set_hs_enable(struct dsim_global *dsim);
>> +extern int s5p_dsim_set_data_transfer_mode(struct dsim_global *dsim,
>> + =A0 =A0 unsigned char data_path, unsigned char hs_enable);
>> +extern int s5p_dsim_get_frame_done_status(void *dsim_data);
>> +extern int s5p_dsim_clear_frame_done(void *dsim_data);
>> +extern int s5p_dsim_enable_frame_done_int(struct dsim_global *dsim, int=
 enable);
>> +
>> +extern struct fb_info *registered_fb[FB_MAX] __read_mostly;
>> +
>> +#endif /* _S5P_DSIM_COMMON_H */
>> diff --git a/drivers/video/s5p_dsim_lowlevel.c b/drivers/video/s5p_dsim_=
lowlevel.c
>> new file mode 100644
>> index 0000000..6a27395
>> --- /dev/null
>> +++ b/drivers/video/s5p_dsim_lowlevel.c
>> @@ -0,0 +1,562 @@
>> +/* linux/drivers/video/samsung/s5p-dsim.c
>> + *
>> + * Samsung MIPI-DSIM lowlevel driver.
>> + *
>> + * InKi Dae, <inki.dae@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/errno.h>
>> +#include <linux/mutex.h>
>> +#include <linux/wait.h>
>> +#include <linux/delay.h>
>> +#include <linux/fs.h>
>> +#include <linux/mm.h>
>> +#include <linux/ctype.h>
>> +#include <linux/io.h>
>> +
>> +#include <mach/map.h>
>> +
>> +#include <plat/dsim.h>
>> +#include <plat/mipi_ddi.h>
>> +#include <plat/regs-dsim.h>
>> +
>> +void s5p_dsim_func_reset(struct dsim_global *dsim)
>> +{
>> + =A0 =A0 unsigned int cfg =3D 0;
>> +
>> + =A0 =A0 cfg =3D DSIM_FUNCRST;
>> +
>> + =A0 =A0 writel(cfg, dsim->reg_base + S5P_DSIM_SWRST);
>> +}
>
> so much easier to do
> =A0 =A0 =A0 =A0writel(DSIM_FUNCRST, dsim->reg_base + S5P_DSIM_SWRST);
>
> much less space needed.
>

it wouldn't be cleanned. :)

>
>> +void s5p_dsim_sw_reset(struct dsim_global *dsim)
>> +{
>> + =A0 =A0 unsigned int cfg =3D 0;
>> +
>> + =A0 =A0 cfg =3D DSIM_SWRST;
>> +
>> + =A0 =A0 writel(cfg, dsim->reg_base + S5P_DSIM_SWRST);
>> +}
>> +
>> +void s5p_dsim_set_interrupt_mask(struct dsim_global *dsim, unsigned int=
 mode,
>> + =A0 =A0 unsigned int mask)
>> +{
>
> bool for mask.
>

ok, it would be modified.

>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_INTMSK);
>> +
>> + =A0 =A0 if (mask)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D mode;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(mode);
>
> no need for () around mode.
>
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_INTMSK);
>> +}
>> +
>> +void s5p_dsim_init_fifo_pointer(struct dsim_global *dsim, unsigned char=
 cfg)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 reg =3D readl(dsim->reg_base + S5P_DSIM_FIFOCTRL);
>> +
>> + =A0 =A0 writel(reg & ~(cfg), dsim->reg_base + S5P_DSIM_FIFOCTRL);
>> + =A0 =A0 mdelay(10);
>> + =A0 =A0 reg |=3D cfg;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_FIFOCTRL);
>> +}
>> +
>> +/*
>> + * this function set PLL P, M and S value in D-PHY
>> + */
>> +void s5p_dsim_set_phy_tunning(struct dsim_global *dsim, unsigned int va=
lue)
>> +{
>> + =A0 =A0 writel(DSIM_AFC_CTL(value), dsim->reg_base + S5P_DSIM_PHYACCHR=
);
>> +}
>> +
>> +void s5p_dsim_set_main_disp_resol(struct dsim_global *dsim,
>> + =A0 =A0 unsigned short vert_resol, unsigned short hori_resol)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 /* standby should be set after configuration so set to not rea=
dy*/
>> + =A0 =A0 reg =3D (readl(dsim->reg_base + S5P_DSIM_MDRESOL)) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(DSIM_MAIN_STAND_BY);
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_MDRESOL);
>> +
>> + =A0 =A0 reg &=3D ~(0x7ff << 16) & ~(0x7ff << 0);
>> + =A0 =A0 reg |=3D DSIM_MAIN_VRESOL(vert_resol) | DSIM_MAIN_HRESOL(hori_=
resol);
>> +
>> + =A0 =A0 reg |=3D DSIM_MAIN_STAND_BY;
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_MDRESOL);
>> +}
>> +
>> +void s5p_dsim_set_main_disp_vporch(struct dsim_global *dsim,
>> + =A0 =A0 unsigned int cmd_allow, unsigned int vfront, unsigned int vbac=
k)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 reg =3D (readl(dsim->reg_base + S5P_DSIM_MVPORCH)) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(DSIM_CMD_ALLOW_MASK) & ~(DSIM_STABLE_VFP_MAS=
K) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(DSIM_MAIN_VBP_MASK);
>> +
>> + =A0 =A0 reg |=3D ((cmd_allow & 0xf) << DSIM_CMD_ALLOW_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((vfront & 0x7ff) << DSIM_STABLE_VFP_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((vback & 0x7ff) << DSIM_MAIN_VBP_SHIFT);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_MVPORCH);
>> +}
>> +
>> +void s5p_dsim_set_main_disp_hporch(struct dsim_global *dsim,
>> + =A0 =A0 unsigned short front, unsigned short back)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 reg =3D (readl(dsim->reg_base + S5P_DSIM_MHPORCH)) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(DSIM_MAIN_HFP_MASK) & ~(DSIM_MAIN_HBP_MASK);
>> +
>> + =A0 =A0 reg |=3D (front << DSIM_MAIN_HFP_SHIFT) | (back << DSIM_MAIN_H=
BP_SHIFT);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_MHPORCH);
>> +}
>> +
>> +void s5p_dsim_set_main_disp_sync_area(struct dsim_global *dsim,
>> + =A0 =A0 unsigned short vert, unsigned short hori)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 reg =3D (readl(dsim->reg_base + S5P_DSIM_MSYNC)) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(DSIM_MAIN_VSA_MASK) & ~(DSIM_MAIN_HSA_MASK);
>> +
>> + =A0 =A0 reg |=3D ((vert & 0x3ff) << DSIM_MAIN_VSA_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (hori << DSIM_MAIN_HSA_SHIFT);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_MSYNC);
>> +}
>> +
>> +void s5p_dsim_set_sub_disp_resol(struct dsim_global *dsim,
>> + =A0 =A0 unsigned short vert, unsigned short hori)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 reg =3D (readl(dsim->reg_base + S5P_DSIM_SDRESOL)) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(DSIM_SUB_STANDY_MASK);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_SDRESOL);
>> +
>> + =A0 =A0 reg &=3D ~(DSIM_SUB_VRESOL_MASK) | ~(DSIM_SUB_HRESOL_MASK);
>> + =A0 =A0 reg |=3D ((vert & 0x7ff) << DSIM_SUB_VRESOL_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((hori & 0x7ff) << DSIM_SUB_HRESOL_SHIFT);
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_SDRESOL);
>> +
>> + =A0 =A0 reg |=3D (1 << DSIM_SUB_STANDY_SHIFT);
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_SDRESOL);
>> +}
>> +
>> +void s5p_dsim_init_config(struct dsim_global *dsim,
>> + =A0 =A0 struct dsim_lcd_config *main_lcd_info,
>> + =A0 =A0 struct dsim_lcd_config *sub_lcd_info, struct dsim_config *dsim=
_info)
>> +{
>> + =A0 =A0 unsigned int cfg =3D (readl(dsim->reg_base + S5P_DSIM_CONFIG))=
 &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(1 << 28) & ~(0x1f << 20) & ~(0x3 << 5);
>> +
>> + =A0 =A0 cfg =3D =A0 (dsim_info->auto_flush << 29) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim_info->eot_disable << 28) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim_info->auto_vertical_cnt << DSIM_AUTO_MOD=
E_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim_info->hse << DSIM_HSE_MODE_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim_info->hfp << DSIM_HFP_MODE_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim_info->hbp << DSIM_HBP_MODE_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim_info->hsa << DSIM_HSA_MODE_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim_info->e_no_data_lane << DSIM_NUM_OF_DATA=
LANE_SHIFT);
>> +
>> + =A0 =A0 writel(cfg, dsim->reg_base + S5P_DSIM_CONFIG);
>> +}
>> +
>> +void s5p_dsim_display_config(struct dsim_global *dsim,
>> + =A0 =A0 struct dsim_lcd_config *main_lcd, struct dsim_lcd_config *sub_=
lcd)
>> +{
>> + =A0 =A0 u32 reg =3D (readl(dsim->reg_base + S5P_DSIM_CONFIG)) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0x3 << 26) & ~(1 << 25) & ~(0x3 << 18) & ~(0=
x7 << 12) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0x3 << 16) & ~(0x7 << 8);
>> +
>> + =A0 =A0 if (main_lcd->e_interface =3D=3D DSIM_VIDEO)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (1 << 25);
>> + =A0 =A0 else if (main_lcd->e_interface =3D=3D DSIM_COMMAND)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(1 << 25);
>> + =A0 =A0 else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev, "this ddi is not MIPI inter=
face.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* main lcd */
>> + =A0 =A0 reg |=3D ((u8) (main_lcd->parameter[DSI_VIDEO_MODE_SEL]) & 0x3=
) << 26 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((u8) (main_lcd->parameter[DSI_VIRTUAL_CH_ID])=
 & 0x3) << 18 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((u8) (main_lcd->parameter[DSI_FORMAT]) & 0x7)=
 << 12;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_CONFIG);
>> +}
>> +
>> +void s5p_dsim_enable_lane(struct dsim_global *dsim, unsigned char lane,
>> + =A0 =A0 unsigned char enable)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 reg =3D readl(dsim->reg_base + S5P_DSIM_CONFIG);
>> +
>> + =A0 =A0 if (lane =3D=3D DSIM_LANE_CLOCK) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (1 << 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(1 << 0);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (lane << 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(lane << 1);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_CONFIG);
>> +}
>> +
>> +
>> +void s5p_dsim_set_data_lane_number(struct dsim_global *dsim,
>> + =A0 =A0 unsigned char count)
>> +{
>> + =A0 =A0 unsigned int cfg =3D 0;
>> +
>> + =A0 =A0 /* get the data lane number. */
>> + =A0 =A0 cfg =3D DSIM_NUM_OF_DATA_LANE(count);
>> +
>> + =A0 =A0 writel(cfg, dsim->reg_base + S5P_DSIM_CONFIG);
>> +}
>> +
>> +void s5p_dsim_enable_afc(struct dsim_global *dsim, unsigned char enable,
>> + =A0 =A0 unsigned char afc_code)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_PHYACCHR);
>> +
>> + =A0 =A0 if (enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (1 << 14);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(0x7 << 5);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (afc_code & 0x7) << 5;
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(1 << 14);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_PHYACCHR);
>> +}
>> +
>> +void s5p_dsim_enable_pll_bypass(struct dsim_global *dsim,
>> + =A0 =A0 unsigned char enable)
>
> unsigned int enable.
>

also.

>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(DSIM_PLL_BYPASS_EXTERNAL);
>> +
>> + =A0 =A0 reg |=3D enable << DSIM_PLL_BYPASS_SHIFT;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
>> +}
>> +
>> +void s5p_dsim_set_pll_pms(struct dsim_global *dsim, unsigned char p,
>> + =A0 =A0 unsigned short m, unsigned short s)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_PLLCTRL);
>> +
>> + =A0 =A0 reg |=3D ((p & 0x3f) << 13) | ((m & 0x1ff) << 4) | ((s & 0x7) =
<< 1);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
>> +}
>> +
>> +void s5p_dsim_pll_freq_band(struct dsim_global *dsim, unsigned char fre=
q_band)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0x1f << DSIM_FREQ_BAND_SHIFT);
>> +
>> + =A0 =A0 reg |=3D ((freq_band & 0x1f) << DSIM_FREQ_BAND_SHIFT);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
>> +}
>> +
>> +void s5p_dsim_pll_freq(struct dsim_global *dsim, unsigned char pre_divi=
der,
>> + =A0 =A0 unsigned short main_divider, unsigned char scaler)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0x7ffff << 1);
>> +
>> + =A0 =A0 reg |=3D (pre_divider & 0x3f) << 13 | (main_divider & 0x1ff) <=
< 4 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (scaler & 0x7) << 1;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
>> +}
>> +
>> +void s5p_dsim_pll_stable_time(struct dsim_global *dsim,
>> + =A0 =A0 unsigned int lock_time)
>> +{
>> + =A0 =A0 writel(lock_time, dsim->reg_base + S5P_DSIM_PLLTMR);
>> +}
>> +
>> +void s5p_dsim_enable_pll(struct dsim_global *dsim, unsigned char enable)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0x1 << DSIM_PLL_EN_SHIFT);
>> +
>> + =A0 =A0 reg |=3D ((enable & 0x1) << DSIM_PLL_EN_SHIFT);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
>> +}
>> +
>> +void s5p_dsim_set_byte_clock_src(struct dsim_global *dsim, unsigned cha=
r src)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0x3 << DSIM_BYTE_CLK_SRC_SHIFT);
>> +
>> + =A0 =A0 reg |=3D ((unsigned int) src) << DSIM_BYTE_CLK_SRC_SHIFT;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
>> +}
>> +
>> +void s5p_dsim_enable_byte_clock(struct dsim_global *dsim,
>> + =A0 =A0 unsigned char enable)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(1 << DSIM_BYTE_CLKEN_SHIFT);
>> +
>> + =A0 =A0 reg |=3D enable << DSIM_BYTE_CLKEN_SHIFT;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
>> +}
>> +
>> +void s5p_dsim_set_esc_clk_prs(struct dsim_global *dsim, unsigned char e=
nable,
>> + =A0 =A0 unsigned short prs_val)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(1 << DSIM_ESC_CLKEN_SHIFT) & ~(0xffff);
>> +
>> + =A0 =A0 reg |=3D enable << DSIM_ESC_CLKEN_SHIFT;
>> + =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D prs_val;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
>> +}
>> +
>> +void s5p_dsim_enable_esc_clk_on_lane(struct dsim_global *dsim,
>> + =A0 =A0 unsigned char lane_sel, unsigned char enable)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_CLKCTRL);
>> +
>> + =A0 =A0 if (enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lane_sel & DSIM_LANE_CLOCK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D 1 << DSIM_LANE_ESC_CL=
KEN_SHIFT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lane_sel & DSIM_LANE_DATA0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D 1 << (DSIM_LANE_ESC_C=
LKEN_SHIFT + 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lane_sel & DSIM_LANE_DATA1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D 1 << (DSIM_LANE_ESC_C=
LKEN_SHIFT + 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lane_sel & DSIM_LANE_DATA2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D 1 << (DSIM_LANE_ESC_C=
LKEN_SHIFT + 3);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lane_sel & DSIM_LANE_DATA2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D 1 << (DSIM_LANE_ESC_C=
LKEN_SHIFT + 4);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lane_sel & DSIM_LANE_CLOCK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(1 << DSIM_LANE_ESC_=
CLKEN_SHIFT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lane_sel & DSIM_LANE_DATA0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(1 << (DSIM_LANE_ESC=
_CLKEN_SHIFT + 1));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lane_sel & DSIM_LANE_DATA1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(1 << (DSIM_LANE_ESC=
_CLKEN_SHIFT + 2));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lane_sel & DSIM_LANE_DATA2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(1 << (DSIM_LANE_ESC=
_CLKEN_SHIFT + 3));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lane_sel & DSIM_LANE_DATA2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(1 << (DSIM_LANE_ESC=
_CLKEN_SHIFT + 4));
>> + =A0 =A0 }
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
>> +}
>> +
>
>> +
>
>> +void s5p_dsim_clear_interrupt(struct dsim_global *dsim, unsigned int in=
t_src)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_INTSRC);
>> +
>> + =A0 =A0 reg |=3D int_src;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_INTSRC);
>> +}
>>
>
>
>> +unsigned char s5p_dsim_is_pll_stable(struct dsim_global *dsim)
>> +{
>> + =A0 =A0 return (unsigned char) ((readl(dsim->reg_base + S5P_DSIM_STATU=
S) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 31)) >> 31);
>> +}
>
> do you really need to be casting to an unsigned char?
>
> sure the code would be more efficient if you simply return an unsigned
> int.
>
> Either >> 31 the result (hint, it'll be the only bit left) or use
> the & (1 << 31) and return the result (non-zero generally regarded as tru=
e).
>

ok, code cleanup was less.
More will be cleaner.

>> +
>> +unsigned int s5p_dsim_get_fifo_state(struct dsim_global *dsim)
>> +{
>> + =A0 =A0 unsigned int ret =3D 0;
>> +
>> + =A0 =A0 ret =3D (readl(dsim->reg_base + S5P_DSIM_FIFOCTRL) & ~(0x1f));
>> +
>> + =A0 =A0 return ret;
>> +}
>
> again, no need for intermediate variable and certianly no need to init
> it before assinging it.
>

also.

>> +
>> +void s5p_dsim_wr_tx_header(struct dsim_global *dsim,
>> + =A0 =A0 unsigned char di, unsigned char data0, unsigned char data1)
>> +{
>> + =A0 =A0 unsigned int reg =3D (data1 << 16) | (data0 << 8) | ((di & 0x3=
f) << 0);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_PKTHDR);
>> +}
>> +
>> +unsigned int _s5p_dsim_get_frame_done_status(struct dsim_global *dsim)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_INTSRC);
>> +
>> + =A0 =A0 return (reg & INTSRC_FRAME_DONE) ? 1 : 0;
>> +}
>> +
>> +void _s5p_dsim_clear_frame_done(struct dsim_global *dsim)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_INTSRC);
>> +
>> + =A0 =A0 writel(reg | INTSRC_FRAME_DONE, dsim->reg_base +
>> + =A0 =A0 =A0 =A0 =A0 =A0 S5P_DSIM_INTSRC);
>> +}
>> +
>> +void s5p_dsim_wr_tx_data(struct dsim_global *dsim, unsigned int tx_data)
>> +{
>> + =A0 =A0 writel(tx_data, dsim->reg_base + S5P_DSIM_PAYLOAD);
>> +}
>> diff --git a/drivers/video/s5p_dsim_lowlevel.h b/drivers/video/s5p_dsim_=
lowlevel.h
>> new file mode 100644
>> index 0000000..ff950ba
>> --- /dev/null
>> +++ b/drivers/video/s5p_dsim_lowlevel.h
>> @@ -0,0 +1,101 @@
>> +/* linux/drivers/video/samsung/s5p_dsim_lowlevel.h
>> + *
>> + * Header file for Samsung MIPI-DSIM lowlevel driver.
>> + *
>> + * Copyright (c) 2009 Samsung Electronics
>> + * InKi Dae <inki.dae@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#ifndef _S5P_DSIM_LOWLEVEL_H
>> +#define _S5P_DSIM_LOWLEVEL_H
>> +
>> +struct dsim_global;
>> +
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

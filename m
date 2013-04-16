From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Tue, 16 Apr 2013 13:44:04 +0000
Subject: Re: [PATCH 4/8] video: atmel_lcdfb: add device tree suport
Message-Id: <20130416134404.GA4998@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130411145741.GB25242@game.jcrosoft.org>
 <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
 <1365692422-9565-4-git-send-email-plagnioj@jcrosoft.com>
 <516D554C.1090909@atmel.com>
In-Reply-To: <516D554C.1090909@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 15:42 Tue 16 Apr     , Nicolas Ferre wrote:
> On 04/11/2013 05:00 PM, Jean-Christophe PLAGNIOL-VILLARD :
> > get display timings from device tree
> > Use videomode helpers to get display timings and configurations from
> > device tree
>=20
> 2 sentences? Simply elaborate the 2nd one and it will be good.
>=20
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  .../devicetree/bindings/video/atmel,lcdc.txt       |   75 ++++++
> >  drivers/video/Kconfig                              |    2 +
> >  drivers/video/atmel_lcdfb.c                        |  244 ++++++++++++=
+++++---
> >  3 files changed, 289 insertions(+), 32 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/video/atmel,lcdc.=
txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/video/atmel,lcdc.txt b/D=
ocumentation/devicetree/bindings/video/atmel,lcdc.txt
> > new file mode 100644
> > index 0000000..1ec175e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/video/atmel,lcdc.txt
>=20
> Why lcdc? I would have preferred atmel,lcdfb, like the driver's name: it
> is even more self-explanatory...
we do not describe drivers but IP
>=20
> > @@ -0,0 +1,75 @@
> > +Atmel LCDC Framebuffer
> > +-----------------------------------------------------
> > +
> > +Required properties:
> > +- compatible :
> > +	"atmel,at91sam9261-lcdc" ,=20
> > +	"atmel,at91sam9263-lcdc" ,
> > +	"atmel,at91sam9g10-lcdc" ,
> > +	"atmel,at91sam9g45-lcdc" ,
> > +	"atmel,at91sam9g45es-lcdc" ,
> > +	"atmel,at91sam9rl-lcdc" ,
> > +	"atmel,at32ap-lcdc"
> > +- reg : Should contain 1 register ranges(address and length)
> > +- interrupts : framebuffer controller interrupt
> > +- display: a phandle pointing to the display node
> > +
> > +Required nodes:
> > +- display: a display node is required to initialize the lcd panel
> > +	This should be in the board dts.
> > +- default-mode: a videomode within the display with timing parameters
> > +	as specified below.
> > +
> > +Example:
> > +
> > +	fb0: fb@0x00500000 {
> > +		compatible =3D "atmel,at91sam9g45-lcdc";
> > +		reg =3D <0x00500000 0x1000>;
> > +		interrupts =3D <23 3 0>;
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_fb>;
> > +		display =3D <&display0>;
> > +		status =3D "okay";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +
> > +	};
> > +
> > +Atmel LCDC Display
> > +-----------------------------------------------------
> > +Required properties (as per of_videomode_helper):
>=20
> Can you please point somewhere to the documentation:
> Documentation/devicetree/bindings/video/display-timing.txt
>=20
> > + - atmel,dmacon: dma controler configuration
>=20
> Typo: controller.
>=20
> > + - atmel,lcdcon2: lcd controler configuration
>=20
> Ditto
>=20
> > + - atmel,guard-time: lcd guard time (Delay in frame periods)
>=20
> periods -> period, no?
no it's periods even in the datasheet
>=20
> > + - bits-per-pixel: lcd panel bit-depth.
> > +
> > +Optional properties (as per of_videomode_helper):
> > + - atmel,lcdcon-backlight: enable backlight
> > + - atmel,lcd-wiring-mode: lcd wiring mode "RGB" or "BRG"
>=20
> Is it a sting, or a number (as seen below)? If it is a number, please
> tell how to choose the index.
String
>=20
>=20
> > + - atmel,power-control-gpio: gpio to power on or off the LCD (as many =
as needed)
> > +
> > +Example:
> > +	display0: display {
> > +		bits-per-pixel =3D <32>;
> > +		atmel,lcdcon-backlight;
> > +		atmel,dmacon =3D <0x1>;
> > +		atmel,lcdcon2 =3D <0x80008002>;
> > +		atmel,guard-time =3D <9>;
> > +		atmel,lcd-wiring-mode =3D <1>;
> > +
> > +		display-timings {
> > +			native-mode =3D <&timing0>;
> > +			timing0: timing0 {
> > +				clock-frequency =3D <9000000>;
> > +				hactive =3D <480>;
> > +				vactive =3D <272>;
> > +				hback-porch =3D <1>;
> > +				hfront-porch =3D <1>;
> > +				vback-porch =3D <40>;
> > +				vfront-porch =3D <1>;
> > +				hsync-len =3D <45>;
> > +				vsync-len =3D <1>;
> > +			};
> > +		};
> > +	};
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 4c1546f..0687482 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -1018,6 +1018,8 @@ config FB_ATMEL
> >  	select FB_CFB_FILLRECT
> >  	select FB_CFB_COPYAREA
> >  	select FB_CFB_IMAGEBLIT
> > +	select FB_MODE_HELPERS
> > +	select OF_VIDEOMODE
> >  	help
> >  	  This enables support for the AT91/AT32 LCD Controller.
> > =20
> > diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> > index f67e226..4a31570 100644
> > --- a/drivers/video/atmel_lcdfb.c
> > +++ b/drivers/video/atmel_lcdfb.c
> > @@ -20,7 +20,11 @@
> >  #include <linux/gfp.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_data/atmel.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_gpio.h>
> >  #include <video/of_display_timing.h>
>=20
> As said in patch 1/8, this one belongs to this 4/8 patch.
>=20
> > +#include <video/videomode.h>
> > =20
> >  #include <mach/cpu.h>
> >  #include <asm/gpio.h>
> > @@ -59,6 +63,13 @@ struct atmel_lcdfb_info {
> >  	struct atmel_lcdfb_config *config;
> >  };
> > =20
> > +struct atmel_lcdfb_power_ctrl_gpio {
> > +	int gpio;
> > +	int active_low;
> > +
> > +	struct list_head list;
> > +};
> > +
> >  #define lcdc_readl(sinfo, reg)		__raw_readl((sinfo)->mmio+(reg))
> >  #define lcdc_writel(sinfo, reg, val)	__raw_writel((val), (sinfo)->mmio=
+(reg))
> > =20
> > @@ -945,16 +956,187 @@ static void atmel_lcdfb_stop_clock(struct atmel_=
lcdfb_info *sinfo)
> >  	clk_disable(sinfo->lcdc_clk);
> >  }
> > =20
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id atmel_lcdfb_dt_ids[] =3D {
> > +	{ .compatible =3D "atmel,at91sam9261-lcdc" , .data =3D &at91sam9261_c=
onfig, },
> > +	{ .compatible =3D "atmel,at91sam9263-lcdc" , .data =3D &at91sam9263_c=
onfig, },
> > +	{ .compatible =3D "atmel,at91sam9g10-lcdc" , .data =3D &at91sam9g10_c=
onfig, },
> > +	{ .compatible =3D "atmel,at91sam9g45-lcdc" , .data =3D &at91sam9g45_c=
onfig, },
> > +	{ .compatible =3D "atmel,at91sam9g45es-lcdc" , .data =3D &at91sam9g45=
es_config, },
> > +	{ .compatible =3D "atmel,at91sam9rl-lcdc" , .data =3D &at91sam9rl_con=
fig, },
> > +	{ .compatible =3D "atmel,at32ap-lcdc" , .data =3D &at32ap_config, },
> > +	{ /* sentinel */ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, atmel_lcdfb_dt_ids);
> > +
> > +static const char *atmel_lcdfb_wiring_modes[] =3D {
> > +	[ATMEL_LCDC_WIRING_BGR]	=3D "BRG",
> > +	[ATMEL_LCDC_WIRING_RGB]	=3D "RGB",
> > +};
> > +
> > +const int atmel_lcdfb_get_of_wiring_modes(struct device_node *np)
> > +{
> > +	const char *mode;
> > +	int err, i;
> > +
> > +	err =3D of_property_read_string(np, "atmel,lcd-wiring-mode", &mode);
> > +	if (err < 0)
> > +		return ATMEL_LCDC_WIRING_BGR;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(atmel_lcdfb_wiring_modes); i++)
> > +		if (!strcasecmp(mode, atmel_lcdfb_wiring_modes[i]))
> > +			return i;
> > +
> > +	return -ENODEV;
> > +}
> > +
> > +static void atmel_lcdfb_power_control_gpio(struct atmel_lcdfb_pdata *p=
data, int on)
> > +{
> > +	struct atmel_lcdfb_power_ctrl_gpio *og;
> > +
> > +	list_for_each_entry(og, &pdata->pwr_gpios, list)
> > +		gpio_set_value(og->gpio, on);
> > +}
> > +
> > +static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
> > +{
> > +	struct fb_info *info =3D sinfo->info;
> > +	struct atmel_lcdfb_pdata *pdata =3D &sinfo->pdata;
> > +	struct fb_var_screeninfo *var =3D &info->var;
> > +	struct device *dev =3D &sinfo->pdev->dev;
> > +	struct device_node *np =DEv->of_node;
> > +	struct device_node *display_np;
> > +	struct device_node *timings_np;
> > +	struct display_timings *timings;
> > +	enum of_gpio_flags flags;
> > +	struct atmel_lcdfb_power_ctrl_gpio *og;
> > +	bool is_gpio_power =3D false;
> > +	int ret =3D -ENOENT;
> > +	int i, gpio;
> > +
> > +	sinfo->config =3D (struct atmel_lcdfb_config*)
> > +		of_match_device(atmel_lcdfb_dt_ids, dev)->data;
>=20
> Please split it in 2 steps, otherwise the day that the drivers doesn't
> find the device in dt_ids table, it hangs here with an Oops.
no as you will never end here in this case
>=20
> > +
> > +	display_np =3D of_parse_phandle(np, "display", 0);
> > +	if (!display_np) {
> > +		dev_err(dev, "failed to find display phandle\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	ret =3D of_property_read_u32(display_np, "bits-per-pixel", &var->bits=
_per_pixel);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to get property bits-per-pixel\n");
> > +		goto put_display_node;
> > +	}
> > +
> > +	ret =3D of_property_read_u32(display_np, "atmel,guard-time", &pdata->=
guard_time);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to get property atmel,guard-time\n");
> > +		goto put_display_node;
> > +	}
> > +
> > +	ret =3D of_property_read_u32(display_np, "atmel,lcdcon2", &pdata->def=
ault_lcdcon2);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to get property atmel,lcdcon2\n");
> > +		goto put_display_node;
> > +	}
> > +
> > +	ret =3D of_property_read_u32(display_np, "atmel,dmacon", &pdata->defa=
ult_dmacon);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to get property bits-per-pixel\n");
>=20
> No, wrong error message.
>=20
> > +		goto put_display_node;
> > +	}
> > +
> > +	ret =3D -ENOMEM;
> > +	for (i =3D 0; i < of_gpio_named_count(display_np, "atmel,power-contro=
l-gpio"); i++) {
> > +		gpio =3D of_get_named_gpio_flags(display_np, "atmel,power-control-gp=
io",
> > +					       i, &flags);
> > +		if (gpio < 0)
> > +			continue;
> > +
> > +		og =3D devm_kzalloc(dev, sizeof(*og), GFP_KERNEL);
> > +		if (!og)
> > +			goto put_display_node;
> > +
> > +		og->gpio =3D gpio;
> > +		og->active_low =3D flags & OF_GPIO_ACTIVE_LOW;
> > +		is_gpio_power =3D true;
> > +		ret =3D devm_gpio_request(dev, gpio, "lcd-power-control-gpio");
> > +		if (ret) {
> > +			dev_err(dev, "request gpio %d failed\n", gpio);
> > +			goto put_display_node;
> > +		}
> > +
> > +		ret =3D gpio_direction_output(gpio, og->active_low);
> > +		if (ret) {
> > +			dev_err(dev, "set direction output gpio %d failed\n", gpio);
> > +			goto put_display_node;
> > +		}
> > +	}
> > +
> > +	if (is_gpio_power)
> > +		pdata->atmel_lcdfb_power_control =3D atmel_lcdfb_power_control_gpio;
> > +
> > +	ret =3D atmel_lcdfb_get_of_wiring_modes(display_np);
> > +	if (ret < 0) {
> > +		dev_err(dev, "invalid atmel,lcd-wiring-mode\n");
> > +		goto put_display_node;
> > +	}
> > +	pdata->lcd_wiring_mode =3D ret;
> > +
> > +	pdata->lcdcon_is_backlight =3D of_property_read_bool(display_np, "atm=
el,lcdcon-backlight");
> > +
> > +	timings =3D of_get_display_timings(display_np);
> > +	if (!timings) {
> > +		dev_err(dev, "failed to get display timings\n");
> > +		goto put_display_node;
> > +	}
> > +
> > +	timings_np =3D of_find_node_by_name(display_np, "display-timings");
> > +	if (!timings_np) {
> > +		dev_err(dev, "failed to find display-timings node\n");
> > +		goto put_display_node;
> > +	}
> > +
> > +	for (i =3D 0; i < of_get_child_count(timings_np); i++) {
> > +		struct videomode vm;
> > +		struct fb_videomode fb_vm;
> > +
> > +		ret =3D videomode_from_timing(timings, &vm, i);
> > +		if (ret < 0)
> > +			goto put_timings_node;
> > +		ret =3D fb_videomode_from_videomode(&vm, &fb_vm);
> > +		if (ret < 0)
> > +			goto put_timings_node;
> > +
> > +		fb_add_videomode(&fb_vm, &info->modelist);
> > +	}
> > +
> > +	return 0;
> > +
> > +put_timings_node:
> > +	of_node_put(timings_np);
> > +put_display_node:
> > +	of_node_put(display_np);
> > +	return ret;
> > +}
> > +#else
> > +static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > =20
> >  static int __init atmel_lcdfb_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev =3D &pdev->dev;
> >  	struct fb_info *info;
> >  	struct atmel_lcdfb_info *sinfo;
> > -	struct atmel_lcdfb_pdata *pdata;
> > -	struct fb_videomode fbmode;
> > +	struct atmel_lcdfb_pdata *pdata =3D NULL;
> >  	struct resource *regs =3D NULL;
> >  	struct resource *map =3D NULL;
> > +	struct fb_modelist *modelist;
> >  	int ret;
> > =20
> >  	dev_dbg(dev, "%s BEGIN\n", __func__);
> > @@ -967,17 +1149,35 @@ static int __init atmel_lcdfb_probe(struct platf=
orm_device *pdev)
> >  	}
> > =20
> >  	sinfo =3D info->par;
> > +	sinfo->pdev =3D pdev;
> > +	sinfo->info =3D info;
> > +
> > +	INIT_LIST_HEAD(&info->modelist);
> > =20
> > -	if (dev->platform_data) {
> > -		pdata =3D (struct atmel_lcdfb_pdata *)dev->platform_data;
> > +	if (pdev->dev.of_node) {
> > +		ret =3D atmel_lcdfb_of_init(sinfo);
> > +		if (ret)
> > +			goto free_info;
> > +	} else if (dev->platform_data) {
> > +		struct fb_monspecs *monspecs;
> > +		int i;
> > +
> > +		pdata =3D dev->platform_data;
> > +		monspecs =3D pdata->default_monspecs;
> >  		sinfo->pdata =3D *pdata;
> > +
> > +		for (i =3D 0; i < monspecs->modedb_len; i++)
> > +			fb_add_videomode(&monspecs->modedb[i], &info->modelist);
> > +
> > +		sinfo->config =3D atmel_lcdfb_get_config(pdev);
> > +
> > +		info->var.bits_per_pixel =3D pdata->default_bpp ? pdata->default_bpp=
 : 16;
> > +		memcpy(&info->monspecs, pdata->default_monspecs, sizeof(info->monspe=
cs));
> >  	} else {
> >  		dev_err(dev, "cannot get default configuration\n");
> >  		goto free_info;
> >  	}
> > -	sinfo->info =3D info;
> > -	sinfo->pdev =3D pdev;
> > -	sinfo->config =3D atmel_lcdfb_get_config(pdev);
> > +
> >  	if (!sinfo->config)
> >  		goto free_info;
> > =20
> > @@ -986,7 +1186,6 @@ static int __init atmel_lcdfb_probe(struct platfor=
m_device *pdev)
> >  	info->pseudo_palette =3D sinfo->pseudo_palette;
> >  	info->fbops =3D &atmel_lcdfb_ops;
> > =20
> > -	memcpy(&info->monspecs, pdata->default_monspecs, sizeof(info->monspec=
s));
> >  	info->fix =3D atmel_lcdfb_fix;
> > =20
> >  	/* Enable LCDC Clocks */
> > @@ -1002,14 +1201,11 @@ static int __init atmel_lcdfb_probe(struct plat=
form_device *pdev)
> >  	}
> >  	atmel_lcdfb_start_clock(sinfo);
> > =20
> > -	ret =3D fb_find_mode(&info->var, info, NULL, info->monspecs.modedb,
> > -			info->monspecs.modedb_len, info->monspecs.modedb,
> > -			pdata->default_bpp);
> > -	if (!ret) {
> > -		dev_err(dev, "no suitable video mode found\n");
> > -		goto stop_clk;
> > -	}
> > +	modelist =3D list_first_entry(&info->modelist,
> > +			struct fb_modelist, list);
> > +	fb_videomode_to_var(&info->var, &modelist->mode);
> > =20
> > +	atmel_lcdfb_check_var(&info->var, info);
> > =20
> >  	regs =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	if (!regs) {
> > @@ -1093,18 +1289,6 @@ static int __init atmel_lcdfb_probe(struct platf=
orm_device *pdev)
> >  		goto unregister_irqs;
> >  	}
> > =20
> > -	/*
> > -	 * This makes sure that our colour bitfield
> > -	 * descriptors are correctly initialised.
> > -	 */
> > -	atmel_lcdfb_check_var(&info->var, info);
> > -
> > -	ret =3D fb_set_var(info, &info->var);
> > -	if (ret) {
> > -		dev_warn(dev, "unable to set display parameters\n");
> > -		goto free_cmap;
> > -	}
> > -
> >  	dev_set_drvdata(dev, info);
> > =20
> >  	/*
> > @@ -1116,10 +1300,6 @@ static int __init atmel_lcdfb_probe(struct platf=
orm_device *pdev)
> >  		goto reset_drvdata;
> >  	}
> > =20
> > -	/* add selected videomode to modelist */
> > -	fb_var_to_videomode(&fbmode, &info->var);
> > -	fb_add_videomode(&fbmode, &info->modelist);
> > -
> >  	/* Power up the LCDC screen */
> >  	atmel_lcdfb_power_control(sinfo, 1);
> > =20
> > @@ -1130,7 +1310,6 @@ static int __init atmel_lcdfb_probe(struct platfo=
rm_device *pdev)
> > =20
> >  reset_drvdata:
> >  	dev_set_drvdata(dev, NULL);
> > -free_cmap:
> >  	fb_dealloc_cmap(&info->cmap);
> >  unregister_irqs:
> >  	cancel_work_sync(&sinfo->task);
> > @@ -1249,6 +1428,7 @@ static struct platform_driver atmel_lcdfb_driver =
=3D {
> >  	.driver		=3D {
> >  		.name	=3D "atmel_lcdfb",
> >  		.owner	=3D THIS_MODULE,
> > +		.of_match_table	=3D of_match_ptr(atmel_lcdfb_dt_ids),
> >  	},
> >  };
> > =20
> >=20
>=20
>=20
> --=20
> Nicolas Ferre

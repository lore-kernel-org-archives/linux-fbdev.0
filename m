From: Richard Genoud <richard.genoud@gmail.com>
Date: Wed, 29 May 2013 15:01:58 +0000
Subject: Re: [PATCH 4/8] video: atmel_lcdfb: add device tree suport
Message-Id: <CACQ1gAhbnsrmCzdv0KNDMN153+0F_8cwNPZUz=SF8sKUPbty3g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130411145741.GB25242@game.jcrosoft.org>
 <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
 <1365692422-9565-4-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <1365692422-9565-4-git-send-email-plagnioj@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

2013/4/11 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
> get display timings from device tree
> Use videomode helpers to get display timings and configurations from
> device tree
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  .../devicetree/bindings/video/atmel,lcdc.txt       |   75 ++++++
>  drivers/video/Kconfig                              |    2 +
>  drivers/video/atmel_lcdfb.c                        |  244 ++++++++++++++=
+++---
>  3 files changed, 289 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/atmel,lcdc.txt
>
> diff --git a/Documentation/devicetree/bindings/video/atmel,lcdc.txt b/Doc=
umentation/devicetree/bindings/video/atmel,lcdc.txt
> new file mode 100644
> index 0000000..1ec175e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/atmel,lcdc.txt
> @@ -0,0 +1,75 @@
> +Atmel LCDC Framebuffer
> +-----------------------------------------------------
> +
> +Required properties:
> +- compatible :
> +       "atmel,at91sam9261-lcdc" ,
> +       "atmel,at91sam9263-lcdc" ,
> +       "atmel,at91sam9g10-lcdc" ,
> +       "atmel,at91sam9g45-lcdc" ,
> +       "atmel,at91sam9g45es-lcdc" ,
> +       "atmel,at91sam9rl-lcdc" ,
> +       "atmel,at32ap-lcdc"
> +- reg : Should contain 1 register ranges(address and length)
> +- interrupts : framebuffer controller interrupt
> +- display: a phandle pointing to the display node
> +
> +Required nodes:
> +- display: a display node is required to initialize the lcd panel
> +       This should be in the board dts.
> +- default-mode: a videomode within the display with timing parameters
> +       as specified below.
> +
> +Example:
> +
> +       fb0: fb@0x00500000 {
> +               compatible =3D "atmel,at91sam9g45-lcdc";
> +               reg =3D <0x00500000 0x1000>;
> +               interrupts =3D <23 3 0>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_fb>;
> +               display =3D <&display0>;
> +               status =3D "okay";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +
> +       };
> +
> +Atmel LCDC Display
> +-----------------------------------------------------
> +Required properties (as per of_videomode_helper):
> +
> + - atmel,dmacon: dma controler configuration
> + - atmel,lcdcon2: lcd controler configuration
> + - atmel,guard-time: lcd guard time (Delay in frame periods)
> + - bits-per-pixel: lcd panel bit-depth.
> +
> +Optional properties (as per of_videomode_helper):
> + - atmel,lcdcon-backlight: enable backlight
> + - atmel,lcd-wiring-mode: lcd wiring mode "RGB" or "BRG"
> + - atmel,power-control-gpio: gpio to power on or off the LCD (as many as=
 needed)
still on lcdcon_pol_negative, we can add something like that:
 - atmel,lcdcon-pwm-pulse-low: Output PWM pulses are low level (high
level if not set)

> +
> +Example:
> +       display0: display {
> +               bits-per-pixel =3D <32>;
> +               atmel,lcdcon-backlight;
> +               atmel,dmacon =3D <0x1>;
> +               atmel,lcdcon2 =3D <0x80008002>;
> +               atmel,guard-time =3D <9>;
> +               atmel,lcd-wiring-mode =3D <1>;
> +
> +               display-timings {
> +                       native-mode =3D <&timing0>;
> +                       timing0: timing0 {
> +                               clock-frequency =3D <9000000>;
> +                               hactive =3D <480>;
> +                               vactive =3D <272>;
> +                               hback-porch =3D <1>;
> +                               hfront-porch =3D <1>;
> +                               vback-porch =3D <40>;
> +                               vfront-porch =3D <1>;
> +                               hsync-len =3D <45>;
> +                               vsync-len =3D <1>;
> +                       };
> +               };
> +       };
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 4c1546f..0687482 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1018,6 +1018,8 @@ config FB_ATMEL
>         select FB_CFB_FILLRECT
>         select FB_CFB_COPYAREA
>         select FB_CFB_IMAGEBLIT
> +       select FB_MODE_HELPERS
> +       select OF_VIDEOMODE
>         help
>           This enables support for the AT91/AT32 LCD Controller.
>
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index f67e226..4a31570 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -20,7 +20,11 @@
>  #include <linux/gfp.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/atmel.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
>  #include <video/of_display_timing.h>
> +#include <video/videomode.h>
>
>  #include <mach/cpu.h>
>  #include <asm/gpio.h>
> @@ -59,6 +63,13 @@ struct atmel_lcdfb_info {
>         struct atmel_lcdfb_config *config;
>  };
>
> +struct atmel_lcdfb_power_ctrl_gpio {
> +       int gpio;
> +       int active_low;
> +
> +       struct list_head list;
> +};
> +
>  #define lcdc_readl(sinfo, reg)         __raw_readl((sinfo)->mmio+(reg))
>  #define lcdc_writel(sinfo, reg, val)   __raw_writel((val), (sinfo)->mmio=
+(reg))
>
> @@ -945,16 +956,187 @@ static void atmel_lcdfb_stop_clock(struct atmel_lc=
dfb_info *sinfo)
>         clk_disable(sinfo->lcdc_clk);
>  }
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id atmel_lcdfb_dt_ids[] =3D {
> +       { .compatible =3D "atmel,at91sam9261-lcdc" , .data =3D &at91sam92=
61_config, },
> +       { .compatible =3D "atmel,at91sam9263-lcdc" , .data =3D &at91sam92=
63_config, },
> +       { .compatible =3D "atmel,at91sam9g10-lcdc" , .data =3D &at91sam9g=
10_config, },
> +       { .compatible =3D "atmel,at91sam9g45-lcdc" , .data =3D &at91sam9g=
45_config, },
> +       { .compatible =3D "atmel,at91sam9g45es-lcdc" , .data =3D &at91sam=
9g45es_config, },
> +       { .compatible =3D "atmel,at91sam9rl-lcdc" , .data =3D &at91sam9rl=
_config, },
> +       { .compatible =3D "atmel,at32ap-lcdc" , .data =3D &at32ap_config,=
 },
> +       { /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, atmel_lcdfb_dt_ids);
> +
> +static const char *atmel_lcdfb_wiring_modes[] =3D {
> +       [ATMEL_LCDC_WIRING_BGR] =3D "BRG",
> +       [ATMEL_LCDC_WIRING_RGB] =3D "RGB",
> +};
> +
> +const int atmel_lcdfb_get_of_wiring_modes(struct device_node *np)
> +{
> +       const char *mode;
> +       int err, i;
> +
> +       err =3D of_property_read_string(np, "atmel,lcd-wiring-mode", &mod=
e);
> +       if (err < 0)
> +               return ATMEL_LCDC_WIRING_BGR;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(atmel_lcdfb_wiring_modes); i++)
> +               if (!strcasecmp(mode, atmel_lcdfb_wiring_modes[i]))
> +                       return i;
> +
> +       return -ENODEV;
> +}
> +
> +static void atmel_lcdfb_power_control_gpio(struct atmel_lcdfb_pdata *pda=
ta, int on)
> +{
> +       struct atmel_lcdfb_power_ctrl_gpio *og;
> +
> +       list_for_each_entry(og, &pdata->pwr_gpios, list)
> +               gpio_set_value(og->gpio, on);
> +}
> +
> +static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
> +{
> +       struct fb_info *info =3D sinfo->info;
> +       struct atmel_lcdfb_pdata *pdata =3D &sinfo->pdata;
> +       struct fb_var_screeninfo *var =3D &info->var;
> +       struct device *dev =3D &sinfo->pdev->dev;
> +       struct device_node *np =DEv->of_node;
> +       struct device_node *display_np;
> +       struct device_node *timings_np;
> +       struct display_timings *timings;
> +       enum of_gpio_flags flags;
> +       struct atmel_lcdfb_power_ctrl_gpio *og;
> +       bool is_gpio_power =3D false;
> +       int ret =3D -ENOENT;
> +       int i, gpio;
> +
> +       sinfo->config =3D (struct atmel_lcdfb_config*)
> +               of_match_device(atmel_lcdfb_dt_ids, dev)->data;
> +
> +       display_np =3D of_parse_phandle(np, "display", 0);
> +       if (!display_np) {
> +               dev_err(dev, "failed to find display phandle\n");
> +               return -ENOENT;
> +       }
> +
> +       ret =3D of_property_read_u32(display_np, "bits-per-pixel", &var->=
bits_per_pixel);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to get property bits-per-pixel\n");
> +               goto put_display_node;
> +       }
> +
> +       ret =3D of_property_read_u32(display_np, "atmel,guard-time", &pda=
ta->guard_time);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to get property atmel,guard-time\n");
> +               goto put_display_node;
> +       }
> +
> +       ret =3D of_property_read_u32(display_np, "atmel,lcdcon2", &pdata-=
>default_lcdcon2);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to get property atmel,lcdcon2\n");
> +               goto put_display_node;
> +       }
> +
> +       ret =3D of_property_read_u32(display_np, "atmel,dmacon", &pdata->=
default_dmacon);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to get property bits-per-pixel\n");
> +               goto put_display_node;
> +       }
> +
> +       ret =3D -ENOMEM;
> +       for (i =3D 0; i < of_gpio_named_count(display_np, "atmel,power-co=
ntrol-gpio"); i++) {
> +               gpio =3D of_get_named_gpio_flags(display_np, "atmel,power=
-control-gpio",
> +                                              i, &flags);
> +               if (gpio < 0)
> +                       continue;
> +
> +               og =3D devm_kzalloc(dev, sizeof(*og), GFP_KERNEL);
> +               if (!og)
> +                       goto put_display_node;
> +
> +               og->gpio =3D gpio;
> +               og->active_low =3D flags & OF_GPIO_ACTIVE_LOW;
> +               is_gpio_power =3D true;
> +               ret =3D devm_gpio_request(dev, gpio, "lcd-power-control-g=
pio");
> +               if (ret) {
> +                       dev_err(dev, "request gpio %d failed\n", gpio);
> +                       goto put_display_node;
> +               }
> +
> +               ret =3D gpio_direction_output(gpio, og->active_low);
> +               if (ret) {
> +                       dev_err(dev, "set direction output gpio %d failed=
\n", gpio);
> +                       goto put_display_node;
> +               }
> +       }
> +
> +       if (is_gpio_power)
> +               pdata->atmel_lcdfb_power_control =3D atmel_lcdfb_power_co=
ntrol_gpio;
> +
> +       ret =3D atmel_lcdfb_get_of_wiring_modes(display_np);
> +       if (ret < 0) {
> +               dev_err(dev, "invalid atmel,lcd-wiring-mode\n");
> +               goto put_display_node;
> +       }
> +       pdata->lcd_wiring_mode =3D ret;
> +
> +       pdata->lcdcon_is_backlight =3D of_property_read_bool(display_np, =
"atmel,lcdcon-backlight");

and here, something like:
pdata->lcdcon_pol_negative =3D of_property_read_bool(display_np,
"atmel,lcdcon-pwm-pulse-low");
would be nice


Regards,
Richard.

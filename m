From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 26 Jun 2018 10:01:35 +0000
Subject: Re: simple-framebuffer enquire
Message-Id: <9fb661e6-482b-76e0-2af0-a62a70e5606d@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOf5uwmSeugMHBBFc8ZQKY=wEsVD-YwD=YSWi=XbysU58Gp=Ww@mail.gmail.com>
In-Reply-To: <CAOf5uwmSeugMHBBFc8ZQKY=wEsVD-YwD=YSWi=XbysU58Gp=Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi,

On 25-06-18 15:29, Michael Nazzareno Trimarchi wrote:
> Hi Hans
> 
> In order to let it even registered the simplefb I have added this
> change. According on what I understand
> from the code seems that this is the way to acquire memory with the
> correct attribute
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index a3c44ec..7e61ce3 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -466,8 +466,8 @@ static int simplefb_probe(struct platform_device *pdev)
> 
>          info->fbops = &simplefb_ops;
>          info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
> -       info->screen_base = ioremap_wc(info->fix.smem_start,
> -                                      info->fix.smem_len);
> +       info->screen_base = arch_memremap_wb(info->fix.smem_start,
> +                                            info->fix.smem_len);

I'm not sure why you need this?  wb certainly is not optimal
for a framebuffer, the existing wc mapping is really what you
want.

>          if (!info->screen_base) {
>                  ret = -ENOMEM;
>                  goto error_fb_release;
> 
> Another question is
> 
>          aliases {
>                  display0 = &lcdif;
>          };
> 
>          chosen {
>                  #address-cells = <1>;
>                  #size-cells = <1>;
>                  ranges;
> 
>                  stdout-path = &uart1;
>                  framebuffer0: framebuffer@86fd6080 {
>                          compatible = "simple-framebuffer";
>                          reg = <0x86fd6080 (480 * 272 * 4)>;
>                          width = <480>;
>                          height = <272>;
>                          stride = <(480 * 4)>;
>                          format = "a8r8g8b8";
>                          clocks = <&clks IMX6UL_CLK_LCDIF_PIX>,
>                                   <&clks IMX6UL_CLK_LCDIF_APB>,
>                                   <&clks IMX6UL_CLK_DUMMY>,
>                                   <&clks IMX6UL_CLK_GPIO3>,
>                                   <&clks IMX6UL_CLK_GPIO4>;
>                          nshut-supply = <&reg_lcd_nshut>;
>                          nreset-supply = <&reg_lcd_nreset>;

This looks like GPIOS to me why are you modeling this a supplies?

Anyways ...

>                          display = <&lcdif>;
>                  };
>          };
> };
> 
> How do you ensure that regulators that are bind to gpios can be
> maintain during boot?

Any regulators listed in the simplefb dt-node will be kept enabled
until remove_conflicting_framebuffers is called() from the native
display driver. To keep them enabled while loading the native
display driver, you should get and enable them in the native display
driver *before* calling remove_conflicting_framebuffers()
(and the same goes for the clocks).

Regards,

Hans



> A small minor comment is how to automatic switch then to normal
> framebuffer. Anyway seems
> that
>                  #address-cells = <1>;
>                  #size-cells = <1>;
>                  ranges;
> 
> are mandatory and they are in the dts documentation.
> 
> Best regards
> Michael
> 

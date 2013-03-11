From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 11 Mar 2013 10:25:40 +0000
Subject: Re: [PATCH v2 2/2] video: imxfb: Add DT support
Message-Id: <20130311102540.GB23082@e106331-lin.cambridge.arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362504608-15839-1-git-send-email-mpa@pengutronix.de>
 <1362504608-15839-3-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1362504608-15839-3-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

Any reason for not CCing devicetree-discuss?

I have a couple of comments on the binding and the way it's parsed.

On Tue, Mar 05, 2013 at 05:30:08PM +0000, Markus Pargmann wrote:
> Add devicetree support for imx framebuffer driver. It uses the generic
> display bindings and helper functions.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> ---
>
> Notes:
>     Changes in v2:
>     - Removed pwmr register property
>     - Cleanup of devicetree binding documentation
>     - Use default values for pwmr and lscr1
>
>  .../devicetree/bindings/video/fsl,imx-fb.txt       |  49 ++++++
>  drivers/video/imxfb.c                              | 182 +++++++++++++++++----
>  2 files changed, 197 insertions(+), 34 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/fsl,imx-fb.txt
>
> diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> new file mode 100644
> index 0000000..e1a53a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> @@ -0,0 +1,49 @@
> +Freescale imx21 Framebuffer
> +
> +This framebuffer driver supports devices imx1, imx21, imx25, and imx27.
> +
> +Required properties:
> +- compatible : "fsl,<chip>-fb", chip should be imx1 or imx21
> +- reg : Should contain 1 register ranges(address and length)
> +- interrupts : One interrupt of the fb dev
> +
> +Required nodes:
> +- display: Phandle to a display node as described in
> +       Documentation/devicetree/bindings/video/display-timing.txt
> +       Additional, the display node has to define properties:
> +       - bpp: Bits per pixel
> +       - pcr: LCDC PCR value

As these are non-standard, it would be good to prefix them (e.g. "fsl,pcr").

If you need them, why are they not a good fit for the generic binding?

I'm not familiar with the hardware, what is the PCR exactly?

[...]

> -static int __init imxfb_probe(struct platform_device *pdev)
> +static int imxfb_of_read_mode(struct device_node *np,
> +               struct imx_fb_videomode *imxfb_mode)
> +{
> +       int ret;
> +       struct fb_videomode *of_mode = &imxfb_mode->mode;
> +       u32 bpp;
> +       u32 pcr;
> +
> +       ret = of_property_read_string(np, "model", &of_mode->name);
> +       if (ret)
> +               of_mode->name = NULL;
> +
> +       ret = of_get_fb_videomode(np, of_mode, OF_USE_NATIVE_MODE);
> +       if (ret)
> +               return ret;
> +
> +       ret = of_property_read_u32(np, "bpp", &bpp);
> +       ret |= of_property_read_u32(np, "pcr", &pcr);
> +
> +       if (ret)
> +               return ret;

Is this return value used anywhere in anything more than an "if (!err)"
capacity?  If so it may be worth having individual return value checks:

If one call returns -EINVAL (-22) and the other -ENODATA (-61), out the other
end we'd get -EISDIR (-21). If we don't care particularly about which error
code we actually pass on, we could always return a sensible code when ret is
nonzero:

if (ret)
	return -EINVAL;

> +
> +       if (bpp > 255)
> +               return -EINVAL;

Might it also be worth checking for 0 here?

[...]

> @@ -837,15 +914,51 @@ static int __init imxfb_probe(struct platform_device *pdev)
>
>         fbi = info->par;
>
> -       if (!fb_mode)
> -               fb_mode = pdata->mode[0].mode.name;
> -
>         platform_set_drvdata(pdev, info);
>
>         ret = imxfb_init_fbinfo(pdev);
>         if (ret < 0)
>                 goto failed_init;
>
> +       if (pdata) {
> +               if (!fb_mode)
> +                       fb_mode = pdata->mode[0].mode.name;
> +
> +               fbi->mode = pdata->mode;
> +               fbi->num_modes = pdata->num_modes;
> +       } else {
> +               struct device_node *display_np;
> +               fb_mode = NULL;
> +
> +               display_np = of_parse_phandle(pdev->dev.of_node, "display", 0);
> +               if (!display_np) {
> +                       dev_err(&pdev->dev, "No display defined in devicetree\n");
> +                       ret = -EINVAL;
> +                       goto failed_of_parse;
> +               }
> +
> +               /*
> +                * imxfb does not support more modes, we choose only the native
> +                * mode.
> +                */
> +               fbi->num_modes = 1;
> +
> +               fbi->mode = devm_kzalloc(&pdev->dev,
> +                               sizeof(struct imx_fb_videomode), GFP_KERNEL);
> +               if (!fbi->mode) {
> +                       ret = -ENOMEM;
> +                       goto failed_of_parse;
> +               }
> +
> +               ret = imxfb_of_read_mode(display_np, fbi->mode);
> +               if (ret)
> +                       goto failed_of_parse;
> +       }
> +
> +       for (i = 0, m = &fbi->mode[0]; i < fbi->num_modes; i++, m++)
> +               info->fix.smem_len = max_t(size_t, info->fix.smem_len,
> +                               m->mode.xres * m->mode.yres * m->bpp / 8);

Surely this is broken if bpp is not as multiple of 8?

If we can only handle multiples of 8, could we not sanity check this earlier?

If there's no strong preference for describing it in bits, could we not
describe it in bytes and side-step the issue?

[...]

Thanks,
Mark.

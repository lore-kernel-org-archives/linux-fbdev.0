From: Philipp Zabel <philipp.zabel@gmail.com>
Date: Sat, 03 Oct 2015 17:02:44 +0000
Subject: Re: [PATCH 2/2] video: fbdev: pxafb: initial devicetree conversion
Message-Id: <CA+gwMceWchEhPQ0Prs5Ne+D+Fq1uybPkB48tRNWzj=i14TW8Yg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443888714-12362-1-git-send-email-robert.jarzmik@free.fr>
	<1443888714-12362-3-git-send-email-robert.jarzmik@free.fr>
In-Reply-To: <1443888714-12362-3-git-send-email-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Robert,

On Sat, Oct 3, 2015 at 6:11 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> This patch brings a first support of pxa framebuffer devices to a
> devicetree pxa platform, as was before platform data.
>
> There are restrictions with this port, the biggest one being the lack of
> support of smart panels. Moreover the conversion doesn't provide a way
> to declare multiple framebuffer configurations with different bits per
> pixel, only the LCD hardware bus width is used.
>
> The patch was tested on both pxa25x, pxa27x and pxa3xx platform (namely
> lubbock, mainstone and zylonite).
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Thanks a lot for working on this! Out of interest, do you plan to
convert MIOA701 to DT?

[...]
> +       of_property_read_u32(dev->of_node, "depth", &depth);
[...]
> +       of_property_read_u32(dev->of_node, "enable-transparency-bit",
[...]
> +       display = of_parse_phandle(dev->of_node, "display", 0);
[...]
> +       ret = of_property_read_u32(disp, "bits-per-pixel", &bpp);
[...]
> +       ret = of_property_read_string(disp, "lcd-type", &s);
[...]
> +       timings = of_get_display_timings(disp);

These DT properties need some kind of binding documentation.

[...]
> @@ -2313,11 +2461,19 @@ static int pxafb_remove(struct platform_device *dev)
>         return 0;
>  }
>
> +static const struct of_device_id pxafb_of_dev_id[] = {
> +       {
> +               .compatible = "marvell,pxa2xx-fb",

At least in the old Intel manuals, this was called the LCD Controller,
all register names are LCsomething.
Please let's not just put the Linux driver name in the device tree and
call this pxa2xx-lcd-controller or a shortened version thereof.

best regards
Philipp

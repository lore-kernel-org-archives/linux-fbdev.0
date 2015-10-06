From: Philipp Zabel <philipp.zabel@gmail.com>
Date: Tue, 06 Oct 2015 06:58:08 +0000
Subject: Re: [PATCH v2] video: fbdev: add Marvell PXA framebuffer binding
Message-Id: <CA+gwMcciuonC5Ektt3wdUcp7RW3E+caCuktYrhcYSqTrnVng9Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443954683-13126-1-git-send-email-robert.jarzmik@free.fr>
In-Reply-To: <1443954683-13126-1-git-send-email-robert.jarzmik-GANU6spQydw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, Oct 4, 2015 at 12:31 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Add documentation for the PXA frambuffer devicetree binding.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: Philipp's review on the whole binding
> ---
>  .../devicetree/bindings/video/marvell,pxafb.txt    | 80 ++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/marvell,pxafb.txt
>
> diff --git a/Documentation/devicetree/bindings/video/marvell,pxafb.txt b/Documentation/devicetree/bindings/video/marvell,pxafb.txt
> new file mode 100644
> index 000000000000..4d6bd490680d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/marvell,pxafb.txt
> @@ -0,0 +1,80 @@
> +PXA LCDC Framebuffer
> +--------------------
> +
> +Required properties:
> + - compatible :
> +       "marvell,pxa2xx-lcdc",
> + - reg : Should contain 1 register ranges(address and length).
> +        Can contain an additional register range(address and length)
> +        for fixed framebuffer memory. Useful for dedicated memories.
> + - interrupts : framebuffer controller interrupt
> +
> +Required nodes:
> + - clocks: phandle to input clocks.
> + - port: connection to the LCD panel (see video-interfaces.txt)
> +        This nodes must have its properties bus-width and remote-endpoint set.
> +        This should be in the board dts.
> +
> +Example:
> +
> +       lcd-controller@40500000 {
> +               compatible = "marvell,pxa2xx-lcdc";
> +               reg = <0x44000000 0x10000>;
> +               interrupts = <17>;
> +               clocks = <&clks CLK_LCD>;
> +               interrupts = <23>;

The interrupt line is duplicated in the example.

> +               status = "okay";
> +
> +               port {
> +                       lcdc_out: endpoint {
> +                               remote-endpoint = <&panel_in>;
> +                               bus-width = <16>;
> +                       };
> +               };
> +       };
> +
> +PXA LCDC Display
> +----------------
> +Required properties (as per of_videomode_helper):
> + - lcd-type: either "mono-stn", "mono-dstn", "color-stn", "color-dstn",
> +                   "color-tft", "smart-panel"

Would it make sense to make this property optional and have the
default be "color-tft"? That is probably the most common one by far.

regards
Philipp

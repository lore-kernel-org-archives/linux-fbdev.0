From: Rob Herring <robh@kernel.org>
Date: Tue, 06 Oct 2015 13:30:30 +0000
Subject: Re: [PATCH v2] video: fbdev: add Marvell PXA framebuffer binding
Message-Id: <CAL_JsqLy-pK4VpBkj1-wVg85XvPemssM-=Ckx=yDjiXKXbtwtA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443954683-13126-1-git-send-email-robert.jarzmik@free.fr>
In-Reply-To: <1443954683-13126-1-git-send-email-robert.jarzmik-GANU6spQydw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Sun, Oct 4, 2015 at 5:31 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Add documentation for the PXA frambuffer devicetree binding.

Strictly speaking this is a binding for PXA display controller, not a
Linux FB driver. There are lots of "framebuffer" and "DRM" bindings
which I'm trying to curb.

> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: Philipp's review on the whole binding
> ---
>  .../devicetree/bindings/video/marvell,pxafb.txt    | 80 ++++++++++++++++++++++

Please put in bindings/display/ as I'm consolidating all the display
related bindings there[1].

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

No differences in h/w for any of the chips?

> + - reg : Should contain 1 register ranges(address and length).
> +        Can contain an additional register range(address and length)
> +        for fixed framebuffer memory. Useful for dedicated memories.

This is memory that can't be used for anything else? We already have
reserved-memory for this if it is just RAM. There's also a binding for
on-chip SRAM which should probably be used if the memory is usable for
other things.

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

This should not be specific to PXA, but for this panel. This should be
in bindings/display/panel/.

> +----------------
> +Required properties (as per of_videomode_helper):
> + - lcd-type: either "mono-stn", "mono-dstn", "color-stn", "color-dstn",
> +                   "color-tft", "smart-panel"
> +
> +Optional properties (as per of_videomode_helper):
> + - power-supply: power supply regulator to the LCD to power it on or off
> +                (see regulator.txt)
> + - backlight: backlight control (see backlight.txt)
> +
> +Required nodes:
> + - port: connection to the LCD controller
> + - display-timings: panel timings (see display-timing.txt)

If lcd-type is smart-panel, then this node would not make sense.

> +
> +Example:
> +       panel {
> +               compatible = "toshiba,ltm0305a776";
> +               lcd-type = "color-tft";
> +
> +               power-supply = <&lcd_supply>;
> +               backlight = <&lcd_backlight>;
> +
> +               port {
> +                       panel_in: endpoint {
> +                               remote-endpoint = <&lcdc_out>;
> +                       };
> +               };
> +
> +               display-timings {
> +                       native-mode = <&timing0>;
> +                       timing0: 240p {
> +                               /* 240x320p24 */
> +                               clock-frequency = <4545000>;
> +                               hactive = <240>;
> +                               vactive = <320>;
> +                               hfront-porch = <4>;
> +                               hback-porch = <6>;
> +                               hsync-len = <4>;
> +                               vback-porch = <5>;
> +                               vfront-porch = <3>;
> +                               vsync-len = <2>;
> +                       };
> +               };
> +       };
> --
> 2.1.4
>

[1] https://lkml.org/lkml/2015/10/1/899

From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Oct 2015 18:48:14 +0000
Subject: Re: [PATCH v3] video: fbdev: add Marvell PXA LCD controller binding
Message-Id: <CAL_JsqJSfKLUVGO_e2tdh_Pr1CEHKLoBveMmJEOPMSFzYtx-6Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444649423-25369-1-git-send-email-robert.jarzmik@free.fr>
In-Reply-To: <1444649423-25369-1-git-send-email-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Mon, Oct 12, 2015 at 6:30 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Add documentation for the PXA LCD controller devicetree binding.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: Philipp's review on the whole binding
> Since v2: moved to display/, Philipp's and Rob's review
>           dropped panel description, should be a simple panel with a
>           lcd-type optional node that could be added to simple-panel.

Applied, thanks.

Rob

> ---
>  .../bindings/display/marvell,pxa2xx-lcdc.txt       | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/marvell,pxa2xx-lcdc.txt
>
> diff --git a/Documentation/devicetree/bindings/display/marvell,pxa2xx-lcdc.txt b/Documentation/devicetree/bindings/display/marvell,pxa2xx-lcdc.txt
> new file mode 100644
> index 000000000000..309c47f25b87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/marvell,pxa2xx-lcdc.txt
> @@ -0,0 +1,34 @@
> +PXA LCD Controller
> +------------------
> +
> +Required properties:
> + - compatible : one of these
> +       "marvell,pxa2xx-lcdc",
> +       "marvell,pxa270-lcdc",
> +       "marvell,pxa300-lcdc"
> + - reg : should contain 1 register range (address and length).
> + - interrupts : framebuffer controller interrupt.
> + - clocks: phandle to input clocks
> +
> +Required nodes:
> + - port: connection to the LCD panel (see video-interfaces.txt)
> +        This node must have its properties bus-width and remote-endpoint set.
> +        If the panel is not a TFT color panel, then a "lcd-type" property in
> +        the panel should specify the panel type.
> +        This panel node should be in the board dts.
> +
> +Example:
> +       lcd-controller@40500000 {
> +               compatible = "marvell,pxa2xx-lcdc";
> +               reg = <0x44000000 0x10000>;
> +               interrupts = <17>;
> +               clocks = <&clks CLK_LCD>;
> +               status = "okay";
> +
> +               port {
> +                       lcdc_out: endpoint {
> +                               remote-endpoint = <&panel_in>;
> +                               bus-width = <16>;
> +                       };
> +               };
> +       };
> --
> 2.1.4
>

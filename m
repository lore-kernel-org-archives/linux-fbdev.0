From: Philipp Zabel <philipp.zabel@gmail.com>
Date: Sat, 03 Oct 2015 17:14:36 +0000
Subject: Re: [PATCH] video: fbdev: add Marvell PXA framebuffer binding
Message-Id: <CA+gwMceq-+8UX4J7zgMG_DcGYE1RhmiHhKig8i7MVwga53LQRw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443888694-12311-1-git-send-email-robert.jarzmik@free.fr>
In-Reply-To: <1443888694-12311-1-git-send-email-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

On Sat, Oct 3, 2015 at 6:11 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Add documentation for the PXA frambuffer devicetree binding.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
>
> ---
>  .../devicetree/bindings/video/marvell,pxafb.txt    | 75 ++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/marvell,pxafb.txt
>
> diff --git a/Documentation/devicetree/bindings/video/marvell,pxafb.txt b/Documentation/devicetree/bindings/video/marvell,pxafb.txt
> new file mode 100644
> index 000000000000..489055bf3c57
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/marvell,pxafb.txt
> @@ -0,0 +1,75 @@
> +PXA LCDC Framebuffer
> +-----------------------------------------------------
> +
> +Required properties:
> +- compatible :
> +       "marvell,pxa2xx-fb",

Should be "marvell,pxa2xx-lcd-controller", "marvell,pxa2xx-lcdc" or
something like this.

> +- reg : Should contain 1 register ranges(address and length).
> +       Can contain an additional register range(address and length)
> +       for fixed framebuffer memory. Useful for dedicated memories.
> +- interrupts : framebuffer controller interrupt
> +- display: a phandle pointing to the display node
> +
> +Required nodes:
> +- display: a display node is required to initialize the lcd panel
> +          This should be in the board dts.

I'd prefer to use an of-graph link to a panel node with a proper
compatible value for the panel, instead of this custom display
property.
That way, if somebody ever decides convert the fbdev driver to a drm
driver, we don't have to change the device tree and can directly use
drm_panel.

> +- default-mode: a videomode within the display with timing parameters
> +               as specified below.
> +- bits-per-pixel: pixel data bus width of the LCD panel

Would bus-width be better here?

> +Optional properties:
> +- lcd-supply: Regulator for LCD supply voltage.

How does this differ from the regulator below?

> +- enable-transparency-bit: if framebuffer colorspace reserves a bit for
> +                          transparency

That doesn't belong in the device tree.

> +- enable-greyscale-cmap: true if palette is a grayscale based instead of color

I suspect this doesn't belong in the device tree either. Does this
specify the pixel format of the memory framebuffer?

> +Example:
> +
> +       fb0: video@0x44000000 {
> +               compatible = "marvell,pxa2xx-fb";
> +               reg = <0x44000000 0x10000>;
> +               interrupts = <17>;
> +               clocks = <&clks CLK_LCD>;
> +               interrupts = <23>;
> +               display = <&display0>;
> +               status = "okay";
> +
> +               enable-transparency-bit = <0>;
> +               enable-greyscale-cmap = <0>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;

What are the #address/size-cells needed for?

> +       };
> +
> +PXA LCDC Display
> +-----------------------------------------------------
> +Required properties (as per of_videomode_helper):
> + - lcd-type: either "mono-stn", "mono-dstn", "color-stn", "color-dstn",
> +                   "color-tft", "smart-panel"
> + - bits-per-pixel: LCD data bus width

This is already found in the lcd controller node above.

> +Optional properties (as per of_videomode_helper):
> + - power-regulator: power supply regulator to the LCD to power it on or off

regards
Philipp

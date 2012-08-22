From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 22 Aug 2012 21:07:21 +0000
Subject: Re: [PATCHv3 7/9] arm: vt8500: doc: Add device tree bindings for arch-vt8500 devices
Message-Id: <50354A09.7070507@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345582058-2291-1-git-send-email-linux@prisktech.co.nz>
 <1345582058-2291-8-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1345582058-2291-8-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/21/2012 02:47 PM, Tony Prisk wrote:
> Bindings for gpio, interrupt controller, power management controller,
> timer, realtime clock, serial uart, ehci and uhci controllers and
> framebuffer controllers used on the arch-vt8500 platform.
> 
> Framebuffer binding also specifies a 'display' node which is required
> for determining the lcd panel data.

> diff --git a/Documentation/devicetree/bindings/gpio/gpio_vt8500.txt b/Documentation/devicetree/bindings/gpio/gpio_vt8500.txt

> +- #gpio-cells : should be <3>.
> +	1) bank
> +	2) pin number
> +	3) flags

Should this enumerate what legal values are for flags, or point at a
standard document that does?

> diff --git a/Documentation/devicetree/bindings/tty/serial/via,vt8500-uart.txt b/Documentation/devicetree/bindings/tty/serial/via,vt8500-uart.txt

> +	uart@d8210000 {
> +		compatible = "via,vt8500-uart";
> +		reg = <0xd8210000 0x1040>;
> +		interrupts = <47>;
> +	};

How does the UART know what frequency its clock input is, in order to
calculate dividers? Should there be a clocks property to link to the
input clock, so the rate can be queried? If so, a reference to the
common clock binding, plus a specification of which clocks must be
listed in the clock property should be included here.

> diff --git a/Documentation/devicetree/bindings/video/via,vt8500-fb.txt b/Documentation/devicetree/bindings/video/via,vt8500-fb.txt

> +VIA VT8500 Display
> +-----------------------------------------------------
> +Required properties:
> +- xres : lcd panel horizontal resolution
> +- yres : lcd panel vertical resolution
> +- left-margin,
> +- right-margin,
> +- hsync-len: lcd panel horizontal timings in pixels
> +- upper-margin,
> +- lower-margin,
> +- vsync-len: lcd panel verticals timings in pixels
> +- bpp: lcd panel bit-depth.
> +	<16> for RGB565, <32> for RGB888

Shouldn't this reference Sascha Hauer's binding document (although I
suppose it isn't checked in yet), and just document the additions? I
wonder if this binding should be written assuming Sascha's binding doc
will be checked in?

From: Mark Rutland <mark.rutland@arm.com>
Date: Fri, 21 Mar 2014 09:47:01 +0000
Subject: Re: [PATCH 3/3] video: clps711x: Add bindings documentation for CLPS711X framebuffer
Message-Id: <20140321094701.GJ23372@e106331-lin.cambridge.arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395332818-23193-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1395332818-23193-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

On Thu, Mar 20, 2014 at 04:26:58PM +0000, Alexander Shiyan wrote:
> Add OF document for Cirrus Logic CLPS711X framebuffer driver.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  .../bindings/video/cirrus,clps711x-fb.txt          | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/cirrus,clps711x-fb.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/cirrus,clps711x-fb.txt b/Documentation/devicetree/bindings/video/cirrus,clps711x-fb.txt
> new file mode 100644
> index 0000000..9d59ad3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/cirrus,clps711x-fb.txt
> @@ -0,0 +1,48 @@
> +* Currus Logic CLPS711X Framebuffer
> +
> +Required properties:
> +- compatible: Shall contain "cirrus,clps711x-fb".
> +- reg: Physical base address and length of the controller's registers +
> +   location and size of the framebuffer memory.
> +- clocks: phandle + clock specifier pair of the FB reference clock.
> +
> +Required nodes:
> +- display: Phandle to a display node as described in display-timing.txt.

Is this a node or a property?

It looks like you need a node and a phandle to it, please describe these
separately.

Cheers,
Mark.

> +  Additionally, the display node has to define properties:
> +  - bits-per-pixel: Bits per pixel.
> +  - ac-prescale: LCD AC bias frequency. This frequency is the required
> +     AC bias frequency for a given manufacturer's LCD plate.
> +  - cmap-invert: Invert the color levels (Optional).
> +
> +Optional properties:
> +- lcd-supply: Regulator for LCD supply voltage.
> +
> +Example:
> +	fb: fb@800002c0 {
> +		compatible = "cirrus,ep7312-fb", "cirrus,clps711x-fb";
> +		reg = <0x800002c0 0xd44>, <0x60000000 0xc000>;
> +		clocks = <&clks 2>;
> +		lcd-supply = <&reg5v0>;
> +		display = <&display>;
> +	};
> +
> +	display: display {
> +		model = "320x240x4";
> +		native-mode = <&timing0>;
> +		bits-per-pixel = <4>;
> +		ac-prescale = <17>;
> +
> +		display-timings {
> +			timing0: 320x240 {
> +				hactive = <320>;
> +				hback-porch = <0>;
> +				hfront-porch = <0>;
> +				hsync-len = <0>;
> +				vactive = <240>;
> +				vback-porch = <0>;
> +				vfront-porch = <0>;
> +				vsync-len = <0>;
> +				clock-frequency = <6500000>;
> +			};
> +		};
> +	};
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

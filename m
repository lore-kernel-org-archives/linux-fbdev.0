From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 21 Oct 2013 08:03:27 +0000
Subject: Re: [Patch v2][ 08/37] video: mx3fb: Add device tree suport.
Message-Id: <20131021080327.GA30088@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
 <1382022155-21954-9-git-send-email-denis@eukrea.com>
 <20131019110459.GM18477@ns203013.ovh.net>
In-Reply-To: <20131019110459.GM18477@ns203013.ovh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, Oct 19, 2013 at 01:04:59PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:02 Thu 17 Oct     , Denis Carikli wrote:
> > diff --git a/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt b/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
> > new file mode 100644
> > index 0000000..ae0b343
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
> > @@ -0,0 +1,52 @@
> > +Freescale mx3 Framebuffer
> > +
> > +This framebuffer driver supports the imx31 and imx35 devices.
> > +
> > +Required properties:
> > +- compatible : Must be "fsl,mx3-fb".
> > +- reg : Should contain 1 register ranges(address and length).
> > +- dmas : Phandle to the ipu dma node as described in
> > +	Documentation/devicetree/bindings/dma/dma.txt
> > +- dma-names : Must be "tx".
> > +- clocks : Phandle to the ipu source clock.
> > +- display: Phandle to a display node as described in
> > +	Documentation/devicetree/bindings/video/display-timing.txt
> > +	Additional, the display node has to define properties:
> > +	- bits-per-pixel: lcd panel bit-depth.
> > +
> > +Optional properties:
> > +- ipu-disp-format: could be "rgb666", "rgb565", or "rgb888".
> > +  If not specified defaults to "rgb666".
> > +
> > +Example:
> > +
> > +	lcdc: mx3fb@53fc00b4 {
> > +		compatible = "fsl,mx3-fb";
> > +		reg = <0x53fc00b4 0x0b>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_lcdc_1>;
> > +		clocks = <&clks 55>;
> > +		dmas = <&ipu 14>;
> > +		dma-names = "tx";
> > +	};

As mentioned to the v1 patch: This should really be closer to the IPUv3
binding. IPUv1 and IPUv3 are very similar hardwares. Having two
different bindings for it is painful.

Implementing IPUv1 as a DMA driver was the wrong decision back then, now
exposing the IPU to dt using the DMA binding makes it worse.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 05 Nov 2013 06:09:29 +0000
Subject: Re: [PATCHv4][ 2/6] dma: ipu: Add devicetree support.
Message-Id: <20131105060929.GX24559@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383581724-14817-1-git-send-email-denis@eukrea.com>
 <1383581724-14817-2-git-send-email-denis@eukrea.com>
In-Reply-To: <1383581724-14817-2-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 04, 2013 at 05:15:20PM +0100, Denis Carikli wrote:
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-ipu.txt b/Documentation/devicetree/bindings/dma/fsl-imx-ipu.txt
> new file mode 100644
> index 0000000..2f3c976
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-ipu.txt
> @@ -0,0 +1,20 @@
> +* Freescale Image Processing Unit (IPU) support for i.MX3x.
> +
> +This driver supports the imx31 and imx35 devices.
> +
> +Required properties:
> +- compatible : Should be "fsl,imx31-ipu".
> +- reg : Should contain IPU registers location and length.
> +- interrupts : First item should be IPU interrupt, second one is optional and
> +    should contain IPU Error interrupt.
> +
> +Example:
> +
> +	ipu: ipu@53fc0000 {
> +		compatible = "fsl,imx31-ipu";
> +		reg = <	0x53fc0000 0x5f
> +			0x53fc0088 0x2b >;
> +		interrupts = <42 41>;
> +		clocks = <&clks 55>;
> +		clock-names = "";
> +	};

As said before: I don't think that splitting the IPU in several nodes
like above just to satisfy the current Linux driver setup is
appropriate.

The IPU should rather look like:

ipu: ipu@53fc0000 {
	compatible = "fsl,imx31-ipu";
	reg = <0x53fc0000 0x4000>;
	interrupts = <42 31>;
	clocks = <&clks 55 ...>;
	clock-names = "...";
};

Note that the above covers the whole address space of the IPU. This is
more close to the IPUv3 binding. With separating the IDMAC and DI nodes
you force us to keep the current driver separation between dma and fb
driver. The IPU should never have used the Linux DMA driver framework
though.

When you cover the whole address space you could then in the
corresponding driver register platform devices which match to the
current dma/fb driver combination.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

From: Rob Herring <robh@kernel.org>
Date: Thu, 02 Mar 2017 16:13:30 +0000
Subject: Re: [PATCH 2/2] dt-bindings: display: imx: entry for LAUSCR
Message-Id: <20170302161330.6xguzjv3ttwbv5ek@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1488193030-13064-1-git-send-email-martin@kaiser.cx>
 <1488193030-13064-2-git-send-email-martin@kaiser.cx>
In-Reply-To: <1488193030-13064-2-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Kaiser <martin@kaiser.cx>
Cc: linux-fbdev@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 27, 2017 at 11:56:42AM +0100, Martin Kaiser wrote:
> Allow setting the LCDC AUS Mode Control Register from the device tree.
> This setting is optional, the register is available only on imx21 and
> compatible chipsets.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt b/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt
> index 7a5c0e2..bd5077f 100644
> --- a/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt
> @@ -13,6 +13,8 @@ Required nodes:
>  	Additional, the display node has to define properties:
>  	- bits-per-pixel: Bits per pixel
>  	- fsl,pcr: LCDC PCR value
> +	A display node may optionally define
> +	- fsl,lauscr: LCDC AUS Mode Control Register value (only for imx21)

Looks like we already got one, but generally we don't just put magic 
register values in the DT. What does this register control?

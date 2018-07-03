From: Rob Herring <robh@kernel.org>
Date: Tue, 03 Jul 2018 20:14:42 +0000
Subject: Re: [PATCH 1/2] dt-bindings: video: fbdev: add devicetree bindings for pxa3xx-gcu
Message-Id: <20180703201442.GA9598@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180623191125.22965-1-daniel@zonque.org>
In-Reply-To: <20180623191125.22965-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Mack <daniel@zonque.org>
Cc: airlied@linux.ie, mark.rutland@arm.com, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, robert.jarzmik@free.fr

On Sat, Jun 23, 2018 at 09:11:24PM +0200, Daniel Mack wrote:
> This patch adds the binding documentation for the pxa3xx gcu.

The subject should match the bindings hierarchy, not what driver 
subsystem you are currently using.

> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  .../bindings/display/marvell,pxa3xx-gcu.txt    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/marvell,pxa3xx-gcu.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/marvell,pxa3xx-gcu.txt b/Documentation/devicetree/bindings/display/marvell,pxa3xx-gcu.txt
> new file mode 100644
> index 000000000000..d1b2302d0fd8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/marvell,pxa3xx-gcu.txt
> @@ -0,0 +1,18 @@
> +PXA3xx GCU Controller
> +---------------------
> +
> +Required properties:
> + - compatible : "marvell,pxa3xx-gcu"

Don't use wildcards in compatible strings.

> + - reg : should contain the register range (address and length).
> + - interrupts : GCU interrupt.
> + - clocks: phandle to input clocks

Be specific as to how many.

> +
> +Example for PXA3xx:
> +
> +	gcu@54000000 {

display-controller@...

> +		compatible = "marvell,pxa3xx-gcu";
> +		reg = <0x54000000 0x1000>;
> +		interrupts = <39>;
> +		clocks = <&clks CLK_PXA300_GCU>;
> +	};
> +
> -- 
> 2.17.1
> 

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 28 Feb 2014 15:59:37 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <20140228155937.GQ21483@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com> <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1393590016-9361-4-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Fri, Feb 28, 2014 at 02:20:10PM +0200, Tomi Valkeinen wrote:
> Add DT binding documentation for DVI Connector.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reviewed-by: Archit Taneja <archit@ti.com>
> ---
>  .../devicetree/bindings/video/dvi-connector.txt    | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/dvi-connector.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/dvi-connector.txt b/Documentation/devicetree/bindings/video/dvi-connector.txt
> new file mode 100644
> index 000000000000..6a0aff866c78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/dvi-connector.txt
> @@ -0,0 +1,26 @@
> +DVI Connector
> +=======
> +
> +Required properties:
> +- compatible: "dvi-connector"
> +
> +Optional properties:
> +- label: a symbolic name for the connector
> +- i2c-bus: phandle to the i2c bus that is connected to DVI DDC
> +
> +Required nodes:
> +- Video port for DVI input
> +
> +Example
> +-------
> +
> +dvi0: connector@0 {
> +	compatible = "dvi-connector";
> +	label = "dvi";
> +
> +	i2c-bus = <&i2c3>;
> +
> +	dvi_connector_in: endpoint {
> +		remote-endpoint = <&tfp410_out>;
> +	};
> +};

This looks far too simplistic.  There are different classes of DVI
connector - there is:

DVI A - analogue only
DVI D - digital only (single and dual link)
DVI I - both (single and dual digital link)

DRM at least makes a distinction between these three classes, and this
disctinction is part of the user API.  How would a display system know
which kind of DVI connector is wired up on the board from this DT
description?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

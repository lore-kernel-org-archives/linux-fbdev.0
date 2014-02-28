From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 28 Feb 2014 13:43:28 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <1393595008.3802.35.camel@paszta.hi.pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
	<1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hi Tomi,

Am Freitag, den 28.02.2014, 14:20 +0200 schrieb Tomi Valkeinen:
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

For the i.MX bindings I had called this property 'ddc', but
Documentation/devicetree/bindings/panel/simple-panel.txt already
uses 'ddc-i2c-bus'. We should definitely standardize this.

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

regards
Philipp


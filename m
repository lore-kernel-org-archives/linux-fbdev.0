From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 18 Mar 2014 08:43:54 +0000
Subject: Re: [PATCHv2 4/8] Doc/DT: Add DT binding documentation for HDMI Connector
Message-Id: <1395132234.4134.1.camel@paszta.hi.pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
 <1395130547-18633-5-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1395130547-18633-5-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robherring2@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hi Tomi,

Am Dienstag, den 18.03.2014, 10:15 +0200 schrieb Tomi Valkeinen:
> Add DT binding documentation for HDMI Connector.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reviewed-by: Archit Taneja <archit@ti.com>
> ---
>  .../devicetree/bindings/video/hdmi-connector.txt   | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/hdmi-connector.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/hdmi-connector.txt b/Documentation/devicetree/bindings/video/hdmi-connector.txt
> new file mode 100644
> index 000000000000..ccccc19e2573
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/hdmi-connector.txt
> @@ -0,0 +1,28 @@
> +HDMI Connector
> +=======
> +
> +Required properties:
> +- compatible: "hdmi-connector"
> +- type: the HDMI connector type: "a", "b", "c", "d" or "e"
> +
> +Optional properties:
> +- label: a symbolic name for the connector
> +
> +Required nodes:
> +- Video port for HDMI input

Geert's comment also applies to all other connector types. These can be
input connectors, too.

regards
Philipp



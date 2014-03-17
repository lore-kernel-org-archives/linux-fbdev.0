From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 17 Mar 2014 14:19:32 +0000
Subject: Re: [PATCH 5/9] Doc/DT: Add DT binding documentation for MIPI DPI Panel
Message-Id: <3721050.m43feCICLQ@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-6-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1393590016-9361-6-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hi Tomi,

Thank you for the patch.

On Friday 28 February 2014 14:20:12 Tomi Valkeinen wrote:
> Add DT binding documentation for MIPI DPI Panel.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reviewed-by: Archit Taneja <archit@ti.com>
> ---
>  .../devicetree/bindings/video/panel-dpi.txt        | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/panel-dpi.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/panel-dpi.txt
> b/Documentation/devicetree/bindings/video/panel-dpi.txt new file mode
> 100644
> index 000000000000..72636c6f1c67
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/panel-dpi.txt
> @@ -0,0 +1,43 @@
> +Generic MIPI DPI Panel
> +===========
> +
> +Required properties:
> +- compatible: "panel-dpi"
> +
> +Optional properties:
> +- label: a symbolic name for the panel
> +- gpios: panel enable gpio and backlight enable gpio

While integrated in the panel module, the backlight is a separate piece of 
hardware, which could be controlled through other means (I2C for instance). 
Wouldn't it be better to add an explicit DT node for the backlight device and 
reference that node from the panel node ?

> +
> +Required nodes:
> +- "panel-timing" containing video timings
> +  (Documentation/devicetree/bindings/video/display-timing.txt)
> +- Video port for DPI input
> +
> +Example
> +-------
> +
> +lcd0: display@0 {
> +        compatible = "samsung,lte430wq-f0c", "panel-dpi";
> +        label = "lcd";
> +
> +        lcd_in: endpoint {
> +                remote-endpoint = <&dpi_out>;
> +        };
> +
> +        panel-timing {
> +                clock-frequency = <9200000>;
> +                hactive = <480>;
> +                vactive = <272>;
> +                hfront-porch = <8>;
> +                hback-porch = <4>;
> +                hsync-len = <41>;
> +                vback-porch = <2>;
> +                vfront-porch = <4>;
> +                vsync-len = <10>;
> +
> +                hsync-active = <0>;
> +                vsync-active = <0>;
> +                de-active = <1>;
> +                pixelclk-active = <1>;
> +        };
> +};

-- 
Regards,

Laurent Pinchart


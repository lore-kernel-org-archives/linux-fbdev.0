From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 03 Jul 2014 09:04:47 +0000
Subject: Re: [RFC v4 2/2] backlight: device tree: add new tps611xx backlight binding
Message-Id: <20140703090447.GC29837@leverpostej>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404367277-12003-1-git-send-email-gshark.jeong@gmail.com>
 <1404367277-12003-3-git-send-email-gshark.jeong@gmail.com>
In-Reply-To: <1404367277-12003-3-git-send-email-gshark.jeong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Jeong <gshark.jeong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Daniel Jeong <daniel.jeong-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Jul 03, 2014 at 07:01:17AM +0100, Daniel Jeong wrote:
> This commit is about tps611xx device tree documentation.
> 
> Signed-off-by: Daniel Jeong <gshark.jeong@gmail.com>
> ---
>  .../video/backlight/tps611xx-backlight.txt         |   24 ++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt b/Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt
> new file mode 100644
> index 0000000..7af8182
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt
> @@ -0,0 +1,24 @@
> +TPS611xx family of backlight driver based on EasyScale.
> +
> +EasyScale is a simple but flexible one pin interface to configure the current.
> +
> +Required properties:
> +- compatible: should contain at least one of
> +  "ti,tps61158_bl"
> +  "ti,tps61161_bl"
> +  "ti,tps61163_bl"
> +  "ti,tps61165_bl"

In v3 I asked you to get rid of the "_bl" suffix.

> +- rfa-enable: enable request for acknowledge.
> +  If RFA is enabled, the data byte includes the RFA bit and device will wait
> +  and check acknowledge from device.

You didn't answer my question as to why this should be in the DT.

> +- es-gpio : GPIO for easy-scale communication.(see GPIO binding[0])
> +
> +[0]: Documentation/devicetree/bindings/gpio/gpio.txt
> +
> +Example:
> +
> +	backlight {
> +		compatible = "ti,tps61163";

This now doesn't match the Documentation above.

Thanks,
Mark.

> +		rfa-enable;
> +		es-gpio = <&gpio 45 0>;
> +	};
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

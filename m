From: Gyungoh Yoo <gyungoh@gmail.com>
Date: Fri, 09 Jan 2015 01:30:36 +0000
Subject: Re: [PATCH v10 3/6] devicetree: mfd: Add new SKY81452 mfd binding
Message-Id: <20150109013036.GA2907@jack-ThinkPad-T520>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1420597167-3188-1-git-send-email-jack.yoo@skyworksinc.com>
 <1420597167-3188-4-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1420597167-3188-4-git-send-email-jack.yoo-tjhQNA90jdKqndwCJWfcng@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, matti.vaittinen-OYasijW0DpE@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, florian.vaussard-p8DiymsW2f8@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, antonynpavlov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hytszk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, jack.yoo-tjhQNA90jdKqndwCJWfcng@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

DT Ack please.

On Wed, Jan 07, 2015 at 11:19:24AM +0900, gyungoh@gmail.com wrote:
> From: Gyungoh Yoo <jack.yoo@skyworksinc.com>
> 
> Signed-off-by: Gyungoh Yoo <jack.yoo@skyworksinc.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> Changes v10:
> Nothing
> 
> Changes v9:
> Nothing
> 
> Changes v8:
> Made up the example for backlight DT
> 
> Changes v7:
> Nothing
> 
> Changes v6:
> Nothing
> 
> Changes v5:
> Changed DT for regulator : 'lout' node should be defined under 'regulator'
> Removed compatible string from sky81452-regulator driver
> 
> Changes v4:
> Nothing
> 
> Changes v3:
> Nothing
> 
> Changes v2:
> Added reg attribute for I2C slave address
> 
>  Documentation/devicetree/bindings/mfd/sky81452.txt | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sky81452.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sky81452.txt b/Documentation/devicetree/bindings/mfd/sky81452.txt
> new file mode 100644
> index 0000000..ab71473
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sky81452.txt
> @@ -0,0 +1,36 @@
> +SKY81452 bindings
> +
> +Required properties:
> +- compatible	: Must be "skyworks,sky81452"
> +- reg		: I2C slave address
> +
> +Required child nodes:
> +- backlight	: container node for backlight following the binding
> +		in video/backlight/sky81452-backlight.txt
> +- regulator	: container node for regulators following the binding
> +		in regulator/sky81452-regulator.txt
> +
> +Example:
> +
> +	sky81452@2c {
> +		compatible = "skyworks,sky81452";
> +		reg = <0x2c>;
> +
> +		backlight {
> +			compatible = "skyworks,sky81452-backlight";
> +			name = "pwm-backlight";
> +			skyworks,en-channels = <0x3f>;
> +			skyworks,ignore-pwm;
> +			skyworks,phase-shift;
> +			skyworks,ovp-level = <20>;
> +			skyworks,current-limit = <2300>;
> +		};
> +
> +		regulator {
> +			lout {
> +				regulator-name = "sky81452-lout";
> +				regulator-min-microvolt = <4500000>;
> +				regulator-max-microvolt = <8000000>;
> +			};
> +		};
> +	};
> -- 
> 1.9.1
> 

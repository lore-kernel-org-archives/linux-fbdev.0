From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 05 Sep 2012 17:25:27 +0000
Subject: Re: [PATCH v5 2/4] pwm_backlight: use power sequences
Message-Id: <50478B07.4080708@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346412846-17102-1-git-send-email-acourbot@nvidia.com> <1346412846-17102-3-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1346412846-17102-3-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/31/2012 05:34 AM, Alexandre Courbot wrote:
> Make use of the power sequences specified in the device tree or platform
> data to control how the backlight is powered on and off.

> +++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt

>  Optional properties:
> -  - pwm-names: a list of names for the PWM devices specified in the
> -               "pwms" property (see PWM binding[0])
> +  - pwm-names: name for the PWM device specified in the "pwms" property (see PWM
> +      binding[0]). Necessary if power sequences are used

So this implies that power sequence are completely optional in the pwm
binding...

> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig

>  config BACKLIGHT_PWM
>  	tristate "Generic PWM based Backlight Driver"
>  	depends on PWM
> +	select POWER_SEQ

... but that implies they're basically mandatory.

Briefly looking at the code, power sequences don't appear to be
optional, at least for the DT case, so perhaps you just need to update
the documentation to make "pwm-names" non-optional?

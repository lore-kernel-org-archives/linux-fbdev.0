From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Tue, 07 Aug 2018 05:37:05 +0000
Subject: Re: [PATCH V4 5/8] backlight: qcom-wled: Restructure the driver for WLED3
Message-Id: <20180807053705.GB23866@tuxbook-pro>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-6-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1531131741-19971-6-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org

On Mon 09 Jul 03:22 PDT 2018, Kiran Gunda wrote:
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
[..]
> @@ -365,6 +434,15 @@ static int wled_configure(struct wled *wled, struct device *dev)
>  
>  	cfg->num_strings = cfg->num_strings + 1;
>  
> +	string_len = of_property_count_elems_of_size(dev->of_node,
> +						     "qcom,enabled-strings",
> +						     sizeof(u32));
> +	if (string_len > 0)
> +		rc = of_property_read_u32_array(dev->of_node,
> +						"qcom,enabled-strings",
> +						wled->cfg.enabled_strings,

qcom,enabled-strings is listed as optional, but without it we will end
up with qcom,num-strings zeros in an array.  Initialize
wled->cfg.enabled_strings to 0,1,2,3 and the driver will be backwards
compatible.

I also think that if you do qcom,enabled-strings = <0, 1, 2>; there's no
need to also specify qcom,num-strings = <3>; and we can just use
string_len for num_strings.

> +						sizeof(u32));
> +
>  	return 0;
>  }

Regards,
Bjorn

From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Wed, 20 Jun 2018 05:33:00 +0000
Subject: Re: [PATCH V3 6/7] backlight: qcom-wled: add support for short circuit handling
Message-Id: <20180620053300.GJ15126@tuxbook-pro>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-7-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1529406822-15379-7-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, Daniel Thompson <daniel.thompson@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org

On Tue 19 Jun 04:13 PDT 2018, Kiran Gunda wrote:

> Handle the short circuit interrupt and check if the short circuit
> interrupt is valid. Re-enable the module to check if it goes
> away. Disable the module altogether if the short circuit event
> persists.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 130 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 127 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
[..]
>  struct wled {
>  	const char *name;
>  	struct device *dev;
>  	struct regmap *regmap;
> +	struct mutex lock;	/* Lock to avoid race from ISR */
> +	ktime_t last_short_event;
>  	u16 ctrl_addr;
>  	u16 sink_addr;
>  	u32 brightness;
>  	u32 max_brightness;
> +	u32 short_count;
>  	const int *version;
> +	bool disabled_by_short;
> +	bool has_short_detect;

The use of feature flags, instead of checking the version, like this is
good!

>  
>  	struct wled_config cfg;
>  	int (*wled_set_brightness)(struct wled *wled, u16 brightness);

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

From: Vinod <vkoul@kernel.org>
Date: Wed, 20 Jun 2018 05:59:22 +0000
Subject: Re: [PATCH V3 6/7] backlight: qcom-wled: add support for short circuit handling
Message-Id: <20180620054722.GH13316@vkoul-mobl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-7-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1529406822-15379-7-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, b.zolnierkie@samsung.com, jingoohan1@gmail.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, bjorn.andersson@linaro.org, linux-leds@vger.kernel.org, linux-arm-msm@vger.kernel.org, lee.jones@linaro.org, linux-kernel@vger.kernel.org

On 19-06-18, 16:43, Kiran Gunda wrote:

>  struct wled {
>  	const char *name;
>  	struct device *dev;
>  	struct regmap *regmap;
> +	struct mutex lock;	/* Lock to avoid race from ISR */

the comment is wrong as you avoid race with thread handler and not the
main ISR. The ISR runs in atomic context so you cant use a mutex but you
may do so with a thread handler

> +#define WLED_SHORT_DLY_MS			20
> +#define WLED_SHORT_CNT_MAX			5
> +#define WLED_SHORT_RESET_CNT_DLY_US		USEC_PER_SEC

an empty line after defines would be better

> +static int wled_configure_short_irq(struct wled *wled,
> +				    struct platform_device *pdev)
> +{
> +	int rc = 0, short_irq;

superfluous initialization of rc

-- 
~Vinod

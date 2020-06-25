From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 25 Jun 2020 09:46:12 +0000
Subject: Re: [PATCH 8/8] backlight: qcom-wled: Remove unused configs for LED3 and LED4
Message-Id: <20200625094612.fn3o5bd37t7vadsc@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624145721.2590327-9-lee.jones@linaro.org>
In-Reply-To: <20200624145721.2590327-9-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, jingoohan1@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <agross@kernel.org>, dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jun 24, 2020 at 03:57:21PM +0100, Lee Jones wrote:
> Fixes W=1 warnings:
> 
>  drivers/video/backlight/qcom-wled.c:1294:34: warning: ‘wled4_string_cfg’ defined but not used [-Wunused-const-variable=]
>  1294 | static const struct wled_var_cfg wled4_string_cfg = {
>  | ^~~~~~~~~~~~~~~~
>  drivers/video/backlight/qcom-wled.c:1290:34: warning: ‘wled3_string_cfg’ defined but not used [-Wunused-const-variable=]
>  1290 | static const struct wled_var_cfg wled3_string_cfg = {
>  | ^~~~~~~~~~~~~~~~
> 
> Cc: <stable@vger.kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/qcom-wled.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 4c8c34b994414..c25c31199952c 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -1287,14 +1287,6 @@ static const struct wled_var_cfg wled4_string_i_limit_cfg = {
>  	.size = ARRAY_SIZE(wled4_string_i_limit_values),
>  };
>  
> -static const struct wled_var_cfg wled3_string_cfg = {
> -	.size = 8,
> -};
> -
> -static const struct wled_var_cfg wled4_string_cfg = {
> -	.size = 16,
> -};
> -
>  static const struct wled_var_cfg wled5_mod_sel_cfg = {
>  	.size = 2,
>  };
> -- 
> 2.25.1
> 

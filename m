From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 20 Apr 2020 15:21:14 +0000
Subject: Re: [PATCH] backlight: qcom-wled: remove 'wled4_string_cfg' and 'wled3_string_cfg'
Message-Id: <20200420152114.b7licril3r6itd45@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417092335.14163-1-yanaijie@huawei.com>
In-Reply-To: <20200417092335.14163-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jason Yan <yanaijie@huawei.com>
Cc: linux-fbdev@vger.kernel.org, kgunda@codeaurora.org, b.zolnierkie@samsung.com, jingoohan1@gmail.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, bjorn.andersson@linaro.org, Hulk Robot <hulkci@huawei.com>, agross@kernel.org, linux-arm-msm@vger.kernel.org, lee.jones@linaro.org

On Fri, Apr 17, 2020 at 05:23:35PM +0800, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/video/backlight/qcom-wled.c:939:34: warning: ‘wled4_string_cfg’
> defined but not used [-Wunused-const-variable=]
>  static const struct wled_var_cfg wled4_string_cfg = {
>                                   ^~~~~~~~~~~~~~~~
> drivers/video/backlight/qcom-wled.c:935:34: warning: ‘wled3_string_cfg’
> defined but not used [-Wunused-const-variable=]
>  static const struct wled_var_cfg wled3_string_cfg = {
>                                   ^~~~~~~~~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/qcom-wled.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 3d276b30a78c..df53fbd5cd03 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -932,14 +932,6 @@ static const struct wled_var_cfg wled4_string_i_limit_cfg = {
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
>  static u32 wled_values(const struct wled_var_cfg *cfg, u32 idx)
>  {
>  	if (idx >= cfg->size)
> -- 
> 2.21.1
> 

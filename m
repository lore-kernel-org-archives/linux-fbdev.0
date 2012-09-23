From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 23 Sep 2012 19:37:24 +0000
Subject: Re: [PATCH] video: exynos_dp: replace link_status with link_align to check channel equalization
Message-Id: <505F64F4.7050201@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000001cd89b1$2852e3b0$78f8ab10$%han@samsung.com>
In-Reply-To: <000001cd89b1$2852e3b0$78f8ab10$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 09/03/2012 08:50 AM, Jingoo Han wrote:
> To check channel equalization, the value of LANE_ALIGN_STATUS_UPDATED is
> necessary in exynos_dp_channel_eq_ok(). Also, link_align includes this value.
> However, link_status does not include this value, so it makes the problem
> that channel equalization is failed during link training.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/exynos/exynos_dp_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index f57c915..cdc1398 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -587,7 +587,7 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
>  			dp->link_train.training_lane[lane] = training_lane;
>  		}
>  
> -		if (exynos_dp_channel_eq_ok(link_status, lane_count) = 0) {
> +		if (exynos_dp_channel_eq_ok(link_align, lane_count) = 0) {
>  			/* traing pattern Set to Normal */
>  			exynos_dp_training_pattern_dis(dp);
>  


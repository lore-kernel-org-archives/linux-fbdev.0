From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 24 Jun 2012 21:00:56 +0000
Subject: Re: [PATCH] video: exynos_dp: remove duplicated declarations from header file
Message-Id: <4FE78008.80305@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000601cd4f94$415cd750$c41685f0$%han@samsung.com>
In-Reply-To: <000601cd4f94$415cd750$c41685f0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 06/21/2012 09:57 AM, Jingoo Han wrote:
> Some functions are declared twice in header file; thus, these
> declarations are unnecessary.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/exynos/exynos_dp_core.h |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
> index 1e0f998..8526e54 100644
> --- a/drivers/video/exynos/exynos_dp_core.h
> +++ b/drivers/video/exynos/exynos_dp_core.h
> @@ -85,10 +85,6 @@ void exynos_dp_set_link_bandwidth(struct exynos_dp_device *dp, u32 bwtype);
>  void exynos_dp_get_link_bandwidth(struct exynos_dp_device *dp, u32 *bwtype);
>  void exynos_dp_set_lane_count(struct exynos_dp_device *dp, u32 count);
>  void exynos_dp_get_lane_count(struct exynos_dp_device *dp, u32 *count);
> -void exynos_dp_set_link_bandwidth(struct exynos_dp_device *dp, u32 bwtype);
> -void exynos_dp_get_link_bandwidth(struct exynos_dp_device *dp, u32 *bwtype);
> -void exynos_dp_set_lane_count(struct exynos_dp_device *dp, u32 count);
> -void exynos_dp_get_lane_count(struct exynos_dp_device *dp, u32 *count);
>  void exynos_dp_enable_enhanced_mode(struct exynos_dp_device *dp, bool enable);
>  void exynos_dp_set_training_pattern(struct exynos_dp_device *dp,
>  				 enum pattern_set pattern);


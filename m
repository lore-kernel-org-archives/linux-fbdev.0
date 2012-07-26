From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 26 Jul 2012 17:22:51 +0000
Subject: Re: [PATCH] video: exynos_dp: check the only INTERLANE_ALIGN_DONE bit during Link Training
Message-Id: <50117CEB.2000503@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000c01cd63f8$57550000$05ff0000$%han@samsung.com>
In-Reply-To: <000c01cd63f8$57550000$05ff0000$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 07/17/2012 08:44 AM, Jingoo Han wrote:
> The only INTERLANE_ALIGN_DONE bit should be checked for channel equalization
> during Link Training. Previously, the other bits such as LINK_STATUS_UPDATED
> were checked, and channel equalization procedure was repeated unnecessarily.
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
> index 9db7b9f..6ca8043 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -336,7 +336,7 @@ static int exynos_dp_channel_eq_ok(u8 link_status[6], int lane_count)
>  	u8 lane_status;
>  
>  	lane_align = link_status[2];
> -	if ((lane_align = DPCD_INTERLANE_ALIGN_DONE) = 0)
> +	if ((lane_align & DPCD_INTERLANE_ALIGN_DONE) = 0)
>  		return -EINVAL;
>  
>  	for (lane = 0; lane < lane_count; lane++) {


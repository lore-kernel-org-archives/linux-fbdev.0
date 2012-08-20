From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 20 Aug 2012 09:19:36 +0000
Subject: Re: [PATCH 05/10] video: exynos_dp: Remove sink control to D0
Message-Id: <004b01cd7eb4$eaf48980$c0dd9c80$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344398064-13563-6-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1344398064-13563-6-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wednesday, August 08, 2012 12:54 PM Sean Paul wrote:
> 
> Don't reset the sink power to D0. Removing this for three reasons:
> 
> 1) It's not required in the SW link training documentation
OK.
> 2) The comment is incorrect, D0 is normal operation, not "power down"
OK. As you mentioned, D0 is not 'power down', 'normal operation'.
However, if comment is wrong, usually we fix comment, not remove it. :)

> 3) It seems to change things in the link training that causes glitches

Um, it seems that this problem depends on LCD panel.
Other LCDs that I have tested do not have this kind of problem.
Please, modify this comment.

> 
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>  drivers/video/exynos/exynos_dp_core.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index 207bd7e..1c998d9 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -273,12 +273,6 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
>  	for (lane = 0; lane < lane_count; lane++)
>  		dp->link_train.cr_loop[lane] = 0;
> 
> -	/* Set sink to D0 (Sink Not Ready) mode. */
> -	ret = exynos_dp_write_byte_to_dpcd(dp, DPCD_ADDR_SINK_POWER_STATE,
> -				DPCD_SET_POWER_STATE_D0);
> -	if (ret)
> -		return ret;
> -
>  	/* Set link rate and count as you want to establish*/
>  	exynos_dp_set_link_bandwidth(dp, dp->link_train.link_rate);
>  	exynos_dp_set_lane_count(dp, dp->link_train.lane_count);
> --
> 1.7.7.3


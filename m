From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 18 Jun 2012 05:22:01 +0000
Subject: RE: [PATCH 1/1] video: exynos_dp: Fix compilation warning
Message-Id: <000c01cd4d12$4a6956e0$df3c04a0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1339995317-17788-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1339995317-17788-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org


On Mon, June 18, 2012 at 1:55 PM, Sachin Kamat wrote:

> Fixes the following warning:
> drivers/video/exynos/exynos_dp_core.c: In function ‘exynos_dp_set_link_train’:
> drivers/video/exynos/exynos_dp_core.c:529:18: warning: ‘reg’ may be used uninitialized in this function
> [-Wuninitialized]
> drivers/video/exynos/exynos_dp_core.c:395:6: note: ‘reg’ was declared here

This warning was already reported and patch was submitted by Olof Johansson.
I will check and fix it later.

Thank you.

> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/video/exynos/exynos_dp_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index a36b2d2..017c727 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -392,7 +392,7 @@ static unsigned int exynos_dp_get_lane_link_training(
>  				struct exynos_dp_device *dp,
>  				int lane)
>  {
> -	u32 reg;
> +	u32 reg = 0;
> 
>  	switch (lane) {
>  	case 0:
> --
> 1.7.4.1


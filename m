From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 20 Jun 2012 00:46:24 +0000
Subject: Re: [PATCH] video: exynos_dp: fix build warning due to uninitialized value
Message-Id: <4FE11D60.9040109@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <001501cd4de5$d955a290$8c00e7b0$%han@samsung.com>
In-Reply-To: <001501cd4de5$d955a290$8c00e7b0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Olof Johansson' <olof@lixom.net>

Hi Jingoo,

On 06/19/2012 06:36 AM, Jingoo Han wrote:
> This patch fixes build warning due to uninitialized value dereference.
> 
> drivers/video/exynos/exynos_dp_core.c: In function 'exynos_dp_set_link_train':
> drivers/video/exynos/exynos_dp_core.c:529:18: warning: 'reg' may be used uninitialized in this function [-Wuninitialized]
> drivers/video/exynos/exynos_dp_core.c:395:6: note: 'reg' was declared here
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/video/exynos/exynos_dp_core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index a36b2d2..9b2cdff 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -407,6 +407,8 @@ static unsigned int exynos_dp_get_lane_link_training(
>  	case 3:
>  		reg = exynos_dp_get_lane3_link_training(dp);
>  		break;
> +	default:
> +		return -EINVAL;

Why do you consider returning -EINVAL here a good idea? As far as I can
see the caller does not check the return value for an error condition
and I doubt that the hardware understands what -EINVAL means. If you
want to fix the warning, make sure that you don't hide actual errors,
add an WARN or BUG or make sure the error code makes it to userspace.

>  	}
>  
>  	return reg;


Best regards,

Florian Tobias Schandinat

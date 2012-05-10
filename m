From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 10 May 2012 00:19:59 +0000
Subject: Re: [PATCH] video: exynos_dp: fix max loop count in EQ sequence of link training
Message-Id: <4FAB09AF.6010803@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <003201cd2998$2ee3eef0$8cabccd0$%han@samsung.com>
In-Reply-To: <003201cd2998$2ee3eef0$8cabccd0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 05/04/2012 01:49 AM, Jingoo Han wrote:
> This patch fixes max loop count in EQ(Channel Equalization) sequence
> of link training. According to DP(displayport) specification,
> the max loop count in this sequence should be 5.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  include/video/exynos_dp.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/video/exynos_dp.h b/include/video/exynos_dp.h
> index 8847a9d..bd8cabd 100644
> --- a/include/video/exynos_dp.h
> +++ b/include/video/exynos_dp.h
> @@ -14,7 +14,7 @@
>  
>  #define DP_TIMEOUT_LOOP_COUNT 100
>  #define MAX_CR_LOOP 5
> -#define MAX_EQ_LOOP 4
> +#define MAX_EQ_LOOP 5
>  
>  enum link_rate_type {
>  	LINK_RATE_1_62GBPS = 0x06,


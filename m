From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 17 Apr 2020 14:08:09 +0000
Subject: Re: [PATCH] video: fbdev: aty128fb: remove unused 'sdr_64'
Message-Id: <aec78fff-4a5b-1222-7758-99e9ea892a0c@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200417085705eucas1p12357601660992a5fbef90358cc7aa219@eucas1p1.samsung.com>
 <20200417092318.13978-1-yanaijie@huawei.com>
In-Reply-To: <20200417092318.13978-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jason Yan <yanaijie@huawei.com>
Cc: linux-fbdev@vger.kernel.org, daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Hulk Robot <hulkci@huawei.com>, paulus@samba.org


On 4/17/20 11:23 AM, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/video/fbdev/aty/aty128fb.c:337:36: warning: ‘sdr_64’ defined but
> not used [-Wunused-const-variable=]
>  static const struct aty128_meminfo sdr_64 = {
>                                     ^~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Patch queued for v5.8, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/aty/aty128fb.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
> index d7e41c8dd533..d05d4195acad 100644
> --- a/drivers/video/fbdev/aty/aty128fb.c
> +++ b/drivers/video/fbdev/aty/aty128fb.c
> @@ -334,20 +334,6 @@ static const struct aty128_meminfo sdr_128 = {
>  	.name = "128-bit SDR SGRAM (1:1)",
>  };
>  
> -static const struct aty128_meminfo sdr_64 = {
> -	.ML = 4,
> -	.MB = 8,
> -	.Trcd = 3,
> -	.Trp = 3,
> -	.Twr = 1,
> -	.CL = 3,
> -	.Tr2w = 1,
> -	.LoopLatency = 17,
> -	.DspOn = 46,
> -	.Rloop = 17,
> -	.name = "64-bit SDR SGRAM (1:1)",
> -};
> -
>  static const struct aty128_meminfo sdr_sgram = {
>  	.ML = 4,
>  	.MB = 4,
> 

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 21 Jun 2019 11:15:00 +0000
Subject: Re: [PATCH] video: fbdev: pvr2fb: fix compile-testing as module
Message-Id: <3ee91294-044d-9bcd-0c4c-3365c0c97604@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190617124822epcas2p2c93d6cec3b60d08d85f228945d5c7623@epcas2p2.samsung.com>
        <20190617124758.1252449-1-arnd@arndb.de>
In-Reply-To: <20190617124758.1252449-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mike Marshall <hubcap@omnibond.com>, YueHaibing <yuehaibing@huawei.com>, Ira Weiny <ira.weiny@intel.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 6/17/19 2:47 PM, Arnd Bergmann wrote:
> Building an allmodconfig kernel now produces a harmless warning:
> 
> drivers/video/fbdev/pvr2fb.c:726:12: error: unused function 'pvr2_get_param_val' [-Werror,-Wunused-function]
> 
> Shut this up the same way as we do for other unused functions
> in the same file, using the __maybe_unused attribute.
> 
> Fixes: 0f5a5712ad1e ("video: fbdev: pvr2fb: add COMPILE_TEST support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks but I've fixed it already by adding #ifndef MODULE (since other
functions in the same file using __maybe_unused depend on either PCI or
SH_DREAMCAST I've preferred not to use this attribute):

https://marc.info/?l=linux-fbdev&m6050904010778&w=2

> ---
>  drivers/video/fbdev/pvr2fb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
> index 59c59b3a67cb..cf9cfdc5e685 100644
> --- a/drivers/video/fbdev/pvr2fb.c
> +++ b/drivers/video/fbdev/pvr2fb.c
> @@ -723,8 +723,8 @@ static struct fb_ops pvr2fb_ops = {
>  	.fb_imageblit	= cfb_imageblit,
>  };
>  
> -static int pvr2_get_param_val(const struct pvr2_params *p, const char *s,
> -			      int size)
> +static int __maybe_unused pvr2_get_param_val(const struct pvr2_params *p,
> +					     const char *s, int size)
>  {
>  	int i;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

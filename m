From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 Oct 2020 20:58:36 +0000
Subject: Re: [PATCH -next] video: Remove set but not used variable
Message-Id: <20201016205836.GB1496366@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1600957106-13741-1-git-send-email-liheng40@huawei.com>
In-Reply-To: <1600957106-13741-1-git-send-email-liheng40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Li Heng <liheng40@huawei.com>
Cc: linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com

Hi Li Heng

On Thu, Sep 24, 2020 at 10:18:26PM +0800, Li Heng wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/video/fbdev/sis/300vtbl.h:1064:28: warning:
> ‘SiS300_CHTVVCLKSONTSC’ defined but not used [-Wunused-const-variable=]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Li Heng <liheng40@huawei.com>

Thanks, now applied to drm-misc-next.

	Sam

> ---
>  drivers/video/fbdev/sis/300vtbl.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/sis/300vtbl.h b/drivers/video/fbdev/sis/300vtbl.h
> index e4b4a26..26b19f7 100644
> --- a/drivers/video/fbdev/sis/300vtbl.h
> +++ b/drivers/video/fbdev/sis/300vtbl.h
> @@ -1061,8 +1061,6 @@ static const unsigned char SiS300_CHTVVCLKUNTSC[]  = { 0x29,0x29,0x29,0x29,0x2a,
> 
>  static const unsigned char SiS300_CHTVVCLKONTSC[]  = { 0x2c,0x2c,0x2c,0x2c,0x2d,0x2b };
> 
> -static const unsigned char SiS300_CHTVVCLKSONTSC[] = { 0x2c,0x2c,0x2c,0x2c,0x2d,0x2b };
> -
>  static const unsigned char SiS300_CHTVVCLKUPAL[]   = { 0x2f,0x2f,0x2f,0x2f,0x2f,0x31 };
> 
>  static const unsigned char SiS300_CHTVVCLKOPAL[]   = { 0x2f,0x2f,0x2f,0x2f,0x30,0x32 };
> --
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

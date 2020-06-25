From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 25 Jun 2020 09:24:34 +0000
Subject: Re: [PATCH 1/8] backlight: lms501kf03: Remove unused const variables
Message-Id: <20200625092434.szrdyt3sxmxmfajg@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624145721.2590327-2-lee.jones@linaro.org>
In-Reply-To: <20200624145721.2590327-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, jingoohan1@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org

On Wed, Jun 24, 2020 at 03:57:14PM +0100, Lee Jones wrote:
> W=1 kernel build reports:
> 
>  drivers/video/backlight/lms501kf03.c:96:28: warning: ‘seq_sleep_in’ defined but not used [-Wunused-const-variable=]
>  96 | static const unsigned char seq_sleep_in[] = {
>  | ^~~~~~~~~~~~
>  drivers/video/backlight/lms501kf03.c:92:28: warning: ‘seq_up_dn’ defined but not used [-Wunused-const-variable=]
>  92 | static const unsigned char seq_up_dn[] = {
>  | ^~~~~~~~~
> 
> Either 'seq_sleep_in' nor 'seq_up_dn' have been used since the
> driver first landed in 2013.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/lms501kf03.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/video/backlight/lms501kf03.c b/drivers/video/backlight/lms501kf03.c
> index 8ae32e3573c1a..c1bd02bb8b2ee 100644
> --- a/drivers/video/backlight/lms501kf03.c
> +++ b/drivers/video/backlight/lms501kf03.c
> @@ -89,14 +89,6 @@ static const unsigned char seq_rgb_gamma[] = {
>  	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>  };
>  
> -static const unsigned char seq_up_dn[] = {
> -	0x36, 0x10,
> -};
> -
> -static const unsigned char seq_sleep_in[] = {
> -	0x10,
> -};
> -
>  static const unsigned char seq_sleep_out[] = {
>  	0x11,
>  };
> -- 
> 2.25.1
> 

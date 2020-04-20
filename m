From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 20 Apr 2020 13:51:00 +0000
Subject: Re: [PATCH] backlight: lms501kf03: remove unused 'seq_sleep_in' and 'seq_up_dn'
Message-Id: <20200420135100.lhwcdkl33jzomy6p@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417092257.13694-1-yanaijie@huawei.com>
In-Reply-To: <20200417092257.13694-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jason Yan <yanaijie@huawei.com>
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, jingoohan1@gmail.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Hulk Robot <hulkci@huawei.com>, lee.jones@linaro.org

On Fri, Apr 17, 2020 at 05:22:57PM +0800, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/video/backlight/lms501kf03.c:96:28: warning: ‘seq_sleep_in’
> defined but not used [-Wunused-const-variable=]
>  static const unsigned char seq_sleep_in[] = {
>                             ^~~~~~~~~~~~
> drivers/video/backlight/lms501kf03.c:92:28: warning: ‘seq_up_dn’ defined
> but not used [-Wunused-const-variable=]
>  static const unsigned char seq_up_dn[] = {
>                             ^~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/lms501kf03.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/video/backlight/lms501kf03.c b/drivers/video/backlight/lms501kf03.c
> index 8ae32e3573c1..c1bd02bb8b2e 100644
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
> 2.21.1
> 

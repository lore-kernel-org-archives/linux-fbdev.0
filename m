From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 18 Sep 2020 12:45:35 +0000
Subject: Re: [PATCH v2] fbcon: Remove the superfluous break
Message-Id: <20200918124535.GB438822@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200918010521.69950-1-jingxiangfeng@huawei.com>
In-Reply-To: <20200918010521.69950-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc: krzysztof.h1@wp.pl, akpm@linux-foundation.org, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, ndesaulniers@google.com, gustavoars@kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, george.kennedy@oracle.com, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, natechancellor@gmail.com, jirislaby@kernel.org, peda@axentia.se

On Fri, Sep 18, 2020 at 09:05:21AM +0800, Jing Xiangfeng wrote:
> Remove the superfluous break, as there is a 'return' before it.
> 
> Fixes: bad07ff74c32 ("fbcon: smart blitter usage for scrolling")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to drm-misc-next, thanks.
-Daniel

> ---
>  drivers/video/fbdev/core/fbcon.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 0b49b0f44edf..623359aadd1e 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -1727,7 +1727,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>  				    vc->vc_video_erase_char,
>  				    vc->vc_size_row * count);
>  			return true;
> -			break;
>  
>  		case SCROLL_WRAP_MOVE:
>  			if (b - t - count > 3 * vc->vc_rows >> 2) {
> @@ -1818,7 +1817,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>  				    vc->vc_video_erase_char,
>  				    vc->vc_size_row * count);
>  			return true;
> -			break;
>  
>  		case SCROLL_WRAP_MOVE:
>  			if (b - t - count > 3 * vc->vc_rows >> 2) {
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

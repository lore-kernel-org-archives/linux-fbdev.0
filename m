From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Mon, 28 Mar 2011 16:18:46 +0000
Subject: Re: [PATCH] fbcon: Remove unused 'display *p' variable from
Message-Id: <20110328091846.485dfef0@jbarnes-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110324205052.GA4238@swordfish>
In-Reply-To: <20110324205052.GA4238@swordfish>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 24 Mar 2011 22:50:52 +0200
Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:

> fbcon: Remove unused 'display *p' variable from fb_flashcursor()
> 
> Signed-of-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> ---
> 
>  drivers/video/console/fbcon.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
> index c583934..8745637 100644
> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -370,7 +370,6 @@ static void fb_flashcursor(struct work_struct *work)
>  {
>  	struct fb_info *info = container_of(work, struct fb_info, queue);
>  	struct fbcon_ops *ops = info->fbcon_par;
> -	struct display *p;
>  	struct vc_data *vc = NULL;
>  	int c;
>  	int mode;
> @@ -386,7 +385,6 @@ static void fb_flashcursor(struct work_struct *work)
>  		return;
>  	}
>  
> -	p = &fb_display[vc->vc_num];
>  	c = scr_readw((u16 *) vc->vc_pos);
>  	mode = (!ops->cursor_flash || ops->cursor_state.enable) ?
>  		CM_ERASE : CM_DRAW;

Looks fine to me, is Paul the lucky owner of fbdev now?

-- 
Jesse Barnes, Intel Open Source Technology Center

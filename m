From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Fri, 04 Sep 2020 14:53:16 +0000
Subject: Re: [PATCH v2 (resend)] video: fbdev: fix OOB read in vga_8planes_imageblit()
Message-Id: <36618e37-2cb6-8114-7a43-788780fae321@i-love.sakura.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <11ad8786-e407-3289-8bd9-2745c4834718@i-love.sakura.ne.jp>
 <90b55ec3-d5b0-3307-9f7c-7ff5c5fd6ad3@i-love.sakura.ne.jp>
In-Reply-To: <90b55ec3-d5b0-3307-9f7c-7ff5c5fd6ad3@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hello, Greg.

Since nobody is interested in this bug, can you directly pick up
this obvious patch without waiting for maintainer's response?

On 2020/08/31 19:37, Tetsuo Handa wrote:
> syzbot is reporting OOB read at vga_8planes_imageblit() [1], for
> "cdat[y] >> 4" can become a negative value due to "const char *cdat".
> 
> [1] https://syzkaller.appspot.com/bug?id
7a0da1557dcd1989e00cb3692b26d4173b4132
> 
> Reported-by: syzbot <syzbot+69fbd3e01470f169c8c4@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  drivers/video/fbdev/vga16fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
> index a20eeb8308ff..578d3541e3d6 100644
> --- a/drivers/video/fbdev/vga16fb.c
> +++ b/drivers/video/fbdev/vga16fb.c
> @@ -1121,7 +1121,7 @@ static void vga_8planes_imageblit(struct fb_info *info, const struct fb_image *i
>          char oldop = setop(0);
>          char oldsr = setsr(0);
>          char oldmask = selectmask();
> -        const char *cdat = image->data;
> +	const unsigned char *cdat = image->data;
>  	u32 dx = image->dx;
>          char __iomem *where;
>          int y;
> 

From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 31 Jan 2018 08:33:21 +0000
Subject: Re: [PATCH] Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().
Message-Id: <CA+7wUsyQhz2b437z0iYLOSo-35itALmGk39X4N0gR+HoCyod9A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180130203042.4797-1-peter.malone@gmail.com>
In-Reply-To: <20180130203042.4797-1-peter.malone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Malone <peter.malone@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Jan 30, 2018 at 9:30 PM, Peter Malone <peter.malone@gmail.com> wrote:
> Signed-off-by: Peter Malone <peter.malone@gmail.com>

AFAIK empty commit message is not acceptable upstream

>  drivers/video/fbdev/sbuslib.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
> index af6fc97f4ba4..a436d44f1b7f 100644
> --- a/drivers/video/fbdev/sbuslib.c
> +++ b/drivers/video/fbdev/sbuslib.c
> @@ -122,7 +122,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
>                 unsigned char __user *ured;
>                 unsigned char __user *ugreen;
>                 unsigned char __user *ublue;
> -               int index, count, i;
> +               unsigned int index, count, i;
>
>                 if (get_user(index, &c->index) ||
>                     __get_user(count, &c->count) ||
> @@ -161,7 +161,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
>                 unsigned char __user *ugreen;
>                 unsigned char __user *ublue;
>                 struct fb_cmap *cmap = &info->cmap;
> -               int index, count, i;
> +               unsigned int index, count, i;
>                 u8 red, green, blue;
>
>                 if (get_user(index, &c->index) ||
> --
> 2.14.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

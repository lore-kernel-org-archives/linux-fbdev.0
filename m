From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 16 Aug 2013 13:56:33 +0000
Subject: Re: [PATCH] drivers: video: fbcmap: add signed type cast for comparation
Message-Id: <CANq1E4St=75rQ0_3DrmS8jXh3BtekaM7WvKOf+4tZadPduOqKw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51ECECA2.1020006@asianux.com>
In-Reply-To: <51ECECA2.1020006@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi

On Mon, Jul 22, 2013 at 10:26 AM, Chen Gang <gang.chen@asianux.com> wrote:
> According to fb_set_cmap() in this file, knows about it is necessary to
> check 'start' whether less than zero or not, so need add related type
> cast for its comparing.
>
> The related warning:
>
>   drivers/video/fbcmap.c:288:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  drivers/video/fbcmap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
> index 5c3960d..44c88e3 100644
> --- a/drivers/video/fbcmap.c
> +++ b/drivers/video/fbcmap.c
> @@ -285,7 +285,7 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
>                 rc = -ENODEV;
>                 goto out;
>         }
> -       if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
> +       if ((int)cmap->start < 0 || (!info->fbops->fb_setcolreg &&
>                                 !info->fbops->fb_setcmap)) {

What's the reason to do this, anyway? fb_set_cmap() does the same but
actually casts to a signed integer. So I think we can remove this
check here.

Regards
David

>                 rc = -EINVAL;
>                 goto out1;
> --
> 1.7.7.6
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

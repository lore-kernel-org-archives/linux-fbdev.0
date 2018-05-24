From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 24 May 2018 06:13:47 +0000
Subject: Re: [PATCH] Fix checkpatch warnings in goldfishfb.c
Message-Id: <CA+7wUsxR_g5aAtDqm-XDN6FBeCr5Ar_DMHCiAffMKKi=sOJuqQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180518233156.84527-1-rkir@google.com>
In-Reply-To: <20180518233156.84527-1-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Roman,

On Sat, May 19, 2018 at 1:31 AM,  <rkir@google.com> wrote:
> From: Roman Kiryanov <rkir@google.com>

Usually you want a non-empty commit message. Also you did not send the
patch to anyone, you need to use get_maintainer script to find someone
to send it to. Since it is a trivial patch, you may want to include
trivial@k.o

https://www.kernel.org/doc/html/v4.16/process/submitting-patches.html

> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>  drivers/video/fbdev/goldfishfb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
> index 3b70044773b6..de29c4ff77e5 100644
> --- a/drivers/video/fbdev/goldfishfb.c
> +++ b/drivers/video/fbdev/goldfishfb.c
> @@ -124,6 +124,7 @@ static int goldfish_fb_check_var(struct fb_var_screeninfo *var,
>  static int goldfish_fb_set_par(struct fb_info *info)
>  {
>         struct goldfish_fb *fb = container_of(info, struct goldfish_fb, fb);
> +
>         if (fb->rotation != fb->fb.var.rotate) {
>                 info->fix.line_length = info->var.xres * 2;
>                 fb->rotation = fb->fb.var.rotate;
> @@ -148,13 +149,14 @@ static int goldfish_fb_pan_display(struct fb_var_screeninfo *var,
>         wait_event_timeout(fb->wait,
>                         fb->base_update_count != base_update_count, HZ / 15);
>         if (fb->base_update_count = base_update_count)
> -               pr_err("goldfish_fb_pan_display: timeout waiting for base update\n");
> +               pr_err("%s: timeout waiting for base update\n", __func__);
>         return 0;
>  }
>
>  static int goldfish_fb_blank(int blank, struct fb_info *info)
>  {
>         struct goldfish_fb *fb = container_of(info, struct goldfish_fb, fb);
> +
>         switch (blank) {
>         case FB_BLANK_NORMAL:
>                 writel(1, fb->reg_base + FB_SET_BLANK);
> --
> 2.17.0.441.gb46fe60e1d-goog
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

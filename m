From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 03 Jun 2019 11:57:13 +0000
Subject: Re: [PATCH v2] video: fbdev: Fix Warning comparing pointer to 0 reported by coccicheck
Message-Id: <CA+7wUswkGyBrnbAZrA57PcxTb1jB=dLkv9SYXT05A2fX8Mb0jw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+7wUswLsZ7PF6Pi8Oz=9287UYZQeKCFJHP7FDtPf1Cq8PO7ag@mail.gmail.com>
 <1559560752-12314-1-git-send-email-shobhitkukreti@gmail.com>
In-Reply-To: <1559560752-12314-1-git-send-email-shobhitkukreti@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Mon, Jun 3, 2019 at 1:21 PM <shobhitkukreti@gmail.com> wrote:
>
> From: Shobhit Kukreti <shobhitkukreti@gmail.com>
>
> Fixed Warning Comparing Pointer to 0. Changed return value to -ENOMEM to
> report kzalloc failure
>
> drivers/video/fbdev/controlfb.c: WARNING comparing pointer to 0
> drivers/video/fbdev/controlfb.c: WARNING comparing pointer to 0
> drivers/video/fbdev/controlfb.c: WARNING comparing pointer to 0
>
> Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
> ---
> Changes in v2:
>  - Modified commit message to report change in return type
>
>  drivers/video/fbdev/controlfb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
> index 7af8db2..07907c5 100644
> --- a/drivers/video/fbdev/controlfb.c
> +++ b/drivers/video/fbdev/controlfb.c
> @@ -182,7 +182,7 @@ int init_module(void)
>         int ret = -ENXIO;
>
>         dp = of_find_node_by_name(NULL, "control");
> -       if (dp != 0 && !control_of_init(dp))
> +       if (dp != NULL && !control_of_init(dp))
>                 ret = 0;
>         of_node_put(dp);
>
> @@ -580,7 +580,7 @@ static int __init control_init(void)
>         control_setup(option);
>
>         dp = of_find_node_by_name(NULL, "control");
> -       if (dp != 0 && !control_of_init(dp))
> +       if (dp != NULL && !control_of_init(dp))
>                 ret = 0;
>         of_node_put(dp);
>
> @@ -683,8 +683,8 @@ static int __init control_of_init(struct device_node *dp)
>                 return -ENXIO;
>         }
>         p = kzalloc(sizeof(*p), GFP_KERNEL);
> -       if (p = 0)
> -               return -ENXIO;
> +       if (p = NULL)

nit: I would have use `!p` (same for the others above). Maybe
checkpatch with --strict would warn for those (can't remember from top
of my head).

Anyway:

Reviewed-by: Mathieu Malaterre <malat@debian.org>

> +               return -ENOMEM;
>         control_fb = p; /* save it for cleanups */
>
>         /* Map in frame buffer and registers */
> --
> 2.7.4
>

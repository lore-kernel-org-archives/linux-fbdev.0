From: Sachin Kamat <spk.linux@gmail.com>
Date: Fri, 20 Jun 2014 09:21:40 +0000
Subject: Re: [PATCH 1/1] video: omapdss: Fix potential null pointer dereference
Message-Id: <CAK5sBcHSPDoYBoY1rtoFQXzcVnJg2daqZTgJP2Ebwz1d2LxamQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401445595-22884-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1401445595-22884-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, May 30, 2014 at 3:56 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> kmalloc can return null. Add a check to avoid potential null
> pointer dereference error when the pointer is accessed later.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/video/fbdev/omap2/dss/omapdss-boot-init.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c b/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
> index 99af9e88b2d8..2f0822ee3ff9 100644
> --- a/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
> +++ b/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
> @@ -121,9 +121,11 @@ static void __init omapdss_add_to_list(struct device_node *node, bool root)
>  {
>         struct dss_conv_node *n = kmalloc(sizeof(struct dss_conv_node),
>                 GFP_KERNEL);
> -       n->node = node;
> -       n->root = root;
> -       list_add(&n->list, &dss_conv_list);
> +       if (n) {
> +               n->node = node;
> +               n->root = root;
> +               list_add(&n->list, &dss_conv_list);
> +       }
>  }
>
>  static bool __init omapdss_list_contains(const struct device_node *node)
> --
> 1.7.9.5
>
>

Gentle ping..

-- 
Regards,
Sachin.

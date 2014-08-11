From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Mon, 11 Aug 2014 10:25:30 +0000
Subject: Re: [PATCH 4/4] drivers: video: fbdev: atmel_lcdfb.c: fix error return code
Message-Id: <53E89A1A.2060600@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407355938-10932-4-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1407355938-10932-4-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/08/2014 22:12, Julia Lawall :
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Convert a zero return value on error to a negative one, as returned
> elsewhere in the function.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> (
> if@p1 (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret@p1 = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> 
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Okay, seems good patch:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, best regards,

> ---
> The error codes chosen are the ones that are commonly used elsewhere or
> these functions.  Perhaps something else is wanted.
> 
>  drivers/video/fbdev/atmel_lcdfb.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
> index 92640d4..1d8bdb9 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -1102,12 +1102,14 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
>  	timings = of_get_display_timings(display_np);
>  	if (!timings) {
>  		dev_err(dev, "failed to get display timings\n");
> +		ret = -EINVAL;
>  		goto put_display_node;
>  	}
>  
>  	timings_np = of_find_node_by_name(display_np, "display-timings");
>  	if (!timings_np) {
>  		dev_err(dev, "failed to find display-timings node\n");
> +		ret = -ENODEV;
>  		goto put_display_node;
>  	}
>  
> 
> 


-- 
Nicolas Ferre

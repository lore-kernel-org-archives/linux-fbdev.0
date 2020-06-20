From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 20 Jun 2020 11:27:19 +0000
Subject: Re: [PATCH][next] fbdev/fb.h: Use struct_size() helper in kzalloc()
Message-Id: <20200620112719.GC16901@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200617175647.GA26370@embeddedor>
In-Reply-To: <20200617175647.GA26370@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-fbdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Gustavo.

On Wed, Jun 17, 2020 at 12:56:47PM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

struct_size is defined in overflow.h - which is not included by fs.h.
So we rely on overflow.h being pulled in by some other header - maybe
slab.h in this case.
Seems fragile, should this patch add an include of overflow.h?

	Sam

> ---
>  include/linux/fb.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 3b4b2f0c6994..2b530e6d86e4 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -506,8 +506,9 @@ struct fb_info {
>  };
>  
>  static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
> -	struct apertures_struct *a = kzalloc(sizeof(struct apertures_struct)
> -			+ max_num * sizeof(struct aperture), GFP_KERNEL);
> +	struct apertures_struct *a;
> +
> +	a = kzalloc(struct_size(a, ranges, max_num), GFP_KERNEL);
>  	if (!a)
>  		return NULL;
>  	a->count = max_num;
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

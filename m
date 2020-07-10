From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 10 Jul 2020 14:23:39 +0000
Subject: Re: [PATCH][next] fbcon: Use array3_size() helper in scr_memcpyw()
Message-Id: <01ccc599-28a3-d6f0-40ca-7f1983211ce2@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200615231029eucas1p1875c2cab0363a12afd0c5dea7ab0cb8b@eucas1p1.samsung.com>
 <20200615231542.GA20470@embeddedor>
In-Reply-To: <20200615231542.GA20470@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>


On 6/16/20 1:15 AM, Gustavo A. R. Silva wrote:
> Use array3_size() helper instead of the open-coded version in scr_memcpyw()
> and scr_memsetw(). These sorts of multiplication factors need to be wrapped
> in array3_size().
> 
> This issue was found with the help of Coccinelle and, audited and fixed
> manually.
> 
> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/core/fbcon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 9d28a8e3328f..6af2734f2a7b 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -639,7 +639,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
>  			       GFP_KERNEL);
>  		if (save) {
>  			int i = cols < new_cols ? cols : new_cols;
> -			scr_memsetw(save, erase, logo_lines * new_cols * 2);
> +			scr_memsetw(save, erase, array3_size(logo_lines, new_cols, 2));
>  			r = q - step;
>  			for (cnt = 0; cnt < logo_lines; cnt++, r += i)
>  				scr_memcpyw(save + cnt * new_cols, r, 2 * i);
> @@ -676,7 +676,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
>  		q = (unsigned short *) (vc->vc_origin +
>  					vc->vc_size_row *
>  					rows);
> -		scr_memcpyw(q, save, logo_lines * new_cols * 2);
> +		scr_memcpyw(q, save, array3_size(logo_lines, new_cols, 2));
>  		vc->vc_y += logo_lines;
>  		vc->vc_pos += logo_lines * vc->vc_size_row;
>  		kfree(save);
> 

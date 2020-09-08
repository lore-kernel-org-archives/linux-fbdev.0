From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 08 Sep 2020 11:37:32 +0000
Subject: Re: [PATCH 22/29] video: fbdev: Avoid comma separated statements
Message-Id: <736b1915-b6dc-3cdb-2bff-a307406ce354@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1598331148.git.joe@perches.com>
 <CGME20200825045729eucas1p2a05e6a670152b105f1b4cf31d6e2090c@eucas1p2.samsung.com>
 <3e56046e67e583ac93030297ff6d58c08ca54086.1598331149.git.joe@perches.com>
In-Reply-To: <3e56046e67e583ac93030297ff6d58c08ca54086.1598331149.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: linux-fbdev@vger.kernel.org, Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 8/25/20 6:56 AM, Joe Perches wrote:
> Use semicolons and braces.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/tgafb.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/tgafb.c b/drivers/video/fbdev/tgafb.c
> index e9869135d833..666fbe2f671c 100644
> --- a/drivers/video/fbdev/tgafb.c
> +++ b/drivers/video/fbdev/tgafb.c
> @@ -989,8 +989,10 @@ tgafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
>  	/* We can fill 2k pixels per operation.  Notice blocks that fit
>  	   the width of the screen so that we can take advantage of this
>  	   and fill more than one line per write.  */
> -	if (width = line_length)
> -		width *= height, height = 1;
> +	if (width = line_length) {
> +		width *= height;
> +		height = 1;
> +	}
>  
>  	/* The write into the frame buffer must be aligned to 4 bytes,
>  	   but we are allowed to encode the offset within the word in
> @@ -1171,8 +1173,10 @@ copyarea_8bpp(struct fb_info *info, u32 dx, u32 dy, u32 sx, u32 sy,
>  	   More than anything else, these control how we do copies.  */
>  	depos = dy * line_length + dx;
>  	sepos = sy * line_length + sx;
> -	if (backward)
> -		depos += width, sepos += width;
> +	if (backward) {
> +		depos += width;
> +		sepos += width;
> +	}
>  
>  	/* Next copy full words at a time.  */
>  	n32 = width / 32;
> 

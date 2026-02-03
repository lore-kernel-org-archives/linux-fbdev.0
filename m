Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC6F37AA8F;
	Tue,  3 Feb 2026 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770106650; cv=none; b=p7zB0rqDR+3ja7cmX5RDruwzmwFQMXfBSyeCJLqkKYjwAbZ/EVQkJuKXGlHFdE1hrehuKmMoWUi5HDqkcO+g2OngENhTOjG2midNY6e9puWkr0wZ74mPSkydoDeVvyYLXwM/KXqe98v85F0gtQqFm5/eEIwjVy1uU6uL/L6rd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770106650; c=relaxed/simple;
	bh=zz1E+vz9JOh8fCD0f3bnFGy0jEo34aMhdcN0zwpb5ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8pXkhlpObXpwjRNQJPrBsd9w7z7Q4K8li3XOpzNXaM87dQWBJc8omXJSBoPLS7KDE7zB7/nwNB6tXqIaUyOpeP+TSTPLeoHklZfY/AHDTEK2VaoS1lVrpVcTCFaWHu4rl3t/cXnkfYlpFQlBW9zJDAWCJ7LEwWhv8Db+wwKlzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aI5AzWwC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aI5AzWwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37928C116D0;
	Tue,  3 Feb 2026 08:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770106649;
	bh=zz1E+vz9JOh8fCD0f3bnFGy0jEo34aMhdcN0zwpb5ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aI5AzWwCxUg00atcqvf23+erjPKIVZmxgx3g5P5fqbVwLtZoScdLrAfaey5/+isiI
	 DBEbL1IL1fq1sNB8WiTYA+hHS7W4fLcKa4CsaisQr+Vsx70sdChC1QqFGvhCyzYv8V
	 nWOXCKfMmErtWl6qosP4f9hchLDuHE1q+emXJAsU=
Date: Tue, 3 Feb 2026 09:17:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: yehudis9982 <y0533159982@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: rename Bpp to bytes_per_pixel
Message-ID: <2026020357-prideful-grip-5730@gregkh>
References: <2026020201-monogamy-sash-4866@gregkh>
 <20260202171243.133935-1-y0533159982@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202171243.133935-1-y0533159982@gmail.com>

On Mon, Feb 02, 2026 at 07:12:43PM +0200, yehudis9982 wrote:
> Rename the Bpp parameter to bytes_per_pixel for clarity and to avoid CamelCase, as reported by checkpatch.pl.
> 
> Signed-off-by: yehudis9982 <y0533159982@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 046b9282b..3fe9429e1 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -48,7 +48,7 @@ void sm750_hw_de_init(struct lynx_accel *accel)
>  	      DE_STRETCH_FORMAT_ADDRESSING_MASK |
>  	      DE_STRETCH_FORMAT_SOURCE_HEIGHT_MASK;
>  
> -	/* DE_STRETCH bpp format need be initialized in setMode routine */
> +	/* DE_STRETCH bytes_per_pixel format need be initialized in setMode routine */
>  	write_dpr(accel, DE_STRETCH_FORMAT,
>  		  (read_dpr(accel, DE_STRETCH_FORMAT) & ~clr) | reg);
>  
> @@ -76,7 +76,7 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
>  {
>  	u32 reg;
>  
> -	/* fmt=0,1,2 for 8,16,32,bpp on sm718/750/502 */
> +	/* fmt=0,1,2 for 8,16,32,bytes_per_pixel on sm718/750/502 */
>  	reg = read_dpr(accel, DE_STRETCH_FORMAT);
>  	reg &= ~DE_STRETCH_FORMAT_PIXEL_FORMAT_MASK;
>  	reg |= ((fmt << DE_STRETCH_FORMAT_PIXEL_FORMAT_SHIFT) &
> @@ -85,7 +85,7 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
>  }
>  
>  int sm750_hw_fillrect(struct lynx_accel *accel,
> -		      u32 base, u32 pitch, u32 Bpp,
> +		      u32 base, u32 pitch, u32 bytes_per_pixel,
>  		      u32 x, u32 y, u32 width, u32 height,
>  		      u32 color, u32 rop)
>  {
> @@ -102,14 +102,14 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
>  
>  	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, base); /* dpr40 */
>  	write_dpr(accel, DE_PITCH,
> -		  ((pitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
> +		  ((pitch / bytes_per_pixel << DE_PITCH_DESTINATION_SHIFT) &
>  		   DE_PITCH_DESTINATION_MASK) |
> -		  (pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
> +		  (pitch / bytes_per_pixel & DE_PITCH_SOURCE_MASK)); /* dpr10 */
>  
>  	write_dpr(accel, DE_WINDOW_WIDTH,
> -		  ((pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
> +		  ((pitch / bytes_per_pixel << DE_WINDOW_WIDTH_DST_SHIFT) &
>  		   DE_WINDOW_WIDTH_DST_MASK) |
> -		   (pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
> +		   (pitch / bytes_per_pixel & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
>  
>  	write_dpr(accel, DE_FOREGROUND, color); /* DPR14 */
>  
> @@ -138,7 +138,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
>   * @sy: Starting y coordinate of source surface
>   * @dBase: Address of destination: offset in frame buffer
>   * @dPitch: Pitch value of destination surface in BYTE
> - * @Bpp: Color depth of destination surface
> + * @bytes_per_pixel: Bytes per pixel (color depth / 8) of destination surface
>   * @dx: Starting x coordinate of destination surface
>   * @dy: Starting y coordinate of destination surface
>   * @width: width of rectangle in pixel value
> @@ -149,7 +149,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
>  		      unsigned int sBase, unsigned int sPitch,
>  		      unsigned int sx, unsigned int sy,
>  		      unsigned int dBase, unsigned int dPitch,
> -		      unsigned int Bpp, unsigned int dx, unsigned int dy,
> +		      unsigned int bytes_per_pixel, unsigned int dx, unsigned int dy,
>  		      unsigned int width, unsigned int height,
>  		      unsigned int rop2)
>  {
> @@ -249,9 +249,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
>  	 * pixel values. Need Byte to pixel conversion.
>  	 */
>  	write_dpr(accel, DE_PITCH,
> -		  ((dPitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
> +		  ((dPitch / bytes_per_pixel << DE_PITCH_DESTINATION_SHIFT) &
>  		   DE_PITCH_DESTINATION_MASK) |
> -		  (sPitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
> +		  (sPitch / bytes_per_pixel & DE_PITCH_SOURCE_MASK)); /* dpr10 */
>  
>  	/*
>  	 * Screen Window width in Pixels.
> @@ -259,9 +259,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
>  	 * for a given point.
>  	 */
>  	write_dpr(accel, DE_WINDOW_WIDTH,
> -		  ((dPitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
> +		  ((dPitch / bytes_per_pixel << DE_WINDOW_WIDTH_DST_SHIFT) &
>  		   DE_WINDOW_WIDTH_DST_MASK) |
> -		  (sPitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
> +		  (sPitch / bytes_per_pixel & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
>  
>  	if (accel->de_wait() != 0)
>  		return -1;
> -- 
> 2.43.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

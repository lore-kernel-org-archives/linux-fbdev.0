Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA43C6A5C;
	Tue, 28 Jul 2026 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222672; cv=none; b=lewXfytzzs8SWIuOwC3UBQuD87LqdMjd6Q+JDHkn5H6q2EZy78PDgMAprHzqemVe9jxtsloR5gNL5skusyxEpOGg20SUVqhPt55aorL159DyV2OoUxxIskMklL6LJGMi20e2fENJyFZ2kVxLKGAaR73jsZbupdzlSmQCKFnRZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222672; c=relaxed/simple;
	bh=+apUkxdCKjqMtfmkb7nweZraUi/j27BdOVzzz1rCJC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqR0ABx1QRJcfZNxNYtMdQESokSUOsyGFQGoWyahzUzOzWkAdWSXDm0b2Oy0fAsFoOQ3XO8S7gkGoVIBkUlTC95wy3reOJi7YQYR9EoPTUfM92UWGK/a1cPx5dXMMI/SzJc7Z2RfzkBLn1AjoiSGkZ0KIc8rUkYgcrnQmKjXFp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pSCbBnP8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pSCbBnP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBFE1F000E9;
	Tue, 28 Jul 2026 07:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785222670;
	bh=eblHaWPv+q84B7y2xKhUJZcQkR1enp7NetvdCnw0+CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pSCbBnP8o4a9yAy6YFmG3VgMxhsLL1SJed+JxbIvWDTJSUMB46UBN3VqPozck95yb
	 6vQ6UQJ5AEvZ5VtQsgk4gYlOpr/507EvPaEujiQMGAgrJUBx5PuTtBJOrefvElbi+x
	 AjOJWPt9N4fF2IDDAh9D407cT15V5JDHZWOVeLJA=
Date: Tue, 28 Jul 2026 09:10:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: fix mono image source stride
 mismatch in lynxfb_ops_imageblit()
Message-ID: <2026072843-deafening-stream-a902@gregkh>
References: <20260718103103.18082-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718103103.18082-1-meatuni001@gmail.com>

On Sat, Jul 18, 2026 at 03:31:03PM +0500, Muhammad Bilal wrote:
> sm750_hw_imageblit() advances its monochrome source pointer by
> src_delta per scanline, and computes the correct rounded-up stride
> internally as:
> 
> 	bytes_per_scan = (width + start_bit + 7) / 8;
> 
> Its only caller, lynxfb_ops_imageblit(), instead passed src_delta as
> image->width >> 3. For widths not a multiple of 8 this under-counted
> the stride, so the source pointer fell further behind the real
> per-scanline layout on every line, corrupting the rendered image.
> 
> Rather than just fixing the caller's calculation, remove src_delta
> as a parameter entirely and have sm750_hw_imageblit() advance by the
> bytes_per_scan it already computes for itself. There has only ever
> been one caller, and that caller was passing an out-of-sync
> derivative of the same width/start_bit values sm750_hw_imageblit()
> already has, so keeping stride as a separate parameter served no
> purpose beyond letting the two calculations drift apart, which is
> exactly what happened here.
> 
> Fixes: 81dee67e215b2 ("staging: sm750fb: add sm750 to staging")
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c       | 2 +-
>  drivers/staging/sm750fb/sm750.h       | 2 +-
>  drivers/staging/sm750fb/sm750_accel.c | 6 ++----
>  drivers/staging/sm750fb/sm750_accel.h | 4 +---
>  4 files changed, 5 insertions(+), 9 deletions(-)
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

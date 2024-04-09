Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834E131BCF;
	Tue,  9 Apr 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677768; cv=none; b=jDzEM2RnEV6nVGl4rr6Gy1jNzCHWybfNXcLMMqUuAE/fXZMxSFUpjj8MK8Pa539gFwblCcvunsyn9eNuhbWWHy73GO05rx+bKpw3eWRWMR6eIoTkn2Sp1AQcfCg1mPXBR994MxjpXd05XW4b4DW1t44EZd07wesZSYXjOyszCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677768; c=relaxed/simple;
	bh=uwl+DYO34osnS4Se+9oQAPTyhZwBq5JpKEjFYv+yrok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUBNo4u2gfN8zIu2YCVZljhQTv+tRjizylYxki37w2NtnPINvqZO3TVjXGOiAe5fiCVfhqjjcp9t3WvpxzuE7feLF3lb4UgGFmXDn+OLOnUaXjHwfe4hfXgvrB1YacYmqU7gXN+WnARY8sVK1F+bk9VJyvTLNhL/CdX3MrCK2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sYVQGSAK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sYVQGSAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092C0C43390;
	Tue,  9 Apr 2024 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712677768;
	bh=uwl+DYO34osnS4Se+9oQAPTyhZwBq5JpKEjFYv+yrok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sYVQGSAKJJEWvkbsD7b+ll3+gutvTtk8gmvhpGDd60ykr3R5MXLBPQ5G/D+eIso/c
	 bPWVuDRsCe2zxTDges9Bx99qGzo1+Rp84OvsRYy0QUYI8YOvZPFR6jr3HomhpTUFU9
	 MXQE6P+sKPn2f1Evf4SmSSMsvQTYVw7mVV1HO7Ao=
Date: Tue, 9 Apr 2024 17:49:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: purofle <purofle@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: fb_st7789v: support setting offset
Message-ID: <2024040935-naturist-skimmer-391f@gregkh>
References: <20240405165747.93377-1-purofle@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405165747.93377-1-purofle@gmail.com>

On Sat, Apr 06, 2024 at 12:57:47AM +0800, purofle wrote:
> Some screen sizes using st7789v chips are different from 240x320,
> and offsets need to be set to display all images properly.
> 
> Signed-off-by: purofle <purofle@gmail.com>

We need a semi-real name here please.

> ---
>  drivers/staging/fbtft/fb_st7789v.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> index 861a15414..d47ab4262 100644
> --- a/drivers/staging/fbtft/fb_st7789v.c
> +++ b/drivers/staging/fbtft/fb_st7789v.c
> @@ -30,6 +30,12 @@
>  
>  #define HSD20_IPS 1
>  
> +#define WIDTH 240
> +#define HEIGHT 320

So you are now hard-coding the size?

> +
> +#define LEFT_OFFSET 0
> +#define TOP_OFFSET 0

Is this always going to be 0, if so, why need it at all?


thanks,

greg k-h

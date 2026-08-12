Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA7343883;
	Wed, 12 Aug 2026 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786494447; cv=none; b=Rr/kveMl7DJRCYa3PitpQJxW12NLoaAQXEycBOVZ2u4++TcDqLPXiYDR4T3AeQ7oHwPkJB0+zcPMwwVXfaIGv7/PZxiu/px1eTwpp3L+2tsh/qsFTMA57yJJrsdMaxjURlDAfmF90flv4LD74pdQyd3K6Tl3lKqAWk52iX4iPz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786494447; c=relaxed/simple;
	bh=xBAqTaU6DPt1HpnZJ769ARfGUcoJgBJovF6XH9OurFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+iOtmqzyAjJRMYbEkl1Vr3eJT7AhUtBL1fSNqFs4huh3tL13gb8rt7Fokpks+rknD6y47iNrDmTqI4LPEZ/8UsOehtyyl7Ti2bFoTpkPr6tnvC7lnNWRzdaJsR3hPRpGJm2eIOBkiAWJ2YoM1l+GyyIVhllqC967Rfx2z0CX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eGZSS3VK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eGZSS3VK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DFD1F00A3A;
	Wed, 12 Aug 2026 00:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786494446;
	bh=0ubwVBx9TBmtktH4Q/QhwRV0Uhb4CDuOIbbo44ZYHN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eGZSS3VKyHDqFOxVhsaQ00v6FV5sENPcPNVL7gfcXHjtthf7QnHaF+0GRKkYCERz4
	 Umq/7asPnif8FDbveDWW/fR9kv7E3XCRHf2XQ3allqBbmjf1JXc0tvNAfUantIuaD0
	 YZj5pglOVgykf7r3zK74r6xO5KcWz4V/kKHwMMZw=
Date: Wed, 12 Aug 2026 09:25:53 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Maxim Codita <maxkoditsa7c@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb/sm750.c: mark g_def_fbmode as const
 pointer
Message-ID: <2026081233-simmering-exerciser-4ab2@gregkh>
References: <20260811130813.434660-1-maxkoditsa7c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811130813.434660-1-maxkoditsa7c@gmail.com>

On Tue, Aug 11, 2026 at 03:08:13PM +0200, Maxim Codita wrote:
> Fix a checkpatch.pl warning for g_def_fbmode by marking the pointer
> as const. Ensures it is stored as read-only.
> 
> Note: g_fbmode[] is left as non-const as its elements are modified at
> runtime by lynxfb_set_fbinfo() and sm750fb_setup().
> 
> Signed-off-by: Maxim Codita <maxkoditsa7c@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 89c811e0806c..cc38dac88a73 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -22,7 +22,7 @@ static int g_hwcursor = 1;
>  static int g_noaccel __ro_after_init;
>  static int g_nomtrr __ro_after_init;
>  static const char *g_fbmode[] = {NULL, NULL};
> -static const char *g_def_fbmode = "1024x768-32@60";
> +static const char  * const g_def_fbmode = "1024x768-32@60";

The spacing here looks very odd, don't you think?

And how was this tested?

thanks,

greg k-h

Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592893DDB1E;
	Fri,  7 Aug 2026 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107227; cv=none; b=r6PIVHE3kIh/2AKGGF5/tCgfWje48LR5ZkwK+fSlOQ1s25fcsAL7WdBGlvIrb7YuZjWscKrZHNgQawzOXrk1sG7ljPw1aZ5qihV1a45RAFdvwyTdYnkd78VulomLGRNXuXfeCxkNMFhwuB2iVXz70+DsBz8/LsAyTUpReBDUWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107227; c=relaxed/simple;
	bh=jw3JkQcm7J+kOSxRCeGS2D3A6Qe+4qxhPBNgCgg0zNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mR11MWRy36JRQSaDn/YTxing+T0A69IE8DmCrA3h8v/+BtSPA2SEzYbz2X4c0No/rcZp70Iv3jEvVBhIG7Am4a7BGDMPZaJJJpzrNiCFar3bO2yWL3A2ybS0/wCy0KfTtgFTWxajprXStk5vm4dJbEqL7nFcdB0LYSOjsMSXzfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sEJRfZU1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ExIx+e59; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sEJRfZU1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ExIx+e59"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786107207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4mifpDlB5CYk8EeRO5Kq/ALY2oICGCMbinicf4fy6c=;
	b=sEJRfZU1fzV0uLT+f0n5227TugAYQ7YhuAcqd29nB+yy8Cn90FeyPZnccaXU4YwE8zZS7q
	N+L/cE91GnL9iai8Dh/NkyCEefjVRiMK75EWsG/SYu1i7WKuMVxnHCq1Oh9JR6kJXEV1Kj
	foUNGAOSaq0uW8Q4i4u0Qy962mtURexN54r9ArWswU4shg8XMNh7cGmiMXWPalqQud5ceM
	FmA4SCWz/hsw7HJsXWyHq8s6nlzPauD+ndDhxp69fo8RE4M4jIH577UAJA/KdiQJAtQyW2
	6ld/0L78CTotHuA6mz9YYFm1d5/J3oCFOgn+PPnQV1DGREiiFDZgTiy4LD6lUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786107207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4mifpDlB5CYk8EeRO5Kq/ALY2oICGCMbinicf4fy6c=;
	b=ExIx+e59AsMBXTZ90pr6zvXLuEvwYAwLWeT1c3GVKwRD0QyyRBGwJpQAuxCJO0G7DoNyQd
	LIFfh1eCjEZ/8XBQ==
To: sh_def@163.com, andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 sh_def@163.com, thomas.petazzoni@free-electrons.com, notro@tronnes.org
Subject: Re: [PATCH] staging: fbtft: make dirty_lock IRQ-safe
In-Reply-To: <20260804173712.176017-1-sh_def@163.com>
References: <20260804173712.176017-1-sh_def@163.com>
Date: Fri, 07 Aug 2026 14:53:26 +0200
Message-ID: <87pkzu852x.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

sh_def@163.com writes:
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index ca0c38221c16..193643d0329d 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -298,14 +298,20 @@ static void fbtft_mkdirty(struct fb_info *info, int y, int height)
>  {
>  	struct fbtft_par *par = info->par;
>  	struct fb_deferred_io *fbdefio = info->fbdefio;
> +	unsigned long flags;
>  
>  	/* Mark display lines/area as dirty */
> -	spin_lock(&par->dirty_lock);
> +	/*
> +	 * fbcon takes dirty_lock while holding console_owner. Disable local
> +	 * interrupts here so a printk hardirq cannot acquire console_owner
> +	 * while dirty_lock is held and create the inverse lock ordering.
> +	 */

Beside that reason, we also need spin_lock_irqsave() because
fbtft_mkdirty() can be called in both task context and hardirq
context. And this reason alone suffices and usually is why
spin_lock_irqsave() is used, so I think a comment is not necessary.

But I am fine with it either way.

> +	spin_lock_irqsave(&par->dirty_lock, flags);
>  	if (y < par->dirty_lines_start)
>  		par->dirty_lines_start = y;
>  	if (y + height - 1 > par->dirty_lines_end)
>  		par->dirty_lines_end = y + height - 1;
> -	spin_unlock(&par->dirty_lock);
> +	spin_unlock_irqrestore(&par->dirty_lock, flags);
>  
>  	/* Schedule deferred_io to update display (no-op if already on queue)*/
>  	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
> @@ -317,14 +323,15 @@ static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagereflis
>  	unsigned int dirty_lines_start, dirty_lines_end;
>  	struct fb_deferred_io_pageref *pageref;
>  	unsigned int y_low = 0, y_high = 0;
> +	unsigned long flags;
>  
> -	spin_lock(&par->dirty_lock);
> +	spin_lock_irqsave(&par->dirty_lock, flags);
>  	dirty_lines_start = par->dirty_lines_start;
>  	dirty_lines_end = par->dirty_lines_end;
>  	/* set display line markers as clean */
>  	par->dirty_lines_start = par->info->var.yres - 1;
>  	par->dirty_lines_end = 0;
> -	spin_unlock(&par->dirty_lock);
> +	spin_unlock_irqrestore(&par->dirty_lock, flags);

fbtft_deferred_io() is executed in workqueue with interrupt enabled. So
it can use spin_lock_irq() instead of spin_lock_irqsave(), right?

Nam

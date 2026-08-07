Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3AD47606C
	for <linux-fbdev@vger.kernel.org>; Fri,  7 Aug 2026 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108127; cv=none; b=nmZ6q3MIXMbEmtC/M+dQkFJfX34c+4gLvw7Wc4WqaVi2p6LJaRWn4uSy1v2IOjZt5vuGUWHNKzxvqJiweh0YsVOLhslC8h3/Y5b2K8rLK6gYeOGfn1c1oNcO2dgemqoCFwdih88Xpuvok6d3FwEKe+4Px/zpkVcQvwZ6RJnox20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108127; c=relaxed/simple;
	bh=r6tQKNJBJLBKkcU905VTnz7Q+CMwMCXgVwnHBoFckgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxo+wBjZ3LDvPJ2nNjuSKEaMOVHPVR9Ihmm5FNCI46UiHL1wrekBrvNqV7mmqFXnr3bfbK57zZ2QY7LMIlasNN5l/x52soUtuKU69mSGyKwiAW29ODF0ZhY7Hrtsibx9/BqMfI9F0mBGm//YQiucrbxrEpXapD2fAAwYycNsWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7Kfyaii; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7Kfyaii"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4798bea72f9so2084528f8f.1
        for <linux-fbdev@vger.kernel.org>; Fri, 07 Aug 2026 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108110; x=1786712910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XjfEMCqkZ88kBIhDMMBN1abXLKDzKlzUH+bF7MfZKwc=;
        b=S7KfyaiirenYUOFITRX99IME3D0ku4natSq9tXJIJjizw5lVdOvMCU0wnzFoD8d2yJ
         xEOcT+YtCAnyI9f51PiS/z7qZ6NTs8Cgf5vkwz9no6/2Vgu0OWMntB0PtNRgJ8qs1btk
         k/wT9QdhEKxfzDuPGYKw1prJd3wf3y7bkXSFDjZVswIVGO70ECPQ3MsnvjftUUyAj7nH
         8G+X0oIvlla9aJRpypOeQ7RqGOO5Z2emvmzWLhb2MA0BZHVtySEtfkUeRzskQ/XWFBNT
         cwBR/hvevPbfYKjUIZa3ngVMVl7c+OIewJM6paD/GEcna2pDEV99Py07iG/dH+MHdJ3l
         BH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108110; x=1786712910;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XjfEMCqkZ88kBIhDMMBN1abXLKDzKlzUH+bF7MfZKwc=;
        b=Qmdb3KPzD3mUECFYp/WhZW5/qLOW26FZsiabLLDHyK6/9y3YrbPAH1Z9yAm6Oz2+Ym
         TEVvCsyTPHeFN3sP9fnHTDNHHXrOgw1uXly1cTbCETDSUrnTUvMedCSRlSmffI4CM1gG
         wzTbVEVz5rva6I/KnnX0tDocOAbC4WAOOLpovOQZt3QRo1u96OXnpcV8aspo8HxaKhDP
         JVyguBk6hDlu057eAjriT5S834Yt+jQ2K6rzBZKnYFsMCBQKFblJucCDHD2YyLSjBW7d
         /47J8Q0Fwb4/mpgOxWnmAQrWCklvnyEOc+T/cLKcl36o97xf7UJSvzBw/9PEje8AZ2Ew
         EGPw==
X-Forwarded-Encrypted: i=1; AHgh+RqBuSHOddeGWWCoBnJsJ+qwd/ugEZ60OQw9Q0WVbZxDsmraVmrEGG5su6lxzShc6CeGfEMxyHW2+yGh2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt97SjpFzU8ScRdYbLoABlvhlxE6j8K6UTUXsl/03lSMkoHH3B
	8dvOf0pajcPKOU/zEOusQpQw2kqVF/ZLT5WHV/ryhKfseOmpJIdr5J/P
X-Gm-Gg: AR+sD10R3LoKawXmyY1mP5SrpWmfGQu5hec26pfRGJ62048pJF1Wl3TQrq0MztQVpBp
	7vq1VqddyuE+hDF+9/igZSBBonKS2IZDHne9qZmpAUT+18qhWW6tR5Gb32j+PkqIIVPLXcLQ2Xh
	4yhSeBZz2wFeHwqGkiKGGkBp6gLzJtDUeBzOSoGB9j4bBpea18uG7EcAgtRlqcpaM8df8Zv4MQ3
	bQNUKIYuRf2QBZYPtSyylBJXgF3vil353TQcGCtAmjgi9vHl+4KDUtjy4eL8yckxbFz2kVfNkZT
	giCfUhWFRfV3cXxp0QYoFw9BjCkfZht17KV+r201XwCfKgRHYK1Dn1tITHNIjijiZ/kktr2X2Bc
	T9nOjgp3yzGYAyrRCIXCydqdFUCEXL1KyvD8Mu3NpAmJrjVuONreMNLetUFCqFqXSFjIzRfI9aT
	PdFmjat7hUXoX4MDvbr8pjUOBrBM5UmjWaNJbhWDW6XNUV3JJClBE0J09b
X-Received: by 2002:a5d:50c2:0:b0:47f:8e50:9411 with SMTP id ffacd0b85a97d-47fec52acc2mr26764789f8f.20.1786108110319;
        Fri, 07 Aug 2026 06:08:30 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021501bcsm5754365f8f.9.2026.08.07.06.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:08:29 -0700 (PDT)
Date: Fri, 7 Aug 2026 16:08:26 +0300
From: Dan Carpenter <error27@gmail.com>
To: Nam Cao <namcao@linutronix.de>
Cc: sh_def@163.com, andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	thomas.petazzoni@free-electrons.com, notro@tronnes.org
Subject: Re: [PATCH] staging: fbtft: make dirty_lock IRQ-safe
Message-ID: <anXYynas7E3oarx2@stanley.mountain>
References: <20260804173712.176017-1-sh_def@163.com>
 <87pkzu852x.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pkzu852x.fsf@yellow.woof>

On Fri, Aug 07, 2026 at 02:53:26PM +0200, Nam Cao wrote:
> sh_def@163.com writes:
> > diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> > index ca0c38221c16..193643d0329d 100644
> > --- a/drivers/staging/fbtft/fbtft-core.c
> > +++ b/drivers/staging/fbtft/fbtft-core.c
> > @@ -298,14 +298,20 @@ static void fbtft_mkdirty(struct fb_info *info, int y, int height)
> >  {
> >  	struct fbtft_par *par = info->par;
> >  	struct fb_deferred_io *fbdefio = info->fbdefio;
> > +	unsigned long flags;
> >  
> >  	/* Mark display lines/area as dirty */
> > -	spin_lock(&par->dirty_lock);
> > +	/*
> > +	 * fbcon takes dirty_lock while holding console_owner. Disable local
> > +	 * interrupts here so a printk hardirq cannot acquire console_owner
> > +	 * while dirty_lock is held and create the inverse lock ordering.
> > +	 */
> 
> Beside that reason, we also need spin_lock_irqsave() because
> fbtft_mkdirty() can be called in both task context and hardirq
> context. And this reason alone suffices and usually is why
> spin_lock_irqsave() is used, so I think a comment is not necessary.
> 
> But I am fine with it either way.

AI always adds comments.  If we keep alowing obvious comments, the kernel
will turn into reading the Terms and Conditions which are impossible to
read in a single human life time.

regards,
dan carpenter


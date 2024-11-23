Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2BEEADC
	for <linux-fbdev@vger.kernel.org>; Sat, 23 Nov 2024 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732392673; cv=none; b=e4iEitHcq1Mf78eywwoliXma0lu7gG4LO5kHgFQMQJXoI1gOb+n2eqWjlyWGJq2t6B+5ERAsJi0O3TnUfbIPS9fH4tLB3YN00dHVYUNdi4ilXRi8auKogbnXqYO++3tNIoSxW1WFcBlKjqv1OPLqOQx17Tnl2OpUSsSqCD+hK8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732392673; c=relaxed/simple;
	bh=GfY5OOJjYtKwKCT9nVoNfjEhMuP5Dx8oEGJHh7s+ZtQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVTVCHVT3CWDJHHZ+1dMDiwNDbssYZR5hjgFQdkr7SnOktnSQeHWVB/+nxyfdbmF4jjv94QJy24i/aoBiKBsB5HVeli7GcOQKqBQOxPnpNAv7cSKk+V9nkBJGC/i024CPoE7Eol5gzh1omLn0/v6uxY7sDheS5m5YqOHDMT+l6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 10a0d7d4-a9d7-11ef-8881-005056bdd08f;
	Sat, 23 Nov 2024 22:11:04 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 23 Nov 2024 22:11:03 +0200
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, bonbons@linux-vserver.org, jikos@kernel.org,
	bentiss@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	shawnguo@kernel.org, festevam@gmail.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 20/28] fbdev: clps711x-fb: Replace check_fb in favor
 of struct fb_info.lcd_dev
Message-ID: <Z0I211pFIHS_ajoX@surfacebook.localdomain>
References: <20240906075439.98476-1-tzimmermann@suse.de>
 <20240906075439.98476-21-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906075439.98476-21-tzimmermann@suse.de>

Fri, Sep 06, 2024 at 09:52:34AM +0200, Thomas Zimmermann kirjoitti:
> Store the lcd device in struct fb_info.lcd_dev. The lcd subsystem can
> now detect the lcd's fbdev device from this field.
> 
> This makes the implementation of check_fb in clps711x_lcd_ops obsolete.
> Remove it.

...

> +	lcd = devm_lcd_device_register(dev, "clps711x-lcd", dev, cfb,
> +				       &clps711x_lcd_ops);
> +	if (IS_ERR(lcd)) {
> +		ret = PTR_ERR(lcd);
> +		goto out_fb_dealloc_cmap;
> +	}
> +
> +	info->lcd_dev = lcd;
> +
>  	ret = register_framebuffer(info);
>  	if (ret)
>  		goto out_fb_dealloc_cmap;
>  
> -	lcd = devm_lcd_device_register(dev, "clps711x-lcd", dev, cfb,
> -				       &clps711x_lcd_ops);
> -	if (!IS_ERR(lcd))
> -		return 0;
> +	return 0;
>  
> -	ret = PTR_ERR(lcd);
>  	unregister_framebuffer(info);

Haven't you got a dead code warning here?

>  
>  out_fb_dealloc_cmap:

-- 
With Best Regards,
Andy Shevchenko



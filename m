Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952512472B9
	for <linux-fbdev@vger.kernel.org>; Mon,  6 Oct 2025 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738058; cv=none; b=FfMDwPVFKOoMJsiiILztXDG5h/c3/9EnwRBVPo7qHhkPl+2g1zBL3KWpckYzhJGDNjMsKxwEQ81GpGqskC8U8GlRN90yalRuQtXUCtE6PmR3RhXEX2NIEfJB8SSIsKP0x1EKWGqa31cj7x6f5hXM1D6kJrz/iBAJAp2ZT2QWOII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738058; c=relaxed/simple;
	bh=n+5G5zLCQtVUtTCkfsHcjEWUoQbyGcwHnsl/KbwHGD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYYXOW2PmKPW4Y4Jm0BDhOTKM+GEwv7bcKkkMZZrt/PyXLQH1dhQILtZEPF38vjBSQy+PUNSZjFCZSdutFiOGRan5vzZPHHqayxmvhpt3jnTDvcxmXZqMEVWeZDf/mPA3oTYIJxTX+yxAhduRKB68dUcgK390ja1bgcrVpAfKoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GmcwCV/v; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GmcwCV/v"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso36630625e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 06 Oct 2025 01:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759738054; x=1760342854; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fIP3nj/kaZqoURQHnILt3INTmC8e4a2ZYKLYXuyFz/8=;
        b=GmcwCV/vroKVrRVF/L+yOhaGnC+rmkWvyEWJLPZyuDA0dE+pxzo9eZS7s6WJJFlPLI
         V2rJ2I5AB8QWaTzxvwe+C5rDI3p0266doy3hxSTdSF+91506cYg7p3/BTsQymrInmt5Z
         Udsh/Zto4F/EnIDDRJoLsbecNoSxJWdG+VY6gA8G60UWTFGWdG4Bue3WrQoydvGYKYgP
         +Mwwts/I5cf60Xzi0CiE7doakV5ykeJhvo4U5v7pXJcN1XG5uRvYVVT3vW2daROxEwPH
         5Tla0PB3RtaWRaAYvwXH56RbJRnRX0ncyYvEw+BctMaDFDv8qEfzBmLKzmJZaS24mil6
         Pq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759738054; x=1760342854;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fIP3nj/kaZqoURQHnILt3INTmC8e4a2ZYKLYXuyFz/8=;
        b=o9VUUCHzxmaIazmK4UClqGHTpiyFc5YbyllxroVutWHg8iovrhAHohx9NMuqgJjhvq
         nv5bb+wekbVspA8lThRD5crfUydlY8wWCksreE/5gB7jNp0wI5g9GAusxUfhbYfhrkyY
         w4UL5L4Pb6MXubCWvFNfCp+IaT8ohs6UpoOoASlhQy9ms2p7KG3gJTu+13iQQXef3vSe
         IaLqHYlbxBNbxQ6HOMFTQiIOsdzN/sUvw0PYCm2r9v9WObANumlMI5J7zBmH59mRWP5x
         uV6khaWmAJtAluXdvCrCkSPt9Gn0WZ4tcqqPW+nB4g5NcCIFMQeDmE8o+J27pp8NzBy1
         70+g==
X-Forwarded-Encrypted: i=1; AJvYcCXMmiC80o+vKs+xblH3ErQ6367lsjWTBL3G2xzVJamRuMblA7gYH1lSK0EqTci/fls+d8HHCSVJtETaug==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy0r9VdxtEkj+c9sZLn6RsT3ccQ6DsyfbBocYYBRNNLQpSqe+r
	gcCFenI/yz+D3S9dfJxiRYyEAz6sKEncwkGPc6cnKRBIeoB0FqmQzQG1w1lovoppkSc=
X-Gm-Gg: ASbGncvGC6t/qf+7RI9vKmIYGT542EzGVashL34cT+88gh5+mcDhN9kmlJJ5AvqNJCi
	57DdD56AcvakzGwMMTkFsBe/tNOe60hngMBto6oHDbmBc2sJ+g0JPxFZUqOvq/PKVbpx1EAI2VU
	cynWkTN4Kijfn48rps0kMhrBqeEXXHLu/OVMXG2csmymvGwrtejs1niYTz1kIjEmPN3TeAvbFaM
	VOSNGxJPPFNChWK6tK1Zy+Br6an/t2p9T89+x1QkKx+e1GD/vLPz17SDUkrvL+gSvcB4QfkL8og
	TrBG8js1I8NsDab5cwxHVLz4YzSAJ0WCGJ+bSeTwXXhzdFmOPHVelyc/qo3gIBr1qUaOP5Bn6yj
	j2Vjx49rJ6JnW5yksG41WQo9bLmSzeiiFHaRGuXjglDqSZ/HrWg2NodT/BMpT2TZGJ8xjfhxn2k
	2katWrEHGb8KJX
X-Google-Smtp-Source: AGHT+IEPOZAD4VRyHv8G07fK+SBrRsq0r0Hw/6N9Dx+r87/odXDC5BnpiOYuk9CtEdQgvS4jobcOWw==
X-Received: by 2002:a05:600c:1d12:b0:46e:32d4:46a1 with SMTP id 5b1f17b1804b1-46e7113f48fmr66978345e9.22.1759738053649;
        Mon, 06 Oct 2025 01:07:33 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8e9724sm19466682f8f.28.2025.10.06.01.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 01:07:33 -0700 (PDT)
Date: Mon, 6 Oct 2025 10:07:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Javier Garcia <rampxxxx@gmail.com>
Cc: deller@gmx.de, tzimmermann@suse.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] fbdev: mb862xxfbdrv: Make CONFIG_FB_DEVICE optional
Message-ID: <ewca4jzmahwdl47rbojxtynbizu2vuompjxrprsz7aelovnvao@kzpxjjbjj6px>
References: <20251005173812.1169436-1-rampxxxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251005173812.1169436-1-rampxxxx@gmail.com>

Hello,

On Sun, Oct 05, 2025 at 07:38:12PM +0200, Javier Garcia wrote:
> This patch wraps the relevant code blocks with #ifdef CONFIG_FB_DEVICE,
> allowing the driver to be built and used even if CONFIG_FB_DEVICE is not =
selected.
>=20
> The sysfs only give access to show some controller and cursor registers so
> it's not needed to allow driver works correctly.
>=20
> Signed-off-by: Javier Garcia <rampxxxx@gmail.com>

I don't understand this patch. CONFIG_FB_DEVICE is about legacy /dev/fb*
stuff, and this patch make the creation of a sysfs file dependent on
that.

> diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/f=
bdev/mb862xx/mb862xxfbdrv.c
> index ade88e7bc760..a691a5fefb25 100644
> --- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> +++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> @@ -530,6 +530,7 @@ static int mb862xxfb_init_fbinfo(struct fb_info *fbi)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_FB_DEVICE
>  /*
>   * show some display controller and cursor registers
>   */
> @@ -569,6 +570,7 @@ static ssize_t dispregs_show(struct device *dev,
>  }
> =20
>  static DEVICE_ATTR_RO(dispregs);
> +#endif
> =20
>  static irqreturn_t mb862xx_intr(int irq, void *dev_id)
>  {
> @@ -759,9 +761,11 @@ static int of_platform_mb862xx_probe(struct platform=
_device *ofdev)
> =20
>  	dev_set_drvdata(dev, info);
> =20
> +#ifdef CONFIG_FB_DEVICE
>  	if (device_create_file(dev, &dev_attr_dispregs))
>  		dev_err(dev, "Can't create sysfs regdump file\n");
>  	return 0;
> +#endif

That looks wrong. Without CONFIG_FB_DEVICE set the success return is
removed and all resources are freed essentially making the
CONFIG_FB_MB862XX_LIME part of the driver unusable.

>  rel_cmap:
>  	fb_dealloc_cmap(&info->cmap);
> @@ -801,7 +805,9 @@ static void of_platform_mb862xx_remove(struct platfor=
m_device *ofdev)
>  	free_irq(par->irq, (void *)par);
>  	irq_dispose_mapping(par->irq);
> =20
> +#ifdef CONFIG_FB_DEVICE
>  	device_remove_file(&ofdev->dev, &dev_attr_dispregs);
> +#endif
> =20
>  	unregister_framebuffer(fbi);
>  	fb_dealloc_cmap(&fbi->cmap);
> @@ -1101,8 +1107,10 @@ static int mb862xx_pci_probe(struct pci_dev *pdev,
> =20
>  	pci_set_drvdata(pdev, info);
> =20
> +#ifdef CONFIG_FB_DEVICE
>  	if (device_create_file(dev, &dev_attr_dispregs))
>  		dev_err(dev, "Can't create sysfs regdump file\n");
> +#endif
> =20
>  	if (par->type =3D=3D BT_CARMINE)
>  		outreg(ctrl, GC_CTRL_INT_MASK, GC_CARMINE_INT_EN);
> @@ -1151,7 +1159,9 @@ static void mb862xx_pci_remove(struct pci_dev *pdev)
> =20
>  	mb862xx_i2c_exit(par);
> =20
> +#ifdef CONFIG_FB_DEVICE
>  	device_remove_file(&pdev->dev, &dev_attr_dispregs);
> +#endif
> =20
>  	unregister_framebuffer(fbi);
>  	fb_dealloc_cmap(&fbi->cmap);

The amount of ifdefs could be greatly reduced using the following patch:

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbd=
ev/mb862xx/mb862xxfbdrv.c
index a691a5fefb25..3f79dfc27a53 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -530,7 +530,6 @@ static int mb862xxfb_init_fbinfo(struct fb_info *fbi)
 	return 0;
 }
=20
-#ifdef CONFIG_FB_DEVICE
 /*
  * show some display controller and cursor registers
  */
@@ -570,7 +569,6 @@ static ssize_t dispregs_show(struct device *dev,
 }
=20
 static DEVICE_ATTR_RO(dispregs);
-#endif
=20
 static irqreturn_t mb862xx_intr(int irq, void *dev_id)
 {
@@ -761,11 +759,9 @@ static int of_platform_mb862xx_probe(struct platform_d=
evice *ofdev)
=20
 	dev_set_drvdata(dev, info);
=20
-#ifdef CONFIG_FB_DEVICE
-	if (device_create_file(dev, &dev_attr_dispregs))
+	if (IS_ENABLED(CONFIG_FB_DEVICE) && device_create_file(dev, &dev_attr_dis=
pregs))
 		dev_err(dev, "Can't create sysfs regdump file\n");
 	return 0;
-#endif
=20
 rel_cmap:
 	fb_dealloc_cmap(&info->cmap);
@@ -805,9 +801,8 @@ static void of_platform_mb862xx_remove(struct platform_=
device *ofdev)
 	free_irq(par->irq, (void *)par);
 	irq_dispose_mapping(par->irq);
=20
-#ifdef CONFIG_FB_DEVICE
-	device_remove_file(&ofdev->dev, &dev_attr_dispregs);
-#endif
+	if (IS_ENABLED(CONFIG_FB_DEVICE))
+		device_remove_file(&ofdev->dev, &dev_attr_dispregs);
=20
 	unregister_framebuffer(fbi);
 	fb_dealloc_cmap(&fbi->cmap);
@@ -1107,10 +1102,8 @@ static int mb862xx_pci_probe(struct pci_dev *pdev,
=20
 	pci_set_drvdata(pdev, info);
=20
-#ifdef CONFIG_FB_DEVICE
-	if (device_create_file(dev, &dev_attr_dispregs))
+	if (IS_ENABLED(CONFIG_FB_DEVICE) && device_create_file(dev, &dev_attr_dis=
pregs))
 		dev_err(dev, "Can't create sysfs regdump file\n");
-#endif
=20
 	if (par->type =3D=3D BT_CARMINE)
 		outreg(ctrl, GC_CTRL_INT_MASK, GC_CARMINE_INT_EN);
@@ -1159,9 +1152,8 @@ static void mb862xx_pci_remove(struct pci_dev *pdev)
=20
 	mb862xx_i2c_exit(par);
=20
-#ifdef CONFIG_FB_DEVICE
-	device_remove_file(&pdev->dev, &dev_attr_dispregs);
-#endif
+	if (IS_ENABLED(CONFIG_FB_DEVICE))
+		device_remove_file(&pdev->dev, &dev_attr_dispregs);
=20
 	unregister_framebuffer(fbi);
 	fb_dealloc_cmap(&fbi->cmap);

(It would still be questionable however to make the device file creation
dependent on FB_DEVICE.)

Best regards
Uwe

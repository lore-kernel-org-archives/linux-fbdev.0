Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DA2145348
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Feb 2026 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500064; cv=none; b=oPKIVUQkZUaFmPgnYwX34Dnj1hl/e0xiATmqA/wt0xsOb47COZmjejignMPFz7+gF57XpcK2y7aGbvuwkcmhMj+3Cp/EYJ9apvk60xH0lGI6Nj+pICuO0JlpXE2D2Q2ELBour+7LZLKdoqw8LoIM29G5wO9p+iQf/AJOt9y+6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500064; c=relaxed/simple;
	bh=0+jv8NLQ2MHqs1y6vZyiNPgRVZIeA3p1cl720hr0LAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzApceaUUWaWjZzheSurBt7ljNbz98ylqPd8F+mh6b3VnMypG3JKE7VKCj3bQbWjjkBniF8nhOgCILWs1R/4dWQHsmXTBta9vcTAqZMQteOYtT7bbZLa0wUF9VieHXD+sFPcuLnay5Dv4TshCaH0qoXb0SKxoqKLlV31QDiRgGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Mve2FnXf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Mve2FnXf"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee0291921so16491945e9.3
        for <linux-fbdev@vger.kernel.org>; Sat, 07 Feb 2026 13:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770500062; x=1771104862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tfrnHsqrS7b6As3CIMHSJTCp+MPpzv+h69MSx8cjWHo=;
        b=Mve2FnXf8XRihOpe8aYeshmr9W+p7AOJycY9v0NgnFhe45cRiiA4Jbx9hVNqyjqb9z
         z0x4EMHlCBi3BnpiAJZLgdmSBFQ9XBrBmhSqIICT2/bCbwbZE8f3LeFNn1CU3RVJcNFE
         FFOJWx/DuyoA5eb7jkuwVL5vpkZhTXxPFYlEMYEoPbmLfSVaUfKifejYol9c1L75J5Sm
         68cQQAVLzempkvIaYnMEz3l7LE+TtVN5VM9XW4IaY3y7xa5lsnXUtgdIBy3O1dBigtVy
         /Bj7IXkJXa4QScjEv8gjiaqFhjxfqavYitEzEGI2l9bF9gfydAS2f9a/0i/Hj4oEgLOS
         +n+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770500062; x=1771104862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfrnHsqrS7b6As3CIMHSJTCp+MPpzv+h69MSx8cjWHo=;
        b=T6CTK4LrkIrpEz1lz6mtJ45n3Ra0VDEQu/elNrNwYdt4ysnHaxQvl8+bu8HoE7+vcP
         G33b8e2MK3OXRQWuKoUl2QlOEiA0dCQ8gF2JicPGaD/YH+ZEi3WxvEYj9pBBJ+WJHFnT
         HxrU0ACAyvBY1vm4dE9fKzVqmanPTkG2Ib5qDTRPsILwDc+45ABz3LKHKXFxIMNZYk5x
         1geuJrQyohpfRH6hlrCAt4IAUFtqCXm/B7xLicoedjqHMcCz6u+y3qjJPWc+uNeEopkb
         mVn3XS6rBOlXeSXq6pSKhSSczxfOeJwgRNbpcRQEGCDDtG7r2zXVcp3wbB9slUeNbheH
         baBA==
X-Forwarded-Encrypted: i=1; AJvYcCW2meXuBjlh5oyD3hfgYxhVz19nleGvRkqdeHaqlEmOScuncVGV+scGfqIATKoIJ4dn7M1Aylv9k4vO+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJYlSjvYEsOwQLJaJEFLVuTU/6fTW2gJyxE3Y2+m3A3N8TWxe
	UNBicMV5NEVG60S2QEWq7OeO9xKb/WQMm92J5vDGzUPdSsrQPEl9hLVdSDW/zrc1EBVfsrprLOc
	SfLtv
X-Gm-Gg: AZuq6aJEUANVHD9KsaYj6/q5dqCQjU8Ml2I54dHEXJYxq8fBefZLBKqavg3KeeyVuYe
	2iKQZ6PIhZiS/arakbsEDuowT0/MAlwqBkkoVD6lnRJxBzRBrFVqHJvBPQpuMti3OFrl4zN0p74
	mC6kZ16SA4xPk2iEeZ68RZaYImhVCQWrUWyUQYlkJkyJonEUPCAofneeVxPbu5b8/HXCbVHsB5K
	if2n7wfT9gKa3eAuxcWcTY1Hia9Si+k6T1FVPF3Nd5IFr3rmQ33iuOmfNDk9UKneSQP4bhWLnre
	x06R40HSrcs3X2DAkeJJWM5rEHv24t8ghskPP1KbP1MBIDHPoTBF6pavtIkx0sdI0UPK1y/uMox
	Svg46dqof6Gv1LMH0BOeXdAf38Ckb2DO8b5kVtaj2F6VuJHrCyw/rgMIDkub9ZTrGvcfg+cX7Im
	nBq0JeNUaJCdkXaUb4
X-Received: by 2002:a05:600c:3b03:b0:480:1b65:b741 with SMTP id 5b1f17b1804b1-483201e3b8cmr91225305e9.15.1770500061712;
        Sat, 07 Feb 2026 13:34:21 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4376a78d796sm176771f8f.20.2026.02.07.13.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 13:34:21 -0800 (PST)
Date: Sat, 7 Feb 2026 22:34:16 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/4] fbdev: au1100fb: Don't store device specific data
 in global variables
Message-ID: <aYevgJ6cfe6JVlJq@monoceros>
References: <cover.1770483674.git.u.kleine-koenig@baylibre.com>
 <0e1ecdde447dc32816f1f066812ec8e84b4aad0a.1770483674.git.u.kleine-koenig@baylibre.com>
 <7334e2a2-d71f-404c-b2b0-170a7117c0c5@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d35sh22q3uapum4y"
Content-Disposition: inline
In-Reply-To: <7334e2a2-d71f-404c-b2b0-170a7117c0c5@gmx.de>


--d35sh22q3uapum4y
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/4] fbdev: au1100fb: Don't store device specific data
 in global variables
MIME-Version: 1.0

Hello Helge,

On Sat, Feb 07, 2026 at 08:04:21PM +0100, Helge Deller wrote:
> > @@ -547,7 +542,7 @@ void au1100fb_drv_remove(struct platform_device *de=
v)
> >   #ifdef CONFIG_PM
> >   static struct au1100fb_regs fbregs;
>=20
> ^ you missed to delete "fbregs" now.
> Your previous series deleted it.

I guess this is a fallout from reordering the patches. Will fix.

> > -int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t sta=
te)
> > +static int au1100fb_drv_suspend(struct platform_device *dev, pm_messag=
e_t state)
> >   {
> >   	struct au1100fb_device *fbdev =3D platform_get_drvdata(dev);
> > @@ -559,7 +554,7 @@ int au1100fb_drv_suspend(struct platform_device *de=
v, pm_message_t state)
> >   	clk_disable(fbdev->lcdclk);
> > -	memcpy(&fbregs, fbdev->regs, sizeof(struct au1100fb_regs));
> > +	memcpy(&fbdev->pm_regs, fbdev->regs, sizeof(struct au1100fb_regs));
>=20
> Although memcpy() was used before, isn't this:
> 	fbdev->pm_regs =3D *fbdev->regs;
> sufficient and better?

Probably yes, that's a separate patch then.

Best regards
Uwe

--d35sh22q3uapum4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmHr9YACgkQj4D7WH0S
/k6iowf/cO96jiS4X1jREbF+RkH18ZfeRULpcSU/4pi2tHEoKSVZk2VwaPUSja+g
CBmrtT4AI6FgqfPzFqpGK753YuwPTqTqSpHUYI6MEPaTTrkbL8eZgDpJIbf6wCSp
7ZW8Rhf4V21/ZkxCbZJ/zvMSui6RG6iaXHDfxFBBRmSKZ9//X8bNreLspMq39R4K
VHaSUk8fAnSRj5HmTQws44AhWp350sbQvxQVp0zG2WaxtInMvkeMTlL0hnNUn/9L
nbgI7waNuqpoFH/scoDXzi/NLqdDMVuUE6PzNe4FeEmhJEWm3vyV47uvN7T3RoLB
GZu4/Ek/pDSQFCCfSZ4ylyO9A0ThNQ==
=bteR
-----END PGP SIGNATURE-----

--d35sh22q3uapum4y--

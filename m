Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51525DB12
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Feb 2026 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770622444; cv=none; b=lFZ0ROlpX0zIfRw+rFXsAEUwQnRKN8iqh79rIG0uRb7R28+rfn3zdN2IkAIPbvK1yacjq/fSxdBMB42A1KakelJCHJaOs4ckbaPAjeewfkiYEMJAKwzNeOsEh2rnpLw94O7kcL0AKkwrkAMtdxTKp5bQucvz2751+r4nlOSjd5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770622444; c=relaxed/simple;
	bh=MG0bPYR3WSu084wnzAku9lQCKliUFo5vL9HEhV68AwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aagj9cs9w2HiNe031tg20dElVmYUxz2Z5+NJIWBhjQtqPDBz3PMiyHsgMIq7nf4QULoX5n9hQWV3xcbGzegokXP//SnLdfh9Fo7qY/V1ww1FB3MDQ+UnZzeUg4mK276PIff3F4XKuGuJgz7QknjyupbTnk/XE1TBWoRHEbSQbYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bL9HZ+bY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bL9HZ+bY"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-435a11957f6so3173665f8f.0
        for <linux-fbdev@vger.kernel.org>; Sun, 08 Feb 2026 23:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770622441; x=1771227241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCETD2Ir3XdZsZrpCZXE8L7Gxegk6DC6juk+h3rkygY=;
        b=bL9HZ+bYniu58rND/b3LFoOWIQfpa6TxY0dAE/AbVqIvWUPesGy3G1WDEYRwjc25C9
         XBzZiEokZRkJvW2D7SMSoh9rlRgow7f5v07eI1kMNiYh2v7yrAwLuHONIC4HQBvmZE3g
         HkgxdP0YDaij+czTcT9374Ejq9tb7CLrAAGeooa9EzhPZx2+FDYYTjBs4TD83arfKh8+
         1gH5Um/rQrFkGpWcEd72ATYfq97hMXuDSf/gvbO7G+GgmmvYobkF3pYr3PfC4SwZU72p
         Y3Ii0ks180xJOCdzuvxI9ow4IYe6bZKCysz9fFt90oNbP1XCtTQOXfysHlSkr/BZfkpF
         btDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770622441; x=1771227241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCETD2Ir3XdZsZrpCZXE8L7Gxegk6DC6juk+h3rkygY=;
        b=sDKpyM0GpGMuWDC+wXPVc2boKfMxYsZOgpJxh0sax0RrtuBe8fTQFX+FJc0ofxDWcN
         YbLqpe3kwjM72uH0jk8Iebk9L01YE9x8EuICmi1u7qpNYr7/nKnxdANBeSVoZklxz2Lo
         rpviss32HnYfdAG365hZmyemAEESMbu8E1vR42WgkeQiX3jaDIj0+7GYcDwF0OdrbzwH
         R5aHp31rbXK3u8C0ZPFmU2EKPMZibGe6VaUdIVrZm2JROd2ZzumT7RmEPcHRgSBbcZic
         UXXt2ZLmgCPYex6Zkr54UkgrAgUX3STeXRGLKIQRzq8Wc2Gt7sdStXeX/ez7+ctWq92F
         7hrw==
X-Forwarded-Encrypted: i=1; AJvYcCVsX9eyhrkvJsumlTx+UpFAjkT+ArL/1aV35A2FK8XahXtj8xagUVhbmqpQaSYI1zQgVhtSWNsZX++vyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhgm0dRMibMpYT+IVAo6+Q5/fik4CQGXSZDbxn2LSBEmWhkkF8
	cH56n9m6EINt1ZGBcWULOLuSUS7OpvjnNstqCbCPZtN75jBqB5usKUmJbCG7c9XRrzW/OJhChP+
	l4Yit
X-Gm-Gg: AZuq6aJaYCJED/JrT54G+NEH+AVlcUYJ/v1h4j43DHhkQ/RcWznOHcUYqd26GBVsEQ3
	ASXCoRkE8uXY6NFJUyU5NhBogzlkgfy/htcCBJsG4Em8qwqPouIQc2dRBEGybcxADdindB4jEuu
	a0ELzAABH63ODNpaF2iPg693C6lzoHaR11OcGBoqlAr013h0KtxBCKWptuCTEpzRm9WqsGjQ7AF
	t0C/jqI4iTeV4KsxAzkuSzdSw0J3grrbK6i8Osg78EgKCXhPgPvnUcFKQaUKfFFP2ucfTImoaJp
	R+YD2vr6z1djzd9bmxR39gDmNmRxidMZSe3p44nqyUfTrqmwBF50EYBYxH2k/R3EZl4USZtG1el
	oLUh4OANIxE0pXY6+9QoRyD2I6yh17CU0P8WAIvhMRBtSks8YR5S4nzfqD50NwWgY5e8yfhd8AG
	GK1QWnP7XxBqCzktYT
X-Received: by 2002:a05:6000:2209:b0:435:9241:37b4 with SMTP id ffacd0b85a97d-4362938ffe3mr17992442f8f.53.1770622441280;
        Sun, 08 Feb 2026 23:34:01 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4376686130csm12534072f8f.1.2026.02.08.23.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 23:34:00 -0800 (PST)
Date: Mon, 9 Feb 2026 08:33:59 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 3/6] fbdev: au1100fb: Use %zu to printk a value of
 type size_t
Message-ID: <aYmMyNMC0z8dLisS@monoceros>
References: <cover.1770572936.git.u.kleine-koenig@baylibre.com>
 <3eea98cc14bae12a3ff6c6574971669e15a1f16a.1770572936.git.u.kleine-koenig@baylibre.com>
 <f4b5c6ec-0960-4c76-be49-ec0236b1e450@gmx.de>
 <d6891ed3-0a6b-443d-b64f-10e8a17bde49@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="whgo2niphctkkmr6"
Content-Disposition: inline
In-Reply-To: <d6891ed3-0a6b-443d-b64f-10e8a17bde49@gmx.de>


--whgo2niphctkkmr6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/6] fbdev: au1100fb: Use %zu to printk a value of
 type size_t
MIME-Version: 1.0

Hello Helge,

On Sun, Feb 08, 2026 at 08:24:43PM +0100, Helge Deller wrote:
> On 2/8/26 20:21, Helge Deller wrote:
> > On 2/8/26 18:58, Uwe Kleine-K=C3=B6nig wrote:
> > > @@ -465,7 +465,7 @@ static int au1100fb_drv_probe(struct platform_dev=
ice *dev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev->info.fix.smem_len =3D fbdev->fb=
_len;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_dbg("Framebuffer memory map at %=
p", fbdev->fb_mem);
> > > -=C2=A0=C2=A0=C2=A0 print_dbg("phys=3D0x%08x, size=3D%dK", fbdev->fb_=
phys, fbdev->fb_len / 1024);
> > > +=C2=A0=C2=A0=C2=A0 print_dbg("phys=3D0x%08x, size=3D%zuK", &fbdev->f=
b_phys, fbdev->fb_len / 1024);
> >=20
> > The & seems to be wrong.
>=20
> I see you fix it up in patch #4.
> Maybe simply merge them?

I see how my compile testing went wrong: I checked that

	make drivers/video/fbdev/

was happy on several archs (but not mips) but only starting with patch
#5 this actually compiled the driver. =F0=9F=99=84

I'll give it another go tomorrow or so.

Best regards
Uwe

--whgo2niphctkkmr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmJjeUACgkQj4D7WH0S
/k59kQf/V6SKzt6FZ8AYhQY7Rmk3hbW5XDpdI3qUpn25p4yU4ZlhAa7es+94axGa
w4tW7z+a504jbueH8n9CDQTlAuNwvT4RKRTCMKlLEzZOvlXMWiFKxtkPOt/BMY++
BGLekYKrZqqiqvPBOEjWWkkSAFzKk6BWN4ognAM2lNB1D1ivIjVeqvMD6VPmwSYO
zh5k5sl4WxG5v2kfZtEfBSR0GL+hHMotp2z7jmoQ36ZMZoNdhjbW5afVE33dTq1m
snHKSf4mGQ0gYYI2NmOq6GkzUYtoFj+oJrY7heixt5iTYx6O5hsyw/t7BDeTXokd
50LRfUVUV7KdWbq2qf+tbCTnDxsnzQ==
=wUKs
-----END PGP SIGNATURE-----

--whgo2niphctkkmr6--

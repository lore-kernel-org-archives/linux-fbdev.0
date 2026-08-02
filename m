Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BDD381AE5
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Aug 2026 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785677747; cv=none; b=YD5w9ilceOcsRfqDNSXqITsw8qXNqmwISh7lBulyhpYS8j9USHSlY/5+S69KN8pa75ufM9Q/O/ul70uUTwPJAOaFo8eAdrID7TsvaZUWgKdsKuorUA3Ts9HBlesNMFEqaC34Pg6++ST9RH7Kmd8InlQ7FHMW1WjVK+kYtDOq1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785677747; c=relaxed/simple;
	bh=UlAe688FL5SqYvNdYPiubZv5Vup2lbXf0/HgRirxAQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt0S8/Q8zmG9IAWyRi3r93ph6Q3rOEtu3TfHYZPwr/ozXGrsHvCHC5llPHgI8x+CY56FXN00YbQl8pFlbnh8iD0r7EftegX1GH9Vy5cUD5RgQTYKw1K0xj4KPONB8opi/7gZTQ85aG4JScaXucaSSZVq35ZS+xT0RMrLvMJDdTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LdCEIrQ8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LdCEIrQ8"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so10740635e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 02 Aug 2026 06:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785677742; x=1786282542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UlAe688FL5SqYvNdYPiubZv5Vup2lbXf0/HgRirxAQY=;
        b=LdCEIrQ8ptjQNgEeXZXwT8yRl8hjPKh9CzcJi/Yv1ob3p3kNXCxTDXDkqbIMHAc43e
         Uqrj72HWGtTUo99XgZhc7XpyB1c1+fJ4tYfHzHHarkhzYoSXo29RgRfFMF3uT6ae/2uG
         eCH9svGgky8X0y74jopfPzfpth3CemP1jj39HYZmdQcLsQ+THYilcN8keeFfImSkTrPE
         y+rvHTeze3S8EQ3ytoILEjl6KaMnTkFHVl/UoaIs5viICG3CsHQYEPp/ARHkwCSq8J7f
         m+CIjUPqgVaexQ0u7ZxOnE3Hr0NEUiW6wa26UzZbdO0WKvGHxKMvnBUBYKoBheDFkR4/
         mkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785677742; x=1786282542;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UlAe688FL5SqYvNdYPiubZv5Vup2lbXf0/HgRirxAQY=;
        b=PtPJ5dwiKVGfN3H9rs6q08ffK8ZZw8g5Hv/lqCzzhTzrMFH1V7sQkjncYBCnaq6l91
         AOF6v63g2ozd6XQIq50CNqY1zr1oVrXNTccYudt+h8dnTp1dFUKTLlBEWNYGHVjGoMiG
         JSjJA0sjZTTCuwyrVPl2l10/dpVAVgg3atcBTLzR8aqAn6cR95NF75H3EIe1lXlZB3vZ
         qVmm6rBLIa0/e72EouCd8hW5R9xArg83QB0fPwnm3QM7fCBvHipygH+oftP0pFcZecfS
         Hvj483+Vor52c3wFsmLXk1t/freGd9g49fwRZgpZnyJM15tm2OpJ9cjgRtV0g6p0Ny/a
         yd7A==
X-Forwarded-Encrypted: i=1; AHgh+RrEVky3vxFVr87Esh7exl+jqNZJG+jRtL406uL1Y7HB71E6MjKKFQUKUR4tvrffEt9gN5I/en3RhO/ElA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaKeYw+yYCwmYfWiXy0XEx3dmOn+61m0F9Lc15ZVDdPUMNrzup
	RpBWNeNlkSpAqlbF46ZQ49LG7/rrI78Nv0AKuI+zTXMIJSHpfxtEZM+AjEL69KwgpMg=
X-Gm-Gg: AR+sD12U2UjI5cGV3W3mtxC/NQcirFolmQ+bQ27Xc+uVoqVRp7IGMDHrO6WDnXRcAwM
	uyxxZlNQQ04U9OAnQ87ZfomZ32kjdHB0rs61Rcgc3kFBqtGtuPOPxW2kSqiVEBETUuaHtrCEN7m
	0zZBN223JHsihl0blRbsDy4s54KsGhDaM3IO8PCUJ6r+B1SG5u2qIMB+roRBX7Pi3fQL7DpPg5g
	aLAI0V+ouV60BKI0BSWKfdVOS1jh8NJHlEWORpdXrDY+lDoxW+itvbBHVLPU8ExIz63Mhvs2e1r
	q7zZj9cAa+OyovzboWIcG60g4DDTDw0Jz+b7VwgCTLPzP1nAk6+nwOWdXMhztslw5TU07T+BI+q
	WTMnUlhs4gG0DOYGugd4P5alaYyP/Y8Sba/fWo9HdJaHVMnbnrjT6BJb7sRMPewqByIJM8y+f6I
	INmYcZs4huCRWxPWf5Pmckr/xJaTZ/MW/pzibeEhZnV34DWIkb0QbAGT40Bevi0Pixjg==
X-Received: by 2002:a05:600c:3150:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-4980eb8c4c9mr97559055e9.3.1785677742549;
        Sun, 02 Aug 2026 06:35:42 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4980819a030sm144499215e9.6.2026.08.02.06.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 06:35:41 -0700 (PDT)
Date: Sun, 2 Aug 2026 15:35:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
Message-ID: <am9DGQFk6JfR6bXl@monoceros>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros>
 <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6rrxlhjbsv2gpeab"
Content-Disposition: inline
In-Reply-To: <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>


--6rrxlhjbsv2gpeab
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
MIME-Version: 1.0

Hello M=C3=A0xim,

On Sun, Aug 02, 2026 at 12:01:58AM +0200, M=C3=A0xim Pedraza Padilla wrote:
> Uwe Kleine-K=C3=B6nig wrote:
> > My 0.02=E2=82=AC: Usually you want to use the display using drm and not=
 fb once
> > the machine is fully booted. If you're using fb during boot to display a
> > logo, it's hardly possible to switch to drm later in the boot process
> > without flicker.
> >
> > So my recommendation for your usecase is to not use the kernel boot logo
> > stuff, but something like https://github.com/pengutronix/platsch.
>=20
> Thanks for the pointer, I did not know platsch and it looks like a good
> fit for the problem it solves. It does not solve mine, though, and I
> think the reason is worth spelling out, because it is not about how the
> image gets drawn but about when.
>=20
> These are industrial units, and the requirement is time to first pixel
> after power is applied. If the panel stays dark for more than a moment
> the unit reads as dead, and that is a support call. Anything running in
> userspace is by construction later than the kernel: it needs the kernel
> booted, the rootfs mounted and init far enough along to exec it. I can
> measure the exact difference on our hardware if that is useful for the
> discussion.

No need to wait for init, the idea is to use init=3D/usr/sbin/platsch so
it starts before init (and once the display is setup execve()s
/sbin/init). Also you can put it in an initramfs which gets rid of the
dependency on "rootfs mounted". And if your kernel is modular apart from
what is needed for the display the time difference between kernel boot
image and platsch might be negligible compared to the simplification of
the software architecture.

Having said that, I'm against putting boot splash info in the device
tree as the pointed out alternative is IMHO good enough. But my opinion
probably isn't the one that eventually counts.

Best regards
Uwe

--6rrxlhjbsv2gpeab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpvR6YACgkQj4D7WH0S
/k55+wf+LNETFlaOPhwExqKupPUo/OH39ybKdaQJ9uAkqBo70lHb+Xm37TY6D1sa
P6+sFxOwFR6mGxWni4QEila6hAYHRNzqqp1o4Rl8mpnPTbG6vkJrRaT4vFCnOie+
6Y+yocUerh6JqqjAim+X+SGrIjaJ/54KtfaQ6dGBUxGFHr0q/pThdXedHep4ZcB6
viwOGBykkKZpx1gNKR09GiA8PlxG00jkAvA9ay3cvlzMg7zwU0nRjjIDp1d+lo7K
ef908NB2SG1R1TNMBEYy9T103E2VidGZ7bA9NsIqYLiCEGo3z1smJcAVdaXl1iTy
hyLG+z6x2P06fk2+cllcwxaOEU/dXQ==
=CFkM
-----END PGP SIGNATURE-----

--6rrxlhjbsv2gpeab--

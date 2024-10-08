Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4532E1EF954
	for <linux-fbdev@vger.kernel.org>; Tue,  8 Oct 2024 06:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370699; cv=none; b=uxg1E2+N0eq1EV+F1ILxbzdKBPH59IvbXJ6J1pTVSQU/U/fr35HlDfjSYxL3ZHX4nZEp65KG2NXlQvCOv1sDw4QdqtVknMfiHaZtlvSW4cGh5bHAVNlnNzG4ZWnlZk6dYlHQk9qTXRFuOqy+0LY3hUXg7nnSSTjOJ8wMT1fe6vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370699; c=relaxed/simple;
	bh=mh2J0HVw/nVFjsQE1DHaQY4suD6gXDrPbFWzTtGu7Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqK9xlvOkt6IMQS4/UjJowDUUcB8J/otQHAk/MrMjCV4pGj92UdF0Uf/Di68jzoeUvqbgUkvNB6ot2Pil2F3KlOTvqrsOoofIA38lZPUjsEtM0bTVN8d1ZXmyCvSt0unOtNVO6etnhs8Ks0tRFVUJh4CSM2TSBGjAbSEZlaq4wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KKcUMMFn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KKcUMMFn"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9943897c07so373625166b.3
        for <linux-fbdev@vger.kernel.org>; Mon, 07 Oct 2024 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728370694; x=1728975494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oX5cCIKvh3FQNxKc0x56gg6gPSEg8iwRBf7xW5JFeok=;
        b=KKcUMMFnrpoK9f6CmhWdk+xuD3QIRzOxvmiu3MiPoGVsKNaw0YFgjEsBZWQXe2Y8o6
         a0gjpUo7K4YKChlkU0TRgKJ+D8Xi4ADeq4uqNjDFZriHqLHwm9vV53VyBUkggRShVBIy
         ommgWOfG8QgQr9TQ7syofMFAw6PKyHo/TrUNx2AtF2W3u15NoteP2tGv9otAbYyrlUNZ
         mUIspdOZooaGgtnboGBWTD6z+2+7R7lVTToSIPYi3HzUdwBu6IoM6976jvFHc4lFxWoi
         O1AYM0HRic2QlT5ObP/UVPnn3lQ784tl9ZvCgmMwxf8ZqFwc65nv2gaWsRS7kl2Uh4/r
         xaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370694; x=1728975494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oX5cCIKvh3FQNxKc0x56gg6gPSEg8iwRBf7xW5JFeok=;
        b=Utdy66ZQWwhQ+rN8IDiShZZB7smamL5SLfq0ppow9m8Cm7/WAfrmj8kQxzYrOAh8ao
         WLkIkYqg2lDkBDCYWmMME59gsifGtUdnDw5nzDZdTfWC/5Wvj7hd/qdtzBsEOH3jZhgh
         laaCDKijB9bXsFaoEmJqzQmT+NfYQeYhd1CU4GQ60ElQsqNi7hc1pKJZHRN7+9YPnam0
         K/Z5qEawCsC/K/nFBT3EW/gVmkPtgD4mpatc1k1ZfexxBI1ZdyGWItt3vmUCXLn1TaFH
         gDhlpSheynzmL5bZHX64roNvjEZS7ACxz8XtFU64+FIvz5WMzKwu/dOdDZ0MAwg/qJjv
         TIVA==
X-Forwarded-Encrypted: i=1; AJvYcCUrbYGDh5UwwGoF8n/RQ8L3dx/ejJF3CyHalzjugeoxR/q4ku4aVykcr15W/zB+RraKra/E+V8z7+/4UA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHJlrrTx2iYC9ULssdY8xOCiE+YprpTNlhcHSjgjxRzGNa+ldh
	vkVA8Szn7k7GlygfxmxS+L9oueYqDJMFLWwArNalQqwtuYC195nRcfjYWlY0dIR2w7xj/hGUHl5
	q
X-Google-Smtp-Source: AGHT+IFpWLbhTPOX259xI0C3449NGs6Ci0Xoqmf6eZs4iSjdEk3EwWyZY4gBRmyp5IcTjtHHqIJEiQ==
X-Received: by 2002:a17:906:f5aa:b0:a72:750d:ab08 with SMTP id a640c23a62f3a-a991bd479a7mr1527145066b.14.1728370694408;
        Mon, 07 Oct 2024 23:58:14 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:6abb:a5f0:cdac:1079])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994c5a219bsm302315066b.152.2024.10.07.23.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 23:58:13 -0700 (PDT)
Date: Tue, 8 Oct 2024 08:58:10 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbdev: Switch back to struct platform_driver::remove()
Message-ID: <7l2xan5aa4kvbzeolwdpeccnsfnp5o5zjucnibd6mdhj2abw46@y7vwlg6tnqmt>
References: <20241007163516.433885-2-u.kleine-koenig@baylibre.com>
 <863209ef-289d-4414-b19f-e0a308d0fba0@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3grve4v64eiurmgi"
Content-Disposition: inline
In-Reply-To: <863209ef-289d-4414-b19f-e0a308d0fba0@suse.de>


--3grve4v64eiurmgi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 08:30:40AM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 07.10.24 um 18:35 schrieb Uwe Kleine-K=F6nig:
> > After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> > return void") .remove() is (again) the right callback to implement for
> > platform drivers.
> >=20
> > Convert all platform drivers below drivers/dma after the previous
> > conversion commits apart from the wireless drivers to use .remove(),
> > with the eventual goal to drop struct platform_driver::remove_new(). As
> > .remove() and .remove_new() have the same prototypes, conversion is done
> > by just changing the structure member name in the driver initializer.
>=20
> This paragraph refers to dma and wireless code. I don't understand how th=
at
> is related.

Ah, too many patches and missing automation in some parts.

@Helge, can you replace this paragraph by:

	Convert all platform drivers below drivers/video/fbdev to use .remove(),
	with the eventual goal to drop struct platform_driver::remove_new(). As
	.remove() and .remove_new() have the same prototypes, conversion is done
	by just changing the structure member name in the driver initializer.

? Or should I resend?

Thanks for noticing,
Uwe

--3grve4v64eiurmgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcE2AAACgkQj4D7WH0S
/k5Jpwf/epYnO4NZimITj5+XuFQJZIGQWSxOp7Qr7XOC92wCCD3GouqP+aIRvJEW
K6dCohM+T7YrW0MeQOos0P+KoLdOApXvlMy0wtdbdtqpW7eIm9A14vUvULYdP1Rn
pMyJaHyGlw7LuEQoJcNQhHdObrtfsXa5mn8aXlQNnbWk1gEo8yi/JgcgF67eeioX
GHpDYhElydC/mT3OAnzcBjG2S9yF6zoWrdMDy11LW6JWT2aneBOqYEcUrYgbd0Lq
oaC44ke3d83UZ0hIP5f4G364+cBSKu0cXNugCkYT5KbQpIQ4mrZE9J2ddJiG/Vf8
NeWrNKXjQTbK9iXOseqEboXL4f4jmw==
=4PSw
-----END PGP SIGNATURE-----

--3grve4v64eiurmgi--

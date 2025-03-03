Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1F2E630
	for <linux-fbdev@vger.kernel.org>; Mon,  3 Mar 2025 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993554; cv=none; b=jjrkIQT0ppptkD38tmx2Y7imG9Ly9YTQ9xlF2aoPJrwDgPXX5fLunicqZcZhfP3wkNtR5LpbuboUyNFsQou9cuRwcSmcSL7W538RaFF5IAZsxFKxJIVin05+hH68/9lJY8RzCqj5QZJQljDmErk5x6jaVzA/X/I2y1jutdEB710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993554; c=relaxed/simple;
	bh=gcNOncFZdUs+yNeq8pr7D0R7rzSHI/mcL2lr8MRssiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYKXA8Y65cBkXW6dHjVBAjmgQeENI9TPIzp7fgPBuyV5EO/NoDWb8UGMaxCeA3+XS3WxL9DMf9z37pheNazRBoOyRaQ2Y9rxWbbsTmkc4ggIITBy2NPDa70kT1SCWUlFSxxLrNWj83IW7pqDHR716mdlvmWrQfV1MAWJpj1nnQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BHgGP/K4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BHgGP/K4"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3910e101d0fso289953f8f.2
        for <linux-fbdev@vger.kernel.org>; Mon, 03 Mar 2025 01:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740993549; x=1741598349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gcNOncFZdUs+yNeq8pr7D0R7rzSHI/mcL2lr8MRssiE=;
        b=BHgGP/K4nfJ/+0PZMEd7uq47PGl6fzMKFzRRPA/1V9tDi0suGuZEDNjahH74gfunp5
         ryMjFzwtwl89eNIXUsxnJUIQGK97jDbunaNAJP4Wx/XBPSgctO3vubEsDpXZhDbZbrzH
         XO+vmbI5liCz9gtRGr3OL9MMbZSN+tpuLzsTCUgB/98pzw1ruE9uVN26fYvzGrmPFNEA
         G+jc5IGla6jQgJWi/5hmXvVZy0USDaggJo14+1hn2wgX2JHjpj7PnTfRnpNgp29muADJ
         K0Z2kOB5ulLsn/Cj9J5/iSAhMXh9iXyWD7wAh646kqvfVYqq5EbviFU1rHtHo8GWETcQ
         gWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740993549; x=1741598349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcNOncFZdUs+yNeq8pr7D0R7rzSHI/mcL2lr8MRssiE=;
        b=mV8UyV7m+J60j8Tu5pWJD0geLCpMDjqtd1pkJJAzyG6bQ+y+4YPF/deuDoLxtxj/HP
         6h1ZQv8xd5dyGuDbZDn3Q+m+rgujdK0slTE8Tz2dMhykHUdWbqPtbNKliDusxmSnQw1e
         84BpSCsQ9V8Fu9w9TFaOnIzeOAEc5aUqNNHvSbXTpGlrdMM8WhYUhEWN18aCmIwwVdJS
         H1BW0yrNWtnmrLgWTTiSiDbCCrTbM+1Ai3InLFhb/6OG81ISSyef37pC+c7WPuuNK/fk
         nfFx0dxxTRCyRZ2fWSY7kYUGkdTCeelr/6IbQjPNt779vtuanzeXVZrLqlhUzbG63biI
         ZR0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUk3ZX1X0LSgUpLZ8e/vyGwGw4dGjDxZ+SCjR7O2RoBIQaSipLjiW7zkF7roUvSwTI8uPlQ82KLx4lixg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIHjm1hLrVJ3AcDi/tzlZbWIfs3CMng3lrykM+FEwQuBhJo8DQ
	lFw/zVFlAyCtIjXKdlaYsS5OkNvily1pF21gHUsMfI3UpLvwJOrznh2+3A/V1gE=
X-Gm-Gg: ASbGncshvR4KM11TvppS2dqGMN4Vhm5/fdRgf39SQXsb2kjEwuSJ4p8QuNBCI7Vw3FG
	IO9okiQMMekVOvNNaidHY38c/1BkgifR6nYFrNbd07u/k0UbtxZSvLHP9Hwc2814/LVp7wtXWHf
	RkepRISq5e32BK3+K2ewa829vPKlnFmlldwJD0WAkLAeJwV1mPbVcncyyXZJ/+c1FiCkWNiEvPb
	tKRw7z7z7DnXHOY+fJjIb8EPr5NB0/8W/xi72voOluZAx5CWKv3dzXa0XF+YUI8dm7zqvg99Y6w
	CB3meu+dd83WoLIRpurz5RngBz6b+L0uhpsmKlPh6knWROviPVHXTnvSYu4cKUjPsFu05lkuSdC
	YVBB0r0IjTAQp8v2hxr/F/b/GYg==
X-Google-Smtp-Source: AGHT+IEgqURih64QQq878LAlpoiWUHZ5SF6g+OaiNjsjRHNfpFnMktBq587o0TTR3FHczDy3N5hAQQ==
X-Received: by 2002:a5d:47c3:0:b0:38d:b610:190b with SMTP id ffacd0b85a97d-390eca377a4mr9441525f8f.46.1740993549456;
        Mon, 03 Mar 2025 01:19:09 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a87sm14038348f8f.32.2025.03.03.01.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 01:19:08 -0800 (PST)
Date: Mon, 3 Mar 2025 10:19:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Antonino Daplas <adaplas@pol.net>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Yihao Han <hanyihao@vivo.com>, cocci@inria.fr, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] video: au1100fb: Move a variable assignment
 behind a null pointer check in au1100fb_setmode()
Message-ID: <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b5ssf4zg6xgpebyg"
Content-Disposition: inline
In-Reply-To: <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>


--b5ssf4zg6xgpebyg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND] video: au1100fb: Move a variable assignment
 behind a null pointer check in au1100fb_setmode()
MIME-Version: 1.0

Hello,

On Sun, Mar 02, 2025 at 07:02:12PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 13 Apr 2023 21:35:36 +0200
>=20
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function =E2=80=9Cau1100fb_setmode=E2=80=9D.
>=20
> Thus avoid the risk for undefined behaviour by moving the assignment
> for the variable =E2=80=9Cinfo=E2=80=9D behind the null pointer check.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Fixes: 3b495f2bb749 ("Au1100 FB driver uplift for 2.6.")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Should also get

Cc: stable@vger.kernel.org

to ensure this is backported to stable.

Best regards
Uwe

--b5ssf4zg6xgpebyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfFdAgACgkQj4D7WH0S
/k6Ubwf+PAWfTbo0e8l6pPMYDWTrIlWDVs6P8JwsxmPeNHmuw2L+6JmiXLUt4r8K
BVOnwleXuUC4G/EKeAKqCwELLweDzt6QsmUWLUCsc6MWiQ1O3QDCv13Fty9auThY
kk47fq5PjnBwjmIVoMGXAgkBlbRg7kL3mHisr4Znw6RGM/T4kW4GGSSRKBNUDTy3
3zTnFrB5Yu6Kzu4JeU34zrCMxKAvQQoBWC61PkTfjcagCj/XrRG86KI818e+6ZPr
P65IgsUOVTGAFKASeg4ZDgvdvaMnvoOH2w4RENMNeHuYWCe4wJaW/bn5brGZq1eP
MJFndsnaHk7DCh94RiyWcyZ7veHiLQ==
=VPpv
-----END PGP SIGNATURE-----

--b5ssf4zg6xgpebyg--

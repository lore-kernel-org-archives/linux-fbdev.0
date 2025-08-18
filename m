Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D469C21147B
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Aug 2025 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507281; cv=none; b=qYEjqvf+4zjX2fXx6HNAaF0MaFzZAjadfR8azeeAs3ZnxKOag+WeaLctoqJH/ruFAM2KvPhVwzRk03KK9PQN/etCqnS7VwxeABFgjxPcaVRLhritNRQSagnyeEuhEmu7m4gQi0w4d7m3z8jIqVP0sZS2PFcekzTNE2pxQ1ba3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507281; c=relaxed/simple;
	bh=mcDEFDthDNzUHS5psBWkX4Shbl8hyUJ0RT+jdgkrEQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC8UiiOGjj9aXiutlW/bq81OLHIg1ewcINUsz9hILl0JDc0V/0ogFAaBvKvJ8Fqep2QmldPgF8w0vPbxzJ0QaylAHaruKHPKZkcs8eh4K/I2oyLBiZKm9hiKmAbMTs10Zt9KEBQcI5QtE2rNBBVzEkPqMeFvnb5ix62JomfSEhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=djqreY8F; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="djqreY8F"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9e4147690so2657288f8f.2
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Aug 2025 01:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755507275; x=1756112075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yzToNQB1ac48NZYa/jSZx0h1+/4yVpTKx5PmVgwy9lw=;
        b=djqreY8Fa1iOPzfnT9ueohm/5KaYayPlSHLRxUe1MuOpPdW2DMpF89MORqsec9OUv7
         xilUDXcUyzfAmKDOWhwTnKzkW1WaAh5GM4D9/UswePY3DeEORqu+3xibMEGFIAS9TXPX
         Wvx/Zun4G+5vd1SxuYB8IBh7OuIbpad6CDW/HPNpwfuVlgsI19aDy84apLpnwugidBev
         9WC6sCnY8NHdJzoly9jeKbnTGHLVcM1CiVZvYHMydkCwNfA6pjXGAtXH3yEHzJ4dNB+R
         irp3Foxjw39VcC54AGQltihcwywsJI4qEAUlObG/rlNxeYgWL2nKZMsuqJDDKW3vIv2y
         Orhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507275; x=1756112075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzToNQB1ac48NZYa/jSZx0h1+/4yVpTKx5PmVgwy9lw=;
        b=YLgDmIv5Fre2zeTtPz9Kf9KxpJ32C6oqEmbajOOsOAe9AWpJDDSxLPFlNd/2UMD/xw
         w9ejJOndHfn6pPBb7BFIGstFuN5x1Azx42/f2EStVEpfWmJM5dGTuOWUHPwBD+sV+uHY
         SKNstPrTrpXXs3cJ2FcR/ED1q2AqRFwlcZkFRgAr1bmR6R0l4XPUZSmqOO9wyYomSF8g
         lSJsqRrKyDgGUWdBlJT9dHVpruAjMuKsKlJZlc0lXcW6qQec5KSwmjGLHYxL0uBLhOGa
         20isf6qlT2P6KNNqsq632/nQjDPGuBmVaLi07cdrTUGSZjXGWBKHvXAGj/svrIC8x4NE
         DPrA==
X-Forwarded-Encrypted: i=1; AJvYcCUVT1RONtEIXlkR7ss3HF3+/gaLhwS4nQ6ggXXMG7F1LX1UH/uoX9oMtvdp70WavxcbKEK8MRmaydurJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7T9n6EHh0E9exrdaKYhRe87moZfh4H1RQhZkVcxMiaHo6mTxd
	pkTKCPYwyXl5BUeUrsEmplmGx9wVE//V6rgMnH0lIMexMdIB8Hrnx2AbIO331Mewmf2Jw7qdPX7
	3tnYO
X-Gm-Gg: ASbGncvyA+RLCQ0bX4FFcLs9gcjb28B2EwbHJuDJ9mKiGqtMGzmHlGOZMd3YFkdMXA5
	o/h8beLCpP8EBig73O/rSNIIL4aHsqYcdpdMK9HnGv1si3jTJ9FXDWYr6w4tblhkjVs4T6KcxYt
	P5RWoy8cqmvQqXyrWqEzW7tnPMgcO3T8e5PxWuWkiacm7lAZVtaGG+9sNhsLfdyz+BpskC2KXo8
	6HLkqbqsY5TYFTbdRgR7LypEwyiM5tj6lHAJ69scPPv25OwQyyKvt3RrW9pb0SUDIlBjtG2TGdz
	EUtiTlnQ+ZQ6Aolap4aC3aVzw2QdpYzqRFK2cb+M4v1q9oiSLR/baurDvEwJhLsTlac3SJiZfNq
	jkPFyjYWktrcH2+G7p+vdx9jKjyjCWAs0vsP8iz9cIoJIbsy/5pq6n+JPDo8yRkjZaZRqKLlUis
	Y=
X-Google-Smtp-Source: AGHT+IEjb/2Ecpb+kxAH67VL36yellRdOhcyrwFdMWOILwnY1/hcnVkn+GO8YTuvm1LTkn3PqL6oYw==
X-Received: by 2002:a05:6000:3110:b0:3b7:8d2a:b33c with SMTP id ffacd0b85a97d-3bc68b89bb2mr5015330f8f.18.1755507274964;
        Mon, 18 Aug 2025 01:54:34 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3bb67c902dbsm11987438f8f.47.2025.08.18.01.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:54:34 -0700 (PDT)
Date: Mon, 18 Aug 2025 10:54:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: FLAVIO SULIGOI <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org
Subject: Re: EXTERNAL: [PATCH 0/2] backlight: mp3309c: Drop pwm_apply_args()
Message-ID: <5i6t3eoockbq6kgu4n2jq2gcrzt2mmippc5oeobmfcah6zzf6r@jp6nqsgnbifv>
References: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
 <PH0PR22MB37899F7A6262C599400AF912FA4FA@PH0PR22MB3789.namprd22.prod.outlook.com>
 <lv6otiqcqa434anam2gx4czhh3jac4stlkl6w5aasqlb5c2ohj@mzvf4gc2bxsz>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="muofh3xiwo3yopfe"
Content-Disposition: inline
In-Reply-To: <lv6otiqcqa434anam2gx4czhh3jac4stlkl6w5aasqlb5c2ohj@mzvf4gc2bxsz>


--muofh3xiwo3yopfe
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: EXTERNAL: [PATCH 0/2] backlight: mp3309c: Drop pwm_apply_args()
MIME-Version: 1.0

Hello,

On Tue, Jul 29, 2025 at 10:17:20PM +0200, Uwe Kleine-K=F6nig wrote:
> [Updating Daniel's email address as the linaro one stopped working]
>=20
> Hello,
>=20
> On Mon, Jul 07, 2025 at 03:44:25PM +0000, FLAVIO SULIGOI wrote:
> > > the first patch of this series is what I really care about: There are
> > > hardly any drivers left that use pwm_apply_args(). When all of them a=
re
> > > converted to not use it any more, I intend to drop that function.
> > >=20
> > > The 2nd patch is just a change that I noticed while editing the driver
> > > that is IMHO nice. If you don't agree and only apply the first patch,=
 I
> > > won't argue. It's an alternative approach to what Daniel Thompson did=
 in
> > > commit 7ee6478d5aa9 ("backlight: mp3309c: Fully initialize
> > > backlight_properties during probe").
> >=20
> > I've tested your patches on my board and all is ok.
>=20
> @Flavio:
> A Tested-by in this reply to the cover letter is understood by b4 (which
> is the tool most maintainers use to apply patches from the mailing
> list). So there wouldn't have been a need to reply to each mail
> individually.
>=20
> @backlight maintainers:
> This patch didn't make it into next yet, I guess it's too late for
> 6.17-rc1 now?

Confirmed, it didn't make it into 6.17-rc1. In next (and also v6.17-rc1)
we have:

$ git grep pwm_apply_args next/master
next/master:drivers/video/backlight/mp3309c.c:          pwm_apply_args(chip=
->pwmd);
next/master:include/linux/pwm.h:static inline void pwm_apply_args(struct pw=
m_device *pwm)
next/master:include/linux/pwm.h:         * PWM users calling pwm_apply_args=
() expect to have a fresh config
next/master:include/linux/pwm.h:         * pwm_apply_args().

so this patch series is the single stopper before I can remove
pwm_apply_args().

Can we please get this into next for 6.18-rc1?

Looking at
https://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git I see
that the branches merged regularily into next (for-backlight-next +
for-backlight-fixes) still points to 6.16-rc1 and 6.10-rc1 respectively.
If that means I should better take this series (or at least the first
patch) through my tree, please tell me.

Best regards
Uwe

--muofh3xiwo3yopfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmii6kUACgkQj4D7WH0S
/k5rzgf+KEnuQYMq2SabE/BY/wyuF9VF4syK7d72kCDkixmZjqmu1r7iYVsU+8jq
7/IZ1zQPMOcpV5Rnj95HffihEaM+WvkuE9N3md2D1c7IHMB36HVKQaLkZ9IoT8LN
olUV+W6oMSiAkCRn5b/bnVzhe2xwjX02hrzQLyyEJjWa8LubFQ95fT2tFohjeDcG
MPQF+fHEGjZTHXFMwWA7lv+Fozut+k8E6rMLEVtLVfGr5mYCMkIpBUC5BVKa4tYS
dqbW9FqyW7gXry8+RIJSYAxGT2wxaSi1dknjgacPgZ/nOBlnZdUobyXNhTS8zsgt
7yTEBjqwIGBVy/6OgADbGlCjZLyrQw==
=jQuo
-----END PGP SIGNATURE-----

--muofh3xiwo3yopfe--

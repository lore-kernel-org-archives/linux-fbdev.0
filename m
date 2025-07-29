Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC5BA45
	for <linux-fbdev@vger.kernel.org>; Tue, 29 Jul 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753820247; cv=none; b=Bwb1eGGkXFnc0sceg2imu7SBjZfsgsdCHFuGOfApkYQpG3tqsYEhpEmPmhaJu6HHba2o8OOrxXc9ar1cQOS0EdJj9hNOaBoMILGzr0iafOFPYPGZhlguvcPj7kT2P4xC4BMiSUvRUFJR3nZZ1nS+IpfjTe5/XNvX5F+33v8t4kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753820247; c=relaxed/simple;
	bh=WV9Qd8VswLll4F/W1lnqlWzljnHTNQ+aOkT7Q5f8HDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmVYtAt0ruks6TL6rhHSnp8j5cGN5LgtzEa5PYJtjC1LntNO12g7hMAflYRsXcQfAtT8nKkszZrThaKmO4FaN6XdxcbF2yUkz9BeH8WJYSc8VjPLms2lq833mciTRBOQYqUeEe8fbZAzwgdAwXrNqfIdwjzu4jvQbWb0zIzJ5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hz+qrJgA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hz+qrJgA"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so468432a12.2
        for <linux-fbdev@vger.kernel.org>; Tue, 29 Jul 2025 13:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753820244; x=1754425044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WV9Qd8VswLll4F/W1lnqlWzljnHTNQ+aOkT7Q5f8HDM=;
        b=hz+qrJgAk9W297WtkxuXqNM/GUn7mOcrFPD/xijgwi3t6XZkISD6xTronVpcc6s6cb
         MYrJKSXcg0mwD5nh1iS6Ov0DdvfhuLmI/16t25hvwa0ZmzQPaIohB8W+aA3CjHlz1lvb
         CX7QHXi9oceNp5fsSN8TDPP6lHofLoQQT2iQZ30NQNpwhXDhcBzdy94cWStWl9NuPaDm
         WbR5opD4LnBLln7M/LroyvLC+3xmNY5pBXIyTFRPT9aw6vA5VY6xhxR7mbXWpe2RHT6n
         1YpRupn6Ktm5fR2BTxZRg8z0+ICUGFm4l5aR833kY2nEkN+zih3q+nojSDBtir6HRNI2
         IbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753820244; x=1754425044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV9Qd8VswLll4F/W1lnqlWzljnHTNQ+aOkT7Q5f8HDM=;
        b=E1c2t8DlAHTsTDDVYArMjJgE4gInakL8ElYaUSkEFzwZYEBcc9S9Z/Ph/6bogcwG/T
         BMAE1rtV3H+egQQu8AWRdnjCHer8fIG0iBMgQpZd/FH4lpS7aR+gPXZyJiuJnz8W5rpD
         QnoTk7MoBrTGnDHAP0P0eCWW7719eQ8OyU8qXeItgexr20i2TMNNnHe7fQAK+cT1MroA
         u36hxABHL56DObEkBXDl6tBcNt+o/2KZXVYy+U0U3aNN+VIB3w+haauEiDS3HFO7avmN
         CaSnaGuZ9YkipmoQWnEPj2WG23crUYlw2aETz11OQm8wLDS54+rCLrOJ6K3K84tiOqyi
         JHBA==
X-Forwarded-Encrypted: i=1; AJvYcCUhEc8NO8LVVdGPVhCAmBlm/lHhAeMfETsmqJtI4r/BZvYJhiA78vSQV3Lv2PbU0w5l9e+/g4NE08eCew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz52RI/tWrkPw/HchRFpAjKHjqE0uFHR64mjEX1NUn5q2C2ukVR
	0/2YXQ9BQmxKBmAkti5KB8km/hEDDxR2ephE5R8ej6yJN3yAoKayTZq66+eRmYADZX0=
X-Gm-Gg: ASbGnctwEmpReLOxeXOzOHEks4ziFw9E1c7AhRkO04idehOsuLDSDj2YzubACl2uVku
	EYjZoSyrcO/3vcfJpHZ/zB2hh2wejPOWi46T3a3Ht4QbBTi/7l9lSd/+Ej/PCCG4Z8awFsIMjiD
	ewsUfR3WUFdqRgiQyYZ6loKGLI1VXoMW6yYLfRlpGC+43hJ33PJkH/8GKfDEh/B98DsFNi3wcM+
	2+j7bZaTj+Nhpp8+Wtl2PMhDFfWLLgXH+F0bnioyZEfltEHInL6BZuXZ0I6HBZLqpEeKk6yGEyI
	0vFM6n0Hp0yCi7+0PJHQdMw4MpZ31NvvDKiruO+mn7nLCxCnsTB5QR17/SFzyhcSakMywDkM/Pf
	8fTgRNdm1I4UL+9qmtYf4DS8Xx2ShDi1NivqPZg==
X-Google-Smtp-Source: AGHT+IEFcub92jjAML4HPfzljPRcZ/77M1VzhjyaMyYsWNiY6ZAsBgO9tT8uZc14CT8rztQkaVJldw==
X-Received: by 2002:a05:6402:3595:b0:612:a77e:1816 with SMTP id 4fb4d7f45d1cf-61586a81e8emr904905a12.0.1753820243958;
        Tue, 29 Jul 2025 13:17:23 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61539ab9188sm3192426a12.26.2025.07.29.13.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 13:17:23 -0700 (PDT)
Date: Tue, 29 Jul 2025 22:17:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: FLAVIO SULIGOI <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Daniel Thompson <danielt@kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: EXTERNAL: [PATCH 0/2] backlight: mp3309c: Drop pwm_apply_args()
Message-ID: <lv6otiqcqa434anam2gx4czhh3jac4stlkl6w5aasqlb5c2ohj@mzvf4gc2bxsz>
References: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
 <PH0PR22MB37899F7A6262C599400AF912FA4FA@PH0PR22MB3789.namprd22.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ndpangs3ennqytsz"
Content-Disposition: inline
In-Reply-To: <PH0PR22MB37899F7A6262C599400AF912FA4FA@PH0PR22MB3789.namprd22.prod.outlook.com>


--ndpangs3ennqytsz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: EXTERNAL: [PATCH 0/2] backlight: mp3309c: Drop pwm_apply_args()
MIME-Version: 1.0

[Updating Daniel's email address as the linaro one stopped working]

Hello,

On Mon, Jul 07, 2025 at 03:44:25PM +0000, FLAVIO SULIGOI wrote:
> > the first patch of this series is what I really care about: There are
> > hardly any drivers left that use pwm_apply_args(). When all of them are
> > converted to not use it any more, I intend to drop that function.
> >=20
> > The 2nd patch is just a change that I noticed while editing the driver
> > that is IMHO nice. If you don't agree and only apply the first patch, I
> > won't argue. It's an alternative approach to what Daniel Thompson did in
> > commit 7ee6478d5aa9 ("backlight: mp3309c: Fully initialize
> > backlight_properties during probe").
>=20
> I've tested your patches on my board and all is ok.

@Flavio:
A Tested-by in this reply to the cover letter is understood by b4 (which
is the tool most maintainers use to apply patches from the mailing
list). So there wouldn't have been a need to reply to each mail
individually.

@backlight maintainers:
This patch didn't make it into next yet, I guess it's too late for
6.17-rc1 now?

Best regards
Uwe

--ndpangs3ennqytsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiJLE0ACgkQj4D7WH0S
/k62qwgAnN30pyYbtWid6YYqnkI/SakoRr8lH8xnQ7FpBuTLizy1TJ+Rq5QPBW9G
OHoyHIkdXLY98NluE1dEAL4OhwsHkKOtuU2LUe+d4tCvANSdr3dSuqf8VGkwtrvH
hIVM2oiS0gGNdfvBHmEJ/TTd3Aw8bif3F4L2zkwmOGruxi6eAkh+TXkOXHkBZNXJ
wdY7mjnO6XkXB4OG6cUvX0N01zRjxtT6Bv+NQcLqnQL2n69erh9XmFvgMPBwA5v5
aPURv9W38wM/QTCGrs0H56lnCFFp4FJy1w8P7CUnSjnhvqhCs6KbyTt1VD7eFX9K
MXDbvP6A5jwrE/7msBl9s7d6MIVqlg==
=tAXd
-----END PGP SIGNATURE-----

--ndpangs3ennqytsz--

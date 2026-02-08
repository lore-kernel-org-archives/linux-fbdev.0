Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6787128CF77
	for <linux-fbdev@vger.kernel.org>; Sun,  8 Feb 2026 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770572895; cv=none; b=Jpm7ZxQ0xFIQdZb4vb6NO7BlPPWPlkPcdBFuJSxPB69H2f7xXAHOILgKFEUljKUx87ha1si9vLbdEngiZVEKmQxBb6sCxaAJ8auwNOYEeeSgD/R02EEdKcuvtACtHUtGYxPO23nawbxjsPGazRiZ4WdM/YSR5L8ICC7RSkuUfxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770572895; c=relaxed/simple;
	bh=sUs5p7JMAmpzI2X8Lgr9Uays7xQ3aL3OdYC3dAwrnJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsohmjW6R2x9ZCLxcPVXbvCxF5SBdec5oT4Q0MXjgeeUJsi1Q2dbWCpBVz6/peV00IgFd/ObuDq7yhneaxADPBu73s+ZazUP2pPB8ID8TBImCLWlz+ebp2qcmXnkrHqfEEb33+MeRggjb0lS5UaZop0bo3QLu8rA+E4PIEEUfZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AOypTnft; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AOypTnft"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47ee07570deso19263035e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 08 Feb 2026 09:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770572892; x=1771177692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qVxkLTNVEDSTdm+aBk1/2i6S8/IHNFf2q2LyNyNYpH4=;
        b=AOypTnft5ZgfxBYw3JwdMBXRxiwlah1r5hkbuvyF3ZXNIuuF0xSrX7/oPlaNC1h+5A
         phSiDleBhBPcSxLZar4g6oecSFu1BSpfKUrc9AC1hG7ZzQpW+Wt8IAqWrzcH5ikMUVxC
         JFjo9F3TvSgTfdP7Qb5FGclOg9gU4na5R3cJu1YZ//4cgAjmH6LlniMXPm1agOTJbdmv
         Gk2Kq8XhkR82nsNBhwEjBxNhSXb1a5fAn9UtWAFC6PL3tZax26BleQEeyM1OpseejJBi
         7nKPhKQiv57wzBAVHw2lYAkIsilEkgMaiL1Ev3xeVFtoMbgCCU8AIUT5LgUYnPkKbGod
         TDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770572892; x=1771177692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVxkLTNVEDSTdm+aBk1/2i6S8/IHNFf2q2LyNyNYpH4=;
        b=KJbSwsT5IqeJYekpqPofprYUG95C82Zm3LI7E6Cr7JLbC1trSOOKqV9SMgplirkvx7
         JhQ7swlMwEMCBXnMDs/naxFp6E/Ex5hQEjZdn1GZWFzccyEp0diVde2k0iW6IPWo7Jm/
         qyuXDWOXGMOFTewlzKctmD/bmd/A8HRcLnp/GiDGcxR+AONSvL34kVmGx8L/nmmPCvSh
         aCCkZwdZJmaypuOWrt6i9AaTdHwQrIjtPIn5zejVvxaY7wKoKKDTGu8H6kGvY+K0VcNG
         1Om3JMur2uC9FE+NUT4o5PwAO90mBR2hWQ9WTkxYfqtRYEFjNL873RWnGRoOC04V/6EX
         FJeA==
X-Forwarded-Encrypted: i=1; AJvYcCXIGz5nut6A/YFg0EtmRAe2Qs26W1nEUkwkL6s2U+QZT6Tm8kXJ4c5R1+ATFjqc2XT1bBC2pFmXGmdnkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyECnJojDYHZrYJYeTglMJyj7wl2tuLSM7dQy+IjFPCypT+jVmx
	oyX6ptULoy5eo9JyXlRnCdMUDsFcwvgii1JVSV2wAfaA1lw6vYJssk4c8OvirRM8EjY=
X-Gm-Gg: AZuq6aJ1MmLSJVKwXHJ2WJWcPBmv/3Ec1yMM0uvaWkAdS+zZSyU5QWPsKVc96cRpPrK
	czJpoBC0Ub/RpUOXaZuqWhecH5o5nJfSxNP9lcK7zn/3bG5ci7Pmt+DjlKtB+pGNYPBnIueTr6w
	SZW1iw/gCt7iR6OJ7cTpjO4D5BH615spuqoWbH4+UMUiSg6TKROw+fswc4BnqZ3XzfXsuDOdnae
	/x3dtuygPuXY6XSvDp20jg9F+NBcMAaBaMTvcCW1WUtAvvX9CV7JFHLnFQfvxF83eVu+YjY34x/
	vePe94MsNiZwt1GJ7CbTO3Ewki6tqAcdhGd39YJM3zYIgchur1Dnd36BGSs6N3BvkayNB8nqhyg
	xx8pRlijAm0tiOzEiuSmvF0Bj++FMG7b+Vo0pumDwwb7WH6GUT3oklMajDllW1irlDDssetTTlo
	/uSKRmN/kcRCCtfEj0
X-Received: by 2002:a05:600c:8116:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-4832021c74cmr132509965e9.26.1770572892294;
        Sun, 08 Feb 2026 09:48:12 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4832097e142sm70961185e9.8.2026.02.08.09.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:48:11 -0800 (PST)
Date: Sun, 8 Feb 2026 18:48:08 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/4] fbdev: au1100fb: Don't store device specific data
 in global variables
Message-ID: <aYjLX1uGMkDugm39@monoceros>
References: <cover.1770483674.git.u.kleine-koenig@baylibre.com>
 <0e1ecdde447dc32816f1f066812ec8e84b4aad0a.1770483674.git.u.kleine-koenig@baylibre.com>
 <7334e2a2-d71f-404c-b2b0-170a7117c0c5@gmx.de>
 <aYevgJ6cfe6JVlJq@monoceros>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="spaogm5g56oxtz74"
Content-Disposition: inline
In-Reply-To: <aYevgJ6cfe6JVlJq@monoceros>


--spaogm5g56oxtz74
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/4] fbdev: au1100fb: Don't store device specific data
 in global variables
MIME-Version: 1.0

Hello,

On Sat, Feb 07, 2026 at 10:34:21PM +0100, Uwe Kleine-K=F6nig wrote:
> > > @@ -559,7 +554,7 @@ int au1100fb_drv_suspend(struct platform_device *=
dev, pm_message_t state)
> > >   	clk_disable(fbdev->lcdclk);
> > > -	memcpy(&fbregs, fbdev->regs, sizeof(struct au1100fb_regs));
> > > +	memcpy(&fbdev->pm_regs, fbdev->regs, sizeof(struct au1100fb_regs));
> >=20
> > Although memcpy() was used before, isn't this:
> > 	fbdev->pm_regs =3D *fbdev->regs;
> > sufficient and better?
>=20
> Probably yes, that's a separate patch then.

Thinking again: this is copying from io memory. So both memcpy and
struct assignment might be a bad idea. I'll keep it as is, this driver
already occupies me much longer than I intended.

Best regards
Uwe

--spaogm5g56oxtz74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmIzFYACgkQj4D7WH0S
/k5S8gf+JqZRaaFc9xKL633QUtFt//Z+4Wyti4iKrtYDkeJAvUA0yAeNksku8Vfh
PHxP25/AY/5swCHs87aAZ28SOgqmkuc2MsQKJWC3g0Xb7i2cgTA1jzCBbHjWydvf
A7YLK0JL1phZSLJKS1gbZ7vYj89gnFq+tc3FJypJoTtU9mmeWneB5ewwUanl4/Ul
wu1+HGhqRUxH3i4iSNAADAG6TyNKn3GI1JYchEV7ANMUrckUOkOmOEHkXTSY1TJx
lHaWjtbib9QzNH0a4Rg/m/KS9pqRWZ9Fa8jG+FSVoAM3mOttEJG45fGS5Ox0ihej
f6WoMhxaGR6yusQgM244g2/U046wiA==
=l4sx
-----END PGP SIGNATURE-----

--spaogm5g56oxtz74--

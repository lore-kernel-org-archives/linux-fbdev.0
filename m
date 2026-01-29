Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3069637A48B
	for <linux-fbdev@vger.kernel.org>; Thu, 29 Jan 2026 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670844; cv=none; b=qGQ8ywEEg1VR5IwQqHj0tVONgaqj/GCLi7Iwhhg8l3M4A5AFloO2AoBMJRQCmusW6Yx0vLsF3puCDgb2EKkBzEXOmC9IwCdhSeIMpYFmnRZR1jvhjbw4TGJBiQBst58nq0f0nYPkQYBu0v2BG5T2Ozre1tsulghfHcluCFTBEXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670844; c=relaxed/simple;
	bh=L+F5CpBXR6il9Er3qZ+S7/cbqloU+3ySb0pfp/IqRj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfIMRWUijCR2KvyOE7gihSxSdknThJTHW9VDNn4HhbxhuOCpjxhVcy3nWOXVWBQrHgfXUZmYXgxGgIJGdLFXd+0eKECZEkahsgH40Ix1fdpgUK/sFczUz7kzcES8ttmWI3hL9aIuXXQ/5MSj09880BVTJ5oLuYmwfmXcqzoV8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RwVxlhPO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RwVxlhPO"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4358fb60802so345373f8f.1
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 23:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769670840; x=1770275640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+F5CpBXR6il9Er3qZ+S7/cbqloU+3ySb0pfp/IqRj4=;
        b=RwVxlhPOD8RGHGzWuq8vP3lSjH+Y9+XvK+NIK/opSM5h8k2tInN+OrO0AKWriJq7Q5
         ddWado+f16CuZh8gl7+vGJcjM9UFWk/WO+SdUwwwcpcZ8zzDJ6CKWM/bGxzUeXNWXWoO
         fX6NwMeVHEiqr7o8EaQ7o+Em6KA4MhRjELVv/6LdBUzXZ1uEkBpYgt/u8o5mUSILfmn+
         YlsH9aGy2Y4rctuqiow/3Qn1pm01qq/sSFx0aYpkY8O8uF8tA9pFirS40RRQcBrQ7IK8
         8uSxl7LvW6TEDSYXoW70wnaQwlQ6KkngAyAXOgLOLrDCFA8c+Ep4NpsMNTo/bxTclBlZ
         ggJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769670840; x=1770275640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+F5CpBXR6il9Er3qZ+S7/cbqloU+3ySb0pfp/IqRj4=;
        b=f/8W4TmNdCf4r8tU+Tnstq230IXOfItPeTRvHQ+eAG84ljZm/sIhAt1OB19Q3uM73U
         Ydjg9FNPawGLDbmnv4gBnFvtnOnFJXmoqISbBgJ8yfg+S3IIsC9DThtswaJOR2S4mbBH
         ExyHHnSxaPnOHmiPYForfwonNbTvyvwwmUGwp0sx8yByZPRUVLQh9IDx/pe0HwdL+tWQ
         EHTArFgY0Rlu58sF1ObwM1ibShL8USfVWeWenNpP/aj7CjKsKM+3kc7dej7GNzJF5bPx
         39Tp3p0SVcFS0az25e4RowLP4cCv4wSAJnm2nXdabz8Td0TmievgroMgDJVofXbNIav2
         r+uw==
X-Forwarded-Encrypted: i=1; AJvYcCVss/PGVe0saSKP2TRfsprRgm4VGk8Y4M0u9gssDModZSwUI9AISwagaPYLd8P8UKE/qkFtk2MnZjG8GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg0LcmDBIa+5+CF+NUwai9n0BMspsuww9v0qbSg1d1reAsmqPN
	BPTrGLwGnyWWcVufWvVvWRnHpHdpaWS2cX6SDacuvlLq/5E3KZvJVqfcTeCeoZSHaNM=
X-Gm-Gg: AZuq6aJR5aucMe4eq3Hw0c1kgt+9TXOrI1U1ttbSBMJU2R9x5MZ62ZuKEJ+PMej7uiJ
	WSngvzB+25+LRYreS405Nst+uTPRaqEQ91ZUfNLnHXvWFQlXoqRHxgiX+0/sceHbT5qs/lKOlET
	vl9eAprfTcIv4c0TOB5Ra34FFEXeFu5l/WXAJ7CwHBJfDFjgeO0J9e0PjxIua3ZEwoF82TVDjKw
	y9c86+35dFH6vsJeyaiIakR9/INqMBkt50t3+vEB79LcHKBn8jd7PJbHj2PKhk7xhE2b5S+ijjB
	DgrTez3bsXCSb4KW49u63npjsfxOt2RpKGIHtSucT1Oc2YFjomOQp4ljkq2bInOJ9tW2k6trayI
	ATVBSrM0dbWznhgPsJ48VD7IVymw3lPBuwBvDHijycmdGWh21uQPEka6WQ5pKqp3U7hhWWIph4v
	WGCKP7GRZYnpO60CVE
X-Received: by 2002:a05:6000:402a:b0:435:932e:f924 with SMTP id ffacd0b85a97d-435ea0645cemr2617818f8f.2.1769670840219;
        Wed, 28 Jan 2026 23:14:00 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-435e10edfccsm11615181f8f.17.2026.01.28.23.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 23:13:59 -0800 (PST)
Date: Thu, 29 Jan 2026 08:13:58 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	elfring@users.sourceforge.net, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fbdev: au1100fb: Check return value of clk_enable()
 in .resume()
Message-ID: <u7a7owvizacghl3kpk5zxrf6iurmvvvjnjnzqa43xgafxcmb7x@jsihky4phvko>
References: <zytpnyodschvn4mmpllxp62yg3o77hjl7l5nyckoxyuvucjyaj@xsxbybnyzd44>
 <20260129040714.2772522-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gr4u2xptyrvtpzze"
Content-Disposition: inline
In-Reply-To: <20260129040714.2772522-1-nichen@iscas.ac.cn>


--gr4u2xptyrvtpzze
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] fbdev: au1100fb: Check return value of clk_enable()
 in .resume()
MIME-Version: 1.0

On Thu, Jan 29, 2026 at 12:07:14PM +0800, Chen Ni wrote:
> Check the return value of clk_enable() in au1100fb_drv_resume() and
> return the error on failure.
> This ensures the system is aware of the resume failure and can track
> its state accurately.
>=20
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Thanks
Uwe

--gr4u2xptyrvtpzze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAml7CLMACgkQj4D7WH0S
/k5VfwgAgl6ASoju2yK6n3drvTVNDpTdikzxleB+4wdtfFDsC3uG7oWJxnKy7uh/
7BkY+1OVaBrHr+epWZWjbuKWYv5zfsdlhNRDdk/Rp63pWOfONNpi8IhFZTvrpoq8
SjLKyuj2RaYAxZ5kzODKlqvrzT/gVHcqesU1vBoBbhq+peUqCbEvpHKSYEg6Kccv
Ni98EAvyupPogf4+HMdRUH2/qDkZbaLZsAQdwEJyNPwCfJ+LeyBWCqK4y1Xn10b3
WjCBJfPXice0NhsTFWg4ptCxH1xfPbBeFvWtPQ1YrnnvGvlvu07emABAqfyl197X
O0dXbeth4EtZiRBR0ggjPGbmXCpa4Q==
=eHUM
-----END PGP SIGNATURE-----

--gr4u2xptyrvtpzze--

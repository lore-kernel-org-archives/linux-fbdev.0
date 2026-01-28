Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96932364026
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612152; cv=none; b=RwQmKIP+jD3JyvCreU8FMF8uVGYyRyRTUKI0nXtC5JMeWp7Eoz2vBFsGe9KHhHkxkZAplAYwFaOr2Eo7QYtD/nZpEFZJ6l1zKpNlOl6F6rTSEaY3WT3hi4c/I+0yWkqVh2YIFAfh/czj0Br/iofgvDb6L1eMCCjK+Fm8Ptsm9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612152; c=relaxed/simple;
	bh=qJrKUXnOdzqLtrI2Lv9P/C8gksIM1/WMbB90SvmCs78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+clGCAVVRQ4lHy4/gozEkcCs7IkWQ2q0Fhd+ERM212Sop4uUaYA2ho3/LBv1eTFzm39KRJRRVSmSHZtyH7AO+kTu5/MdGGaCZ/VcYuEdrMHo5tshPvFHMEFn7TAPWUr97NUp2tkn6Pe9D+pQolj+GrU2G7Px+3KR/f+0a70zFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tLxDbNCL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tLxDbNCL"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so10606355e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 06:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769612146; x=1770216946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i42N5v7By+ZY86n8VpHTlNhVXeHCr4/OH8RItQTbOSE=;
        b=tLxDbNCLLQhFdeAxCWkPOp4aLdeL+r55iLs/bX3a3Eq4fFjK8q17+Bx4MS6+2yrWCs
         jLHJh3p6wI2xZIoqffx5V7VpS4IjXsOH36RBVzcpUk+2ibl7Zz+lu9aP0eNx9E3tILtn
         HZFLy12ry9YEfkVPYlvHdElxabBImG0CX+mkN28tVpyUISkfK0GLTLDOBDggdaAy673a
         HJUPo90zDyLp1HweCNR62lOC/PB3AAYHU/32/fTwqvxYKj433MH+9yZnT2PZFfzFGSIS
         IP0kNV6QnQVBdA71HJYhgSSVytywLL1D1fPThaxPYxV9xM13PTh7nJybaIcKss7eNZgh
         vSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769612146; x=1770216946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i42N5v7By+ZY86n8VpHTlNhVXeHCr4/OH8RItQTbOSE=;
        b=jiOY1Ra3V6NDIEqsILwW6lZSBTEv8xdc7t5e3i7uHv1QDOs3Zzz/tt07PQtjNT27Z5
         juYZHfhpL1LUphBO0JaF1COrSxEPSMyfTYe35g8lyMTFPpwcYHLirE5WEJctXpHyl8Mq
         0hJxBwsWbPcD1bVWN3BnDeTx/v0z63WG/z3nwUQHb14w14j19HgZlQfCXoIXMIJwt5bd
         udnxPWFTbZJit8DnCOV+UQpRAptrk4WDM8C49WYq7CWYtCYPVxj+kGUM+AbVI3ulfMDG
         XN5dVPKmLCwCA1B0RGbjuo5MB345r4zXZ/hWtLo4orccplGArnaaYKeto1CSg0dIXkGe
         9rIw==
X-Forwarded-Encrypted: i=1; AJvYcCWdLtAvzaF5+ArQIAtbxZTbZdGZlJOSiWzvYwy/nfrCGAYJwvAeWOZOtJSAesbDxH0RTUTxyOf24Ww6tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymHD4WydLJJ65Sm146j3V03VcA1TVqZfsu7ByRhKHfeLDFvBwi
	1t5jtThB2fxb6VSIInfFDJvQv49m4wHdZ+vKCbzSND783kpzdktOvZTdjQ0cFnDU+V8=
X-Gm-Gg: AZuq6aKDs8+kTAbqpmzrfLenrQ0Tmq8sNUCmUHWyxDhG2I+HD/yE5xKDe0BhgAcpLMJ
	m8F9ggSu4ZPEjQKod4VHdTUnGnsAqQ0UGJgzyvyPybcwEyY9qKGcVRHcAjKNtNBr05deER2b/7n
	IRaR7C0vMVwGIitffQPOx/yDgcNNhI1PE1rj0fa3OKx0x7yh7mdIp9g1JzksU3q4Ft88uPCYQp7
	DuGL26PSQucrtHmHsxPqgS8T5qqzON3UxOubO+hqLMGhYO2z2+YY1wiS5/nyfhH3NsFBUWvp6N0
	SJOSznlp4rfJO+5VTd1SdTOwVdq4VPFpv1Y7+/9JpJAf1XOsfcJzjbJxvtJqn7OYaksNpI7ijHP
	YlwKph/fBHItbzK7HTaVV20h7aFkQiI7iN9etmr0MMZ+pOWe4Z7WsJABByNfX8MjsYOrDBz2C/S
	9qsa3jiOqrHO90sy2XoVMMNVxKUdYD0tn8GgKqrDBK/7etwqII4p6VMPQkxX6fRdy4jwSQTPX6q
	A==
X-Received: by 2002:a05:600c:6748:b0:477:7a53:f493 with SMTP id 5b1f17b1804b1-48069c5b9a7mr68909475e9.23.1769612145949;
        Wed, 28 Jan 2026 06:55:45 -0800 (PST)
Received: from localhost (p200300f65f20eb0406c9e4547c877c41.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:6c9:e454:7c87:7c41])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48066aaf235sm132090615e9.0.2026.01.28.06.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 06:55:45 -0800 (PST)
Date: Wed, 28 Jan 2026 15:55:44 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>, elfring@users.sourceforge.net, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: au1100fb: Add missing check for clk_enable
Message-ID: <zytpnyodschvn4mmpllxp62yg3o77hjl7l5nyckoxyuvucjyaj@xsxbybnyzd44>
References: <20260128091004.2747011-1-nichen@iscas.ac.cn>
 <9ca6e1cc-7469-450b-a58f-9279412fb9de@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ib6mlg4lv6d3ff4d"
Content-Disposition: inline
In-Reply-To: <9ca6e1cc-7469-450b-a58f-9279412fb9de@gmx.de>


--ib6mlg4lv6d3ff4d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fbdev: au1100fb: Add missing check for clk_enable
MIME-Version: 1.0

On Wed, Jan 28, 2026 at 02:29:37PM +0100, Helge Deller wrote:
> On 1/28/26 10:10, Chen Ni wrote:
> > Add check for the return value of clk_enable() andreturn the error
> > if it fails in order to catch the error.
>=20
> Why?
> If it really fails, the screen and everything stay blank,
> so it's even worse....
> It seems nobody is actually checking the return value, most likely
> because if it fails, the system will sleep forever anyway.
> Or am I missing something?
>=20
> For now I reject this patch.

I think it's the right approach to check the return value. If
au1100fb_drv_resume() fails, the system as a whole will still be
up and it will know that the fb failed to resume.

With the status quo it will assume it's properly resumed despite it
didn't.

Still there are some things so criticise:

	- s/Add missing check for clk_enable/Check return value of clk_enable() in=
 .resume().
	- s/  / /

While looking at the driver I spotted another issue: There is a single

	static struct au1100fb_regs fbregs;

to store the register values. This only works if there are <=3D 1 such
devices (and wastes memory if there is no such device).

Usually there is at most one such device, but it's cheap to move the
struct into struct au1100fb_device, and if it's only to make the driver
a better template for new drivers.

Best regards
Uwe

--ib6mlg4lv6d3ff4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAml6I2QACgkQj4D7WH0S
/k6jAwf/V/KZI3V3blnkUAyYn5WOUUNFxqGteXW//6beysYog6Jzpb1C4mlGXCrz
n0fWqKVIY27RNNCLxI4sL1quIBg5vRMwsyf7IVbfHNYaxzRi4sKZfgnQy/tllR9n
FbnL5qqGG3K/wUF2QrX6ocLUWzb7aVJQUl2rNbISThQXQyMGYT5vs2l072QUUNpX
3kS4Z+yvHR7vGV8aXfOROrs/1jR7XtcWgkTGvzklOB6InxvlJEG083f7Ysqc8H37
w4tUAS5Obu7aXc8E1n8BYvllpWm05Vadpn1b7x+e9P6IsUXXF3gbH57RRyzBhhIs
32dWUnRSUh7TPqeDD6MmrcL/s7szJQ==
=/2It
-----END PGP SIGNATURE-----

--ib6mlg4lv6d3ff4d--

Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ED3374E45
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411866; cv=none; b=tXIikj5FBY8vmliTu2u2o1wxDnuJXlPRmWylWmxkEY0sC4bUf2aDFuZjQwTRnL8i0kw8KIESKpAul/sKrbKY5LNFo2JjvN0KlAE7Dh7uygM5uM59CMRJ5gw0rCQXZUSjlHe0BdaGv3fca/pTxWcUSdiTX04qWwhV1V6NDKJ6bj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411866; c=relaxed/simple;
	bh=wa93jje6EgHUk7Zt2ECfepwMi/iCuz+0PNAnYeWTQUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hb7NWPddDY4Ipqpl3CMxz3hj2BjDUPcF7CuHHp8sPVuUI48NVgCIGBuoISlfC+cBdA10Meq8LdUI1ZLhSSGKMxPEhkmTu7zrj3y65oAUSyjCGevcoLJ6p5oSBJsz9nFlbpPsF52jDq2GGbW9k/FuEBQ0r49BCqH+s7fhXI2Ifrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TlVkOKo9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TlVkOKo9"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso6097063f8f.3
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784411862; x=1785016662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wa93jje6EgHUk7Zt2ECfepwMi/iCuz+0PNAnYeWTQUc=;
        b=TlVkOKo9vf0EXi5ST7U97oZ/YE9QOwu/dXAcpCa4x1RwzD4nl9rVJSJcCqWgSkVFrl
         JPXL2aSk/AIxBjERmihCj7mP2ielysI6OdvdN5X/QH03LeKOPrCQxFtQBhaoDDI9qdbe
         eT9Aoa9x/Tz7cPcd29PPh/B+UPvWadMqYPjOtbGyVHW5Oas+HekerYK8peiXGfqIyRak
         5kQogHvp5tLZDzHLdbmR70pElL+7KsObKtjXMPfBNHpGXOgCFPo8fOum+JQ5yMiogE/Z
         aYQx2OzM3VxJmlcV384exK02GTApIYSt7J+zTekblkNAr2JV2DHyw06rxI6Ws/DPIbrI
         Dg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411862; x=1785016662;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wa93jje6EgHUk7Zt2ECfepwMi/iCuz+0PNAnYeWTQUc=;
        b=FPIiXRF8kmIFJ6QslBKlNKdi193hZvrnmFUgKYCs62IlsbeUBIqOXznOBawTqvxWXk
         WomYkYPi7K+qSj3Sf4+24ZXCEcUA40n8nbhh/oV2qxJ9J744/b4wgOtfWsYEudyHQ8pi
         cIoOHP1ZAChJbFqIFVExyqiArapy8lZEKXNUM//Lnv40fEKK+7/F1B4QgUXkjTv0sue4
         2NF76yswvPJMHpk+fRF4TivB8xbaDTiP3+vAt6IJl7Wznr52HUH1Zi3Zn4ewlqqedVjA
         1PRKDgQzgGrM8fRFijpom7MB+CNKB7Jnb3gsQPgoFo1VDLw3t4W43Jc7xtpeCqYQZQc6
         hEkA==
X-Forwarded-Encrypted: i=1; AHgh+Rpm9DvgM7dQ9/DUKDxcTDBeHkFbZ+3bQE2g4wtyY6JrgwoLMTzeOlYLsjyfGNuACoabdWsg8amUrsCykA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtyN9SlhTYOR11h8h9gFqDsl/Nxx5+B9hWWeBLhzWkK6POYbgd
	EzFhnIADUyBmTnIUUU3igOKv+4LGYmWCfm12o0lUovGObFBnpO1XmHxZM3XJiZjMglw=
X-Gm-Gg: AfdE7cmhOdWiQSCoPfM3z+SIBQFhPs+z6cfnKOPw2AuphDeilQ6QBbGQjZ65elLO8tF
	SKTaNsU+vgd/ED20WGOLl+l1kjQiyYxISC+Y/eln1bOC8XqLkW4VocXOWgKT9VFH3Qa7DfYi12S
	as4+lEOREyv2sNrevuFC/2rmDg/G363j4IK72ZdTpAVhvmtIyCrNiOYAx7muHTXdjYVfAvW7via
	piTGi5P1EjgOsG3aRubwLtpMOiVyr+AcJNtaKJWvaeJiE+Hx//qvB4srFDNJTM83C0cHob59LC1
	QvEw7KndNZOicBJOY7Ht3dU/UgQi6FCO9B7Fsxs+h8yZOmiMCLwlQ/6FQcDzvxU77ql2+DBIr3i
	OX+MKQGRldQsthsx3rbeNcehEBYNS3JdnTK9KDiYUFV0d9V8I93hMdPaXGXFhk3o0tY0gtyOZmJ
	3Mv4lzC+4vsfyI+c5hzg==
X-Received: by 2002:a05:6000:1844:b0:47f:4e42:669 with SMTP id ffacd0b85a97d-47f623169eemr9423338f8f.22.1784411862534;
        Sat, 18 Jul 2026 14:57:42 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f63edcd13sm15085022f8f.26.2026.07.18.14.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 14:57:41 -0700 (PDT)
Date: Sat, 18 Jul 2026 23:57:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: Helge Deller <deller@gmx.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fbdev: pvr2fb: correct user pointer annotation and
 sentinel initializer
Message-ID: <alv10qYL3K8_Tjqv@monoceros>
References: <20260713101638.600333-1-fuchsfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kf7otoxip247seh3"
Content-Disposition: inline
In-Reply-To: <20260713101638.600333-1-fuchsfl@gmail.com>


--kf7otoxip247seh3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] fbdev: pvr2fb: correct user pointer annotation and
 sentinel initializer
MIME-Version: 1.0

On Mon, Jul 13, 2026 at 12:16:38PM +0200, Florian Fuchs wrote:
> Add __user annotation to buf, as it is passed as a user pointer in
> pin_user_pages_fast(). Use an empty initializer for the sentinel
> board-table entry to avoid initializing a function pointer with an
> integer literal.

FTR: Using 0 in an initializer is covered by the C standard. Anyhow, I
agree that { } is nicer.

Having said that, I think the right thing to do here is to drop the
sentinel entry, because board_driver[] is only used in for loops that
iterate between 0 (inclusive) and ARRAY_SIZE(board_driver) (exclusive).

Also I would split this patch in two.

Best regards
Uwe

--kf7otoxip247seh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpb9tIACgkQj4D7WH0S
/k6qngf9HPcjOLFf9ebMiIVzfNiUMnp3nKAf85kikPbocb6uZIoVWVmOOAbdaj/C
Tt7C7ycDzH1+PbhZFJ+1x3bKOQdYwHpeejamFt/nD2ZAeBxz+9n3ffyHgl2A1mtz
NG5iP2KvP12HrLUBl77GyHrNRc8lSNQPDjNoig1hoD/BXQovkL+vHqmarxeGO0b1
8mM+IEnlVfafEVlywlgSPst6xDnp75HoXQeBxEn0URZosnkm5V6qQklbEpIYXc3E
MN5ANqf3R7WzP2B2QTJl/fmW5c3QwxhwBUrNHp4GPC3MQI6o5zYgfQ6Ma9RGsTEv
j32/Xe/K4MPfVPlfaJrPyCX4JjJmtg==
=FAiA
-----END PGP SIGNATURE-----

--kf7otoxip247seh3--

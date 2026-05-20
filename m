Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E43923BCE3
	for <linux-fbdev@vger.kernel.org>; Wed, 20 May 2026 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779283717; cv=none; b=ozW2FGVhMQp+/+ZEEFwHVZx0DbUcKaTt7gRXlxOGpzljJ1FJzPpAGoNEVLx2C+jQQ1pIdaRHVRRvoerYzcdOqLQsSzMM3JAJwGg81oQGVQ7Kt+DDGYdBpokVn3UXYiVrVQKq+mHuCBQXLxoTbS2DNAWeg+aRJ4wiqZTqkcd94VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779283717; c=relaxed/simple;
	bh=MZv+WasUVDmq0Xqz/NMHkKugwF1EzZfGXSZJYQ/rKTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yqc1fr+KDnXVpYxquvrKClxX9eu75SDZIQbUJ9wIopPJn3O72w1P6yExsRfz2xfVL+A7KQrMEEPKvFRtZdg5KAOpj3Qhd7i69IIhW46cPbDk9QXa0SPGrlWvuTKoJb+WXtfFQVIwA3mydCM3sV7mHenVhiumbm7IcFZ5UqYrNYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=OCemOApr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="OCemOApr"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ad135063so39437115e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 20 May 2026 06:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779283711; x=1779888511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YdRArgXhGEk4i+GZe+h4MUY32Lfiq4WFd9PhB4MWWT4=;
        b=OCemOAprg4uY0ollr+cQHgUdeQh4bu+vdEWOoJh44feBOqM9jUOxqoz9SmdYqLyE9C
         84pXYUFBJ2sPDuTVvGu+ALZBGpl6VtJNlqomL3h6rqIJhxEeTZelPCL7VWs8RbV6OVd+
         j0/MVVXEe58Y8TDyo8n5OfFwZJOIyHXptwqrDEhk+Dfu/qhYGDKPztIgYPIsLMX4K64B
         EwoXrCUR1K0zxVtQCA1cGoXMYbPtjDHLRveTK5T6EHBQI3JFagtO3Rg9EqPqYZ3fotwJ
         x7ceeVbnDfCF0KqdeXDZ/pq2tWC3wy83GSjBsAs71SrAkplV5pfFm8pTZb/tvnnXo+D5
         VXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779283711; x=1779888511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdRArgXhGEk4i+GZe+h4MUY32Lfiq4WFd9PhB4MWWT4=;
        b=bXxeibhz7KdRUXStXtyJ2RRR/ocumxASJV7Jc9mtjMATY1Xs/zkIUoDUPgCWYMXS17
         lyyCNsSA2UDDNkMjaDPAjUW2KIelda7yOrsbDPvmIwpNisvSS3TWPDk7Wp7YQUeD78yV
         uePq0MBcveLSO+c0Qgx/Qtbr8l0BL06Vdt1njGwvngmDpUtvsANTLY2GJMax3tSJA42j
         eAjJfFk5kx7fRVNqLpbbrLJmDNzFI1D5fm7rXpa0xp6uXoCuCCNyTLUQgGLvChjnyRzQ
         e0emlQrtkUBVzFR9z1BCDelW6LFnpodDsdVhxj+CdsHiSfdQNsFOnZ5pEdYeN9GQzFh+
         FWAA==
X-Forwarded-Encrypted: i=1; AFNElJ8TXVdq0dbLN17MbmATC+WHOBKepmdZzLuMnQNlPqhujfrHKcTdWvyQZvI4k1DWcJqlsZENc50H7472jQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7y+nrLe2OB5Rq/M1AIQP6BGDyrzhm1jVnCv7WWinww2uGyyEO
	BZgb14eUE4d9zFKd10PH12TXqRQxF0bitGdgrO13x3hEmm6guSTuKjlWEF7z++usfgM=
X-Gm-Gg: Acq92OGn67HrWTuV9HlfUosvH50aoyFcwWbZg5KeLEDtexg4GMVKlWZR60J1CXmGkkh
	R0RMSJ63ra21PlRmCWvAK874jJ6A+CjURDZl3iif5qLKqyaL+VvQiHYk6TqbsI9PDx3qpOdMBHd
	g6dekO7NVYn1nH1msCibbQTTwyqXsXe2317/E20hcSswtoN2aAERdTzl9weg3oyJrtG6c1/0wny
	8CQ5nRFHCa9UAqX7n76pC1xIv8HULFpCpZ+Ado2E2HW0je7faQOnjltUivVbkTytKQYeWU6+QV8
	2GjhRxr/K0/mEorHvIpz/O2pn+gmWMLpFyQ++sczBi0bfDhXQqcLn2EXmcjszNlWTBkAZsRgyct
	e4v1qJlkZyKWMx34zg9l3Tv9kjTD9B1QMM+VeWd6h8PIe4OmVO6opU95IA7FSPKYHvm3QZwWSnv
	g3KrghS5Y2ugV5VvVR0999Imem8QF0/Sotfiq7XQDOCh/9S7Bvj7zqJr7fYLq6X3nn4Nq2UN9Bp
	4JLNg==
X-Received: by 2002:a05:600c:5296:b0:48a:65ad:1881 with SMTP id 5b1f17b1804b1-48fe60ed846mr375342815e9.13.1779283710913;
        Wed, 20 May 2026 06:28:30 -0700 (PDT)
Received: from localhost (p200300f65f47db00000000000000081d.dip0.t-ipconnect.de. [2003:f6:5f47:db00::81d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fe4c8344asm671573025e9.1.2026.05.20.06.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:28:30 -0700 (PDT)
Date: Wed, 20 May 2026 15:28:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Russell King <linux@armlinux.org.uk>, Andres Salomon <dilinger@queued.net>, 
	Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-geode@lists.infradead.org, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH] fbdev: Consistently define pci_device_ids using named
 initializers
Message-ID: <ag22VfyB51APLhQL@monoceros>
References: <20260430111637.211336-2-u.kleine-koenig@baylibre.com>
 <ag1xQVCCzXkc_Ucu@monoceros>
 <6f1e1da5-a086-4261-aacb-f1117e22146b@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ur6redof34jxgqs"
Content-Disposition: inline
In-Reply-To: <6f1e1da5-a086-4261-aacb-f1117e22146b@gmx.de>


--2ur6redof34jxgqs
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fbdev: Consistently define pci_device_ids using named
 initializers
MIME-Version: 1.0

On Wed, May 20, 2026 at 12:11:16PM +0200, Helge Deller wrote:
> On 5/20/26 10:46, Uwe Kleine-K=F6nig (The Capable Hub) wrote:
> > Would you mind squashing that into the patch you already applied, maybe
> > adding:
> >=20
> > 	While touching all these arrays, unify usage of whitespace and
> > 	comma in a few drivers.
> >=20
> > to the commit log? I can also send a v2 of the patch with these changes
> > included if that's easier for you.
> >=20
> > Otherwise I will put sending these modifications separately on my todo
> > list.
>=20
> No need to resend anything. I'll clean it up manually during the next few=
 hours....

Looking at commit bca0e1973086919ae2dcd7b72e4ef5ee48858df5 in your
branch, the result looks fine. Thanks for cleaning up after me, very
appreciated.

Best regards
Uwe

--2ur6redof34jxgqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoNtvoACgkQj4D7WH0S
/k6hDQf/QmYRiZj4xogmbV9WDEP+x/E2ECzORIkyZD+45qdJTmD/Blz8kOhzvJz0
/EkAqyoqAlLkC772ihHZUjPshnDK3USSHcNOIxLqUoSOA9jN8NA9NfadZVMPllqC
Hvu7al1cPZOEt9hMTsqK1udc8XPdKkVsyfoStLkG56POcb+uKORAcrRsGjHoWxhR
x/6/r27m1hhMM1FdD+eHuN1lDOCB/tGLO1mTIqMxKiJBboBiOFrumDEz90TEpLMv
akJ6g/RxEAsQsJFGu5sj0H+FtLWoawj4QLxljR32XLO6Sn5ZUn4qcLJyr3+fXHF4
oBKqDxZM6lVNp2fpiG4EFeEQ+rISLw==
=dV9W
-----END PGP SIGNATURE-----

--2ur6redof34jxgqs--

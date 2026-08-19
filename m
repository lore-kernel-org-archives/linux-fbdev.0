Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E893BBFAD
	for <linux-fbdev@vger.kernel.org>; Wed, 19 Aug 2026 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159239; cv=pass; b=m8l25her0CkVPgYrq+wHDH3zasHFoD+TqYX8L44oUWg2XrEnxkS25ZpNXM4MBxIbnJG8HowgxhD5iKLbgGHZ9/03CGCBy/GZJ3Cwjsto0V9IxSMAGAPZGe4CFBTZE82LS7cNOCbK/7eLr13N3/LfATfo2DzCQziLKV8MIozpOOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159239; c=relaxed/simple;
	bh=fSAJ8Sb2eIq4+8sJL6s8v2TvLC008BJj5Lp/c0rDYWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKUKLNLVIVsKvhoDYrKScaMr1wHsgUKU+LnBjgczNpwMh5W7FwvJ7aEbr2gprP4DlCPblJ5uhbJDtC5K83Hp0fwfgnpR80rvh7nSzbTSUtuSErser7/P/YIHu5Wysh7iu4AsEqEvzGFFI+RBHtABejvIu3mT9XG3X0IY4R51kgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWG9Nh8A; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWG9Nh8A"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c20e70a0962so181429966b.2
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Aug 2026 10:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787159236; cv=none;
        d=google.com; s=arc-20260327;
        b=g66fHVeEfgj0HV1pXI+A22fROUR43QF88alew99EWAj612hiuQ5bLNO7eqRFEkDaCO
         10PJodsMTG+j8qGlP7CUj51I0U+pSFtWucbPK+AWj2jrL+pl+HzG3/j8yHCa0OO3IAmt
         4SjMd8avYxLSs6kG7sVjvWlp/a6b9LOhQZMT125LvU8VRVOmA1/X+/V6+gxR3R0n3n6z
         P0ePVeH02hb4RaOP0XySAlJwkEahusJz5DSu3VBlO7DdWCz97RhaL4+krzW+DM9Kbf4f
         XceqRsxH5Mp+X2GhZPTYAVIcmhNqxH/x22py6/yd3+W4sA8OPTuIbRG5yxEaqUoWWni9
         h4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jKlJ/iR1cPNwjtIJybzvfRzDBetXP7ZIN/hUGlzWzgU=;
        fh=7UImkuG5VDCZDMfUmh/N8YdP3zkcUaDKjIxMywzQECg=;
        b=nKUg4+egpZItO1wKRM0p7Vxe50AGGY3IiDXp6gKiWbKyiScLgkCHdr+kk2ulsfGiNP
         REXe/VYk44wTdxgNRBldYp7Pjcgl3UbvApLZMoYXtKe/eM7jKHheX/HJNUyEQe2YI70p
         5A84ceagYCnf4LXiAEvuKU9GvBRZJs34Je4QzLhOD3JXLmFdvXqBYptOTIAnmeO4V+tW
         rGNzbAyCxDL08Nxd8nmMDaNtpVgQm44jV1/djKUD5WEQuoRnJBQU17zUanOl3eYCo64a
         pL/mrXN797ejGS6Q6dU41kX8FgjvnEq7//o6z8aS9cTVo2ESE3tM88GYhBa9yXU6vRwm
         v6/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787159236; x=1787764036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jKlJ/iR1cPNwjtIJybzvfRzDBetXP7ZIN/hUGlzWzgU=;
        b=MWG9Nh8AZw+sATA93xtwmknqpyT5XU2JHivp1dPFun3aVlEo4pwwhndq+4eypwH/qV
         mK6ZzKAM4dSn2PhsZ/Nu4Vbe/NilF8qfJKYDIcDXg1jA0zlC4623ZjmGO0i/YQ6FpVUo
         g1AptMxfI8iNj6PnKdbEBKG+VFsE5VW6W1iO7VT+KMHMNjnsUPFPuCJrjhrVsvAMRhFa
         UwhVw7b7wcbbMGNqwj6QyHZnaqpxH3Q7YN2GyYQQ9ZcTgap0erAGcFf0f/eoqNyVgIIE
         yzg0OMfimSSCaF5oqoAWBQZlcVy2NqY7J9ruS4kLVIlA7Nd+k+fNeK+ixQj+nBiEVZcL
         F82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787159236; x=1787764036;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jKlJ/iR1cPNwjtIJybzvfRzDBetXP7ZIN/hUGlzWzgU=;
        b=a59iG4JqnXETLRm1474bZQiJnA2NwDFxJ0+JOS07Bz3MhVoxRtj3Tm1PjFUbsfjr0C
         MfLSzHbUYguFlaKBxTCoM8U3AYuK3dXDgntJ8c8Z5MmVAkODxvDS1nHflmlrqgMT03eI
         CoOELhpLhmEKf5JpFY/0zpj4vy2+zE7Za5vG71SGT2qhzRDxv5KN7278/H2fhPw+tVl5
         m2V/l5RbuFq7Oss+t9SM6wz+ZzFrrcT33WTtH+k3Yc7oAve5X9LmkErKvkYXo9PMtgo1
         yal8ANryQimxxwOfstj/xKEkQVmN0LkVjZDfmJs7ROGKmuKL+4iWZdz5VahQcQQKzDX9
         61cg==
X-Forwarded-Encrypted: i=1; AHgh+RrQoc+cx7Rk90DA+NaBX5nnG72v/bPvN8zzLBPm2UO4gF0hVkbqzTvZzu65BwsrERShuk0GrlnhCFTMkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1HFddvH4WuQ127usPIDDAGJHTjzpA6kOs6CD/lKeuaueRBWUa
	j2Ulgc14dnKowflJgk4XshNanTuMurei2auGn7eP4J216WUPd4aFwCUfxMUPuzsiKl+NmWmZLwS
	NuKS7MxoAWxvaZ/dBLpgbL4Mplp3MN5g=
X-Gm-Gg: AR+sD12f91nTyvxGx9B1viHdj6NU4opUTuVtTdb2lDRg7ao+Mn9JGZK49vY1OQ6oXFF
	gFHYffldwD9RzQYnDIw52+0jmNSQb2v/gBjr0cts/glL1KQrDtzIyD0t4qd1QXljuNZR334VziC
	lmPM3TTdVMWwtvM41yjRuKiHFzWwko6bSyVVRsQ0EoUvODdp8RbJBaUWVcfQpINLyyJzAbciZs1
	Dp6dm5P8aXUF6dYJpgpHvj1cYe5SftepfTKmE3dtV3jPTMY5S/X7WS9zxlnQWVQ14W2+WqGhMUV
	qzlNpNMVXQTlgAYCoejqXl6o7xKdDY9mLfbvTQMb9q7fCbP5IUzRPA5YijZdu9bE1LuBJwGC1fz
	OY4ojRsxjpLWUOe/6tm2bXEFT0Qi4xVSpiu9tCLQwSMTEpiq56KckNgX5F5iznv4NycKUUYhzCT
	V7FKWk1XoKeKA0ljnEUDnRDx8QmRIivg==
X-Received: by 2002:a17:907:d26:b0:c16:84dc:9607 with SMTP id
 a640c23a62f3a-c242e242a7bmr386522966b.19.1787159235944; Wed, 19 Aug 2026
 10:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819-fbtft-core-scnprintf-v1-1-842c0603634c.ref@yahoo.pl> <20260819-fbtft-core-scnprintf-v1-1-842c0603634c@yahoo.pl>
In-Reply-To: <20260819-fbtft-core-scnprintf-v1-1-842c0603634c@yahoo.pl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 19 Aug 2026 20:06:39 +0300
X-Gm-Features: AcwNN1XtphdklIb1Xh2EgzEMsoGcQxR0A6TVYdMP1qLtFEyfNntG_muiTXDLy_c
Message-ID: <CAHp75VcGmmz6EZYjG871V+sYmJn=iGOFxj+D1oe4rtguWkipRw@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: prefer scnprintf over sprintf in fbtft-core.c
To: Tomasz Unger <tomasz.unger@yahoo.pl>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 7:45=E2=80=AFPM Tomasz Unger <tomasz.unger@yahoo.pl=
> wrote:
>
> Using sprintf has potential for buffer overflows if the formatted

sprintf()

> string exceeds the destination buffer size. Replace it with
> scnprintf, passing sizeof() of the fixed-size stack buffers

scnprintf()

> (text1[50] and text2[50]) so the write is always bounded.

> In practice an overflow is very unlikely here: text1 only needs
> room for a size_t value from an SPI TX buffer length, and text2
> formats three small integers (bus number, chip select, and
> frequency in MHz) that always come from real hardware ranges far
> below the theoretical worst case for their types. This is
> therefore a defense-in-depth hardening rather than a fix for an
> observed or easily triggered issue.

This paragraph is not for the commit message, rather for the comment.

...

>         if (par->txbuf.buf && par->txbuf.len >=3D 1024)
> -               sprintf(text1, ", %zu KiB buffer memory", par->txbuf.len =
>> 10);

The 64-bit number takes up to 20 decimal digits, the rest here is 20
and one for NUL terminator. 50 is more than enough.

> +               scnprintf(text1, sizeof(text1), ", %zu KiB buffer memory"=
, par->txbuf.len >> 10);
>         if (spi)
> -               sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->b=
us_num,

For this it might be worse, 3 32-bit integers that may take up to 10
decimal digits + sign, so 33 altogether and the rest is 13 and one for
NUL terminator, so still below 50 in the longest case.

> -                       spi_get_chipselect(spi, 0), spi->max_speed_hz / 1=
000000);
> +               scnprintf(text2, sizeof(text2), ", spi%d.%d at %d MHz", s=
pi->controller->bus_num,
> +                         spi_get_chipselect(spi, 0), spi->max_speed_hz /=
 1000000);

Taking the above (and if there are no compiler warnings currently
present) this change is an unneeded churn.

--=20
With Best Regards,
Andy Shevchenko

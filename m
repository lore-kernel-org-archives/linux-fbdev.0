Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2481730566E
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411278; cv=none; b=A7dXTeVdgotx3sdIv1wrlRSo4PiejaMnyM4WPQ6onWCntoehNKwOfyCjTZFz4GuG9ls30PXCuSVgdGJ+EY3HI/T+r3DEsAql0w65v4AuK3EjezrHUhJb3YYTdaOsrzAtub67iIfkqIJB6IHUgZ3mdw7N3TNbjPqU2mHLeiakbt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411278; c=relaxed/simple;
	bh=LSej48dHmbtGy45nBhv0MbNaCCnVPoeB1r++WlGI0W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPJtapph5G7aG9KPONSUEYqWsrhS+iFAvQQbWcwbnn69uFoXPn/C94KsTDQYhAZ+tjH9t4NPBAS0KzmA6KFN15vOTkK+BoE+RidBkFhpRi6hV9lfJopjYVYQ0ezJXxMITTQzRECAPckzxeqRCyEdJg+R2iEzLl+3GdOZxhPHL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=gr4yElkQ; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="gr4yElkQ"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4758bd3731bso2211642f8f.0
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 14:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784411275; x=1785016075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LSej48dHmbtGy45nBhv0MbNaCCnVPoeB1r++WlGI0W4=;
        b=gr4yElkQxRKMTEdSowsfeHiVMXyt4TCAUj0tJpuJUvTNiyYqcJpk5Tyl5u9wQmCnc8
         t2IfJvCN7sKJQkWyKQ9V4N25a5LqmMQ2sRH4J14ZQwqGhwYmWbiK1jCZWOiRY4cewihO
         BQo7QnLibH8NTPmotrVIhY2+ymzAqAaExI4TeYlV7QT2/rqBkwWHZIFIjmLxj6jkWCeq
         dIxZjEVMfnJ+BTl1Kr+wUwQRjLGagexb1z8LPU3jvddArJT9vGbb25RxasDJnKLBICzm
         Jeu67852MtoSjC7xiWdVkwBn9cxiclALfmViEITrkq1Bgc6HF59XeFViM0oHOWlEE5LO
         t/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411275; x=1785016075;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LSej48dHmbtGy45nBhv0MbNaCCnVPoeB1r++WlGI0W4=;
        b=mkgrYOx+IuJWBjHqOfAIthPm9FptmDSN8K0fG0SjbiQTkkSQuchNwYk1KaGBDfFGqi
         FV2aPiRJB+ALGJC7hQJnWOhJy7SXajsccGUfR9PfhEKLFLVkZ2nUIt4RHsnSBphQTBkE
         ereFU8w92q47+6C1wxGnkUpvM/UstyvoqscZAOf09fxnwfcM89yBfNeM0B9L36cPeXQG
         PVBpi/vjsae5su+2AYisx7CSMJK60LLnFYlYfPRSwIX16HYgSmqN8gfX0EMeqF2lTV10
         pwoE0cDIpFhQj7SXSDJ4a+mWQX9I8X1pJirSmPp6eNod890gs/Y+wkuPeTBoJAu2IxtX
         lYMA==
X-Forwarded-Encrypted: i=1; AHgh+RqjdKnLajL/i7yHzU2TauSdiwbdndY9KBJNrdPFAyU7YrXjgNncX+ONWoKEEocRVTh+C2xAIilRsA0g5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGexO9IVBMJYn93k9BZVG9xFpFEUU6twRkHXhaXl8v5TWM9xTt
	bTPBGQ4CPR8LoikA0ETZ79yTIip1iOfynZTdg2L3Esp2kEgzmhTanjrGG2dCOO+k+Zc=
X-Gm-Gg: AfdE7clLHc74r2yNneSZ9PBntrEnLzSJoXzlfsWTBJ0VQACBduh3ypkR5tP1qB2PRUY
	4hRy0MCF5GY1cc058YpB/GNRjP8wSOtjWSzdq0hg/+GUr4vPx1dop4bFkKZkK8vYRLuL1wBp2Lm
	ZU/qp7O8Fs3VKzNXZk5FdX/1H11wfRWXz6SfIiwGIz3xFRZil3R9u+RnvojjPW0woOyO+oWZzUg
	x4k+hPlW6ZfmmgI5wMZVl3U9INhtiCLNNzPCMdtF0d9St8iJQnj5/Vp5sb84fubaq0JQpLJy3UL
	OWFzvCkS2d5/W3IWKhc28RYeCQiT14G8PQWh1uktE41Qpp9xXQfLT23QvXCS2/SAOnLAVqP9Lsj
	24fVlpoWTYs65EA6fVWPOnZ3y8YgoGRzf54adzrON0ZG61FSBetqe4OoJFma5frIMhKhk20yb27
	rOaXd1jbU=
X-Received: by 2002:a05:6000:2509:b0:46f:1b89:999 with SMTP id ffacd0b85a97d-47f5a676c8emr16623315f8f.30.1784411274957;
        Sat, 18 Jul 2026 14:47:54 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f63eeb360sm16216646f8f.34.2026.07.18.14.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 14:47:54 -0700 (PDT)
Date: Sat, 18 Jul 2026 23:47:47 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Kees Cook <kees@kernel.org>, kernel-janitors@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: fbdev: arkfb: Move a variable assignment behind a condition
 check in ics5342_init()
Message-ID: <alvzxjwBr1gxu3Eb@monoceros>
References: <36d0eba7-e78d-4a06-95bc-c97d9b91f8f0@web.de>
 <40d5e392-3f99-44c9-b30a-3481f60143ba@gmx.de>
 <550584cc-863d-48c3-813b-3a0cb45d9084@web.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f3fkxfadp6qkpugc"
Content-Disposition: inline
In-Reply-To: <550584cc-863d-48c3-813b-3a0cb45d9084@web.de>


--f3fkxfadp6qkpugc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: fbdev: arkfb: Move a variable assignment behind a condition
 check in ics5342_init()
MIME-Version: 1.0

Hallo Markus,

On Sat, Jul 18, 2026 at 10:34:33PM +0200, Markus Elfring wrote:
> >> The address of a data structure member was determined before
> >> a corresponding null pointer check in the implementation of
> >> the function =E2=80=9Cics5342_init=E2=80=9D.
> >>
> >> Thus avoid the risk for undefined behaviour by moving the assignment
> >> for the variable =E2=80=9Cinfo=E2=80=9D behind a condition check.
> >>
> >> This issue was detected by using the Coccinelle software.
> >=20
> > There is no "risk" here.
> > It just adds an offset to a potential NULL value (which isn't then used=
 afterwards).
> Does your understanding of programming language details differ from the v=
iew of
> SEI CERT C Coding Standard (from the Carnegie Mellon University)?
> https://cmu-sei.github.io/secure-coding-standards/sei-cert-c-coding-stand=
ard/rules/expressions-exp/exp34-c/

We recently discussed a similar case where several people told you that
the "problem" you fixed wasn't actually a problem. This patch is in the
same category and your reference doesn't match the code touched here.

Please stop to absorb maintainer attention with useless stuff.

Uwe

--f3fkxfadp6qkpugc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpb9IAACgkQj4D7WH0S
/k4yugf/X7EoA2Tt7mChQ8eG4wWf3eTDK6E37TtKWLPT3R1witunWCOP7nOhxZc3
D139hRqc3qXlbwDBHpZTY0c+y7G2EE/7aBrnnhF73GmWLJaSb+CQ2WVCbUuMJ4kC
qPGNY/7HaxPwlylhjJSxmeBt1JtxWDy6qAOgR78JEDzCVSN9+aWL5fFL3SFQOJhR
OjLghlkWaKckJbm//CWA3NLVNHAgFZq58ozqVfTKmXKmKqvYH+iARxU8+V8jfPyV
nFaA9mHT7NuhT+oLzm6orz0tQTgvszXI6SpaGBxiXoe1gbvexg+4MArqV19Gb11W
7j6X45B9ImkYY6zrD6JK3heICJiHbA==
=5CWK
-----END PGP SIGNATURE-----

--f3fkxfadp6qkpugc--

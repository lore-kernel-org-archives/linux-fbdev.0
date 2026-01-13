Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D37F163
	for <linux-fbdev@vger.kernel.org>; Tue, 13 Jan 2026 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768343661; cv=none; b=jSKBIxoBIVmw/sNctLj0wh+SzPX0ByBiscNdJtU9kPU1Mt9+jhacfZJzVOmfwOq+jyY44azuMnvqel+SxHhf34B4A+QmnCIBso0e/CNbSDHG0DyXpDWMIWSo5vAVcKCLKxvFQiBetDE2cCuHPTZDuDzB9iRYVhNOTf97Iccdelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768343661; c=relaxed/simple;
	bh=ca3sMZQ3yRnmRpkI56rIDFvF7bZ5BmR3/Uip6B9NYIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K09L5gEWzBs57kwwyKWyb21y7Nj2MgYnBXzjFDTXf93PumbVkj61gd3F/3YGuhN81mE2M94EpQnLqZBZNWo1E589zWZJ3byIkL19dpLe0eaNZ5rcV4/DOrV3Jx/+rXryWAX01aDauLX/qNcaKQBDDfI7nhGX1Ue0jvgQriCI5/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TElUoEP2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TElUoEP2"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8710c9cddbso432204266b.2
        for <linux-fbdev@vger.kernel.org>; Tue, 13 Jan 2026 14:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768343659; x=1768948459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCjGNZYzF+uQyqn73WJNSUS0xs7xih2Got5mg0iTccU=;
        b=TElUoEP2qww0mPCfYHA6crlEifQP4i9rgp+YQq0Fj6uacqyzDct0Mwh/7XC4nagL52
         BwhvoN0tWrGCkxqYyadn5Eb7Jey0QPp/4SdanjWEUdroV3D41xB29BU/9kCefiVQ0PrK
         u/ngm46GlIMguApacxf367CxJ7TK84fDT6SopmZorBnRvasqWMcHOospA2BQwejsZJfg
         muqwK13rBlY6fKlCojPO9P3PTsiBallbvZ5od6QZtQ0J6qjwTLrJIt2EecEIgei+Y2lq
         9glm+Y6nWHPfK1xYfoyJkdxdzADlsyNMhxedUSpaAsvMYDv8THILsirt3Yn79eDzkzHL
         nYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768343659; x=1768948459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KCjGNZYzF+uQyqn73WJNSUS0xs7xih2Got5mg0iTccU=;
        b=ovPAhRQtE/PAMvAcSW8ejELqTEvObqo+5hlw8bO5nvC3skUtuUX2cJFKfJnevpOCO9
         bTHihwBHEZlpft6hiHhtpWTllyzfscW3lJksCAjGBdGtJCaUI28pV8DRBVM/1BiQbLTL
         u47M+jkDy7N280a0FC05TToNm500+hBJpB34u0Gm2ZY0lT1O/0ML2pP8brPTVrKcLLBt
         ujkh2EPPA0svANsQtIwayFBRcjkSRwrUf3I+GPv+4iIStD/Y/Ja2DjZOdaNt39b44nNS
         RAsrdLAH5QBRyns71mrIrZOCjcpyU/XyROlZf2bGDJrXittQrkFDjQbZDi63pkWW9QoD
         A4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQau7D71k43jPJvvEtHg7/9ssVUPGAiiICnseTNJ3wUoeFFTW8ZpNjse3uohYwutJoPkC+RFcRUb1ZZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YysYPZf5p8pjLxbyGJtjN4LHanT/jg6SPw7WUO8M7nV+wA687OU
	4ejrm6lt3AFczu3f+788eDvmyUjjoBIPtScG8ozbpNzwqPfENhRQUZKIV6ui4DQTI70qdbLp4jA
	xjmGkre+bCVq5Inf8ktCDr6dvsONreq8=
X-Gm-Gg: AY/fxX6aBJ+ZtniG8KXkgEyYrnT6DmiRAdC9+kE4Yvpdqz0Y5AtsKINwumaAaapiICX
	cKwYJ8nypGRxfV6GsCsm97yQ3qzZGXEALj7WyvnpRCIMdrgsDXEUTIBOLwm9P3/HxOfDPtTEZH0
	U8hEUybHDDLOE0iwsYfV2QCfbjW9n/VF1ttpVmtW93vZM/AICpyaQImZwlUUslt6rroHOnVbAeK
	OF/yRlC4QqDKgcXEV1gqPbzeyok7sujFpi/hGUOGazI10/B/QiZPLWzbnH+DFjqbFWphts9w8Rd
	V9aMsmBuF8PeRvJ/agxkp3Jpgfe/047aYzCqC79sSV979V8Q+mCS+ogl5DMnvwLOFZCF7fU=
X-Received: by 2002:a17:906:6a07:b0:b87:2e8a:e256 with SMTP id
 a640c23a62f3a-b8761139c37mr65177666b.31.1768343658499; Tue, 13 Jan 2026
 14:34:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113221722.5157-1-gideonadjei.dev@gmail.com>
In-Reply-To: <20260113221722.5157-1-gideonadjei.dev@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Jan 2026 00:33:42 +0200
X-Gm-Features: AZwV_Qg-KjGT__tA_wPvwToo0BjLz68_JM46Yv5Ai0wR3NAD2NC4cBQyUjLnf7g
Message-ID: <CAHp75Ved+zhACJ9CYLYnkzW6Z52fmZT0VY+0NWKYk6O38HCkdg@mail.gmail.com>
Subject: Re: [PATCH v3] staging: fbtft: Change udelay() to fsleep()
To: Gideon Adjei <gideonadjei.dev@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Abdun Nihaal <abdun.nihaal@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Jianglei Nie <niejianglei2021@163.com>, Matthew Wilcox <willy@infradead.org>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 12:17=E2=80=AFAM Gideon Adjei <gideonadjei.dev@gmai=
l.com> wrote:
>
> Replace udelay() calls >=3D 100us with fsleep() to avoid busy-waiting.
>
> The delays are used in init_display() callbacks. These callbacks are
> invoked by fbtft_probe_common() during the driver's probe path. The
> probe path runs in process context which already uses sleeping APIs.
> This makes fsleep() safe to use in these situations.

You forgot to add a changelog...

> Signed-off-by: Gideon Adjei <gideonadjei.dev@gmail.com>
> ---

...somewhere here.

No need to send v4 because of this, just reply with the changelogs for
v1->v2 and v2->v3.

Also note, it's assumed that even for such a simple patch the time
between versions is at least 24h.

>  drivers/staging/fbtft/fb_tinylcd.c   | 2 +-
>  drivers/staging/fbtft/fb_upd161704.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

--=20
With Best Regards,
Andy Shevchenko

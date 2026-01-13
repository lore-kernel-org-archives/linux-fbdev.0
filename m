Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22780314A89
	for <linux-fbdev@vger.kernel.org>; Tue, 13 Jan 2026 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338870; cv=none; b=HJBVR1Z1fzJzd+ftmlfqatoZWc2s+10Z4MUbCPW3zzEgi6Kl5t5yLQxeI7UbOXC9eCZvm9vchymdBHdY+WKZFzTln000Bs3mekurXs3am0LI2Qh/+0y1IevH1bn02SNGbyBR06nSBWhIPi+fPs64u5omw7PrpIzp+AiF08IUlbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338870; c=relaxed/simple;
	bh=pQigQI/8admlpIuls6ZhRKbo+cO5u2/w2RF0qKuRaZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADfEGbgwS6bPtIertlCeTJPCgpr16kUOW82jSuGO6tJy2EAW7P+7u0w0CpEEcUrCyN/Idzkiz3LahZ+9c/8be0qYXp1o2sJb7ihJLjONCmSzw2jHM8biBDJTukqs7z6//isBVXmH65N3iV8GIy78D6EiYYZcJ24ljheApX6Gz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9KEit3I; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9KEit3I"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8708930695so486592266b.3
        for <linux-fbdev@vger.kernel.org>; Tue, 13 Jan 2026 13:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768338867; x=1768943667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQigQI/8admlpIuls6ZhRKbo+cO5u2/w2RF0qKuRaZQ=;
        b=e9KEit3I/muwX+8LFkdgP9A+7CkMvJzAOEi7FNAhf/zwWYb85GHAIVAnEoL/umd4Go
         s9rnzEzOzeP816eWmsdL3G8pwmwYi2SRPkfZHeflotwda6VEn0jSB6zdFn5Htq3jFhlf
         QjKFmq/8yLexDz9XWxmAsWsxyRLAmLDYs7yd7jqow0pXwDBkH3idoYDKYHy4ifFdOHlt
         Lqd4Rc4m81ICW6FRAgp/hawhGLQY0c80Wif4Sw24ss6u/zX4xRnZZov5Uapqms3T10PK
         bgWlRZUHU6v0uX0ruHGDa0GOjvCxUu36H9ON1P+agiEsiNCcCK1/LftynbrRC6k5XeV/
         fLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768338867; x=1768943667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQigQI/8admlpIuls6ZhRKbo+cO5u2/w2RF0qKuRaZQ=;
        b=EFla6JBHDsQj4/JmCwwVi+3Fp0UtoD6B2JDXvIAApWmwjTysYOtIygp8eQ5zYmrK5j
         Ez2jSvqHWm51Az09IZVqQLsHoCcK/4poFrDQlHBYbgjgKRJXs6OObL7ZSEpMapdNStfw
         xAzVCGPJ4PC8rQaSB+581WnGUy/BoALKIFXz5umzfTJqqqSnmlPveElHHZjQ4S26YF6l
         mnrd03Bnelv4dHXuQ09QXK7ZxNb1YJ6B6mNwzodRpWFy4TY0NZOxymFL+6KMLk/kHWnP
         t4aduir5q+AkJeC9zLKHlFZ41ZInafd5qdqWIvcH0RK6RqRf9ffMPdlFHw/fEX8j29kp
         HAJA==
X-Forwarded-Encrypted: i=1; AJvYcCW0CtS7/bCmnIBnvstzXLRdbtc9Nsbcj53FIX8G74VtG1ZeeMu4zl60ZA6J836WQIDlIFbwlxEOTFR7VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3pffIPqX/oUACSKh/K6Pry3B/qBXMc5LaljiT897ghxv/XGf
	PjQ9+J0NDeXYmfnh9Bh/pwAVnlB6HeRnAWYj1Fst8NdDE5WduEcBLwThQ5jbMLVuR0NlKXiauR9
	lBArD4TCWY9qF4h/xN5XYpemegMWDnkU=
X-Gm-Gg: AY/fxX49foA219Bi8oFzb7+m6T3XnkKxxtrlQCZ35fxtP3p6xKkqeh1E45qn8offxO+
	u6obnQO2qNCh/P1TmuMY/8vf+BNZzt35jnb8AVJ3gl8a/7W8Ll6SZYD9AOmqpPpmKtAjXyOURLt
	euOMMOrvkzKNMjY9zlxgPusyC66cnR4n303PVRv7qPLZeDo77rZ+dWalwyd3xrISVQUbVB/7772
	XHXZvodRVooNcITB7FqOrga01ufVEKoiC8t49zBdLJ/F4ytmiyZSx7Cdjxh21dv2debRXG4uMvO
	gJnHDbsHNctDqsJGD4XpSCtTJIekh5qCyvwXNPO7mNLwHzK8ZXKG+7DVQCt+UNqLZIURD3s=
X-Received: by 2002:a17:907:6ea5:b0:b79:f4e4:b544 with SMTP id
 a640c23a62f3a-b876103e568mr44161266b.21.1768338867286; Tue, 13 Jan 2026
 13:14:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113210559.3020-1-gideonadjei.dev@gmail.com>
In-Reply-To: <20260113210559.3020-1-gideonadjei.dev@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Jan 2026 23:13:51 +0200
X-Gm-Features: AZwV_QjOLtUncA12ujRVp-N3ahqpmevsE8icLNdM6IvrWboaeofcQ5aBk58-iqo
Message-ID: <CAHp75VcGTgd6T4p-5ceE61Y3CGQ4qriXh=VV3kBi=hEF9hNPWw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: Change udelay() to usleep_range()
To: Gideon Adjei <gideonadjei.dev@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Abdun Nihaal <abdun.nihaal@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Jianglei Nie <niejianglei2021@163.com>, Matthew Wilcox <willy@infradead.org>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 11:06=E2=80=AFPM Gideon Adjei <gideonadjei.dev@gmai=
l.com> wrote:
>
> Replace udelay() calls >=3D 100us with usleep_range() to avoid busy-waiti=
ng.
>
> The delays are used in init_display() callbacks. These callbacks are
> invoked by fbtft_probe_common() during the driver's probe path. the
> probe path runs in process context which already uses sleeping APIs.
> This makes usleep_range() safe to use in these situations.

Nice, now can we switch to modern API, i.e. fsleep()?


--=20
With Best Regards,
Andy Shevchenko

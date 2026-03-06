Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4083019BA
	for <linux-fbdev@vger.kernel.org>; Fri,  6 Mar 2026 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803885; cv=none; b=MqI3HiWaBGvngg72HfylKlgNPmXJo1NrHMaSAVZvCzWitKeXeZ4g1OZ69g33nHbslNVpR8o/Y1SNNNesUyU3C80NYsvc0UahWNXgmZ567sINrUHPGEZfObOMUY6fUzeXqyyOiX1VbOW8YOc5upOVtXmOTCnTh6m7aZPsAOYdbw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803885; c=relaxed/simple;
	bh=ldIMvkmPsb5Bw4Y3PSDxaM6rkFLT+r7UsDlUC8mHrgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULAf8lkTow+kHwSh5/fRpNTw3p0jV9x6YB2EHFNSnGCAcqbDQTHldmxjWv7/sDCrV9qK9pRDBN8k0eAEYpwVkGves4C8Vat7iOvcCH/szvewgpt5vVgK4hFCVl4PXGKt5G+jtFbMk7K/4BQ0NH+buEbjIfFp34JGKU5AL3/ufNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6nQDCFQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6nQDCFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313CCC2BCB1
	for <linux-fbdev@vger.kernel.org>; Fri,  6 Mar 2026 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772803885;
	bh=ldIMvkmPsb5Bw4Y3PSDxaM6rkFLT+r7UsDlUC8mHrgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q6nQDCFQve5/yKGj4z0BWu93rKBZekJp55sWTjh9gw5anWBV3g+4/rLskOvyr9TiE
	 SbR/538LjAht7Bt7Dn+H+DSAZcQBaaKfZ9Ltsphw07hMp+6Cdb4lUlZQ5sxJDhR0/k
	 X/EIjIhMtY4hWyWRohJjMWCY73LCKdlj5ZPHLu7M8r2oOg36Phm49hIcXqDaTY+Q3s
	 fKCOjvcFQNhRHESA44pA7vl6pMU9fpZubD4yXH7GsmrBJe3SE87uD7su0a3uCQLKYc
	 6UKUgO7+ZM0FtLxHsCgDXNiqYsB1cEY3Zj2h2ZzGepd/u7XW1QteQSXdnX6ZgmTMGn
	 2RSCVDg4azV6A==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7986e0553b0so79768287b3.2
        for <linux-fbdev@vger.kernel.org>; Fri, 06 Mar 2026 05:31:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMa9klAZHa325fX1fFo4uHNcEnRCS0WeNlDoPHBl8XDPPkIaoepJu1d0QXgbEsFEuDPm89sOkoLiAd2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUJS8Et84cgB8y3EC3AIUHZKC2vwCiyaEz+zNj1Zv64PdcbBn
	bmbcG5Gu/NME3/sedgBBEiZ/z9us0XB6NsBWwAEMReDCYrnBbhLHFC+5DRPxahlwnQdBPKLamqZ
	YE7tnyPK+sLObC5BcxcXbsMQH71u4JSo=
X-Received: by 2002:a05:690c:c4f1:b0:798:138c:76de with SMTP id
 00721157ae682-798dd73c6a1mr17108837b3.41.1772803884445; Fri, 06 Mar 2026
 05:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aYB0cRwmiIb0vVnq@aspen.lan> <20260203021625.578678-1-nichen@iscas.ac.cn>
In-Reply-To: <20260203021625.578678-1-nichen@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 6 Mar 2026 14:31:11 +0100
X-Gmail-Original-Message-ID: <CAD++jLnPM0gp_mvNZt0aTEO3Yd-9ecCnm-yR0qUg7OVX5LJEfA@mail.gmail.com>
X-Gm-Features: AaiRm50P6IlZFW70jZS4zHq_zkTuyRRtcOfUdP7ijMjnor8sOJ1Mh3HktFjQo2c
Message-ID: <CAD++jLnPM0gp_mvNZt0aTEO3Yd-9ecCnm-yR0qUg7OVX5LJEfA@mail.gmail.com>
Subject: Re: [PATCH v2] backlight: sky81452-backlight: Check return value of
 devm_gpiod_get_optional() in sky81452_bl_parse_dt()
To: Chen Ni <nichen@iscas.ac.cn>
Cc: daniel@riscstar.com, danielt@kernel.org, deller@gmx.de, 
	dri-devel@lists.freedesktop.org, jingoohan1@gmail.com, lee@kernel.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 3:17=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote:

> The devm_gpiod_get_optional() function may return an ERR_PTR in case of
> genuine GPIO acquisition errors, not just NULL which indicates the
> legitimate absence of an optional GPIO.
>
> Add an IS_ERR() check after the call in sky81452_bl_parse_dt(). On
> error, return the error code to ensure proper failure handling rather
> than proceeding with invalid pointers.
>
> Fixes: e1915eec54a6 ("backlight: sky81452: Convert to GPIO descriptors")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

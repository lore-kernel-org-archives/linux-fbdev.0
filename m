Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DB7149E06
	for <linux-fbdev@vger.kernel.org>; Wed, 26 Jun 2024 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402740; cv=none; b=AcOaIUX8LWiN38sPdy4srqcTtt3ZMair5IsTrlQrizusEObZ73Se7MtHm2bx2PF4caA5d8W2ZsZdUfy7bNagm8oVUh7wcQNt1eHehpH+XaeqgTDqpASv50cCdcxng0FFA0njOxmHzQIrmGXxW3CSfLv3MoOjB9PoGN7uGdPIjCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402740; c=relaxed/simple;
	bh=xpjrjZmRsZz45Y4K6cy5Tahj6SJPohhDcpzY7RpiacU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfzF+Z3puomKlPYHkH17e4zopAQ567PmzNThR9gZQapxpr040D6emeQ+7kWrlhvus/1RUWWpwv22+JYRju8RVxM6MQ6trB8ANs+RCf1mQTYubADtdGVILz1wpoU8Hj9gAIHRX06LhVfavHEUxgw9XF15CtLVN97tg6mY6ODeMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n/K3zpan; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/K3zpan"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cd6784aa4so5928006e87.3
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jun 2024 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719402737; x=1720007537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpjrjZmRsZz45Y4K6cy5Tahj6SJPohhDcpzY7RpiacU=;
        b=n/K3zpanWGKqPhLK59mSDivOMI1MC2+Qos/dqLjhqOsz7xGe7hr8nScuL9i3G/V/Vb
         ULG76D40rp5OZmWsmzZfZ3M6wS81Fcrkh4xXXqGB5XJ5ofDgSaP/SzFnjLsYl5C3CAiI
         EBLShuGW9uIoSFHQg1be8jg0qauh7B38uqcU4W7rEUeJbUtSVuaHrc+1zIVDNxgYSgqW
         63Ng9xsZXdasff1r5iIjywsn/0blwRidzLKpWrs1qlTwV7mzWgTXCKBmd01cLPkfhlmG
         RD+MiPy3jrewQppmRI8yIDHGUyTcjd2We0vyLOlDQsv8WcIw9pPcLZRQVG/wjEHF8jzh
         Dfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719402737; x=1720007537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpjrjZmRsZz45Y4K6cy5Tahj6SJPohhDcpzY7RpiacU=;
        b=iXhcmMcaUXg8/sH/sedfWLRYA67Ay2dGd1CKrU1ZvzK23oaRm/EVaxPsUua8ftUsLJ
         diloHj78+W74zsDoHORaRW5W1YGtGzBijXlRmezeL+50qnQaQjzCeUF98KAdJsu7PtRC
         tZDkM3swTzU3bAFVQvFCx3aqIzMlSrLfXxPA2s7N5mlGnhHyXzgEuZ/yQXmf2cGL1LeX
         0WeHvRRxfNEeVlFx7Xhd4jHPIPYwKeQHt4C5V0KQMt7uGo+qEEvX27s8LIYsioH/38p6
         wXiLUPK78/2ZnWEA072rSea2Xc7+r0tG9yrRLRqRLCQx6v/t5bkf1iUJ7Bm4Xk+hmLqL
         FjFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJBCzeIC9a+N5lb2rGTH8K5zAJPnsg/bkBwshnMo+5+MPrqnSP26eVz9v1AU9RQMsGJhhsOn4VB27W4es07qV9wgEZGqNEzTqUJxE=
X-Gm-Message-State: AOJu0YyNW9P0uwN2SqygHwh//DSfGOxNmjQXqGNfovDe/mO1d8PCnyQk
	JcpxmI+wIjT/4Nog473guybZrsJ0LCasrvTzZhpJ+/PgZPuuSlZWCnsqT6ryyiM+C5/uU/K4mal
	qWEdeSnTyxfPGiOST0BlEENa7aMCclJ2CM5n9bl67iHUv6faumBg=
X-Google-Smtp-Source: AGHT+IFt5Y6rNkv7qP0DY/jJs8uCxG3fud41/0H3+Siz9GLV1bZC8qZKtVnvB2O2VW30MKoOlKv1yDATTfc64MFALP0=
X-Received: by 2002:ac2:4e09:0:b0:52c:d80e:55a5 with SMTP id
 2adb3069b0e04-52ce183aa97mr7510215e87.41.1719402737078; Wed, 26 Jun 2024
 04:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624152033.25016-1-tzimmermann@suse.de> <20240624152033.25016-6-tzimmermann@suse.de>
In-Reply-To: <20240624152033.25016-6-tzimmermann@suse.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 13:52:05 +0200
Message-ID: <CACRpkdb9CNMw1z8q6gQb0Pi6fZhOfXCoiM1s5QdszRqgbxa+Lw@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] backlight: gpio-backlight: Use backlight power constants
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, sam@ravnborg.org, 
	jingoohan1@gmail.com, deller@gmx.de, f.suligoi@asem.it, ukleinek@kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 5:20=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:

> Replace FB_BLANK_ constants with their counterparts from the
> backlight subsystem. The values are identical, so there's no
> change in functionality.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

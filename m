Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3D20F991
	for <linux-fbdev@vger.kernel.org>; Tue, 14 Jan 2025 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736857727; cv=none; b=O5fqMThLJlv/+RhQxvTmmURKyHiv5ETReBdqdSlf5PRrXSFWpCHdGf4CypL1mHChPiqW0N/Pw8ik5JL9AiI4JxXzpnp7vdp4rMU4HGmEJd31cPsV8llENFCtgPMp7HHRc04U4er1u3fuBU77RUzSQtUUlAq8Ob69VAkDse3ruBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736857727; c=relaxed/simple;
	bh=xrCFDM2eog9VrMzBEgIreAWtdtBzJks+gCbgfxvMvvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRBLIxYWKkHs9dguPXvwAlTM0HrYfETjJPf8SvqMXAsPqXTQ/aSTE/hmj2g6r6yHMVtbiZOWU0t27Fdgmtu69OQy4ixRsOzefjhWfDth3mgS6rqg/Ef7hXbvwnumVOkUOhWk4Cot3/fwvQesJLyzK9xP+dzTisjrzIFYgGKg3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KSoJbI+M; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSoJbI+M"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401bd6ccadso5089339e87.2
        for <linux-fbdev@vger.kernel.org>; Tue, 14 Jan 2025 04:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736857724; x=1737462524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R311TP0IIG73HKbmHXvknkgBvBNSgSTSaWXDIuxlsuo=;
        b=KSoJbI+M7rCGpFPU3gQq/f3UCTACDpNRo8k4bLgPufFEl5/krG93wO1bpxzJgDDUSs
         VrhTxyU3IV/10LyUfrsi7xLX3b90aubf26HoDRe5UHHrsY9eD620ecZRIruBv3HjBS02
         gFO7oBCzLkbX01Q3J0hs3ltewz3ILgdxs/yhDz8HUC/75iARU7Lts0WX9GWaEDts9Ioj
         4B2VIvYZlD6UG81kEyxWgOjMcF/5lZbOMFnIcUNN7jVl6xlMBcjsJ7F2s1V09kCmA6pW
         SnEXY6G8842THCxWi0UYm1H+pixU+xoZdgn7sI9hBLVOMz1Ih5+6rLaLUKik7ql9O74v
         RlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736857724; x=1737462524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R311TP0IIG73HKbmHXvknkgBvBNSgSTSaWXDIuxlsuo=;
        b=kgGpLl75NtvqW0WLtV5/syJoNRF4ud8vZ8t/bH7JhSz5wbLzx+xBbyopQnQEvoNFUl
         eWu2QeTABeMtCyUnlXphLzcWM4/IlEQUKd0P1C7zi8JNfq8ZGp9+oxfLIGoMKrmQ+11A
         vs5mBxHRJ4Ah8Ku89EECEV0LLIEng1TdbgWDG4iytpB+1JdStGflhhEiU1xcEX70d/2J
         3/mJzCQrKQ8dm3CCzl1upbYGLuetViiPgPF0YBFduoJ2l1QqFcIiMvc3Vbctvc2wJnLj
         OMXAUubtcw2IDEe0u4V4vtbySV4je6bpIu13NVKe7JrWQc/532HOIQRf03vJlqGOIxVZ
         Db7w==
X-Forwarded-Encrypted: i=1; AJvYcCVw0AH/bkF1wFGG0zS/wn672+Dw8BJ925y06AYaHNTuZdwtZlv7Nci8yPaF64fwjlpM7ipVpEiam4489w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj9dmTJo1KxtR+/E4Z9qk58Yps2Al6buX8Qqr8eOGPUqHQqGQD
	Ci2kkwNAQ6xPIjhvPesDZbqqbcyAG8l87miRWum5FxphnVogCP5FAKH3hTwkAQnxNtoq9VBKGF5
	WmuiE0Zv2+0bzaADPIdUoo3vNlPuC6b4KwJJYHw==
X-Gm-Gg: ASbGnctCH0pNDao/u6Z9VGM57ftGvKrhpFAv4dq/hGt09D0Lb7+ZPIZ21II2vQvc0iO
	zOs8ScGA6C2U483h1adAZ5XWDTG8EyExbrLnm
X-Google-Smtp-Source: AGHT+IE/JB9Ju8vPiTN0nlYjendIGm/nVqaDgsop0Iz8J7wRpxZHpVu+Lc2gWbi3D4bZAQqtdVvoYD6PMLL0Tumz0Go=
X-Received: by 2002:a05:6512:12c9:b0:542:250d:eefb with SMTP id
 2adb3069b0e04-542845b1ff4mr7814709e87.41.1736857723614; Tue, 14 Jan 2025
 04:28:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102181953.1020878-1-aaro.koskinen@iki.fi>
 <20250102181953.1020878-3-aaro.koskinen@iki.fi> <CACRpkdbfuQuTQ028=hZgRhOPiw5AbPLyoZTbRCbvNDQ-e8UajQ@mail.gmail.com>
 <Z3uAAy5vF2ezUS2c@google.com>
In-Reply-To: <Z3uAAy5vF2ezUS2c@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Jan 2025 13:28:32 +0100
X-Gm-Features: AbW1kvYwdaFGn5ogv2-llw5rv3fQFhE2ONum70bRdkfPBuFkxbdp_9HZVhby-Qc
Message-ID: <CACRpkdYbtCODxWU8F48qGGBJoTL54R5Dj6iYLB6Z2MRwsDqYzw@mail.gmail.com>
Subject: Re: [PATCH 2/3] Input: ads7846 - fix up the pendown GPIO setup on
 Nokia 770
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Helge Deller <deller@gmx.de>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 8:02=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Jan 02, 2025 at 10:32:00PM +0100, Linus Walleij wrote:
> > On Thu, Jan 2, 2025 at 7:20=E2=80=AFPM Aaro Koskinen <aaro.koskinen@iki=
.fi> wrote:
> >
> > > The GPIO is set up as an IRQ, so request it as non-exclusive. Otherwi=
se the
> > > probe fails on Nokia 770 with:
> > >
> > >     ads7846 spi2.0: failed to request pendown GPIO
> > >     ads7846: probe of spi2.0 failed with error -16
> > >
> > > Also the polarity is wrong. Fix it.
> > >
> > > Fixes: 767d83361aaa ("Input: ads7846 - Convert to use software nodes"=
)
> > > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Do we need to have this knowledge in the driver or can it be handled
> in GPIO subsystem or affected board support? Requesting a GPIO with "in"
> direction when it is also an interrupt source should be pretty common.

Hm I don't know exactly the question here but I try to answer
anyway :)

The patch makes the boardfile describe the polarity but the
boardfile (or device tree) cannot define directions, consumers
must specify this. The main reason is that actual users exist that
switch the direction of GPIOs at runtime so this has been designed
as a (runtime) consumer duty.

As for GPIOD_FLAGS_BIT_NONEXCLUSIVE, this enables the
GPIO subsystem to read the GPIO while the irqchip subsystem
can also handle the same GPIO line as an interrupt source, so
it's not exclusive to either subsystem.

Yours,
Linus Walleij

Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CC12EBB99
	for <linux-fbdev@vger.kernel.org>; Fri,  9 Jan 2026 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767943714; cv=none; b=io/v/CWWw8DX03qPMULLu+jWawd5TITsOveAqTOTSHbYaatEo436JCMd55rjKc9xIYuMANE4s9Ai/XDApwCQNK27HCAbMrB+WClpPppvWq2gov0b5HM/+P9HkgQyswZNm8KnD/kHTtuMLLEUNI5CPUEoDrkhWrJGb7oHLaYLQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767943714; c=relaxed/simple;
	bh=z4zdMgkF80Daz5JaXcAIXXKM0qk/WNZUzdY7NnN+H2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eW2DOamMRzY+NPGhSCV9QhDe7u6qbK62rJnyElHJdOiVfiqafPjIzrkqWckTG77+z0uv4AO+LIKsozvOWdxWqyPY4ML1eueDKazMezrQ/KRehGLnCqRlWT0HEopWYw+cuWbyL+RuEfyVJoYAlatG3Td8gFOXJz4YKORDenS7m60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=VIMvIf/9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="VIMvIf/9"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c565c3673so1343534a91.0
        for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 23:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1767943712; x=1768548512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z4zdMgkF80Daz5JaXcAIXXKM0qk/WNZUzdY7NnN+H2A=;
        b=VIMvIf/9a1Di+luyFshfRYvDSMPSL+R0cEJEibjB9+XykGjE6/f+ZF3mGYyDIFlD/3
         ysvYeeIw2xMnV0QY4ulq7lwDOG5vGkfwKfkxRluKcEmvInepZccDuT6L3dRU3F1TSn//
         6Re9wlvyi9lYQLRVKjOOidKcKe19Acvo7DwRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767943712; x=1768548512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4zdMgkF80Daz5JaXcAIXXKM0qk/WNZUzdY7NnN+H2A=;
        b=T/h5dl8FyxP/bAHpHS28xLwIdeEUDBmyU3qiMA637S1GdCwnL5cpC/g0xAEOFokn2+
         Ean8wNGDov6mxiQs9+XCy/xflNn7avBbC/ilTvVkmvbeeEWtxe9t0qC9m98zOtlw3gfB
         Y+8hqhAZcgtVs/RkMEHzL/mhi5l4NbbG0lXjJ5QLKXtstL74+hxpecFFDKkxDYhT/NY1
         8ziVvQgxpcez3tX6oggCk7Yn8O5FOI7NFeQF/dnn27NWa8qcR3+nn1Y2UuPcU5+hemes
         VIYl7bPkTiXt35DItH2qA3VvlFjoGBgEgTlMxZOM0ixs/0Lj8TnlFDDTcZfy5bSAXkmR
         WSbw==
X-Forwarded-Encrypted: i=1; AJvYcCUOjGbGfq7sd/XkOjCBo0RZRtylAM7VALi1OPHuhldgPa0M81f2/M3CpyfCBbrdk3eDySEbv+uQUIFLPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy9DpdUucpOfSEwddaqys4Z85S1JetMBqDeVuJVuUUEJ+TgegG
	1cN1glgTebNct8YoAqgS1NjNIFjrymDaMRpVVXjDtlSMEDxN1fLF+YMqd3j0+EyAzkd4s7HV+Bo
	bgJe4yMQTFyMukozXZc7lNQJCM6REKFBVyQ5KkfIuoki4IUti+TV1JpTYrQ==
X-Gm-Gg: AY/fxX4rR5p5P1L5KOAZW61dAypvEVjhD5D6MQrdrW3rlUOJMLFewH6cqF1GOqPQWjx
	q2Wns/gNobTFB5uMKxC2Do3baNg9v/3BviHN84hDT578BbwlDtOBac3uvN7qayM5uabSvAqgd0s
	7y+2NLSaRiS9NLtUMRlWKWr6eBeYzVIsEW6/EB7S0iqU36GZ7plAp19LsTaYyTs3iK9NUtDgJED
	z6L4lbxPXeYJcu1TEOLZ7DQ1qCBYU8Dnlxx9JZhE3hN+J58gJrvwNj3KD1KiJNO1qCNtlaCktmF
	xWGGFdY=
X-Google-Smtp-Source: AGHT+IGhY024567WzIfV7SQyZniYkmhCoMDXSKq8EUCc6rVKifO3Af8TaSrLk2X1FvkcDFG9K8f9sjPRQu55hlxX9Jc=
X-Received: by 2002:a17:90b:4c0c:b0:34a:be93:72ee with SMTP id
 98e67ed59e1d1-34f68b64e1fmr8314764a91.8.1767943712031; Thu, 08 Jan 2026
 23:28:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-custom-logo-v3-0-5a7aada7a6d4@kernel.org> <20260108-custom-logo-v3-6-5a7aada7a6d4@kernel.org>
In-Reply-To: <20260108-custom-logo-v3-6-5a7aada7a6d4@kernel.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Fri, 9 Jan 2026 16:28:21 +0900
X-Gm-Features: AQt7F2qucaTCcxw87Ptbiuf4h1j-D8sMO9Oi1oo6s6YL0yzRkC93FMC01A59Z3s
Message-ID: <CAFr9PXkbkxKzT=p7xrz3Ti9+1S5B=qfNanw31hs9rbNuOZb=jA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] video/logo: remove logo_mac_clut224
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Fri, 9 Jan 2026 at 04:08, Vincent Mailhol <mailhol@kernel.org> wrote:
> Considering that the logo_mac_clut224 is only used by the Macintosh
> 68k, a machine whose sales ended some thirty years ago and which thus
> represents a very small user base

I guess I'm one of the few people that has actually seen that logo on
real hardware in a long time...
This change seems fine to me.

Bit off-topic but despite the 68k mac not being sold for 30 years
there is still a very active following around it.
This year might be the year of a 100MHz 68060 powered classic mac[0].

0 - https://68kmla.org/bb/threads/new-project-prodigy-040-060-card.51381/

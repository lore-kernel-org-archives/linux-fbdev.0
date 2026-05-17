Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A5635DA77
	for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779012816; cv=pass; b=fD5ZpoeWQwFDKpWdJNsL1RBxZ/D2lojcH/A9z7YCl9pcSADjonJaGGLbaIBWSPqXyVE2e40a4qdUpqtkZ0SzvggZlvgdPX8TC+u5M8w96XrSEq7nsksl364aWGJa9iNNHA8y2Php0JTDB+35aRALk8/RwewzXZxmbWBBTOuvh2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779012816; c=relaxed/simple;
	bh=Ah355/SrzZrFxRMEDg0nnxbwUFNinnvYb3ZHH5bVd7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGMaFf6NX7YlNlrRprTsFezLLHZEw0uorsY5WOA2V3AGmlaAXZLikaYyF3mUXtCsNA0PZmHEOqJRf1g6o+vfc5QtKEM+mOeeTH5aMaV3LOdnlOH8mGn3dPpFSxkm4Y9QZGpEbEZLPAJJ++8BC4KtUdPv4+1IStWmLPkqHRO7gcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpiZQz5C; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpiZQz5C"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c156c4a9efso1493141eec.1
        for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 03:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779012814; cv=none;
        d=google.com; s=arc-20240605;
        b=j0EaUz1hnvqCD38q+ZCnsE23eytOubuSM5mGbQE37zOuvCzNJ9eENWfF1OQPEzo2zW
         py5gaKja9a782KKTASElfkwM9cLPuvudQogUUay/kuKcp5jrWSDmBYPTgYfWlxwmr4mr
         AfzWD2ICRjIG2NBhfv8MVQcLyMtMRI85xA/odtEOqPPoJzdbqUh3YvkbaODIg6sVsybe
         0hzhvQ3rGfiBSZiuRwxEkjgHr0S6sfZtnXZasDXAXIBBCzJoI42tGOCbzSpHibOD2Z8d
         T9xJSqb/h08HPC21pMHHy19F23BMwYmwBATAoz1H3PYTg9TNd3oqzOIATe66eiINBMrZ
         Ij9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ah355/SrzZrFxRMEDg0nnxbwUFNinnvYb3ZHH5bVd7Y=;
        fh=BL3i50gAG6JGIC+j4T2UHBhjW6xEMannZk+wCYcQePE=;
        b=Nx8zFIm0yH50GJ+VmMpFqP36R0NbJHaOD8r9pbjAzIDy4fL25FU0SRKcCqjzS7FjDK
         WeIosL27v6rwbgiQiy8hIhB5+jZs/+8cbthXR5AsF36pAOTlwjX2ziX35tid1dYzkhdk
         LQVk7IKwSmt935yct3sBxhsrM8PzxJv2VkgfJIblHTKYlzznEUfBdWJwAkoGiRKSwIfQ
         /cQQRs9jDrs4hPC3h3aB7ocGnyjYyqpTSModb1qxD5k7xU524wcEzyXLNNK/lIxqcgua
         +zglomF5D0ok7W3veG3sjO4qVJ6Bx6WiE9WLUO1OEwmKuGXaj1KuOIvgThI8+La/ySKj
         xbnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779012814; x=1779617614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah355/SrzZrFxRMEDg0nnxbwUFNinnvYb3ZHH5bVd7Y=;
        b=DpiZQz5CG8ZsaOTOglNTkpxyCrOL2GT7MM2PeQzjC+91XVAbmvolTcCxLU63eB8NbQ
         WEI6T07V2j1xZObTgOmqSnbrokDXpO6061B+NXhy4sDdEPgT5a+ubEBxizQ9myDYGlWC
         O62zgIwpFxpPyLkH4EhPQqjEIdOWArEJXc7t0mML/K9fj+90Q+Qw71nRr09oxaXeqquh
         J7egeAQ7ppT4Va5M2I63q2c6XcGN9klLocWjLb7ZYA9A4LNa6W9Uh2Bm5Y2nQku6s9lA
         TgqsXMrnoAr8q01O+m4luSM4rbXjhePOOY7jxaFcDRXNkWopcSeGTB6F6pa6n0Qh3K1N
         t1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779012814; x=1779617614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ah355/SrzZrFxRMEDg0nnxbwUFNinnvYb3ZHH5bVd7Y=;
        b=SnJiqID2lrIJUaT1EgKaEAubuL6Qz5D7psrf0yTqEjwrDtdpO1OYFzIcxQWmpQ6udQ
         fvfaf0Pb8eK7rOqM9xS9KwXMsepvJa5Mgixti/J7GLusQemXdDVtY+o0uYGyb+wH9Vtn
         mCPe91vz4+wkEjVc8M1MPE+XuLjQYURi/jduDjKGhP1z2PXyeSrlASHIxB5WNU7lTmXM
         fdLUyNiI/XbRNJ5nY5jPV85YxBRJYY6rGlH0jtDKRaqB5jBpzzNlXJCyWqeR4+A1E/13
         DfmI6jRSLTZiAUiju7+4sX3ZEFwclx6TAGXoL7oookemrsxshuvBLQwFXjVXhz3hhhpr
         6yDg==
X-Forwarded-Encrypted: i=1; AFNElJ+LWoEQ4OZpwO8wKLIAq0vH5g5cn6x/VyFDG3TsRk8HOoIVVUj8GSADeKJH71cIAP+1SAkKhb8B1IVH9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YynnFIQSqv+1Ir9aNAxuYTsggZqaD54yrbQQC7VfroggZVze+tt
	ek8pIQhkknTNFhoRFXWZ9Agcd2SBd2RO1Q5323GRKocIxBuPVNEZKYUccwO+InP2x5V3lHFeZeE
	wvHFf7eYJAx4+Ij0I6GQdIfoemW5xLcU=
X-Gm-Gg: Acq92OFx0kzUn3tRTCvJG+Day8VkobawgU8t2numF2WQStohHeTshyhdRl6AtBhsLRr
	0fU7TpXEXd6/k2I+LfHsnAHWr0MaKvgw1OahMbPSBzopjPI+DhsH8IKVrV9s6niwU+S8gqYTkJ8
	UiIqsFXIqRoJ1V514FFfCi75ImBAfZzUl8YbsKzKFXEWTyFYs/XLQO88wlbKjQzgYtzHVkjF0iA
	1LaMGhet1M7FJoXtdxmE4IsR9rK1G56D+pCt2xRt4L5PeogPYAL88a/iASQUZ2c7TcTaaf3K/k9
	Jg1x4ExiIFS4fj+pH4U=
X-Received: by 2002:a05:7300:8b95:b0:2e0:1f09:d924 with SMTP id
 5a478bee46e88-3039813cab5mr5237843eec.5.1779012813884; Sun, 17 May 2026
 03:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com> <agl1T8O6kwP7SFZ1@ashevche-desk.local>
In-Reply-To: <agl1T8O6kwP7SFZ1@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 13:13:22 +0300
X-Gm-Features: AVHnY4IqE6FsGFbbFI5FSmJMlyOUEK62QOSOEKabbR3m07ZeyolRt90bM2zxkWg
Message-ID: <CAPVz0n0tfbwa1AbgO4eKrmNunHvmTFLDqXDFd1=VfLayuafH8w@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] mfd: lm3533: convert to OF bindings, improve support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 10:5=
9 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, May 17, 2026 at 10:43:00AM +0300, Svyatoslav Ryhel wrote:
> > Convert LM3533 to OF bindings, add missing VIN supply, add support for
> > setting mapping mode and LED sources based on device tree.
>
> How is this being different to
> https://lore.kernel.org/lkml/20250218132702.114669-1-clamor95@gmail.com/
> ?
>

I have decided to have a fresh look, this is continuation.

> What about this comment
> https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.com/
> ? Have you talked to Bjorn A and Johan?
>

No, but since grep -r "lm3533_platform_data" * gives 0 results there
are no platform_data users of lm3533.

> --
> With Best Regards,
> Andy Shevchenko
>
>

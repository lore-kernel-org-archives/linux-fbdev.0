Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2E2D7380
	for <linux-fbdev@vger.kernel.org>; Tue, 11 Aug 2026 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786487532; cv=pass; b=GH91A4VDsdvoNTqAtWfkaoFgieucym2eQUU6/Aqn2h1gsDuyDDFMfNCHC/MAoGhOQFnkxW3aoLfUiZ35QhzWgSK1HG4YvWIJ1uxHzk5jrLXob/2okAsWEeeaqJSCpNsG6YhpJyJk35cz3xVs7480prohDGNgZpSWd395b9/BkLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786487532; c=relaxed/simple;
	bh=AuxgX/pY87Dos1ZhmL8usKTm92ZBhvXMmxS/SuJTpqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeBDpGCRHo8NhULzgHccmgAb3Yk11Gak4V3Tlgm11EVjcP/NVnTILvTbeaKTlS7NNiawKme2icuB2sPgYc3Taec+/6sxFJolz3WLTUSd1Sw6RMGG2TQ9CPMqSS32A1M4kJVY0H3Py8/A37Ba9xeqOz1zR3BgJrmf+akZ3171hDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw7vICT7; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw7vICT7"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso207178a12.3
        for <linux-fbdev@vger.kernel.org>; Tue, 11 Aug 2026 15:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786487529; cv=none;
        d=google.com; s=arc-20260327;
        b=j8aSnQCcOceDsC1C1Q391XSYDJ5lLM/+qqWfeuqr4qnfeXC8e6T94S3MvGqhCddp+6
         48OPlac2pCQItzCbdlM2UXu+RBnH3lSg7QneLNW84pvVrcWak8PwTfFCwkWB2oXNoNv0
         W3z2Kp/yhLYne8zuzDBagAwScy29JTYxaK1NMyjsl7EN+RI4JNyluH/6Zuc3PCDeLSEL
         fOwic8jk+W9FFOhBFdSOUP6qao6guRA9tMUFYmkNP2AkYgGRdlZy0N5HwZ5UOvBZfeDS
         DHxkGoPZxZsSDFiuJLD3wuwXVS/ODEUEkKzCaC8wedoINz1AsXSm94ApOt6vEnr0Jpwb
         mpOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NDhag9T7TgtaVJbOY8rWrSF9da5OrhIz5kdObvPrx0c=;
        fh=2cy0OdKXYKr8G0FQkidFAIrYjTBJ23DqsDPWKaLLjEk=;
        b=opKPcH2HpylQ7N6OrLPzNk58RE6Duv/pgTQ5GSBEBj3yMyGtKoER/j79kp/Li6HV2Z
         qdX1/jGlKscCokNrY828ikahun/j4Zjgc70EEjbJV3bj2A9YQEk9f9BY/pJTlRo+36AF
         xhgPfMKMjHX8da6SLEzeYW9iM1msayS3J1f4lraUcmA2nUBgysrOaD4Jfpy92ZcQ8V23
         xksT5LAzQGmADjjURd67CM+zyr5uBA7tdheGFyrBjtGRY2GIucpORM9xjx/4hXQX4L1l
         g+lQJC6shKSPcsxGaPDklSb+guK81337gv7d7LzSRKraI2BKikIU8JSspbK9ER+qAAsh
         sO0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786487529; x=1787092329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NDhag9T7TgtaVJbOY8rWrSF9da5OrhIz5kdObvPrx0c=;
        b=Xw7vICT73Hr8lLLYZqguqcWWSbDpkK6WMKWEuyWJEZIxDPeCU3Nmwat3noNJYjLKPk
         frFX10hJwUuCUsxxONeMXuGuBMkxDXYNBJEVce8l1KYGfoG6wN8zOAvqJrVhSCeOSqBI
         Db14iGbW/o3l5TCX54mpnuQSIWvOfWtZGFvo+s1SE4SuwzNcaGUvmiR3VGg0g71HSh7J
         Nsoi4vEypqkCX59NnAJM/m5TVdh3CqSjtlygZ5XLIspqWKZWE2B8/MmJWHwL1bWX8Mdz
         hQPGoxf35qR/B8eUyMRWcwUkIfUAIp5Yra7oL56kkf88c/asJonv7nCwlZ3hwpWRrBCi
         bD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786487529; x=1787092329;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NDhag9T7TgtaVJbOY8rWrSF9da5OrhIz5kdObvPrx0c=;
        b=gdO28RZOsH6rrJ3oOAxBi+oUkd/DnuprHd6iOdlqWLotNzio9vF889M6r5as+6v7dO
         xcSN6cE5Hmy3khpIYxguDaoQ4Za6wTLgQ65Jq54aQJqNmxg4HGmXzdGP4pw6zsZxWD+0
         0N98q7GiY2Tl8Bn5i2S8mShqS7IQO4Sjmz2m5g0pwzUQIDOPz98HiuSK5hUxhpLMYibC
         wMeAQJI4o+1vyD/YuP2VhUAb/voyHqbOieBvRz9Uv/aIw869pKvLHMF9bi0uX2vSVpGs
         GHWzdKWNkelvxBqQoqwaCGonhi9bii6YKvmH8mMd4zdikP2srq3ZsevNkjuylV2AJy6N
         wizQ==
X-Forwarded-Encrypted: i=1; AHgh+RoRG1nAXaeQ324Weg6MP0OqrteyVnq8BJ8n/vz6mYF/MlHSh7KfzTVWB5510p0tStUO9Zw6raO6SB7wNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwManBARdd2DNUg5/Y3H4mJayTcXmS8oO+YIsknXG/Os/0Q4NUp
	7k/O1P09ewheb/39mUf3A+yCwHvUPajwx2N4TK9I5bZE4TmunJBXvm8/PZ32T5/HSJKvexhrST7
	5K5Z4JHfB0/ZpCN2Fk76neK3HzLSUq+E=
X-Gm-Gg: AR+sD10SsU66u5+Yh+RyliJWsnlySkL59RrZYPmL4tsTt0fdvmLQloVgxcYC4oHLSVq
	+hOFclua2c2xY0nh9lm+ypoy5OvpAlNKJkQqL8p4Q+mhBrKzIkcdqvQjnyuDsYofr6n7REx4reu
	FpheN4KELyWp+HHVRzC/G8l39GWbaRyhOwbpl9lTkvyxKn2NGU7Wqj9DUXLRd3njcYL5RmC+41c
	rWhnXanZMB+VeKeUuupHR0QGr1e6FAhzUGsE9XgLhjKdB0l2Kfl3FsKETXsrDGMCcmgqCZ5+dSD
	WX8IIgNmyg2oJVdV+QjxFiogvXzpFHzj7syy4daL/K9M
X-Received: by 2002:a05:6402:2792:b0:6a1:ffc4:9c0f with SMTP id
 4fb4d7f45d1cf-6a375f5c06fmr15680a12.19.1786487529251; Tue, 11 Aug 2026
 15:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com> <20260810-devout-pig-of-performance-595ccc@houat>
In-Reply-To: <20260810-devout-pig-of-performance-595ccc@houat>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Wed, 12 Aug 2026 02:31:52 +0200
X-Gm-Features: AUfX_mz7nXWHSfkKAN1Ac7JJQdBN1iB9iQXcLpUm_kEW3oLMc-SNNbJ2H3j21U8
Message-ID: <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: Maxime Ripard <mripard@kernel.org>
Cc: Helge Deller <deller@gmx.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 10 ago 2026 a las 11:02, Maxime Ripard (<mripard@kernel.org>) escri=
bi=C3=B3:
> If the sole reason for this series is to keep having something on the
> display while the kernel boots until DRM catches up, then you probably
> want to check [drm state readout]

Thanks, I had missed it. I read it and then measured, having earlier
claimed in this thread that our hardware kept no state worth reading. That
was wrong.

Dumping the LCDC registers at the top of tilcdc's probe, before the driver
touches anything:

  RASTER_CTRL=3D00280081  FB=3D9df13cc0..9dfcf4bc

LCD_EN is set and the scanout address is exactly the framebuffer U-Boot
reported, still holding the image. So readout would have something real to
adopt here. tilcdc is not one of the drivers you implement, but that is
work rather than a disagreement.

One observation that may be worth your time. Pointing a simple-framebuffer
node at that same memory, same device tree, only the driver differing:

  simplefb   the image is still there afterwards
  simpledrm  the buffer reads back as all zeros

So where the CRTC is still scanning the bootloader's buffer, simpledrm
wipes the image it was meant to carry over. I have not chased down the call
that clears it.

What readout cannot cover is having no firmware splash to read. U-Boot's
Falcon mode boots the kernel from SPL and skips U-Boot proper, where
display init lives, so there is no image and no programmed CRTC to inherit
-- and Falcon mode exists to shorten boot time, which is the same reason
one cares about the logo appearing early.

So I do not think they are alternatives: readout preserves what firmware
put up, this series lets the kernel put something there when firmware did
not. On hardware with both, readout is the better answer for the handover
and I would rather not duplicate it.

Max

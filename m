Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165D4690
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Dec 2024 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734539370; cv=none; b=l9HKXXw0Ht/Yb+ULT9oS1cNXLDAKYHGOIw6A4Xbk/wMzBgOqY3ID57LqYatZZaPPpNzdC3sm+fNfRwuYkSNc6z0HyFXukBmtrVp+baZI9S53Zey371G1OypGJWhfPSOFHF8AlE7ij0D8jwyyxJrydLMTGGK3AtjnnnK4n9oR2As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734539370; c=relaxed/simple;
	bh=GRVKvI0VO1mEdRggTJX/G1W6qVyd1PipxzoM61D6JV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isV76SVQzhkAkdkZW0uXURpHTDlu4yLmoQD1IY2q3SEmvgu4+uKR2gcURgf6HW9SaxYMXWCRoH/+8pBhv1Q80vjxROptSWjw/zMjbicKtt4/KEAXLb/D83b28SKJ3+6lQKCRvOlLWPvAK7movXJLIf08E979uGCOv2OHUZQqV/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5161d5b8650so1770946e0c.3
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Dec 2024 08:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734539366; x=1735144166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M66pQlw9tP9OabgR/qYGFv0FIiYcQ4QCkSJprMxGMSs=;
        b=ES+3jJZ/IdXIyhCo8Fy2f7wLlVrVY+iHGp54+2fR2EARLYNcNbOKNKVuzIPribIavH
         QiEO654e42EetCqYzEfhsqNi5BTQ1LXsyRZUW291cR/3ET6DpzA4BlIgouvjNBb0D/32
         VbS8kGySkcR1YcCg5T0CMZWRICD3zsQRfV6Rg27P2WdRKTELh5mxXwbSf8aSJnM0MliI
         hGhJbrT7J7I5ur3Mw26hpOCPe6KucvxXKHW3ocH7FPPonmrluhOZkLWibSoc3bC09K8r
         uyV+NSniqhZ/RMb5U95N+zUFTxojsMzuZPGTMAXuNBxJCqD5t5cIkBobR+f0UnO5VhyI
         z6oA==
X-Gm-Message-State: AOJu0YygVr0r/Q+KmooiKo8qF6c1PSOxnsXCf/cjJEiP+f80XDmKVqCQ
	SSMvvsSYXvkwmaFoIC0g88ny4cqcMWL/hmxlOhUN6+576jwaNfDGH1Fkpo7w
X-Gm-Gg: ASbGncsW+h/onGxwlATJI1v2Pmmmtze7GXBKGkaMierERhZZF+8o48W5ZNHTDQ7QfbH
	/WaLRJrGjm3LZePJysXGw74+topIVWUBYcHnUkA2XUg2xOl9f5g4TsQ/qwlL4Tw2DH5+1IdwLjX
	YEx/KTR9zpg3GxPmseIGv/p4n/nAmw5P3fA6oRJ42/3TlFQl6OU5eQSsjASwLTJojLHOXwLP0eb
	m+9o+QGNZSLdDrp7U0n453cQxGhLKcw7eis0A4aMPMYY6Ef6PdnbF1VTQdbEdz15GFn2H02wwwf
	iQ9Ne9YhxmfWfrooY70=
X-Google-Smtp-Source: AGHT+IHWw6FGVbbcgbMVVt12gqvdkgcHBiWR4pf1tvAJYerx43zvMzDtvDhPAnoZWj28kSEBLFqQQw==
X-Received: by 2002:a05:6122:168d:b0:515:4fab:28c6 with SMTP id 71dfb90a1353d-51b64760c31mr49718e0c.4.1734539366379;
        Wed, 18 Dec 2024 08:29:26 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-519e35e046dsm1149229e0c.12.2024.12.18.08.29.26
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 08:29:26 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4afdf096fc5so1569819137.2
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Dec 2024 08:29:26 -0800 (PST)
X-Received: by 2002:a05:6102:418e:b0:4b1:1b24:7241 with SMTP id
 ada2fe7eead31-4b2ae7824f7mr3369224137.15.1734539365981; Wed, 18 Dec 2024
 08:29:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215104508.191237-1-geert@linux-m68k.org> <20241215104508.191237-13-geert@linux-m68k.org>
 <5b7c10f9-730f-4aa9-95b8-37ac1f0f332c@gmx.de>
In-Reply-To: <5b7c10f9-730f-4aa9-95b8-37ac1f0f332c@gmx.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Dec 2024 17:29:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWDrD+=fH82EHqAW9EHDzTy1aGP54d_TQ6u5k_0Q1mOYw@mail.gmail.com>
Message-ID: <CAMuHMdWDrD+=fH82EHqAW9EHDzTy1aGP54d_TQ6u5k_0Q1mOYw@mail.gmail.com>
Subject: Re: [PATCH fbtest 12/17] drawops: Fix crash when drawing large ellipses
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Helge,

On Sun, Dec 15, 2024 at 4:08=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:
> On 12/15/24 11:45, Geert Uytterhoeven wrote:
> > "test002" crashes when run with a display resolution of e.g. 2560x1440
> > pixels, due to 32-bit overflow in the ellipse drawing routine.
> >
> > Fix this by creating a copy that uses 64-bit arithmetic.  Use a
> > heuristic to pick either the 32-bit or the 64-bit version, to avoid the
> > overhead of the 64-bit version on small systems with small displays.
>
> I see you always build the 32- and 64-bit versions, so when you mean
> overhead you mean runtime overhead, not compiled binary size overhead.

Exactly.

> So, just wondering:
> Did you maybe measured how much slower the 64-bit version is on slow 32-b=
it systems?
> I'm fine with your decision to build both, but I'm wondering if it's real=
ly necessary
> to keep two versions for a "test tool"?

On ARM Cortex-A9, draw_ellipse(400, 240, 300, 239, ...) with a
dummy (empty) set_pixel() method using the 64-bit version takes 44%
longer than the 32-bit version, so I think it is worthwhile to have
both versions.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02EE2C3266
	for <linux-fbdev@vger.kernel.org>; Wed, 20 May 2026 04:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779252552; cv=pass; b=A7p9f/FWIurFscIkHmm+0K50fEJUcYo6nbdeXIprV3vhkqA7IYoAUWU1E4zORk/oovo5FJKgzSQHxw4x74uipl9Z0OLYjj2tE701K6wqGGNKMTOO+2PxF+ZAYQljeQykG+ojIFhElycf1H1QR677gd0bNLzWFHTklo0xSXeHHCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779252552; c=relaxed/simple;
	bh=iX9DgFfgjdBAl007JWxmgssbqGhgCd0Hmt9BlGMfEVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THQcbSmARARDH5+qKCj2QwhsWuhU7bxVDtMWoGUNL0ztpPVGdDzhXO3NetMzfhHE8lYUVGg5VV2+lVct8GYpt2cwlMR478ce8PcJdFokm6/GiJe9xp+VYQ6cAGVsCzUqRpMY0KXlE9Ko+CZeSWrNuQg3YdP2q0BnHb85NaVhB0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6JIs4g5; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6JIs4g5"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8b4298d271fso96029016d6.3
        for <linux-fbdev@vger.kernel.org>; Tue, 19 May 2026 21:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779252550; cv=none;
        d=google.com; s=arc-20240605;
        b=fLg3eacYNukC0u08vtc4ZT379GVyedlf0PwWFrdw66r9mLirh9PEswAKPBS0Q95SON
         uR2YGhrGM/eUGBw02eGbDlUcbjkIEUm7qJ17/nFzm9OhuC5psEhr+trGoppab/+BjC/N
         +pLoGjgzj9BcomsWghfcnCXx8JoiKX6JJEmJZnmfkYiVVCz/8llWaIqbmZfKahG9I7OS
         d5LDcOBybSWz76n5I0pS3wMygzgTGi4ZTAMGSqbO95zNg+E9UzaZl5F7PQCNqAcphyaf
         X6Bg7UQ5rKlNSfxPQmy3tdz8la8IUIE/AIXcqJRGpbwXY5yxrsWo3Yx9zz40MNgA0W5s
         iffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iX9DgFfgjdBAl007JWxmgssbqGhgCd0Hmt9BlGMfEVM=;
        fh=HQC8TibF6W5tj88HaONdh6ouvCntlVwxKzp6h0tlCco=;
        b=DCucR+pmhNbA27xtr6UcQ08c9k+QG5lv+wGQWLOlsHDt5Ts4Xff5H1F7pvMFYaKYEB
         ZY55sV5tT1atK2HITVdfea+EvNPgM25ULDbRFDwmpXsB2g3KGthXeIz0slan54WxKetT
         oQwJMFzZXRbhv8E7AZsWFeUPbYwYTLLH5bTYlutvrLqgADZRSCBM2CKsJqNUVZjvPCEt
         7eO9AIFLA4K429hrowwYn07fsJWAfqe5hiVdE+IfFtYmIloptGpD3AFshgxGhXsViejT
         QvRDBqySAmGoMshQ3rqqz+jtrY8bAsNtKJzU8/QJCjKn2C0Y3I6Z2d4N3BH//LYp5GBr
         qKVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779252550; x=1779857350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX9DgFfgjdBAl007JWxmgssbqGhgCd0Hmt9BlGMfEVM=;
        b=F6JIs4g5EcZETyCCwjtT7UOhJCeIvVhqTQdAhwkeXx6k4sPKYncZvtBCffqMBHDPo8
         X9w4r8LCrUTSGvkZU4+ncWT4Aj6dFKJZuOJlr1HtSTZnynvwJunZEmQQkhjrdOdz1Kbi
         BZ0sTqaXixCbrHcw3hv56jAHoroAPfph8f8h5dzpOQ4178BshYbzRMsaTJ3jHiEB4UK8
         gu7/ZH7ZSplTvk1cfj2FhX2aQBesjRcNc+fxtbqQPDOosKW3NYRVOLlcYYLeHgt4JqkG
         LcCR27oCqCgg3OwviNTYKIoqB7oUTooLkZjna7t7XdhhJ002tQEOXaMu7TZqkp0F84HW
         o4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779252550; x=1779857350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iX9DgFfgjdBAl007JWxmgssbqGhgCd0Hmt9BlGMfEVM=;
        b=mUFki5ev0fPmOi8Y2Az8AwZ2GxkB/OrPsvxf7Qr6pWWW3HFSLtS6j/nnB99E8CaLPj
         FiDYDz2eXO7uZGL8XPM3YoZAmkmdeID2VhJi8h2thjS47iYnkZAM3qTJ0gURM3aLjU0x
         l1ZmZzOftH+2tYtnzt4wx3kSOSx05LPWG/Zim0Ejxptp7eauDLDSXyxcD0Iv4Z1Zwa3o
         g+jaOQf4FljbLWqMwIjeRK9TnxHPkI5reWzOt/7ghXq0CcqAiCqNXAAIh4ZQOz6IJkxt
         MphfLlM2f/sv5HQ8UITf2Ge5Oaptin8afVvM4b7/R/DVjNrClIQEQTJYrU7BwHT+877T
         tRBw==
X-Forwarded-Encrypted: i=1; AFNElJ8/DDJjikoCQZPCNva5VXTFkydYQ11srgaARy1ampyDU6QKPRj+74fR46RqysgST4oNUV7nKsDLJQajfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCg9DBZbznEUitl4teBsycUXQBXJxBg6jEdhwlETvhrmZbUhj8
	hDo4kj+U1jpBZsbRWKjZ0ctGLlH98JjgF+tGvLlbe43Yl4JOy2zM+DaDLeHtWWLtRtUSSDEKVoY
	HgPsL29u0z3NYOP3C22qBSm/hbuK2Ql0wdNr02iaf4w==
X-Gm-Gg: Acq92OFFkDpJx3F3NovuuDFOM7bQRoMkvIP3LRn6ntk3PyquxzO6XfDnmw+bTWHO3I5
	FnOT7esGjl1Wh6QfpRKxElAHRx9ThNSkjjJesz9XqR7VjxZHxkG8t7QN6ImRyarTKAXI6EiEqU/
	ebLpe19jrqjgiRdBh/Omkja07XtGa98IV/l1WG0v/oNgPbvL5rIwjqjq8TS0/xK7TVg8RILGOoI
	3CZZHeusIr0EQB3S7tWvPNvVv5rVUljnhLQmEEYyWsiAwv/RlaG+ck8766hEmK+UMZ8Kb531vSS
	JOAx/FWQ71vdfFqoflud30pkkStYgGg1uL9afI0r8FusNKzfeDW5CtlWTzfrrcHQkYil
X-Received: by 2002:a05:6214:478e:b0:8ca:f47:25ea with SMTP id
 6a1803df08f44-8ca0f4fcfb8mr351820016d6.0.1779252550653; Tue, 19 May 2026
 21:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510023941.190396-1-enelsonmoore@gmail.com>
 <d0bb399f-1285-495b-babe-8bae608729e8@gmx.de> <agwpPFGkN3zHKdCj@carbonx1>
In-Reply-To: <agwpPFGkN3zHKdCj@carbonx1>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue, 19 May 2026 21:49:00 -0700
X-Gm-Features: AVHnY4JqLEwFuVkjtY2Lbvna297TfZ51kPMwwQBMs7y6OuNbOahusQtJV32GfeA
Message-ID: <CADkSEUhhLL6WxUWBChdA=LFrYZQJsCLKOFJoXA_Jsdpab6qx0A@mail.gmail.com>
Subject: Re: [PATCH] ARM: mach-rpc: fix zImage build after recent font-related changes
To: Helge Deller <deller@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Helge,

Thanks for investigating this issue.

On Tue, May 19, 2026 at 2:11=E2=80=AFAM Helge Deller <deller@kernel.org> wr=
ote:
> Ethan, does this compile-only-tested patch fix the issue?
It almost does - I also had to remove #include <linux/math.h> from
include/linux/font.h.
This is probably because of the following highly questionable code in
arch/arm/boot/compressed/Makefile:
CFLAGS_font.o :=3D -Dstatic=3D
which is causing unused static functions to not be optimized out. (The
real purpose of it is to make the acorndata_8x8 array non-static so
the decompressor can use it.) Really, the decompressor should be fixed
to not use this hack.

> Maybe only the first hunk is necessary.
You're right. The kernel links successfully with only the #include
<linux/math.h> removal and the first hunk applied.

Have a nice day!

Ethan

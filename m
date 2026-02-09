Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E684330B22
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Feb 2026 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624272; cv=none; b=gOBCH/d4bXVIsrkSHrzYejzIPoQrXuWT5c4WzmOi8xUD+CDb2iR7CDj6nVF9h+efViwYprex0roBY8WIdLOfaaJJ6NGw7Peovzjwy0u5aOvusynKEscuTZSnnE0EVvQ7MF/lSvBXMqvGvJlVLXgRq0Pm46R5uVYwfkEXNmIpTZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624272; c=relaxed/simple;
	bh=13PZgL9juvMZE/bL12LU87JCclz46Q+nyA5P8hWaysY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3A/O4aUssHQ18NK2XYWwr7OSgqiZzhioFojs/BRuDmQqauUKZ5kTU/0UMZU/xNlcRhMOV3IVPc6fyperXTXGnNYvw+Pqna7Hwo1FvvAErdz2CaSlLlr93QFvD0+3sk1hNZtdPOFbVn4ewkNl9RybI/Xr+LuV4Ju0b6jS8bMCJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c70daf9c94so268155085a.0
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Feb 2026 00:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770624271; x=1771229071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D/rUfBgEbHjBEA1qwbU74Nk1aEVnneXDJbowEUMBT8=;
        b=xGHZJoup9+6Hf/P5idEMJF96udaFjLvuKsSGW0ydhUzIzx08wPwDgcYjq41LaKltC+
         kcegAsx2HHErDtXlWrQORVDhjPLU8eiZxO2kBmfMHYvWGuhk7hhrbTTZeLkfJtS/LSMS
         wM/IpBlWiAWKyxayVobRExitYkX4UNzTsJZpYv3o06TQm4d8+t69GZ4CQJIXPT2g1cRq
         n/ud13uHxxcUboVKgUqJ7Cwh16KLew+oURXFuz2WJTaVPbZoaY8dlIYxpg4hjonEXEWn
         H+iVPql+mD5W5VoQUt9jff54+h8rJDboBmgXY9uhw86U4bzB51fB10sEO2afPDBtArwk
         rEkA==
X-Forwarded-Encrypted: i=1; AJvYcCUTnUwbkeBfxnfg6cb9RgAHOw03XSxmXU4ZrDCmnXXKEWO9qesas2u25iVwKPnjf6jZbyhWdaNbI/6cSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrsfmW6q4uHYAHi4HLhkNTF1iviDVgJsioqRwC9EIB7UPjAmEi
	dEJ1/dIqXyhrvhF+4YPDlwthEiC85brtrQZ3VgJxlHBRSE4PYklKd4PY8fBwJ1Tt
X-Gm-Gg: AZuq6aKdPzYd7xSvuBJPwUA2Pv9Y6+wVPXvpAQsmALI86sXAdZFkMJK+ts6vouTuKKa
	CJZ2KW3BAe4wyb4RnfRGB64fn9aJhQbwUs2TBEcDX6tBQrS2VfABHFmoZA4DSDPlz3oK/JOD2jm
	p4ULxbHm1leCZJ9qP/XyibTBoYlQ0hpu5CqlFdPUTJUb0Wnfygns5AMM7HJ3Jo4q130NBcQWAWV
	lnlhXZ7eqYxLLEMS1b/xDqQRfafugfmAPsbk1x3YgDmnzfZM9UuxJhl5GBONEgtQfQye42l2lrp
	4TSa6p823VMiMwVPHunSpRH01ht03EHMFTK4fKOaqLcITkYD4sOkZ+118O1sWRfR6cu/OjP97dF
	dhm+mhFcKLIL5/R7xImjrPqHasswBZQyQwfIFcvLkaI1I2N7pfkPMGZQN4KrKnPV6BfIhNgizlV
	0FLegJo2ZZRhwIjLERwSuX8LwbETEYkmkrqzDU0XTzttF0ocsyjex4
X-Received: by 2002:a05:620a:17a8:b0:8ca:4288:b158 with SMTP id af79cd13be357-8caf0960ff6mr1416226185a.43.1770624271243;
        Mon, 09 Feb 2026 00:04:31 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9a1575asm811783785a.32.2026.02.09.00.04.30
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 00:04:30 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c6a50c17fdso277401585a.2
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Feb 2026 00:04:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX8qSYk3fAWeVUU62sri62Skqrj6iIMuNU9a68VuWZwFp03NnnohWZ7vNN9BzNar3etudd3KzHqZCd9ZQ==@vger.kernel.org
X-Received: by 2002:a05:6102:26d0:b0:5ee:a3d3:39ec with SMTP id
 ada2fe7eead31-5fae8ba7ed9mr2144888137.22.1770623876657; Sun, 08 Feb 2026
 23:57:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209005212.32370-1-enelsonmoore@gmail.com>
In-Reply-To: <20260209005212.32370-1-enelsonmoore@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 08:57:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUPX_ynhX_t8GtB7eRqF_6W4BwqC8w7SRpro-1Okxd70w@mail.gmail.com>
X-Gm-Features: AZwV_QjWJpSBZb0k6kXBVmUwqWQVDJxSuYpk_vCif3y4EA-71mYU8BrddtYWH5U
Message-ID: <CAMuHMdUPX_ynhX_t8GtB7eRqF_6W4BwqC8w7SRpro-1Okxd70w@mail.gmail.com>
Subject: Re: [PATCH] arch: m68k: remove incomplete, unusable Apollo hardware support
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-m68k@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Biggers <ebiggers@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Thomas Huth <thuth@redhat.com>, 
	Greg Ungerer <gerg@linux-m68k.org>, Finn Thain <fthain@linux-m68k.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, 
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, Kees Cook <kees@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Wei Liu <wei.liu@kernel.org>, 
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>, Sukrut Heroorkar <hsukrut3@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Ethan,

Thanks for your patch!

On Mon, 9 Feb 2026 at 01:53, Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:
> The m68k architecture contains very incomplete support for running on
> Apollo Domain hardware. There are only timer, console, and framebuffer
> drivers, and no storage or network drivers, so there is no way to

3c505 Ethernet support was indeed removed from the kernel a while
ago, and upstream never included the Apollo-specific parts
(CONFIG_APOLLO_ELPLUS).

> practically use it. It is not even capable of rebooting by itself (see
> dn_dummy_reset() in arch/m68k/apollo/config.c).

I didn't know that is a requirement;  one of the advantages of Linux
is that you never need to reboot ;-)

> arch/m68k/apollo has only received tree-wide changes and fixes by
> inspection in the entire Git history (since Linux 2.6.12-rc2), so there
> is clearly no interest in completing support for Apollo hardware.
> Remove it to reduce future maintenance workload.
>
> There are no uses of the removed <asm/bootinfo-apollo.h> UAPI header or
> the constants removed from the <asm/bootinfo.h> UAPI header on GitHub
> or Debian Code Search.

Seems like you missed https://github.com/geertu/m68k-bootinfo...

> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  arch/m68k/Kbuild                             |   1 -
>  arch/m68k/Kconfig.devices                    |   4 +-
>  arch/m68k/Kconfig.machine                    |   8 -
>  arch/m68k/apollo/Makefile                    |   6 -
>  arch/m68k/apollo/apollo.h                    |   4 -
>  arch/m68k/apollo/config.c                    | 240 --------
>  arch/m68k/apollo/dn_ints.c                   |  50 --
>  arch/m68k/configs/apollo_defconfig           | 595 -------------------
>  arch/m68k/configs/multi_defconfig            |   1 -
>  arch/m68k/include/asm/apollohw.h             |  90 ---
>  arch/m68k/include/asm/config.h               |   2 -
>  arch/m68k/include/asm/irq.h                  |   2 -
>  arch/m68k/include/asm/setup.h                |  32 +-
>  arch/m68k/include/uapi/asm/bootinfo-apollo.h |  29 -
>  arch/m68k/include/uapi/asm/bootinfo.h        |   5 +-
>  arch/m68k/kernel/head.S                      |  70 +--
>  arch/m68k/kernel/setup_mm.c                  |   9 -
>  drivers/video/fbdev/Kconfig                  |   8 -
>  drivers/video/fbdev/Makefile                 |   1 -
>  drivers/video/fbdev/dnfb.c                   | 307 ----------
>  20 files changed, 19 insertions(+), 1445 deletions(-)
>  delete mode 100644 arch/m68k/apollo/Makefile
>  delete mode 100644 arch/m68k/apollo/apollo.h
>  delete mode 100644 arch/m68k/apollo/config.c
>  delete mode 100644 arch/m68k/apollo/dn_ints.c
>  delete mode 100644 arch/m68k/configs/apollo_defconfig
>  delete mode 100644 arch/m68k/include/asm/apollohw.h
>  delete mode 100644 arch/m68k/include/uapi/asm/bootinfo-apollo.h
>  delete mode 100644 drivers/video/fbdev/dnfb.c

Apart from dnfb, this only removes code under arch/m68k/.
Is any of the removed code blocking further development for you?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

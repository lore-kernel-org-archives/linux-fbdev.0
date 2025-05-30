Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A391DE4C8;
	Fri, 30 May 2025 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748592000; cv=none; b=lpDGR+47nWWAIsM9RTn1VppgbJjLfPL7d2BOyTxg1gmEs8liVbACMfi/9vmdzCEbYYAeQa9kjhZRVEM744DGu0xfMETaSRALNlB/AAWnj3b9qRTM6GkecfAEwbtXWIKKpd2fixmi8hvYOeF/c7Ad/v2CcUCtGXgJZcYN6qahD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748592000; c=relaxed/simple;
	bh=gCUb+2yqRO1CW9wt91Tc8ujhZEzq+sMnhZYsspI7yAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhYCEftRcIWUO+NuL6nYFuxEMcPAShRgSaueh+0gTRmCzQo/hG5AD4KerIieLjcD0uDDmS8Fm8NKetQHibh7KjK68H6Ir3gd8BalvCsAS3gqm4WShA4Lg/iBABpNURP/AoJFgbllxY2lxhfoJ073OC2eE3tJxe4dp4ILtBgFBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-87de47585acso1219197241.3;
        Fri, 30 May 2025 00:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748591996; x=1749196796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIa/rhWcGznumQSCSgsw8TY1J6vFHoHTI/oacCPJn4s=;
        b=E1Pnp6SIAw5YIwSCiCmZPVDRYRWmEtpIWdYVQ5V/TfIRBZnHFt9x+B4tFuEkAJ//jT
         /u2BQFOFzkg9p0xWxcPs38pIeEgUNeN9QUHvvDlaVIoZb3BbtLNWk6zP1nrlR7xNWEPx
         Flv+1boKY0IrEPcdqLBNjy2NkFD0eq9xEJhFaug45DE17ZzduG4wggRJu47kFNFElfwl
         kt748QrtEZVqND1DFs5aAsHeoWrMBzH1Qjxgaf/FyHzH/5K+p06t2b6ZVJfTrgAc+T+c
         Lxci69IrwwXngzV4wPXro2U4cNjPT7Np/JI/qMMbr/qGun/7LUgshx+ww13zz21DvcKk
         rLzg==
X-Forwarded-Encrypted: i=1; AJvYcCUYFAMPhvZfpUKZAA59jebOhIw+t+4W/+F/QYrwrJwRcsiLoPhXUZ9VpCMvjYM820iqPHTpDoeI0Ji5KQ==@vger.kernel.org, AJvYcCWcZ0g1EgjeB7XUrwf6nfZvVJEED7gRO+Uv+bzLH8kdE34tKN3O9tGgux9C3AsNb2PnDYFw5pHbjP1+1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDfTRxEI59wBEBQ96ELrSRlt2DzoIl5jrgyZybmW/eFWjoP5Fn
	DdpNfFmHwAKclpEBqtT0fWcN+B9O8f9j5sPIaBZq8mfR6AbBlIp7lDuaLGjX2qAP
X-Gm-Gg: ASbGncvQc5yX01w1OJWVuagmn6cURIHfACb4/owHDN82wum3tdd/8OSV75yD7DD/sq3
	d0s1954+BJIgkKyG9/fdQ9lKO8txFHBAy+VOcJiSBdvhawwD/m4tzcRS5W/LNXh9QrPtbDkBBgx
	PKpiyE4PMdttDSmQnm+d4KlIvoYfmlP+riiRKJzgFUEr9Lz+DQU+Sks3FVw/acgGrMU1lVf0GBZ
	9hi/crZMgPKhWTTQwPT/Z1WYJ+cfIUKNtVsEr98wyqClzEU5AaLku7v9rZk64LMTVXFRiYvKEjf
	BFK27ktIAqBmVakcGFxTAQdW2k7/8L2Er5YO3iApKt8wEpm/kzx+jaeTtgAhnn7KzkMQTepyZO0
	7IaW3Cq0LN6rzHmsjlR2HNJDV
X-Google-Smtp-Source: AGHT+IG32K9rqIFQYcfcMAl8m6uQ3G3PPWssRlcIbMzENZMaePMfDECPKBYmrzV5IBdVJM1rFsZEyA==
X-Received: by 2002:a05:6102:162c:b0:4e2:82c3:661c with SMTP id ada2fe7eead31-4e6e4108796mr2525265137.11.1748591996281;
        Fri, 30 May 2025 00:59:56 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e6444295e2sm2454247137.5.2025.05.30.00.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 00:59:55 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87df8fa1c6aso948674241.0;
        Fri, 30 May 2025 00:59:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAh/lmj/FdY5oIslL35qGNeQKTBFajQsVmGAvSGBWC4g3vo/xSOvBFCbDLPz0xwEVFf7QCUdHm8fZwKw==@vger.kernel.org, AJvYcCW6Qv35rnpzBAS0PwJh3OFSf8TwoTSKooFu9zyFaYK6Jopt0V8zvSCzO80191IW1kHjBbZxL3jVigvVpQ==@vger.kernel.org
X-Received: by 2002:a05:6102:c8a:b0:4df:9635:210d with SMTP id
 ada2fe7eead31-4e6e41db7c6mr2389073137.23.1748591995453; Fri, 30 May 2025
 00:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1669406380.git.geert@linux-m68k.org> <a9883a81-d909-09c5-708b-d598e030380e@physik.fu-berlin.de>
 <CAMuHMdWHUnWBN7ddBow+fqmt8W--9wFe5x_YMeRg7GQ=BNAL2Q@mail.gmail.com>
 <74946b31-6166-44b0-b2a7-b0633f014b60@helsinkinet.fi> <CAMuHMdXSWiM_xofyfgpoc0Jj8a_PwRR_tFe79t8=-X85-7WZug@mail.gmail.com>
 <beed53f4-b0d6-4d1d-b5ec-2694d2b5d47a@helsinkinet.fi> <CAMuHMdUSADF51tBbGV=_nsxqyXgfNZcgDNGxuZ4F+tvYs9Q2aw@mail.gmail.com>
 <72078ec9-25a0-42d5-b7da-b0a974033f86@helsinkinet.fi> <CAMuHMdXDdrMewGgeghr3cwtaBvieguYOC4GZ-EXZmA+w5S4bpw@mail.gmail.com>
 <65b78057-c490-46a3-92a7-350d314d604e@helsinkinet.fi>
In-Reply-To: <65b78057-c490-46a3-92a7-350d314d604e@helsinkinet.fi>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 May 2025 09:59:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVhTpcG7uhdoEcSs3qqgtJVtjzXtdp1Xfa-oaKxqGW=QQ@mail.gmail.com>
X-Gm-Features: AX0GCFv1GzlJ2sUyuto4TXy46hiWuy0VbvhpeBdPo_tDmf1ec2QxgJlCcbpqdEI
Message-ID: <CAMuHMdVhTpcG7uhdoEcSs3qqgtJVtjzXtdp1Xfa-oaKxqGW=QQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/3] Atari DRM driver
To: Eero Tamminen <oak@helsinkinet.fi>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Michael Schmitz <schmitzmic@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

Hi Eero,

On Thu, 29 May 2025 at 02:06, Eero Tamminen <oak@helsinkinet.fi> wrote:
> On 28.5.2025 11.57, Geert Uytterhoeven wrote:
> > On Wed, 28 May 2025 at 00:47, Eero Tamminen <oak@helsinkinet.fi> wrote:
> >> I did boot testing on Hatari emulator with a minimal kernel config
> >> having atari_drm enabled, atafb disabled, FB & boot logo enabled.
> >>
> >> Under Falcon emulation:
> >> - RGB/VGA => works fine
> >> - Mono monitor => panic
> >>     "Kernel panic - not syncing: can't set default video mode"
>  >>
> >> Under TT emulation:
> >> - RGB/VGA => boots, but console is black[1] (palette issue?)
> >> - Mono monitor => looks OKish[2], but has constant warnings:
> >> -----------------------------------
> >> WARNING: CPU: 0 PID: 1 at drivers/gpu/drm/drm_atomic_helper.c:1720
> >> drm_atomic_helper_wait_for_vblanks+0x1a0/0x1ee
> >> [CRTC:35:crtc-0] vblank wait timed out
> >
> > I am not sure this is a bug in atari-drm, or just an issue when using
> > DRM on slow machines.
>
> This does not trigger with -Os built "atafb" kernel, but happens even
> with -O2 built "atari-drm" kernel.  Something related to the higher (71)
> HZ of the mono monitors?
>
> (I don't think it relates to TT mono monitor's larger 1280x960
> resolution, because it happens also with ST mono monitor 640x400 one.)

DRM vblank handling is part of DRM, so it is not applicable to atafb.

> > Are these regression in atari-drm, or do they happen with atafb, too?
>
> Only the "can't set default video" issue in Falcon mono mode happens
> also with "atafb".
>
> It has neither the above vblank timeout issue in mono mode, nor
> black-on-black color issue in color mode (on TT and 030 ST).

Unless I made a mistake, color handling should be the same for
atari-drm and atafb. Unfortunately I am no Atari hardware expert.

> >> However, -O2 build has the downside that the resulting kernel Oopses
> >> once it reaches user-space, if 030 data cache emulation is enabled:
> >> ----------------------------------------------------------------
> >> Run /init as init process
> >> ...
> >> Instruction fault at 0x0041a256
> >> BAD KERNEL BUSERR
> >
> > Interesting...
>
> There were some extra config differences between my builds for 6.15
> "atafb" and your "atari-drm-wip-rebasing" branch.
>
> After removing the ones I could:
> --------------------------------
> $ diff -ub .config.old .config | grep '^[-+]C'
> -CONFIG_I2C_HELPER_AUTO=y
> -CONFIG_LOGO=y
> -CONFIG_LOGO_LINUX_MONO=y
> -CONFIG_LOGO_LINUX_VGA16=y
> -------------------------------
>
> Bus error issue went away.
>
> => Could there be some issue with how logo and "atari-drm" code
> interact, which could manifest when reaching user-space?
>
> Note: I haven't tried enabling logo with "atafb" + -O2 build. I could
> try that later on.

Logo shouldn't matter.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

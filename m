Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40FA233D98;
	Wed, 21 May 2025 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811212; cv=none; b=NNsxt4xQvRVez/6I/ZdudAChzzpyE5xAWVe+RJ8MNny7gw4/p15h2RD8wI4W7C6qVfhcdZ2q6xdPbWlbnhEweBhsCvl556+QwEEja1kiMnDydxnHwG4y1KevFfpiKO0U0Diy9xOeyGVoSG45Gjlymr0AYACf3O6q7605ydFtMUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811212; c=relaxed/simple;
	bh=kN7gCLNGDms9Wuy7WJknxpDvHnWcyi5Wp8kZR/n84Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvqIzbv0JkGfu5XMh10DD5rnoMwaIk2i5TRChzWmfbDP11Bnf1kd3P9fS1azXNP4xgf8G2quVRcUzASKegj54mNtqUJo2GumRghBl8YxwEFzn8glIw0FFS5zo5CfzhYYkxgTCa3m5oe0EYN9s40KAcINyxIiiVz6kRVinhUuCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4dfa28eb4d8so3681815137.1;
        Wed, 21 May 2025 00:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747811207; x=1748416007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDdm/gMDJHRRO5S7yUdMVawXFqKo60gp6vNx+WKlT2U=;
        b=UevpuF8/aKC2roJs1DEwfnvukSQI/Uh4RQWSv7+BlvqR2LffVx0dIi3qAoXB1MD6as
         4bqTJqUBdyTYVNg7FIPzqSnu7qSZKXaXzBHhcpGJSZd81W1gfwXrcLCGWm0abKxazTNe
         htaHb1VgBi69DVPI8xNiV4m1dEmGnS5YzC5m9cHdMrPIar7YfU6CUSRwVmI0FSDy0oU8
         0QK96vRfNpukAIinqIdhic+L3nv5KwDhqggoUcSfqjtYuG3La1LksGL30R1VaiustIt6
         5gbQ3BZGNxFNoUMT7oYtBmnFUqMjO/JXgNOJtLq1HljN31XFb5XghJi6UpCxRtf3fq2S
         xzDg==
X-Forwarded-Encrypted: i=1; AJvYcCUCQzYcHj55saR02ToqDCnbiA4+c3FbG8x+++FWFoeOSJ+HZHftcazPrl2jAPj6LNqfgyrcA0WY0RlniQ==@vger.kernel.org, AJvYcCUwUeasRQq4hkwZrdJOb1eGgQyUorBh3QSH3JpC/LZ5rL9Ehe3SudXCCwVRX2O6F2mw46eNuISmuRR1Zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEx+qkm/SOGuYTscFYP1sR7FGZxMBYnx6Po52Z2zYCW9j+SfVU
	Kn+XUVNWgXIna/zY42jCHwpNpoGUYTGIUxFJ/a6b00OqdvR6aJnpw+5dBjFQ4SZA
X-Gm-Gg: ASbGncv4u4E7Ssq1m4TmDoNuL8lm/d2U+5FfoeB14CG4hjhtYfhYPgIcwRuGc/0qxLq
	89xJFChzzo8NzaM7cTJklLie3A9MR7iIxj2dpm49JvFsdyMYiowXbbZkBJUIqUEDY0YE7isoJww
	smc2+kQSPoEzvwXePjiV6hI/ZUC10jLO2YAbK9UJxvbmhf7yWJ411J6JMMarQILU1WLC1MC0sAZ
	bIWDozvgfJj/wsO6V21RJagTziNVknFW5sJlHrWiGn6EYUFVX34jkbS6hy8ibGx0Ok6X8K40mSd
	3rIiIecGppxjYhWejtDFItwrPsIkyFZkK6nlujvPz0h9A/2l5itrLcJdTh9eiHPkOWAGeL/6ku/
	Juf/nqcAjhJYHrg==
X-Google-Smtp-Source: AGHT+IEo1x5paH3X9NHdSQ580yybbUT51mLYF4SVoqHfbMVx0EGDMQz9fOCRgR/kq6WMJ0fbziu9QA==
X-Received: by 2002:a05:6102:1508:b0:4c3:346:29ef with SMTP id ada2fe7eead31-4dfc30f4313mr19386926137.11.1747811207218;
        Wed, 21 May 2025 00:06:47 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4dfa669860asm9360805137.2.2025.05.21.00.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 00:06:46 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4dfa28eb4d8so3681750137.1;
        Wed, 21 May 2025 00:06:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWchq3jYZRgKMCnEIlOKuf/B2VmoNudcUo1cEaw3jdstoE6S2CErV6SeLtnwKDL5wsPyTvz1E0u24jOSA==@vger.kernel.org, AJvYcCWxjctrcTXH6PRbSSqLFAbtU4tXx30FSrawEwTjAHZlT5LYbXEijrmG7CgRjHVVzs/Rfj8dTk8L8c9qQQ==@vger.kernel.org
X-Received: by 2002:a05:6102:3052:b0:4e1:ec70:536 with SMTP id
 ada2fe7eead31-4e1ec700665mr10616805137.4.1747811205821; Wed, 21 May 2025
 00:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1669406380.git.geert@linux-m68k.org> <a9883a81-d909-09c5-708b-d598e030380e@physik.fu-berlin.de>
 <CAMuHMdWHUnWBN7ddBow+fqmt8W--9wFe5x_YMeRg7GQ=BNAL2Q@mail.gmail.com> <74946b31-6166-44b0-b2a7-b0633f014b60@helsinkinet.fi>
In-Reply-To: <74946b31-6166-44b0-b2a7-b0633f014b60@helsinkinet.fi>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 May 2025 09:06:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXSWiM_xofyfgpoc0Jj8a_PwRR_tFe79t8=-X85-7WZug@mail.gmail.com>
X-Gm-Features: AX0GCFuB4vJFSfv66iragTQL4KWajIPLPkZDuxM0m5SK06eB8kBWY6AhcxxTf3o
Message-ID: <CAMuHMdXSWiM_xofyfgpoc0Jj8a_PwRR_tFe79t8=-X85-7WZug@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/3] Atari DRM driver
To: Eero Tamminen <oak@helsinkinet.fi>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Michael Schmitz <schmitzmic@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

Hi Eero,

On Wed, 21 May 2025 at 01:59, Eero Tamminen <oak@helsinkinet.fi> wrote:
> On 23.1.2023 17.10, Geert Uytterhoeven wrote:
> > On Mon, Jan 23, 2023 at 4:09 PM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> >> On 11/25/22 21:31, Geert Uytterhoeven wrote:
> >>> This RFC patch series adds a DRM driver for the good old Atari
> >>> ST/TT/Falcon hardware.  It was developed and tested (only) on the ARAnyM
> >>> emulator.
> >>
> >> I just remembered this WIP driver. Has there been any progress?
> >
> > So far no further progress.
>
> I tried your "atari-drm-wip-v1" branch commits on top of 6.14.

Thanks for testing!

> After some minor changes those applied. Getting it to build required
> adding "&shadow_plane_state->fmtcnv_state" (struct drm_format_conv_state
> *) argument to *_blit() functions in atari_drm.c, and changing:
>         drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
> in its probe function to:
>         struct drm_format_info *format = NULL;
>          drm_client_setup(dev, format);

I do keep it up-to-date locally, so I could provide these changes,
if you are interested.

> However, the result is not working very well yet.
>
> Driver gets initialized fine under Hatari TT emulation:
> -------------------------
> atafb atafb: phys_screen_base 511000 screen_len 311296
> atafb atafb: Determined 1280x960, depth 1
> atafb atafb:    virtual 1280x1945
> Console: switching to mono frame buffer device 160x60
> fb0: frame buffer device, using 304K of video memory
> ...
> atari_drm atari_drm: phys_screen_base 55d000 screen_len 311296
> atari_drm atari_drm: Determined 1280x960, depth 1
> atari_drm atari_drm:    virtual 1280x1945
> [drm] Initialized atari_drm 1.0.0 for atari_drm on minor 0
> atari_drm atari_drm: Atari DRM, using 304K of video memory
> -------------------------
>
> However, once screen switches from "atafb" to "atari_drm" driver, Linux
> boot logo & texts disappear, and (emulated) screen is either all white
> (on mono monitor) or all black (on VGA & RGGB monitors).

So you have both atafb and atari_drm enabled? Please don't do that.

> And while "atafb" works fine also under Falcon emulation with RGB (50Hz)
> or VGA (60Hz) monitor, "atari_drm" probing fails:
> -------------------------
> genirq: Flags mismatch irq 4. 00200000 (framebuffer:modeswitch) vs.
> 00200000 (framebuffer:modeswitch)

That's also a sign of two drivers requesting the same IRQ unexpectedly.

> atari_drm atari_drm: probe with driver atari_drm failed with error -16

i.e. -EBUSY.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

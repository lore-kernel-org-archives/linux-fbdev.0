Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6142741A6;
	Wed, 28 May 2025 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422672; cv=none; b=B+V0z+UyCTVdDmD5QdPozN78nFzzr82xgd2AcyqEhDTT1MeH8NUfLqFwjopvpmh8Tp7UguQCH5wV5OhlYsiHiOuSRhdCtKV59DCSCjVFEv4oTH5EcGwhZixA84FEpQX5Awg8QzCn9L3gY1hSpLdmSVjwicQzYqafD+PUbNoC4yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422672; c=relaxed/simple;
	bh=dED1fsvoPPDQ4pwCz7+XwRKu1f8yHySJKwSduv+Lq20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRE6cjU363VTS0WPNS4W+tRKmEG3ahU8zTPWFfY8HceQsnnWpGkVlSlRQAeR+jNkzLuaeUFmgZ6GrUs95oYiqnh5JKfb8IJSAlRVCiFLZnqX8XHYmgmvdtoAc18AzxLER+bG0xb+r8Evmps/CTVrtRRrjnausKeTmH40gLeU/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-52f036ef186so819552e0c.1;
        Wed, 28 May 2025 01:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748422667; x=1749027467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Y6S2fpn88Y+LADx1uQi1HOUbcr69I8wgFh69LrgIRc=;
        b=Lr2aawk/sxreVqlQ9afb1Kekd2FlbzahER+jEcqOWzYB89jQ3IungpJSW3Lk2CM0Yp
         lpzKVRx51hgLdgND7TCD6wliYwwdPVqEKanU7q1MP8J6FWPw1lTxLzemIpd2/ikFS0DI
         Q8tYQwDUyurgckhobx8P7D2y6yJYXTh+JY2l7P24hnHvdoCHCvdaI8Dy6z1+6a1ndAzG
         +/T5CnL7eLZ62VWvH3iYDnjyv5bG8BDEzUUWl7gF0SO0ES3p6CrmR/zqQljS2wMghThN
         FllHhJb2wkTh5cU78Q4tl7xGTZhGOqFhSBvi/BBlo1amj78hZK5HIRmQMOMNh3W+7505
         KuhA==
X-Forwarded-Encrypted: i=1; AJvYcCUyTVewnIoLB+J3uiAujoq+uhSGiCRp1GClJHdvlafXbzrgthCRzd/QMfTf03yx1Ci6jUbhr3YAwpPSSw==@vger.kernel.org, AJvYcCXMCREmgL/eMCFcOQIRrfSxEefKR1YF0twFuaw0YYt9woPYIs4hZOEu7SzlUVwzbt/GpY9fzoIJiw2WPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMISdVn25ZAiE00lnP/bzZ8Yt06yaDBu9I9HcrgU7tupxxmwlp
	Fmx/NzNyZF2UUNcebCB+x4dIEOvVR93ttM4yCH4yBUXaSrPCz56myKSlok1tXEBG
X-Gm-Gg: ASbGncs5DNHU0Td7fk5Ew/j/TvP8WQSGtX4o0/5MGIMJSwOBaXOiieZSetMGFEihMVT
	zKRjLJK2+y6Tw4hmsLm/L06gEN89zHFcu1h2S3/iWpRuysrnK8DUZt4zrPRWNdcONGZ+SCo/95q
	wI/ur4HZ+wNvD+cCC49maBFDW8QEAGuZ13WcRPFYiG7Qr5YEGpiC6B18+tBda4rFlpoy5tFEQCy
	k36vnIDVgOEDwXFdWtSjEopfoBItqu/GQOnG1rcFMdfyzVVwf6xlccUCfVcfo2TeeTZfK1Jsm7G
	XtQ9EFnX6CEC5Ag7x4XZRyYk2xOKbPaMZ3sklI1wefq6PFe2xKYC9tCmBIwEPHVE5OJ+WdkvErv
	8UZGVn205eNff2Q==
X-Google-Smtp-Source: AGHT+IHye0Di+TTb0Q//6sLtUbpf5aCqhlILzeQmHKbN2IJSXWcw+7U96byEOmWeDdFuFAGtnXyo/g==
X-Received: by 2002:a05:6122:45a9:b0:52f:724a:c748 with SMTP id 71dfb90a1353d-5306689c85emr500621e0c.1.1748422666647;
        Wed, 28 May 2025 01:57:46 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53066750bd6sm626361e0c.0.2025.05.28.01.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 01:57:46 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4e58d270436so506396137.3;
        Wed, 28 May 2025 01:57:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2D47bi37WBbBRujWfQgNoiNeKqby+i6IUz0Ak2m9jYiL8oqssjgLnSYJMBCmF2Rgy7tyU7J8TD+Ncxw==@vger.kernel.org, AJvYcCVPTCqAanYtwyp22NzFrJ5hrWuJn2CI2KqhwXiVaYxGJn7o/Ge3PHtffbmlNiGzuIvbzhqUe7ANif86qQ==@vger.kernel.org
X-Received: by 2002:a05:6102:6c6:b0:4e5:5c14:5935 with SMTP id
 ada2fe7eead31-4e59ed21195mr675818137.2.1748422665738; Wed, 28 May 2025
 01:57:45 -0700 (PDT)
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
 <72078ec9-25a0-42d5-b7da-b0a974033f86@helsinkinet.fi>
In-Reply-To: <72078ec9-25a0-42d5-b7da-b0a974033f86@helsinkinet.fi>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 May 2025 10:57:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXDdrMewGgeghr3cwtaBvieguYOC4GZ-EXZmA+w5S4bpw@mail.gmail.com>
X-Gm-Features: AX0GCFvEQkwp2oID6KSffEq9L6LrcoEy6JF-dSlC7UnCWkDvCuPecuCzc1Xha6A
Message-ID: <CAMuHMdXDdrMewGgeghr3cwtaBvieguYOC4GZ-EXZmA+w5S4bpw@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/3] Atari DRM driver
To: Eero Tamminen <oak@helsinkinet.fi>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Michael Schmitz <schmitzmic@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

Hi Eero,

On Wed, 28 May 2025 at 00:47, Eero Tamminen <oak@helsinkinet.fi> wrote:
> On 25.5.2025 15.05, Geert Uytterhoeven wrote:
> > On Thu, 22 May 2025 at 00:56, Eero Tamminen <oak@helsinkinet.fi> wrote:
> >> On 21.5.2025 10.06, Geert Uytterhoeven wrote:
> >>> I do keep it up-to-date locally, so I could provide these changes,
> >>> if you are interested.
> >>
> >> Yes, please!   (see below)
> >
> > Sorry for taking so long:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=atari-drm-wip-rebasing
>
> Thanks!
>
> I did boot testing on Hatari emulator with a minimal kernel config
> having atari_drm enabled, atafb disabled, FB & boot logo enabled.
>
> Under Falcon emulation:
> - RGB/VGA => works fine
> - Mono monitor => panic
>    "Kernel panic - not syncing: can't set default video mode"
> Under TT emulation:
> - RGB/VGA => boots, but console is black[1] (palette issue?)
> - Mono monitor => looks OKish[2], but has constant warnings:
> -----------------------------------
> WARNING: CPU: 0 PID: 1 at drivers/gpu/drm/drm_atomic_helper.c:1720
> drm_atomic_helper_wait_for_vblanks+0x1a0/0x1ee
> [CRTC:35:crtc-0] vblank wait timed out

I am not sure this is a bug in atari-drm, or just an issue when using
DRM on slow machines.

> -----------------------------------
>
> Under 030 ST/STe emulation:
> - RGB/VGA => boots, but console is black (palette issue?)
> - Mono monitor => looks OK, but has constant slowpath warnings with:
>    "[CRTC:35:crtc-0] vblank wait timed out"
>
> => Any advice on the issues?

Are these regression in atari-drm, or do they happen with atafb, too?

> PS. I also profiled where most of time goes from "atari-drm" probing,
> until boot reaches user space.  On a minimal -Os built kernel, running
> on (emulated) 32Mhz 030 Falcon, in the default 640x480@4 resolution:
> ----------------------------------------------------------------
> Time spent in profile = 15.29712s.
> ...
> Used cycles:
>    22.37%  22.42%  25.35%   _transp
>    19.15%  19.19%  46.82%   atari_drm_fb_blit_rect.isra.0
>     8.09%   8.09%  13.80%   sys_copyarea
>     3.94%   3.95%   6.23%   sys_imageblit
>     3.69%   3.69%   3.69%   fb_copy_offset.isra.0
>     2.12%   2.13%   2.41%   atari_scsi_falcon_reg_read
>     2.03%   2.03%   2.03%   fb_address_forward
>     1.85%   1.85%  17.98%   fbcon_redraw_blit.constprop.0
>     1.81%   1.81%   2.04%   atari_keyb_init
>     1.78%   1.78%   1.98%   fb_reverse_long
>     1.58%   1.58%   1.90%   arch_cpu_idle
>     1.05%                   memcpy
>     0.95%                   memset
> ...
> ----------------------------------------------------------------
>
> => atari-drm blitting takes half the time during boot.

Yeah, conversion from chunky to planar is expensive.
Would be great to have a text console that operates directly on the
buffer used by the hardware...

> Building kernel with -O2, changes above rather radically, both
> time-wise, and where that time goes:
> ----------------------------------------------------------------
> Time spent in profile = 6.54049s.
> ...
> Used cycles:
>    17.61%  17.61%  17.61%   sys_copyarea
>    11.18%  11.18%  13.11%   arch_cpu_idle
>     7.53%   7.55%   8.45%   atari_drm_fb_blit_rect.isra.0
>     4.26%   4.27%   4.76%   atari_keyb_init
>     2.70%   2.70%   2.93%   atari_scsi_falcon_reg_read
>     2.45%   2.45%  23.81%   fbcon_redraw_blit.constprop.0
>     2.35%   2.35%   2.48%   sys_imageblit
>     2.12%   2.12%   5.89%   atari_floppy_init
>     1.97%                   memset
>     1.31%                   memcpy
> ...
> Instruction cache misses:
>    27.14%  27.14%  27.14%   sys_copyarea
>     3.77%   3.77%   4.05%   atari_scsi_falcon_reg_read
> ...
> Data cache hits:
>    63.55%  63.55%  63.67%   atari_keyb_init
>     7.61%   7.62%   7.84%   atari_drm_fb_blit_rect.isra.0
>     3.86%   3.86%   3.86%   sys_copyarea <= not much hits for copying
> ...
> ----------------------------------------------------------------

So it would be worthwhile to factor out the code that is most
performance-critical into its own file, and use CFLAGS_foo.o += -O2
(or even -O3? or other options?) in the Makefile to build it with a
better optimization level.

> However, -O2 build has the downside that the resulting kernel Oopses
> once it reaches user-space, if 030 data cache emulation is enabled:
> ----------------------------------------------------------------
> Run /init as init process
> ...
> Instruction fault at 0x0041a256
> BAD KERNEL BUSERR

Interesting...

Thanks a lot for testing, and for your analysis!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

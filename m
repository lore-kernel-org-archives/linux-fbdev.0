Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A6E4C6D;
	Sun, 25 May 2025 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748174768; cv=none; b=iOb1Ns9/vrbjGdcI9bwOjTGq3BKC65tLVujjMJW3o/zLYUL2VuPhY9BSyGSDD9zGHvBGg4GPpM6x3J/YoInUIUBn+voLW+76iOZ8WD9j/aKk7iKDY8fSNyXvuinmpvFT7haoU8YLwlonX9fG39tiS2WjrO7TXEffka2Cb1E3rjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748174768; c=relaxed/simple;
	bh=HeY0m0KcZxf25YKk1RmXBuywS8wPR0/NzzfWZ+XULI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rwv1yQ/tUwQzABgxzQHbdUC7eK8OcSRDR7ry5TSrYkfEsbeV6tTiqJFW4AZS78lqCOjRqKhjQEi3JWNAkrwz6TuMkmVvuA2uBg/phnUwsUAHbFGPZBGh8BbK2Y2y3M26iD2LFqx3hWwyvUOaCMDT/osYMODlLNbcSaLKKdVW6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f8b0fdd5ffso13316866d6.0;
        Sun, 25 May 2025 05:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748174762; x=1748779562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcNmR9Oh3gKmhm4mVv3+Bc2mhBpOXuGq3s3rGdk5N+k=;
        b=c+9P8ebFgy7aDJTV2lrS0Cv9SScHaSxGBS4agJHRb6NZH9zjW/PF3SW5XBOUNYFe4r
         c6/Np9PJHkL58xYs8xKsXBEQYbqQuH+CiZotjhY8kuY/Q1H7ocaUUxVX+MumqZ6CKhUb
         icN1b8Zx6g0t3Se0IwX8GPRJG5g4vBj41hMVtV+Uc9wOez3NrH0300Win0Cszi7shvvA
         rAgW3IMAtcNRDhJYMytq2vpjp9CrGipFvS3h5d+5ibElrfUbcz16ZLWud58mmFb0ML95
         WaaHiIulbYDXr0peTKBHAXoAJNA2quqA8+nnVRGsRO4ZYBmFUEj3jSznhyHHFk32bH+e
         3vzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLL9z+LOnh+ysN1+Q8f40RSAEueRIcXw9ZLR1nh2kMaWUbKoA64ggfityx3KpoEhwJEb+6Ny9MRpIMDw==@vger.kernel.org, AJvYcCW33M4bxO3rDTO6QRdfQmRWIsWHvg7GBzR2X+y8LMrd/Q4fBsJw7nuLeddl5ttz1nb8hdPCDnr6+sgfAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfj22B0rru4gqiAdLrgJeeLguSZ5fnbPMEyvx2wn/rxU8rDDzj
	zOOIUwx2jOgpmhiowsNS8wUMR/dWnLcjyZoYUuXhk/D23TxBkWyA16XTmq0f8OVk
X-Gm-Gg: ASbGncuzZCSs5vBR+kwbQWDZd0HgyFEQ35/y5882luqfdQWwnol462ZxImnxI0gjzJB
	y+XxvXVpOY0u3XgW9X4wtBrIREww1/SyMtMqt0UPdRNgnlfUXZYzXeCJDmx6zQOLsInDWLlZFy4
	DilOQqMZ/JQh0Wk5TIksjM6zWn8ikcEk60jeY6lMFE6T0lEU7Tl4JRZYrrsqvQvCgHUzLtVvff3
	x8PiyAyzo8446tBKJGzlkBVxEgZP4W5RK0NgwsheKPnexREupjI5lWfKePCK9tEf87otNqRX9ij
	pn8ssNtTpmpJJtgk7IA0sn2k73Ct5tahVXMs6IVX8uZVgGunGGCZUtSUSuRbfO+6oCVfXpfmw3W
	PLp5gDux32hEhZMGcdA==
X-Google-Smtp-Source: AGHT+IEIJUnm/lAFw4HWwOk9iO5zxCOZjRRoALZvj1eXLFqDbSwLI/spWZYXF+UWbxyIDMxlj5stag==
X-Received: by 2002:a05:6214:401b:b0:6fa:864f:87cc with SMTP id 6a1803df08f44-6fa9d2a8d1bmr105143206d6.33.1748174762445;
        Sun, 25 May 2025 05:06:02 -0700 (PDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6faa48185bdsm10564726d6.6.2025.05.25.05.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 05:06:02 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c560c55bc1so154925085a.1;
        Sun, 25 May 2025 05:06:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJO/P3hPGRqG38iOn+IEbjTWcM++XMtesrJCoUVeurTyhoUVOz/EUC2w2QCzsTYTZtl1iTiUeFNZeKlA==@vger.kernel.org, AJvYcCXtRuqBICb9tlISlXipWByJ1BqAkajcSN2NAy+/v/xbnJx2FDPU6PJQd8o3+qN9eyBAj9rf1tNEKWQTDA==@vger.kernel.org
X-Received: by 2002:a05:620a:6183:b0:7c7:a5e1:f204 with SMTP id
 af79cd13be357-7ceecc299d8mr920946385a.56.1748174760848; Sun, 25 May 2025
 05:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1669406380.git.geert@linux-m68k.org> <a9883a81-d909-09c5-708b-d598e030380e@physik.fu-berlin.de>
 <CAMuHMdWHUnWBN7ddBow+fqmt8W--9wFe5x_YMeRg7GQ=BNAL2Q@mail.gmail.com>
 <74946b31-6166-44b0-b2a7-b0633f014b60@helsinkinet.fi> <CAMuHMdXSWiM_xofyfgpoc0Jj8a_PwRR_tFe79t8=-X85-7WZug@mail.gmail.com>
 <beed53f4-b0d6-4d1d-b5ec-2694d2b5d47a@helsinkinet.fi>
In-Reply-To: <beed53f4-b0d6-4d1d-b5ec-2694d2b5d47a@helsinkinet.fi>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 25 May 2025 14:05:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUSADF51tBbGV=_nsxqyXgfNZcgDNGxuZ4F+tvYs9Q2aw@mail.gmail.com>
X-Gm-Features: AX0GCFsstb-MFo59PFz_9P24KO-yVVLC9wRdn1-wDiAWRZRayXjN0xIbl4qIHFs
Message-ID: <CAMuHMdUSADF51tBbGV=_nsxqyXgfNZcgDNGxuZ4F+tvYs9Q2aw@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/3] Atari DRM driver
To: Eero Tamminen <oak@helsinkinet.fi>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Michael Schmitz <schmitzmic@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

Hi Eero,

On Thu, 22 May 2025 at 00:56, Eero Tamminen <oak@helsinkinet.fi> wrote:
> On 21.5.2025 10.06, Geert Uytterhoeven wrote:
> > On Wed, 21 May 2025 at 01:59, Eero Tamminen <oak@helsinkinet.fi> wrote:
> >> I tried your "atari-drm-wip-v1" branch commits on top of 6.14.
> >
> > Thanks for testing!
> >
> >> After some minor changes those applied. Getting it to build required
> >> adding "&shadow_plane_state->fmtcnv_state" (struct drm_format_conv_state
> >> *) argument to *_blit() functions in atari_drm.c, and changing:
> >>          drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
> >> in its probe function to:
> >>          struct drm_format_info *format = NULL;
> >>           drm_client_setup(dev, format);
> >
> > I do keep it up-to-date locally, so I could provide these changes,
> > if you are interested.
>
> Yes, please!   (see below)

Sorry for taking so long:
https://web.git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=atari-drm-wip-rebasing

Enjoy!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

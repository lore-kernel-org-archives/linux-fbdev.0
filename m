Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E342A93
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Apr 2024 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339049; cv=none; b=GoXvmMZBQIMn9RF+/QM8axRU1BhYWMdcqCmHL+BeWHqkOiI2YpKvO8zgVUnYCQDcGfQ3fqNEG0Y6JHRt6ztejN0l9Fo3uWMIQkCAOSGDiafVOsl9/eIFerFMKt71Ufy1qHDuQWMY8Wheb/rRxIaNpjxbdRD4CLq/5gHPhcqQ/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339049; c=relaxed/simple;
	bh=CY5vZpppUnJD5B5cVidYvEinCvrVfBOPSlq3gg5gbiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecHIJiVTKDA3mWOCytwA9IW8w50swTKuaVitPcnnhAGrdIEIC9HvdRiuve7zmlxpgLM1RxC0H2owQreAh7sUpA0Kd5W/WcEaJkcNP9ryCzGjqYIg1FJptMrX87773sPVc5mdme0RCDHhBWEEwfQOQGtlkes9M1MBYIJRbcFaP8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6181d032bf9so50827347b3.3
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Apr 2024 00:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713339045; x=1713943845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtInziVXajqdYdbn8kqIjqOC2K657alE2kZmp/MOz+Q=;
        b=KqQXO2+4MudZKaFXKGc3YX1P/vIWQ3UUvHdFrYTFpYrPkkd5wnZxc+BjijFc/bRZBO
         wDLKZgRQ87cIRt9fWISKm2W0ppr5YwV3q3l2sa7/7xX9yK4MJH1T5noxjliOKnMvSWcW
         9MiPNgJ0MxidgUDR213GUiB4Xgdj25M+FJBcYd7GXlKkjVz3U/6qGB7aTdFPn1rHD7GL
         V4TWi120bfxdPj0Nj0GSZZO3DKgD5kGAmrrn7jIUWunDfzcN72/PGidj9sEKgSx2fBZ8
         RSSwsUBTEuPsTrgeOwiI/A8FObvA/1DRsBPb/GUvKOJ8vTFfohx01jUNaR52bz0eXwTE
         ptDA==
X-Forwarded-Encrypted: i=1; AJvYcCUqSuS2IPrL6uVPlXdXMvpc/WKwCM2FuZDi0TEWB7SxW23/5BpNxM6VtnXbiiYoDXlri3G5CfWn8Y5GHyjL8Ol/yqFqBdpvl4DX1XY=
X-Gm-Message-State: AOJu0YwL+OP+dTHFpT0ncipk5FRWfDC6nAN3ng5YVk2HsAruu2HnFkaa
	vjBMnlE5Wd7sb/XXMqOGImHhZ5FyByF92D8WYH+F8dhu/AxugBoSiloTX9pA
X-Google-Smtp-Source: AGHT+IFN1sSbKorW/YOvRfRNxcsTOuIGvDWhWQJIReQ0u9FM+tE5cb3FHgM8qIyli3PX3qw+0nEVAw==
X-Received: by 2002:a0d:df15:0:b0:61a:df6b:9d71 with SMTP id i21-20020a0ddf15000000b0061adf6b9d71mr6246363ywe.48.1713339045271;
        Wed, 17 Apr 2024 00:30:45 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id cs20-20020a05690c0ed400b006144cc8edccsm2809421ywb.140.2024.04.17.00.30.44
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 00:30:44 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so5073638276.1
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Apr 2024 00:30:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtv85B0zwg6cBaCWi79w4Ce0Vazdp/waHLXchsdIYwMG/gQWsVBgHU7raFR71O/dYZf3fSpiEaJvVNK8P2WnBbcjI4XiN1LDDEaKE=
X-Received: by 2002:a05:6902:1b93:b0:dcf:288e:21ca with SMTP id
 ei19-20020a0569021b9300b00dcf288e21camr16085636ybb.11.1713339044217; Wed, 17
 Apr 2024 00:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410130557.31572-1-tzimmermann@suse.de> <20240410130557.31572-9-tzimmermann@suse.de>
 <87r0f54kir.fsf@minerva.mail-host-address-is-not-set> <6cdccec9-e1a1-477b-a41a-4fb9d94d3238@suse.de>
In-Reply-To: <6cdccec9-e1a1-477b-a41a-4fb9d94d3238@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Apr 2024 09:30:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJCKnJi-jk1wipUgLfbEqneBpmG5OsMMnMAnhAW9xApQ@mail.gmail.com>
Message-ID: <CAMuHMdVJCKnJi-jk1wipUgLfbEqneBpmG5OsMMnMAnhAW9xApQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/43] drm/fbdev: Add fbdev-shmem
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>, deller@gmx.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Tue, Apr 16, 2024 at 2:07=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
> Am 16.04.24 um 13:25 schrieb Javier Martinez Canillas:
> > Thomas Zimmermann <tzimmermann@suse.de> writes:
> > Do I understand correctly that info->fix.smem_start doesn't have to be =
set
> > because that's only used for I/O memory?
>
> It's the start of the framebuffer memory in physical memory. Setting
> smem_start only makes sense if the framebuffer is physically continuous,
> which isn't the case here.

Nothing really needs fix.smem_start, it's mainly for informative use.
However, if smem_start is not page-aligned, userspace does need to
know the start offset inside the page (see below).

> > This also made me think why info->fix.smem_len is really needed. Can't =
we
> > make the fbdev core to only look at that if info->screen_size is not se=
t ?
>
> The fbdev core doesn't use smem_len AFAICT. But smem_len is part of the
> fbdev UAPI, so I set it. I assume that programs use it to go to the end
> of the framebuffer memory.

On fbdev drivers also exporting MMIO to userspace, /dev/fbX contains
two parts: first the frame buffer, followed by the MMIO registers.
Both parts are an integral number of pages, based on fix.smem_{start,len}
resp. fix.mmio_{start,len}.

Old XFree86 used the MMIO part to implement hardware acceleration
when running on top of fbdev.

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

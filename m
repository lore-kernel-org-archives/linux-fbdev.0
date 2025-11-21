Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE9933E349
	for <linux-fbdev@vger.kernel.org>; Fri, 21 Nov 2025 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719407; cv=none; b=rr/dnXMTfkMZc6gsZ6gX7UrZTIwavSV3jSEgpfhJLsbYXwnTYEAoqqXap8Ks0hSvQCRYyhZPtvlqstAY1mYyDfYaBv3qqEdVYUCO8WCuwpo4DN5TbandC/6VP55YjYa1bR2EIvtbqHgU8JbDhb97+dnfATIaw1K8lZ46ekCcmNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719407; c=relaxed/simple;
	bh=TeUAIYoYe5WG9QPmEwZ5LJi25FDVtq2bv+Us8Wz9dgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhdEbooxpmhZAuBsWpdF+pYDQFvs59KoN18SNaYTbOojYygnyHz0zRpwSU/oAJczMU43ye28+rvm842ozm7CNGvHOixpuHJVG7ule91w3ZuLbljwIebvsl2fdftowCdIbA/QEHKR/Y+NvWlbTIp/9/67Odax0iznosKXkvbi0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9372a52af7eso575248241.3
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Nov 2025 02:03:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719404; x=1764324204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlBMUu/EpwAnMbRqR4FueGr8bEwdrvt/wf+TDoxxT9k=;
        b=jglvfvRKot5MfCq4BnRI7/b/eVz635VH+N+1C9/N0duYzb4RbJ/tBKJmQyeta9F7fr
         2k4/a6p9s20eFi2WDUr+dY1ckj33258jl03BnG61cu6IkiHWmxJd3c7N50Rm8qWEeYmQ
         P/r/GMcDwOGmObwbKW6h2nCRJC/BzrgmvDQ9eFNF+bm9dqO/Lt8g0v1C4X3RQOVRi9Ko
         qFqv+L0ucm7bq9T513j+rKYv/aOPiRxMjLIkB3v7UdwUPvUIhTmqqppHKbuVb4mIIayb
         xYrGE41Qc9c2nuTpAOYXk0cqxUQTdew17SYaSEqnHvOkHTrQS8t9V8v+7CvGJlYh1Rxb
         1W2w==
X-Forwarded-Encrypted: i=1; AJvYcCXNL3sRjn1f4wnzBjNwpfVLZTMLYP0dvNBGaHWogbP5rv/RN5RuwTgEXLuElVY6fFKPF8V70WzIR5FIBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHUlZnxL3IR6hpOYRc3setKfpNL/DI20svy1KFR0yb4b9CptWI
	lKwBgfbyr5W1VguHTp1AYiiv215PsSCEhZl4OvH4xH/MXNqdf4Cen/bXkkVaYTyT
X-Gm-Gg: ASbGncsikX92AVRAp54RSPucICR7inAr94TKkMWux9mPI8RFC2LlfzVjUG8ejZs+KzH
	WqV1D25mnOQz/V8N4V+8ctHUa5CLN1pxQ5kZSyNIrbDUWul9ikGPIuIj9LuqAEcbQ19SvQU4sa3
	g62sXwQ8lgYsQYkXKRwpClEltgNvxJSmLXp3rdU7VUcRVgwtWezYO/zdaOPMLon9DX0LjArlYsh
	+79jYnoHcB9bibA1ch+r2nQssXUtRYjVUKI2rzMwssaqPBr7wLkbpqmbroZw7ulEPBEtWgZOUlX
	lBzjhYo8RmFMA2AOfpwjQCbzLhW+SpdH6j5dC2Dvr4E/UqxmdvEjOkKkKfbizuF1lI2q2z3zCiU
	EwTw3gNwlIiXtTioq6Anih6hoWCzLaTudZ7a53l2FmXRrpPbl4FmTtz/aGJ/rhcDKVpMiJFUloz
	XwES0y4WSwdrq78GtWOPMVl7cIXKIangGCUIY8+oGI6TP++Z19
X-Google-Smtp-Source: AGHT+IHDP0sTU9unk4Hje09RyXKu/FxY/5+K1wncIOwqO2Xy/VHe5gubgoWFm/YwJlMhgFr+zRDLMA==
X-Received: by 2002:a05:6102:3e23:b0:5dd:89d5:6e3a with SMTP id ada2fe7eead31-5e1de13b7e3mr333190137.13.1763719403666;
        Fri, 21 Nov 2025 02:03:23 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93c561c3e95sm2069097241.3.2025.11.21.02.03.23
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 02:03:23 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5dfcfbcbcc0so643013137.2
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Nov 2025 02:03:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNvvMPADKidzHDFv7qn+Kko9e6E/SX/S14qrrrmoV9kSI2tvkAtO1VVsJ9EJAsYFLiYIB6Y2ngZhJyNw==@vger.kernel.org
X-Received: by 2002:a05:6102:579a:b0:5db:33f9:adce with SMTP id
 ada2fe7eead31-5e1de3d42camr385692137.41.1763719402998; Fri, 21 Nov 2025
 02:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120180233.763975-1-hsukrut3@gmail.com>
In-Reply-To: <20251120180233.763975-1-hsukrut3@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2025 11:03:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV3UvDHT0uu8oeiCGc9pURaLPDPmG-Fu9kC9H8DQyqRDw@mail.gmail.com>
X-Gm-Features: AWmQ_bkayHVM_Ddsfirz9lK5uUvThJmyJwFAo8HPyX8vy-dtp3QKVrq4J4AGcFo
Message-ID: <CAMuHMdV3UvDHT0uu8oeiCGc9pURaLPDPmG-Fu9kC9H8DQyqRDw@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] fbdev: q40fb: request memory region
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: Helge Deller <deller@gmx.de>, 
	"open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, 
	"open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	shuah@kernel.org, david.hunter.linux@gamil.com, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Sukrut,

CC linux-m68k

On Thu, 20 Nov 2025 at 19:03, Sukrut Heroorkar <hsukrut3@gmail.com> wrote:
> The q40fb driver uses a fixed physical address but never reserves
> the corresponding I/O region. Reserve the range  as suggested in
> Documentation/gpu/todo.rst ("Request memory regions in all fbdev drivers").
>
> If the memory cannot be reserved, fail probe with -EBUSY to avoid
> conflicting with another user of the same address.
>
> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>

Thanks for your patch!

> ---
> Testing: This patch is sent as RFT since Q40 hardware is unavilable and
> QEMU does not emulated a Q40 platform. The change is therefore compile-tested
> only.

I would suggest not to apply this, unless it is tested on real
hardware.  It wouldn't be the first time an innocent-looking change like
this breaks a system. See e.g.
https://lore.kernel.org/all/Y5I2oQexHNdlIbsQ@shell.armlinux.org.uk

> --- a/drivers/video/fbdev/q40fb.c
> +++ b/drivers/video/fbdev/q40fb.c
> @@ -101,6 +101,13 @@ static int q40fb_probe(struct platform_device *dev)
>         info->par = NULL;
>         info->screen_base = (char *) q40fb_fix.smem_start;
>
> +       if (!request_mem_region(q40fb_fix.smem_start, q40fb_fix.smem_len,
> +                               "q40fb")) {
> +               dev_err(&dev->dev, "cannot reserve video memory at 0x%lx\n",
> +                       q40fb_fix.smem_start);
> +               return -EBUSY;
> +       }
> +
>         if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
>                 framebuffer_release(info);
>                 return -ENOMEM;

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14AE3E1687
	for <linux-fbdev@vger.kernel.org>; Mon, 25 May 2026 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701533; cv=none; b=InVZVZTzwjtRBkOI3yG+45RcDl5QdIEoC1doXMN0MojeH5pL4F6c/sLSYYf+/A7NE/AePl8/xCUYu04e6iuDHMoB5jBPSaXuiHZ7WGo36LoUiG/X1O3q0NPSDFoiU/SKvjsd8GdFcAu9157aqWceus+ave9sccYYe4i0pli7rQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701533; c=relaxed/simple;
	bh=F3j8bn8C23dyjaICaMthGn3o+lmAmfGBHoEEw/K40wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5GMLQCz9/+7AOsBZy198PU1qb3FYe3+DUtxswU6smJmaLQojjdR5NahenB5z87NhvK4V0C0erOWNWpjA1Yv8yoTbPhj1nBpG+dTOV2Jjl606jiip/2m62W26hcREFilkSNHKvL1oK0ueMum4nnwMwd6+jizFZeCoxcsB+ru8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-57524e52a3dso7930137e0c.2
        for <linux-fbdev@vger.kernel.org>; Mon, 25 May 2026 02:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779701531; x=1780306331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rWcIUH/SvbVRnVZe/oNltSq1THolH7A9MSmV5+ZKew=;
        b=AaowIwn2NNPxeEURexVHgnLr+3DFiGi/gy+mbfNWjWOgqg2YQ8ie8vq/4HNdYPupiP
         DltBz3SxwiN6UtN0IicPzXVABP+mY0RNTfdoUdV6LL7hW4k6Ar+AMv5BPOm0Tb3Bhcnm
         EC9J4Tt0x9kImnS/fhIx8MuV/kKimtPumCVX1Xdrl82v3vZfAdsPrqhT/SVlYevobUD6
         2hYHwbvyvffF+VbEj2zZ1hYRPCfo+KIXShcGgmuAVi6eXG3vSt4TK+Uv6rHoeHVx/j9G
         6YorM0/PrgvaCKIjhIjUav7jxYoCbMwoN+Z2S8ZhHE7peJAhs7rRvNxOldfeqmYu/SNp
         0dHg==
X-Forwarded-Encrypted: i=1; AFNElJ9WTEn2TQak6dw9s6Nj0P3RaGhJwE4uByGAXEgjKq9QNJTW8cpnAAaQ2czsBnzP0BiOpYFRY/onnNVgJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDc0xpZk1iWBBAuWU9k2S5v9yTgjHihQQWhBppjH/HwG2yJfg
	kz+Jlp6wBcUnYPfaA5nr0WkrSrq2jOXF5sxKcb0g614wZqDZpQMceQhzquclGnqc
X-Gm-Gg: Acq92OGBRb5TjgObpLckdl8jAXEa3JkRJp3OYlqY1iBRuH3TKMelptdjW2gbzzqmZP+
	iNNikrlKl3DwBmnWw8lUvqjou/wPS1yI1idgqy2AXQEka/S5/9wRH31ZjI8ZU1WV2IQz3p+qHSZ
	qVl0n7m8WLuLe0DhvJsVX8iS3IxIMkoxmLmfJ68hR2FLJD+vXWhneGp+sXBAOaDyflTtTu9EAFM
	TT6/SARGKmxgfClZ3X1ksIPwvuH5Y74oDWPcRXY6XhMLETiiD6fGjQyg0/GOSwiJ0Kj1awMwZik
	4ISv4/diSSnknQApchUf8WnQxElku+c3aECOeJ9uNCyDRCljRKaK8WZXtl8Ob0pcEinHmYF+c/B
	ORR0qsE40Tj5ZSSooSdF79OGYDab2uq3BQ6wXmIRquee90wSc2eQUzZzLzTe5QyvzRr743t/C9N
	9vAaG16twNZfDFcznEOUUgF+N9F+8gkd2GGG4KpHUB924HKKUSgh0jhVMh6CDnSM5x
X-Received: by 2002:a05:6122:2203:b0:56e:e80c:bb25 with SMTP id 71dfb90a1353d-586649efacfmr7350808e0c.13.1779701530696;
        Mon, 25 May 2026 02:32:10 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f2f791d1sm11162818e0c.5.2026.05.25.02.32.08
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 02:32:08 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56f70865797so5922548e0c.1
        for <linux-fbdev@vger.kernel.org>; Mon, 25 May 2026 02:32:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+MWNVajDSuZBUcVgH0HbFvR1s07+ZSmuEd3YQeSQOW9rh9mi/k5vLnX7DxqQ1mjLMIZfIMSLWOOXkN8Q==@vger.kernel.org
X-Received: by 2002:a05:6102:3f4c:b0:5ff:f4ae:a154 with SMTP id
 ada2fe7eead31-67c70e6750amr7086176137.1.1779701528081; Mon, 25 May 2026
 02:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522123019.211059-1-tzimmermann@suse.de> <20260522123019.211059-4-tzimmermann@suse.de>
In-Reply-To: <20260522123019.211059-4-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 May 2026 11:31:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXKF=fSZLqQiOuxDvygBDVSZKD+CQ3Rj+R4E_rYrz-WtA@mail.gmail.com>
X-Gm-Features: AVHnY4KfFcrlo4zm05PN319uvgzumHDBn_61S2KqpCQpRdYnyThN8ALdwa-6KzM
Message-ID: <CAMuHMdXKF=fSZLqQiOuxDvygBDVSZKD+CQ3Rj+R4E_rYrz-WtA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] fbdev: Wrap fbcon updates from vga-switcheroo in helper
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, simona@ffwll.ch, airlied@gmail.com, lukas@wunner.de, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Fri, 22 May 2026 at 15:11, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Handle console remapping in fbcon in fb_switch_output(). Vga-switcheroo
> invokes this functionality before switching physical outputs to a new
> graphics device. Open-coding fbcon state in vga-switcheroo exposed fbdev
> implementation details.
>
> Vga-switcheroo is used for switching physical outputs among graphics
> hardware. This functionality is only supported by DRM drivers. A later
> update will further move fb_switch_output() into DRM's fbdev emulation;
> thus fully decoupling vga-switcheroo from fbdev.
>
> v2:
> - use '#if defined' (Helge)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch, which is now commit 91458b3f2a84bc7b ("fbdev:
Wrap fbcon updates from vga-switcheroo in helper") in fbdev/for-next.

> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c
> @@ -31,11 +31,9 @@
>  #define pr_fmt(fmt) "vga_switcheroo: " fmt
>
>  #include <linux/apple-gmux.h>
> -#include <linux/console.h>
>  #include <linux/debugfs.h>
>  #include <linux/fb.h>
>  #include <linux/fs.h>
> -#include <linux/fbcon.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/pm_domain.h>
> @@ -735,8 +733,10 @@ static int vga_switchto_stage2(struct vga_switcheroo_client *new_client)
>         if (!active->driver_power_control)
>                 set_audio_state(active->id, VGA_SWITCHEROO_OFF);
>
> +#if defined(CONFIG_FB)
>         if (new_client->fb_info)
> -               fbcon_remap_all(new_client->fb_info);
> +               fb_switch_outputs(new_client->fb_info);
> +#endif

What if CONFIG_FB is modular?
CONFIG_VGA_SWITCHEROO is bool.

>
>         mutex_lock(&vgasr_priv.mux_hw_lock);
>         ret = vgasr_priv.handler->switchto(new_client->id);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

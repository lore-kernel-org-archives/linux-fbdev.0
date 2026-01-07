Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com [209.85.221.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44A235975
	for <linux-fbdev@vger.kernel.org>; Wed,  7 Jan 2026 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767782230; cv=none; b=X0bJnLTiM+LDJWgj5X3egSG/Q8FlI71p8RmmDBx28sb8bnKiK82ocnPjk9XkPsMhHYRatJ8K5MfKQgNJ/25zHo/v231JnFh7k8zpIH5xFfPcgMWHYhSlBuhI47MKW1PnPswqIDU0pjt61ra132e9iS5VtIkbv9NkaMLRrtyTuNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767782230; c=relaxed/simple;
	bh=GodLXSsnWrNdZeqyDmGiRErnjF0qHoHPpF4pgtaEMSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2iyVE5B08jDzapQ9JELgSvdVgFeveqZ5ou6Kv+iU49AqGebWTBTGYDDhw4TO01g5BY+Q/p3Zu2vl+dFkja1PRM2WnRiIgevRP/VkwGk5eG4OpgS2IJgCrZaFWVjM8WrnRdsVFiOoTD1ST8tP/wBapReUZJjFmt8ga/PBgLOzRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f194.google.com with SMTP id 71dfb90a1353d-55b22d3b2a6so536461e0c.1
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 02:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767782227; x=1768387027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvR5DRwy1DSGr/ekGfe0RQqbV4Hkmy/mYDx8B3sEcoo=;
        b=bIB42fmIKh+cQzQ4U+88GD7oxcyHlUTaJ9gBX5H/eM+Mcxmdi6CqJpLkQODPQjiCB1
         uF9KMfmwdo1Qo+thyklT74zk1yeoUXOH8cfLMbbiKIrkaWPmfFwgvgaQkua/MkAhHXTN
         U+mMtq3Sh9s77QS0wOQzHkCHHRvLgNDnVbKgPekU15MjPp4jC/nxTlVmGB31RCOiRKIQ
         r/wN27SpZBhOJGO7ftZtdhiqn9eNecJgrz1JFLPz99XC1nfv/+ihDLh2CiHp87tNGJgx
         IPwPm+YCrOPdb0S+qRUWLOGpsiuFnG5+VkuhbH4SaRMXFLZmEML9AhjnepiYvv67w7wr
         /Bag==
X-Forwarded-Encrypted: i=1; AJvYcCXHHqOSqgsxNBq59W41jZzQ3XATxTDmiug5g9Tl8XYgibfCmxCqjQmpFFPrn5H91EPIupRRFfIOBQ/Z4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrqI/XgK6rdCpnE9wZhX3oFYkJT1GUpFAkv9R0aQJjf5MtSYGo
	hDF80OE/3z8jIZc8/7R4om89hWizYPE+4+XxNx0eh6VzeS8hNvWJ+ot0jR4YKdkb
X-Gm-Gg: AY/fxX7ICWN+lK20sPQMmfJ8otBnvzsfhVtluY0sDDoGUDUIIwRDNMJ8PfvXFYQo+s5
	3x72aN2lH9N9t+nl1jT8llp07gpcHK4UKAFdMWSQ3wlyTpNQPgRxUluPhWDrMjcypBXIyX3USOQ
	xjtE7607R6/AazR2Hcm61a/I+pq+uuYXJ7hlZ/4NoxkvNu72hZjBn2q943vY4OjIUI1FVsLpiN+
	YfdHv5GirRQPB7Fr4JQOUAADACC97cQVZEUaAe7WbXbBr8kyd7uuNJdOCZiSlyHVlpQqfEKg/Ej
	4ysNJD1EUv4oYy8apu1+6R4CJoPooNJ3KTkjPfmBVdHgUGXp3xSotF9egT59rdsa+W7GoA7EE/y
	++o/BqjDNWAj68NZgZUD4ishvZlMQlh5GJkMDxrC5EyX7na54wqZX5IX2cUdwkxmUKQVf+vLwyB
	bO2YJ9MXAS1o60p+M6cFKzj2C2xcralWmHqlus3XDVRHMY0cx5gOMS
X-Google-Smtp-Source: AGHT+IGMpS1vcszfZ24YVv/K5Bxqd4CglgOzHGOgK+iyYjltECW5VxGkc3DbHj1MUk63NYUWXiZufw==
X-Received: by 2002:a05:6122:488c:b0:559:14e2:9fc7 with SMTP id 71dfb90a1353d-56345f1d477mr859404e0c.0.1767782227438;
        Wed, 07 Jan 2026 02:37:07 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a3f6c0bsm2449908e0c.13.2026.01.07.02.37.06
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 02:37:06 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-563198aea21so487748e0c.0
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 02:37:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPXR226sEv+nKsgyu+ozauKcoxUF5KlIKLTxWaKbaUisgkytE1cNcebx6OymhkyYJ1pRvACs+g85OREw==@vger.kernel.org
X-Received: by 2002:ac5:ccaf:0:b0:54a:8deb:21a7 with SMTP id
 71dfb90a1353d-56339dbf03dmr1504773e0c.4.1767782226762; Wed, 07 Jan 2026
 02:37:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101-custom-logo-v2-0-8eec06dfbf85@kernel.org>
 <20260101-custom-logo-v2-6-8eec06dfbf85@kernel.org> <CAMuHMdVy48F5HAfqfJgbY83KDAztb9YWTqm8mT1ntTfj0311oA@mail.gmail.com>
 <dda4052e-b843-43fa-850c-a1bb20e4a8e3@kernel.org>
In-Reply-To: <dda4052e-b843-43fa-850c-a1bb20e4a8e3@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Jan 2026 11:36:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXz9uKxQ0dH68a+xt4FHqVgdskvO3QRvev1_Wq8h-a1Qg@mail.gmail.com>
X-Gm-Features: AQt7F2pWk5T5DK2Ps7GBdxmwjo6y5zM4oGY-k4cbzlgDPgVvKEzWy8YEHXjK3cA
Message-ID: <CAMuHMdXz9uKxQ0dH68a+xt4FHqVgdskvO3QRvev1_Wq8h-a1Qg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] video/logo: move logo selection logic to Kconfig
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Tue, 6 Jan 2026 at 21:10, Vincent Mailhol <mailhol@kernel.org> wrote:
> On 06/01/2026 at 12:48, Geert Uytterhoeven wrote:
> > Thanks for your patch, which is now commit bd710b3da7308cb1
> > ("video/logo: move logo selection logic to Kconfig") in fbdev/for-next.
> >
> > On Thu, 1 Jan 2026 at 16:26, Vincent Mailhol <mailhol@kernel.org> wrote:
> >> Now that the path to the logo file can be directly entered in Kbuild,
> >> there is no more need to handle all the logo file selection in the
> >> Makefile and the C files.
> >
> > This may do the wrong thing when booting a multi-platform kernel.
> >
> >>
> >> The only exception is the logo_spe_clut224 which is only used by the
> >> Cell processor (found for example in the Playstation 3) [1]. This
> >> extra logo uses its own different image which shows up on a separate
> >> line just below the normal logo. Because the extra logo uses a
> >> different image, it can not be factorized under the custom logo logic.
> >>
> >> Move all the logo file selection logic to Kbuild (except from the
> >> logo_spe_clut224.ppm), this done, clean-up the C code to only leave
> >> one entry for each logo type (monochrome, 16-colors and 224-colors).
> >>
> >> [1] Cell SPE logos
> >> Link: https://lore.kernel.org/all/20070710122702.765654000@pademelon.sonytel.be/
> >>
> >> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> >
> >> --- a/drivers/video/logo/Kconfig
> >> +++ b/drivers/video/logo/Kconfig
> >
> >> @@ -61,6 +63,12 @@ config LOGO_LINUX_CLUT224
> >>  config LOGO_LINUX_CLUT224_FILE
> >>         string "224-color logo .ppm file"
> >>         depends on LOGO_LINUX_CLUT224
> >> +       default "drivers/video/logo/logo_dec_clut224.ppm" if MACH_DECSTATION || ALPHA
> >> +       default "drivers/video/logo/logo_mac_clut224.ppm" if MAC
> >
> > E.g. an m68k multi-platform kernel including Mac support will scare
> > non-Mac users into thinking their machine was assimilated by the
> > Apple Empire...
> >
> >> +       default "drivers/video/logo/logo_parisc_clut224.ppm" if PARISC
> >> +       default "drivers/video/logo/logo_sgi_clut224.ppm" if SGI_IP22 || SGI_IP27 || SGI_IP32
> >> +       default "drivers/video/logo/logo_sun_clut224.ppm" if SPARC
> >> +       default "drivers/video/logo/logo_superh_clut224.ppm" if SUPERH
> >>         default "drivers/video/logo/logo_linux_clut224.ppm"
> >>         help
> >>           Takes a path to a 224-color logo in the portable pixmap file
> >
> >> --- a/drivers/video/logo/logo.c
> >> +++ b/drivers/video/logo/logo.c
> >> @@ -48,59 +48,21 @@ const struct linux_logo * __ref fb_find_logo(int depth)
> >>         if (nologo || logos_freed)
> >>                 return NULL;
> >>
> >> -       if (depth >= 1) {
> >>  #ifdef CONFIG_LOGO_LINUX_MONO
> >> -               /* Generic Linux logo */
> >> +       if (depth >= 1)
> >>                 logo = &logo_linux_mono;
> >>  #endif
> >> -#ifdef CONFIG_LOGO_SUPERH_MONO
> >> -               /* SuperH Linux logo */
> >> -               logo = &logo_superh_mono;
> >> -#endif
> >> -       }
> >>
> >> -       if (depth >= 4) {
> >>  #ifdef CONFIG_LOGO_LINUX_VGA16
> >> -               /* Generic Linux logo */
> >> +       if (depth >= 4)
> >>                 logo = &logo_linux_vga16;
> >>  #endif
> >> -#ifdef CONFIG_LOGO_SUPERH_VGA16
> >> -               /* SuperH Linux logo */
> >> -               logo = &logo_superh_vga16;
> >> -#endif
> >> -       }
> >>
> >> -       if (depth >= 8) {
> >>  #ifdef CONFIG_LOGO_LINUX_CLUT224
> >> -               /* Generic Linux logo */
> >> +       if (depth >= 8)
> >>                 logo = &logo_linux_clut224;
> >>  #endif
> >> -#ifdef CONFIG_LOGO_DEC_CLUT224
> >> -               /* DEC Linux logo on MIPS/MIPS64 or ALPHA */
> >> -               logo = &logo_dec_clut224;
> >> -#endif
> >> -#ifdef CONFIG_LOGO_MAC_CLUT224
> >> -               /* Macintosh Linux logo on m68k */
> >> -               if (MACH_IS_MAC)
> >
> > MACH_IS_MAC can be a runtime check.
>
> OK. I missed this.
>
> I think there are two options to fix this:
>
>   1. Keep CONFIG_LOGO_MAC_CLUT224 untouched
>   2. Remove logo_mac_clut224.ppm
>
> The first option is less controversial but I would like to ask you what
> you think about removing the logo_mac_clut224 file.
>
> Here, we are speaking of the Macintosh 68k which ended sales in 1995,
> right? So the user base should be rather small, I guess.

Yes, the user base is small.

BTW, the only reason you don't have this issue with MACH_DECSTATION and
the various SGI_IP* options is that MIPS does not support multi-platform
kernels.

> And people who still want the custom MAC logo would still be able to add
>
>   CONFIG_LOGO_MAC_CLUT224="path/to/logo_mac_clut224.ppm"

LOGO_LINUX_CLUT224_FILE ;-)

> to their config to restore the old behaviour anyway.
>
> My choice would go more toward the removal option but what do you think?

I am not too attached to keeping the dynamic behavior for the Mac logo,
I just wanted to point out the impact.
I expect most people who care about logos (in products) just have their
own custom out-of-tree code.  As fb_find_logo() and the underlying
infrastructure still exists, I don't expect them to have too much
trouble forward porting that to newer kernels.

What do other people think?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

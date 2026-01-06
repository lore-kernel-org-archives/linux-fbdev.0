Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com [209.85.217.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843862989B7
	for <linux-fbdev@vger.kernel.org>; Tue,  6 Jan 2026 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700107; cv=none; b=dKoXmp0gxqWV7OzjqET2WiFZ16UTFN+imPi8UGjIDKoH9vghRUKP7AVzc3mKvLo0GA+TsyMuogtdtnAz/GmPpPTqpzPDyDTMt+rH1WzGkBpQ6whIYzO4azRNbFcRjWUamHHzrvjjY/RxbapDyaaJbMb3cldTPRrA4srxNRvkSE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700107; c=relaxed/simple;
	bh=cy90DhPfHZ+Icz6r89LIwxLLHRAHP0I0oJNrsBe1qfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5YNGhpVLBx03A0gmmJuSOGSKAq6z02ZtbUvXFWy2cB4k+YW03DSBH5Tx0imb16gxDvkEAY185a7erAf5kipdVpoM+fNgYnN9BUbjj+38hRd+qIXVvBY+UHNukTF2NYFYmr1ubeF25MnQE4s/3qbgkQEx12o4zqaeQHCjMROBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f66.google.com with SMTP id ada2fe7eead31-5dfd0101905so292194137.3
        for <linux-fbdev@vger.kernel.org>; Tue, 06 Jan 2026 03:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767700104; x=1768304904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eme3GKSVVTwekk5ahSqs0LbJRLjiKfIn3cO6kiKk5PI=;
        b=Atv9R/HRXRJq437iU5gbM96XRhgr67zyhR9LqLP0fviYxvufbuCSocxlLARk14YcI+
         W0kEX9+KfezCxjkDEmsUpCiz7A22n/FT+KxmczxT2LzFaiLMGxxxYVHXOzjW4wBg8+EH
         ajmgFpcA0WW2hZgn1ojj8zXiDx9WX1RGEKIJPlaItdHMS10j9J6eYKSROpK1lvrNWvp/
         2/7p+ZuIE2qe9cMbu23vTpMm57sk8RqobDWEsg3snep2LbEBYrzjZXLQUjdkNkunHmEv
         V1Jb4sa/PaY8GQDzKpchu0mpo9A/tu3d95oL/iT6b/7elYho5VcBcPDfrA4X+vgtP+HK
         EryQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhiHbNQKN9z43wn9jKytZiatMQOmlxWZgR4dg6E3d+Qo1IXWFdwznwccD44Yt3ghD1dETnLsBNgn8ekg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywba3MG9DAiV7aDsRW2r5PUzgIusiXxp05m1c34ahMKcPX07Qo6
	fFvrQVFQAUuVGKw+TJ3mdZofsWwyelSf7A/XRsNaEkbbTyqxTbCM7aRVotvf0RIy
X-Gm-Gg: AY/fxX6b1WuSO0SzAXYBS3K/6qpkSNbIveuJknHvnNFIIEdIKr2ZeuxHNBDR/Oolq4R
	b9jzbvfAh1CyBxKa8Em2Eo8cBDh3ZyVR5Y7tl5yZCMNMMwAQQZgjkWZVmstbjiSTSi4ayEdwBA7
	fIUMpsN2A2G3QDwSMsp1yli3+01/sHMlUUYT1rM4CyjZaN2sjh4UvtKB/EJGTqMk/hCgDmcYc9a
	Zusdj/TlHP9h1Okng6SxUlyFENUBgvqjQNFMdMVhP+g9nedrBDzzaJeWP6dpx4adxgdcFP+aFvB
	6LEU0PhFgL4A6aOQwOo2fqvGLKLgZt+Hs8OJFyLQOiM+pxv5z90c6dozvBWnEpKD/943ohCE6u+
	77Mp+djGphsM8GGibnL0PKKdK+Ya4pXclBaSssEQwgsEgQqk3Gg7AZbvxme0N638NnZ6kmzOs38
	fET85sTkxkou03+NB6DXR3M8SftVxo3bPFUxbv0j8ylppg8X+q1xkhTbKXr5s=
X-Google-Smtp-Source: AGHT+IF6ucLMyfWYsK6hb4BSUui9saOqTuSYlxPjmayxR/jWXtAjwkYsRO3eCAzR+7IZnlgxfZVBIA==
X-Received: by 2002:a05:6102:6a92:b0:5dd:b100:47df with SMTP id ada2fe7eead31-5ec742e61c1mr667322137.4.1767700104302;
        Tue, 06 Jan 2026 03:48:24 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944122ad97esm566883241.3.2026.01.06.03.48.23
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 03:48:24 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dfd0101905so292190137.3
        for <linux-fbdev@vger.kernel.org>; Tue, 06 Jan 2026 03:48:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaDO9mBNJDcNgZj8emc/epSDQmQnztAJQaSXBoe3w5QXxrZ+kaP2XZ+nEyEPmCu2sYGRLXukS9TUSIFw==@vger.kernel.org
X-Received: by 2002:a05:6102:3588:b0:5db:d411:20cd with SMTP id
 ada2fe7eead31-5ec744a8304mr863867137.28.1767700102655; Tue, 06 Jan 2026
 03:48:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101-custom-logo-v2-0-8eec06dfbf85@kernel.org> <20260101-custom-logo-v2-6-8eec06dfbf85@kernel.org>
In-Reply-To: <20260101-custom-logo-v2-6-8eec06dfbf85@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Jan 2026 12:48:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVy48F5HAfqfJgbY83KDAztb9YWTqm8mT1ntTfj0311oA@mail.gmail.com>
X-Gm-Features: AQt7F2oMgVPDZ6yIPBL4v-hrcVUiy-32V0b_EbYL6M5HBMZvyW9vi5iymuHAylg
Message-ID: <CAMuHMdVy48F5HAfqfJgbY83KDAztb9YWTqm8mT1ntTfj0311oA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] video/logo: move logo selection logic to Kconfig
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

CC linux-m68k

Thanks for your patch, which is now commit bd710b3da7308cb1
("video/logo: move logo selection logic to Kconfig") in fbdev/for-next.

On Thu, 1 Jan 2026 at 16:26, Vincent Mailhol <mailhol@kernel.org> wrote:
> Now that the path to the logo file can be directly entered in Kbuild,
> there is no more need to handle all the logo file selection in the
> Makefile and the C files.

This may do the wrong thing when booting a multi-platform kernel.

>
> The only exception is the logo_spe_clut224 which is only used by the
> Cell processor (found for example in the Playstation 3) [1]. This
> extra logo uses its own different image which shows up on a separate
> line just below the normal logo. Because the extra logo uses a
> different image, it can not be factorized under the custom logo logic.
>
> Move all the logo file selection logic to Kbuild (except from the
> logo_spe_clut224.ppm), this done, clean-up the C code to only leave
> one entry for each logo type (monochrome, 16-colors and 224-colors).
>
> [1] Cell SPE logos
> Link: https://lore.kernel.org/all/20070710122702.765654000@pademelon.sonytel.be/
>
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

> --- a/drivers/video/logo/Kconfig
> +++ b/drivers/video/logo/Kconfig

> @@ -61,6 +63,12 @@ config LOGO_LINUX_CLUT224
>  config LOGO_LINUX_CLUT224_FILE
>         string "224-color logo .ppm file"
>         depends on LOGO_LINUX_CLUT224
> +       default "drivers/video/logo/logo_dec_clut224.ppm" if MACH_DECSTATION || ALPHA
> +       default "drivers/video/logo/logo_mac_clut224.ppm" if MAC

E.g. an m68k multi-platform kernel including Mac support will scare
non-Mac users into thinking their machine was assimilated by the
Apple Empire...

> +       default "drivers/video/logo/logo_parisc_clut224.ppm" if PARISC
> +       default "drivers/video/logo/logo_sgi_clut224.ppm" if SGI_IP22 || SGI_IP27 || SGI_IP32
> +       default "drivers/video/logo/logo_sun_clut224.ppm" if SPARC
> +       default "drivers/video/logo/logo_superh_clut224.ppm" if SUPERH
>         default "drivers/video/logo/logo_linux_clut224.ppm"
>         help
>           Takes a path to a 224-color logo in the portable pixmap file

> --- a/drivers/video/logo/logo.c
> +++ b/drivers/video/logo/logo.c
> @@ -48,59 +48,21 @@ const struct linux_logo * __ref fb_find_logo(int depth)
>         if (nologo || logos_freed)
>                 return NULL;
>
> -       if (depth >= 1) {
>  #ifdef CONFIG_LOGO_LINUX_MONO
> -               /* Generic Linux logo */
> +       if (depth >= 1)
>                 logo = &logo_linux_mono;
>  #endif
> -#ifdef CONFIG_LOGO_SUPERH_MONO
> -               /* SuperH Linux logo */
> -               logo = &logo_superh_mono;
> -#endif
> -       }
>
> -       if (depth >= 4) {
>  #ifdef CONFIG_LOGO_LINUX_VGA16
> -               /* Generic Linux logo */
> +       if (depth >= 4)
>                 logo = &logo_linux_vga16;
>  #endif
> -#ifdef CONFIG_LOGO_SUPERH_VGA16
> -               /* SuperH Linux logo */
> -               logo = &logo_superh_vga16;
> -#endif
> -       }
>
> -       if (depth >= 8) {
>  #ifdef CONFIG_LOGO_LINUX_CLUT224
> -               /* Generic Linux logo */
> +       if (depth >= 8)
>                 logo = &logo_linux_clut224;
>  #endif
> -#ifdef CONFIG_LOGO_DEC_CLUT224
> -               /* DEC Linux logo on MIPS/MIPS64 or ALPHA */
> -               logo = &logo_dec_clut224;
> -#endif
> -#ifdef CONFIG_LOGO_MAC_CLUT224
> -               /* Macintosh Linux logo on m68k */
> -               if (MACH_IS_MAC)

MACH_IS_MAC can be a runtime check.

> -                       logo = &logo_mac_clut224;
> -#endif
> -#ifdef CONFIG_LOGO_PARISC_CLUT224
> -               /* PA-RISC Linux logo */
> -               logo = &logo_parisc_clut224;
> -#endif
> -#ifdef CONFIG_LOGO_SGI_CLUT224
> -               /* SGI Linux logo on MIPS/MIPS64 */
> -               logo = &logo_sgi_clut224;
> -#endif
> -#ifdef CONFIG_LOGO_SUN_CLUT224
> -               /* Sun Linux logo */
> -               logo = &logo_sun_clut224;
> -#endif
> -#ifdef CONFIG_LOGO_SUPERH_CLUT224
> -               /* SuperH Linux logo */
> -               logo = &logo_superh_clut224;
> -#endif
> -       }
> +
>         return logo;
>  }
>  EXPORT_SYMBOL_GPL(fb_find_logo);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

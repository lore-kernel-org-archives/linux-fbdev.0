Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35A33909A5
	for <linux-fbdev@vger.kernel.org>; Wed,  1 Apr 2026 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029749; cv=none; b=VR+hNha2soXkGOT4o4OTkuN6iqDKqAEFQVPOsD7CYLNBaqC7jENLBNVFocPZJPSBNJkyavwr7mJLUL/qGoO2MBx7ptaqsF2+QQmP+jSLwwPHcrvpGTn/ypHHt/Y9TZ4ycEQqgLLqyFDBq49jUf9o6h7Wpvs27TBjEXx16OxvdaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029749; c=relaxed/simple;
	bh=TrSvQHvFE1kdPPKToRvXLO/y68l8RTw2mwUihP6/Y90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hjjdk2bkS3X1tG1bbNNdnCU7nJp1UNHh/iOU4HJIZap9NLN1muHq68Oru7hcqmtUrpeVbcP5Kuf2wGGmmgOUFRHsESVAa+cV6n/KaSXnroXeJh+m7CF3ikqKBAJia8rbfi+PmLBbtZcPx9GV3S3kr9pOf6fuWTcPjKpQdiv/reM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56cc67e01deso5872033e0c.3
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Apr 2026 00:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775029745; x=1775634545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QViiKnClzREegw/7Mfy/6jKSPqR75a0GyutQdyIknIY=;
        b=lTNqPzThzjFC1RjgpPqq4RD6tFOG+m8R5SHVguarOCx5qAdrW4jnUUTkQ9YBIzJlVg
         UUsT7HW/A3JcwdvPYJMEkeXCB9xPuAl4q9n3ykOyzHcmgmOYSw26JJzRo35xkbIbAa23
         wdII2ClVq9BvLjwFD4M8DNL/zeokk+7MU0+Rpkinpe8UiS6aHede1MTsAcRPjx0+NuiK
         MN+Y7ZsqPiuCItwm8PbDa/iVI3ygL6d2lpp2BIgkbsx/9/15jnUNqpc/OwRla13qk3l+
         Ld3YxR6V7JJ/fQhCGPuh/5t51sowpJDdr4v6VNdwhbmY1GJuaFGcjo2LY4hZMbj4yrOQ
         fmow==
X-Forwarded-Encrypted: i=1; AJvYcCXMVuuepBGjxgrBWn8mkYwPQgA4xCut4ZVyoYamLA3D7q4OwyYARknyFRLckNpXoLi0LduBQY4R8Ept1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoBYd8NgynjROsCQAJK3y6DvOUtegcXKYB8yOJNuOAi6f8EK9h
	o+HhLlhY+x+5uNprQxCw4n++CuhKw+DIz2osrRL9bVORUXyjqMTlgd2brGMvqL/7
X-Gm-Gg: ATEYQzxHmX6uNv3S3kjJZJdOQqdzTbhSOnShT1xv47Z8o0Tv3KvWhJ7UgGYQ7Ns4j1w
	9mv1LQlQgtopEaEsXS0lmeQ/79LMyHpHGN5A8jQl71Lbc2/KVwb9MdcwPgTdRFCOUP5/C2IF4/N
	kSBcRGODnkZdfLmssPvbGYHZ+I9thVBZWbP95GXlevQOld4uJSEloy7LpMmt9gx3+OqDvPT4hvJ
	3+n0d+k01FWRseLBs13udDR1P7OYw2jjjYwyhPOdqSsI7F9zHxTcTEmeLm9Fos9SlCjaRritqCG
	eNU8oJJRd4anQbH9nfQSm51+eji6R0LjvdbS6p2MIvxClrT7/K4K508d5Bp2u933WmYlHQ2mr6n
	lrkPf39CmOTGnuRdUAB/LaHVBaOYcgzOTRQ/n8xgk3ER2uCpJ9GRYb3oT72Y+arsbFD8rydoH1M
	/ayKWdp+ihHFKVn/igi/57WG9/NaoJXxFnMAZunyZnLaipcMHnB+RzlN0Lm1je
X-Received: by 2002:a05:6122:1807:b0:567:433b:e903 with SMTP id 71dfb90a1353d-56d8a83d458mr1131838e0c.6.1775029745439;
        Wed, 01 Apr 2026 00:49:05 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d589fcfcfsm16095439e0c.10.2026.04.01.00.49.03
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 00:49:04 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso3276039241.2
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Apr 2026 00:49:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3aSfh+MTonCui919o68uHDXaZBAqEPTMGQttaIaytIilRQYt+kc/HF6fFu3EYq0X7PTJMcUPGBOAHWg==@vger.kernel.org
X-Received: by 2002:a05:6102:390e:b0:604:dfe1:39a7 with SMTP id
 ada2fe7eead31-60567e18859mr845568137.11.1775029743600; Wed, 01 Apr 2026
 00:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327130431.59481-1-tzimmermann@suse.de> <20260327130431.59481-5-tzimmermann@suse.de>
In-Reply-To: <20260327130431.59481-5-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Apr 2026 09:48:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1vUuKq-Q1-zA5tC5+LWap4osFJMqQ5pRJ373z++KQLQ@mail.gmail.com>
X-Gm-Features: AQROBzAbUUOUvvD9qjb80We-Rv00f545IFsCToqLfb7seW_x9Ac2xM40zkpv4T4
Message-ID: <CAMuHMdX1vUuKq-Q1-zA5tC5+LWap4osFJMqQ5pRJ373z++KQLQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] lib/fonts: Clean up Makefile
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	simona@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Fri, 27 Mar 2026 at 14:05, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Simplify the Makefile. Drop font-obj-y and sort the fonts by dictionary
> order. Done in preparation for supporting optional font rotation.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch, which is now commit 3f90ea78f5fe9495
("lib/fonts: Clean up Makefile") in fbdev/for-next.

> --- a/lib/fonts/Makefile
> +++ b/lib/fonts/Makefile
> @@ -1,23 +1,22 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Font handling
>
> -font-objs := fonts.o
> +font-y := fonts.o
>
> -font-objs-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
> -font-objs-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
> -font-objs-$(CONFIG_FONT_8x8)       += font_8x8.o
> -font-objs-$(CONFIG_FONT_8x16)      += font_8x16.o
> -font-objs-$(CONFIG_FONT_6x11)      += font_6x11.o
> -font-objs-$(CONFIG_FONT_7x14)      += font_7x14.o
> -font-objs-$(CONFIG_FONT_10x18)     += font_10x18.o
> -font-objs-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
> -font-objs-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
> -font-objs-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
> -font-objs-$(CONFIG_FONT_6x10)      += font_6x10.o
> -font-objs-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
> -font-objs-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
> -font-objs-$(CONFIG_FONT_6x8)       += font_6x8.o
> +# Built-in fonts
> +font-$(CONFIG_FONT_10x18)     += font_10x18.o
> +font-$(CONFIG_FONT_6x10)      += font_6x10.o
> +font-$(CONFIG_FONT_6x11)      += font_6x11.o
> +font-$(CONFIG_FONT_6x8)       += font_6x8.o
> +font-$(CONFIG_FONT_7x14)      += font_7x14.o
> +font-$(CONFIG_FONT_8x16)      += font_8x16.o
> +font-$(CONFIG_FONT_8x8)       += font_8x8.o

Please sort the anonymous entries by increasing font size.

> +font-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
> +font-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
> +font-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
> +font-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
> +font-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
> +font-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
> +font-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
>
> -font-objs += $(font-objs-y)
> -
> -obj-$(CONFIG_FONT_SUPPORT)         += font.o
> +obj-$(CONFIG_FONT_SUPPORT) += font.o

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

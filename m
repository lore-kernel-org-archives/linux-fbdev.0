Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com [209.85.217.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5EA202979
	for <linux-fbdev@vger.kernel.org>; Wed,  7 Jan 2026 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767794002; cv=none; b=KplDPbIZbAqaWYNsVu5OEcCjvJ956f3ojFgVpk4xiV9gGCinnjd4FJX3x3l0Wap9JNRyXDGelTK6f/6CO72aeZPx/mfvdcBws+KWzU65rqAwjE3TN8FeQe2xkOmh2/XamBLs2yDSqT6tTGMHXnQW/9v/IR698aIlp8PYUJjV1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767794002; c=relaxed/simple;
	bh=V20kFfbnDfFMAsOpR/V2++b5E9prZcOxV6CNuCyeRTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHZMAWE68OSXaDAaTesBvj5mBKHzm5er4C7yPm9dbdkMkJMjPJlt/0r99lfUVivRkf5FhjPKezi5Pr1zz3TJDJcC7WIy4PPDik0aDAHNZG00TeIOuwc4mBq3wryG/EpsO99Wjua8D5YyusmF2YCx58PLC0R1/6LU36xpKzarIwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f68.google.com with SMTP id ada2fe7eead31-5ecb1d9ac1dso522909137.0
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 05:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767793999; x=1768398799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vycy5U/9AuJWYCD1lBGFTu2izKl734E+hv0jo2cmLag=;
        b=WXCFtzm2wLuRK/v58fHVcM6Y/inmsQSCiwBf1FSYIPmumfqozgnBw6U6qndfIHUCsb
         DBQkZCFEQilkKHQF+0YDtBxyHwqZBIsRApipFKxO6wmCi6VvwZ1kfUeh37iCVjzLMxAR
         CKVYG24PVlR+6u6nDCVXGpFCZmee+wwEAajxAL8Ftx2lmB4mo/ZkWis14KYoigp64u/E
         4DeMXrElLdYK01zAuqNSD2HufrtMj+GXlDee7A/QM4EjHILpuUqg+0EYmv1vmIsn1xTn
         boM7Zrk5KNdPA5/BmPYTMRyw8qyAge8E99OyM4PDnz2yqupOXkrAWfiEQCQr+4/q1dNM
         ho9w==
X-Forwarded-Encrypted: i=1; AJvYcCVkLUlmvgW4wFjFZD1ZnPcfYfdAlU60Q1D5msi095UoZTmWVH1tfQc9k0DNTILtDkRleXuIv2dybDAvew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy46mM/x7KkqZUl7Vb8jJtfxpnum3+kWoWgkrxpqJC/7YiTA91M
	+cKR4kXeWpJru+6YiAc5syoXevXNu8mEcadH5AqAKd0uXEx0dyVcrOlHMZ5e9AvB
X-Gm-Gg: AY/fxX4OMyt1vdf+JPCFFs2439nUuM6TiM8JDwvbB1Fd7cbTaWEbHfZ8AJ3Sss2G5A7
	p7LJmjyoNMrQP1ADCo7v7p2fD2jhz8JtC7ni3SosNpUvXqCjJzJeIWLcoeYmWoMUNg42aWXyOy1
	kHlzQauhRBRoUyAqXnT99LByjXujRSw9rBCn+Wv4JwyYoffiDfbrJ39epSbQ8csVNjM54gKYhQ4
	dfrSYQXpABaQu4PS/LlpmSkjUEamo2nC/ZRc9XaTOorRQIF6Q7huRovmdwPScq/h1GxxGMNJByF
	uH7KRY0pGoO9flotGk7Y/b+0vtqDQbCwKtPpFQczq3Tln0lsJpNKBudSVb52MZtz4cwVTxFRk2k
	YWC3OvHwocLKVYppoPYgC961+b9Ub9hCf6huUHLdpDYUWhx4PBrB5QOWZ/iJ7WSwg0WUBlD807N
	tD+sz6m6Q32v2t2OPvPdcU3JeCM3Ba/24TO2oqrOTr6lV9CMvT
X-Google-Smtp-Source: AGHT+IHP5Q6UwxpldRn84eDCTL3SkwOMzEcEq//1v88nQcO3B0ySgHUBmFk1GfkzOTHi9s3jbcFiCw==
X-Received: by 2002:a67:e7c6:0:b0:5ed:dda:d16c with SMTP id ada2fe7eead31-5ed0ddad239mr266411137.13.1767793998354;
        Wed, 07 Jan 2026 05:53:18 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ecc521d7b1sm1995664137.0.2026.01.07.05.53.17
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 05:53:18 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94120e0acbeso1177572241.2
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 05:53:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3OKsQiwy++iqT8TjOOXeMfmhUw3cZUMr35imMJZlH1luOljIR1OYccWeT/Wun/88R1z44pYJUubVlPA==@vger.kernel.org
X-Received: by 2002:a05:6102:548b:b0:5db:cec7:810b with SMTP id
 ada2fe7eead31-5ecb6904d1cmr977705137.29.1767793997513; Wed, 07 Jan 2026
 05:53:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101-custom-logo-v2-0-8eec06dfbf85@kernel.org>
 <20260101-custom-logo-v2-6-8eec06dfbf85@kernel.org> <CAMuHMdVy48F5HAfqfJgbY83KDAztb9YWTqm8mT1ntTfj0311oA@mail.gmail.com>
 <dda4052e-b843-43fa-850c-a1bb20e4a8e3@kernel.org> <CAMuHMdXz9uKxQ0dH68a+xt4FHqVgdskvO3QRvev1_Wq8h-a1Qg@mail.gmail.com>
 <487ac672-3a2e-4897-aaba-7ae44bcf341a@gmx.de>
In-Reply-To: <487ac672-3a2e-4897-aaba-7ae44bcf341a@gmx.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Jan 2026 14:53:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUqHUrg6XwqXCSwv-3TwiYUOfbBMpMiuS89d1uwChBYaQ@mail.gmail.com>
X-Gm-Features: AQt7F2r20-H4V61D0OQVUYmKrX0oHF-Wf_klXq13jKUBCAwI3lTwG7W_lz7xlEY
Message-ID: <CAMuHMdUqHUrg6XwqXCSwv-3TwiYUOfbBMpMiuS89d1uwChBYaQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] video/logo: move logo selection logic to Kconfig
To: Helge Deller <deller@gmx.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Helge,

On Wed, 7 Jan 2026 at 13:21, Helge Deller <deller@gmx.de> wrote:
> On 1/7/26 11:36, Geert Uytterhoeven wrote:
> > On Tue, 6 Jan 2026 at 21:10, Vincent Mailhol <mailhol@kernel.org> wrote:
> >> On 06/01/2026 at 12:48, Geert Uytterhoeven wrote:
> >>> Thanks for your patch, which is now commit bd710b3da7308cb1
> >>> ("video/logo: move logo selection logic to Kconfig") in fbdev/for-next.
> >>>
> >>> On Thu, 1 Jan 2026 at 16:26, Vincent Mailhol <mailhol@kernel.org> wrote:
> >>>> Now that the path to the logo file can be directly entered in Kbuild,
> >>>> there is no more need to handle all the logo file selection in the
> >>>> Makefile and the C files.
> >>>
> >>> This may do the wrong thing when booting a multi-platform kernel.
> >>>
> >>>>
> >>>> The only exception is the logo_spe_clut224 which is only used by the
> >>>> Cell processor (found for example in the Playstation 3) [1]. This
> >>>> extra logo uses its own different image which shows up on a separate
> >>>> line just below the normal logo. Because the extra logo uses a
> >>>> different image, it can not be factorized under the custom logo logic.
> >>>>
> >>>> Move all the logo file selection logic to Kbuild (except from the
> >>>> logo_spe_clut224.ppm), this done, clean-up the C code to only leave
> >>>> one entry for each logo type (monochrome, 16-colors and 224-colors).
> >>>>
> >>>> [1] Cell SPE logos
> >>>> Link: https://lore.kernel.org/all/20070710122702.765654000@pademelon.sonytel.be/
> >>>>
> >>>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> >>>
> >>>> --- a/drivers/video/logo/Kconfig
> >>>> +++ b/drivers/video/logo/Kconfig
> >>>
> >>>> @@ -61,6 +63,12 @@ config LOGO_LINUX_CLUT224
> >>>>   config LOGO_LINUX_CLUT224_FILE
> >>>>          string "224-color logo .ppm file"
> >>>>          depends on LOGO_LINUX_CLUT224
> >>>> +       default "drivers/video/logo/logo_dec_clut224.ppm" if MACH_DECSTATION || ALPHA
> >>>> +       default "drivers/video/logo/logo_mac_clut224.ppm" if MAC
> >>>
> >>> E.g. an m68k multi-platform kernel including Mac support will scare
> >>> non-Mac users into thinking their machine was assimilated by the
> >>> Apple Empire...

> >>>> --- a/drivers/video/logo/logo.c
> >>>> +++ b/drivers/video/logo/logo.c

> >>>> -#ifdef CONFIG_LOGO_MAC_CLUT224
> >>>> -               /* Macintosh Linux logo on m68k */
> >>>> -               if (MACH_IS_MAC)
> >>>
> >>> MACH_IS_MAC can be a runtime check.
> >>
> >> OK. I missed this.
> >>
> >> I think there are two options to fix this:
> >>
> >>    1. Keep CONFIG_LOGO_MAC_CLUT224 untouched
> >>    2. Remove logo_mac_clut224.ppm
> >>
> >> The first option is less controversial but I would like to ask you what
> >> you think about removing the logo_mac_clut224 file.
> >>
> >> Here, we are speaking of the Macintosh 68k which ended sales in 1995,
> >> right? So the user base should be rather small, I guess.
> >
> > Yes, the user base is small.
> >
> > BTW, the only reason you don't have this issue with MACH_DECSTATION and
> > the various SGI_IP* options is that MIPS does not support multi-platform
> > kernels.
> >
> >> And people who still want the custom MAC logo would still be able to add
> >>
> >>    CONFIG_LOGO_MAC_CLUT224="path/to/logo_mac_clut224.ppm"
> >
> > LOGO_LINUX_CLUT224_FILE ;-)
> >
> >> to their config to restore the old behaviour anyway.
> >>
> >> My choice would go more toward the removal option but what do you think?
> >
> > I am not too attached to keeping the dynamic behavior for the Mac logo,
> > I just wanted to point out the impact.
> > I expect most people who care about logos (in products) just have their
> > own custom out-of-tree code.  As fb_find_logo() and the underlying
> > infrastructure still exists, I don't expect them to have too much
> > trouble forward porting that to newer kernels.
> >
> > What do other people think?
>
> This is about a small visible icon. It's not some relevant feature.
> So, I think it's unfortunate that the patch then drops the specific mac logo.
> But adding additional coding and complexity to simply make this logo
> visible for such a small user base IMHO does not justify the effort.

This patch does not drop the specific Mac logo.
Instead, it prioritizes the Mac logo over the generic logo when Mac
support is enabled in a multi-platform kernel.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

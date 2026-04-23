Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF9145A05
	for <linux-fbdev@vger.kernel.org>; Thu, 23 Apr 2026 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928937; cv=none; b=rAGEKccfAoBhtq+kGcpDsMDGXGyEcc9GIgoBQJM3SeWyNo/2b0KEwynEse1MRGk2nlROSDAEtY4IfPTct75qyAqUH70FmCP/INiN6/ELwsOJlUtxOuDHn/kRe6Dxi3vnAJYZU4Oa6UGrxd/2ZGIbEIVwgfW9Ey3tnH0hFXmjfNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928937; c=relaxed/simple;
	bh=JrSLrKz90yWLq0N0xvfDHOLGj/W1VB93BXaNcdoATBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gImqLg9F0SYUzfU/qvDV0DB+VaADrfNB/Cedwj/cTpd1w8wLDaLc1KjtA1wbFcv7HpAIvvZAS5OCMKAV6TQJvvQtPBBvJWBo4sby2LBs4wMjjCftzyQeGsmyuakwAQD6PmU2Hae3CgFR5XeNgy4TyG8PAp99mqiY7G0yKBfDREo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9539d9f1675so4094757241.2
        for <linux-fbdev@vger.kernel.org>; Thu, 23 Apr 2026 00:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776928934; x=1777533734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ogvygskie7zIIQ16XGTtOId1La+S1Rf8wP528DIfndM=;
        b=C111C4lOLBgMzp1ZQvEjvY6rkw4WDDYdG5XbzdSyPyaqIm+q9KulLCxzIYtD8CuxDt
         JwO9crT49GNsHyHeHj5sspDzHNjC4hLkjiDw7oI6SqtK7EXxx3FEFLQIxgnKep2rPJ1b
         j3NxYvjv0AvLJ+dpdnw45QHPmGC8zfv1Q4gbMxQy+RNS37UPnKV5XX+vsTxnOPUk8JH7
         5ob1+Hl4jQaPiEe5dAV1RIwN+Txw0Ewj0AZxoD1hgqFPrNmEp2/lkr4cnj1X+JpAmbz+
         3Ee6CZ1uGCS1MThz7u12NrLZDYSev2Gt4eeplGbpSxB6IoHN5Dt/PxmHUWscXLpZCIyZ
         7+eA==
X-Forwarded-Encrypted: i=1; AFNElJ9ZOs+z9mDocFoLHz5hE+yCyKcmn9cbYFr3F9a11KGUoXI5CuG0mxNCxRfpOwKijV5b0sWivZ4/KSSJsA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy13hcE7XUwsWgg0Brc5ipCyJ387Vtx8kgl0KTLUyfxdNt8Saow
	vrh9aDi5Xqje55KLlD7JOu3+TvZkKjcnCpGXZdIvGVISYBxG6DYPdnPmjy3klEsljvo=
X-Gm-Gg: AeBDievXSw2o7I8/nmp11NL1vNMZC6MjozseI76EMpPVIP32o8V59npKrGYwwQovWCj
	sIEgMLrPnpVCBPNapknmHdA/U6ThviLeDT9QDhBOTnmUripSYyKN1gQWZKxI4LqFt1/Uh2SuJyc
	DK8xsIDqVHIzPLq0z+5HJqlp11zCjf7XJmbIMJSnP92SXEigKBeN9cY1uLEbLpSTxHKaho1n6RG
	sZM7hAztmVp6zf+/bxyn8Hd5Z09/Qc6Dk8E5rXm0bZNjxGFLv7l8Lk/zCzdTjtMvFMLwi9aDO7s
	PpAMc3flGxVm2qZxlPKW8CF4mK1uf6ez5Eip0gAzXHa5r9bp6NiPIywp2Qu3fiU2YsIsOKTIgkJ
	wKcn2PWKgVIcai7WG+keemRNsUrwbfgt55ZaJTdO6rPqfRE13axA+xlYq7C4fEMeHslppYfWJn+
	WpU8YKIdWO43PUMg0wpiE4qhyZXPwFBbm5G0DOPJuwbO5H8GqlDW+1HrH8rLjSgAR+6ueYAec=
X-Received: by 2002:a05:6102:3e2a:b0:5ef:ac78:3c77 with SMTP id ada2fe7eead31-616f6df5214mr13828031137.18.1776928934599;
        Thu, 23 Apr 2026 00:22:14 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-617482b199csm9282384137.11.2026.04.23.00.22.14
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 00:22:14 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-60591ade110so4326937137.1
        for <linux-fbdev@vger.kernel.org>; Thu, 23 Apr 2026 00:22:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+fOMCyokFP1YNe75LPjHRay0TRmzHD/TFYOCUL/+S8pzSWsRkKF+29S8VACf2w6+iLMSWDw5Qjn+S63A==@vger.kernel.org
X-Received: by 2002:a05:6102:160d:b0:607:a3cb:4573 with SMTP id
 ada2fe7eead31-616f7d6405dmr12594944137.26.1776928933991; Thu, 23 Apr 2026
 00:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420134424.77494-1-amit.barzilai22@gmail.com>
In-Reply-To: <20260420134424.77494-1-amit.barzilai22@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Apr 2026 09:22:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWhpD5vjfzsYieVOrio0chQAU=s0z5rX8AKTon3S=v-OA@mail.gmail.com>
X-Gm-Features: AQROBzBQyIzuck49gUq_0zIao92xxorffLSB_x1afAEZiGdBIOmNXPBtNdhrmqo
Message-ID: <CAMuHMdWhpD5vjfzsYieVOrio0chQAU=s0z5rX8AKTon3S=v-OA@mail.gmail.com>
Subject: Re: [PATCH 0/3] fbdev: Request memory regions in platform drivers
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: deller@gmx.de, thomas.zimmermann@suse.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Hi Amit,

On Mon, 20 Apr 2026 at 17:23, Amit Barzilai <amit.barzilai22@gmail.com> wrote:
> Several fbdev platform drivers call ioremap() on their hardware MMIO
> without first claiming the range via request_mem_region(). This leaves
> the kernel resource tree (/proc/iomem) with no record of the mapping,
> allowing another driver to silently map the same registers.
>
> This series fixes three platform_device drivers by switching to helpers
> that combine resource claiming and ioremap in a single managed call.
> cobalt_lcdfb and clps711x-fb are converted to
> devm_platform_get_and_ioremap_resource(); goldfishfb is converted to
> devm_ioremap_resource(), which also lets us drop the manual iounmap()
> calls from the error path and remove function.
>
> For clps711x-fb, resource 1 (the framebuffer range) already used
> devm_platform_get_and_ioremap_resource() correctly; this series makes
> resource 0 (the MMIO control registers) consistent with it.
>
> This is part of the ongoing effort described in
> Documentation/drm/todo.rst ("Request memory regions in all fbdev
> drivers").

This file does not seem to exist?
Was it hallucinated by Claude:claude-sonnet-4-6?

> Amit Barzilai (3):
>   fbdev: cobalt_lcdfb: Request memory region
>   fbdev: clps711x-fb: Request memory region for MMIO
>   fbdev: goldfishfb: Request memory region

Thanks for your series, which is now commit d2386d9e3eb4c12f ("fbdev:
cobalt_lcdfb: Request memory region") and a40c0e815962b1f6 ("fbdev:
clps711x-fb: Request memory region for MMIO") in fbdev/for-next.

Have you tested this series?  I have to ask, because adding
seemingly-innocent request_mem_region() calls without testing the
result is a recurring source of broken drivers.

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13593939B0
	for <linux-fbdev@vger.kernel.org>; Wed, 24 Jun 2026 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291078; cv=none; b=ISVhJUjxRRTeyWnA3KPU4PxsrognQobQo8Azd/2M6XRJDs7fQk3gtW4vBunjDqHrP69KICPTq9n9mdzCqz2Ry6EIdiPKdGmtvgUEfBFFrw4Kg2Zqtfdn3EZvCTrDLplAbOQS6M4CBG1qu24w39AiUbCPl5Qdp4S4qceqv0pu0cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291078; c=relaxed/simple;
	bh=I23H8PBd+djMh4SrB4v4JdwvU9KzRMoMagFE7hs+N1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMdnNAfkn71YTpfHkzMmcWzdl9G+ykibVg4PDRu4Tx1fz5KvVrtR650KnKi+g+I5Ou1x1QNUqSkBUHAufk1gs764Rr9JGoOMhb624rnwYvyjd2D5Ng1t7JW4Z3+XAvsXzGmvLXECUcg3SvNN5xCCpRlmxATNLTOhSamKY/sWalw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bbc6c99c3aso549103e0c.3
        for <linux-fbdev@vger.kernel.org>; Wed, 24 Jun 2026 01:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782291076; x=1782895876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqytCPnwBH27Ys1F84xwvi9+7+D3fwtua39hc9A5h9k=;
        b=Km9wyUGf8aDBkgVzQ0OMmZzYwhSqLnR8ep2jk/B8tKfWX+RR/HQcxFRZVpQxSduS6z
         vc/psS7xDrRtawtaDbnFLVQ9K3PeEkoiSRH5F8uZoWJ65Du88ui69eUuC7VJpYHUpGwl
         xTiHiSsiOzzo8ZXFqevq3kRYGqm7h3FknX7PLlacorm0Djo+WC/50KD0RrKZRarGRQYy
         2dxl4CrFYnrkBe2vKG4fP4Kr1g6o8jMF4TL9/0iO23ndyUZkiT+C9kYNxDlHK7cZpQ7m
         Dab54byferwUe7LN7CQ3ubGHIHGWA2Hc6avvRAPIQGAfRvJnuM7ZnCL+2JIs2+AGy++c
         coeA==
X-Forwarded-Encrypted: i=1; AFNElJ+cnQJ6kRj9AyuJARBaKJy+q6w3jI2sPK1LD6Pmnw7QFqHFLL9Brfr0G3TgSZ92SqrrZjsFsHGben3Cpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyA9TYcnua456wTUDrXaNZUGJSwI6DnrbWhlX+pMg+zSTfLhhIS
	RO5LovLAAH5za+ad7aJHsyHpR0XyLGOSEBNOdcQHWYIKFV6AkpaTEItWpBB3D+9b
X-Gm-Gg: AfdE7cky/yIc63wQEmWT9P4fNdNAVlaWJyPPegsqWRDK8jU20/29sEOkUnxj8Cu8t73
	n0JOKQkiMS82D7Yuq5uBLfeh/CKD3SPs2BLEYkqqK2HPW9KemraAFE+eXYjxzXz4vQbfao5MSFc
	6J/GYTjgak+Bb5yhvVO14iUAjZl4DLb4SEExunVkKFIQyp2B9JEOX/ORIXscqLNSLTcZryML8sb
	JL1qz3Ev7hA7G9SUzgFX822Z6jdnsFOhuo668Px1iw76fomFlR8o2qbsEa4U0ZFNaYVZnodFAFV
	MiayZ7chAVCLusSKNw4eotlst1K++GWLql5PMtPvPwo+OJwpa3I6iE1Dg8IvhmMTOhAvg8YuA1o
	b3p7863i1YfyyDVFq85tSfpY9sdzYoak5tQu3HizM1yq1UWBKtykGpmGIz4VEGvBlFRpmYKhXrL
	e+xRIbpdtzSAG6w9Qb4JJCGyVzX1DJhkDL/8kVfOjjeYyoX7wzQTfQyeOo0bN/
X-Received: by 2002:a05:6122:a1a:b0:576:1a8d:8989 with SMTP id 71dfb90a1353d-5bc3eb1484bmr1127420e0c.0.1782291075788;
        Wed, 24 Jun 2026 01:51:15 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbfba739d2sm10451381e0c.15.2026.06.24.01.51.13
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 01:51:14 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9670c23ca7fso455795241.1
        for <linux-fbdev@vger.kernel.org>; Wed, 24 Jun 2026 01:51:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8IHDX0TSV6jXzUQBozo4EejE5WwD/8ij/hBI2ZTXbLZfW+i9BPjEVhHjuZuyZ6+wuzmLPNBGcRpwFxuQ==@vger.kernel.org
X-Received: by 2002:a05:6102:1628:b0:726:cd42:d039 with SMTP id
 ada2fe7eead31-7311593bc40mr980150137.24.1782291073707; Wed, 24 Jun 2026
 01:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622064915.767194-1-haoxiang_li2024@163.com>
In-Reply-To: <20260622064915.767194-1-haoxiang_li2024@163.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Jun 2026 10:51:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUSVacMR2Lb-VwkeZMrS=wKz9y+XtF=nAOCuSLbDs-HdQ@mail.gmail.com>
X-Gm-Features: AVVi8CdAnFBD23v1TZLF1N6maP__8rBsA0F0VCuhXPs6KKGubkqUcrjbf5oJASY
Message-ID: <CAMuHMdUSVacMR2Lb-VwkeZMrS=wKz9y+XtF=nAOCuSLbDs-HdQ@mail.gmail.com>
Subject: Re: [PATCH] video: hpfb: Unregister DIO driver on init failure
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: deller@gmx.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Philip Blundell <philb@gnu.org>, Kars de Jong <jongk@linux-m68k.org>, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Haoxiang,

CC hp300

On Tue, 23 Jun 2026 at 06:41, Haoxiang Li <haoxiang_li2024@163.com> wrote:
> hpfb_init() registers the DIO driver via dio_register_driver().
> If a later error occurs, the function returns directly without
> unregistering the DIO driver. Unregister the DIO driver before
> returning from these error paths.
>
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Thanks for your patch, which is now commit d6c3e2402523ce01 ("fbdev:
hpfb: Unregister DIO driver on init failure") in fbdev/for-next

> --- a/drivers/video/fbdev/hpfb.c
> +++ b/drivers/video/fbdev/hpfb.c
> @@ -407,10 +407,13 @@ static int __init hpfb_init(void)

As per the comment out-of-context above, this driver supports devices
on two types of buses:

        /* Topcats can be on the internal IO bus or real DIO devices.
         * The internal variant sits at 0x560000; it has primary
         * and secondary ID registers just like the DIO version.
         * So we merge the two detection routines.

>         err = copy_from_kernel_nofault(&i, (unsigned char *)INTFBVADDR + DIO_IDOFF, 1);
>
>         if (!err && (i == DIO_ID_FBUFFER) && topcat_sid_ok(sid = DIO_SECID(INTFBVADDR))) {
> -               if (!request_mem_region(INTFBPADDR, DIO_DEVSIZE, "Internal Topcat"))
> +               if (!request_mem_region(INTFBPADDR, DIO_DEVSIZE, "Internal Topcat")) {
> +                       dio_unregister_driver(&hpfb_driver);
>                         return -EBUSY;
> +               }
>                 printk(KERN_INFO "Internal Topcat found (secondary id %02x)\n", sid);
>                 if (hpfb_init_one(INTFBPADDR, INTFBVADDR)) {
> +                       dio_unregister_driver(&hpfb_driver);
>                         return -ENOMEM;
>                 }
>         }

Hence if the detection or initialization on the internal bus fails,
other devices on the DIO bus must not be force-unbound.

This is also the reason why any error returned by
copy_from_kernel_nofault() is not considered fatal.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

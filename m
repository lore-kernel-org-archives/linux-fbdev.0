Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DFC376463
	for <linux-fbdev@vger.kernel.org>; Thu, 11 Jun 2026 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165449; cv=none; b=HoE5URUBwW5HioXRAYuYo8/9+OgAP8lWofwKatEXuPhrHxiGBRDvbeA8/7R1QqHiu9RMM2lOC9TWXSLz6uUBzDIHoKt9XunRTtNBapTrm/cC6Q292YH8c7FKLnTE5mM14whTm4f6xerTRNISIAaoY+EFdJjrrcNnRsxRmje3RRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165449; c=relaxed/simple;
	bh=5/G/melH4q341EMTbiew8MEq5fXijt7ym+q2DgIM6is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdKzXqmhX1F9MPOhhu9x5lgBImrtGGlw+IJ1JasBwPD17XPAgJwaemPJrK0M+kJyc5teVhDgvFyfA/huosi7+pvpWdJNTIXJzQZ+frhK8QtHD6V3mwm2syUn8JO0cDfq8u1q3In7KNlFlTxAsJcbyMjRUtWJQkypwyDvXNVXS2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-96358d0a024so5205723241.3
        for <linux-fbdev@vger.kernel.org>; Thu, 11 Jun 2026 01:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781165445; x=1781770245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIoi3XPcNIb2wKg/vVIZMhNixDSLEl80pAhTezj3BuE=;
        b=l6J4U8DQ1fKj98Ni7nrMNwHJ+yp2CNnYwC22rrk5bRaKm5w1K8HJLiZf3OT+Gw2/7T
         vowtSrUk6R6eiEK2mHrAQ4ki8mIwl1gMuL40sN0f2BavdYl0bAdweoF0meRYbB1xn9de
         RBJ4fDf+QasODUWQlWLFvwnoWMH/FIRJ//tDR6BgDWYifL6lpFF/LLV7FRIUP7vCXtZq
         SKRWhpgjZCiQZ3T97PXieVDVCnDfm76j92v8CXPixPOENfQovnzzTa+Bagk9BUIvCF3B
         WJKs1GqNnEuSxxuTvMGDCXM6VYhyXTdNXSF7T3O0r1+/FfHtbnWd1kOOy8BKnDSMDaqc
         tIXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Qv+IipxDCSrPboXtOkHgYnjWlETG2RPeA6bWI1BOHGp3Awi8Efm0yuZ8mz4XVGwG+AEcQjMgGkbJibA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLUEgvmpmBUpFVtusYtF+akUsUpuWd+MrAdhx3srD1y6niV3gp
	OY1ssAJKMyG13uApWAPzP5kzh7FZN7sJZh+zh0cwvJrCUFJp+MjqhNM5+FBAHpuieJM=
X-Gm-Gg: Acq92OGO9eF2iY4MyLqxnpFYxq2/KmEjvLcnZftms3NRHWbEcYNzOQFV0jUN331usY7
	mH0W42myK4xnCGkD4HGDMu0oyB0YrHy8NWwehEFqAJMvxYnXVxD3JU+JW90yOq29GcjZ5LryZwK
	0nLRqIPUuT+IVOtVWJdEH5+YJrNFY1MD+N2zG2/f//eAe5YWT2tOU2tb2GZDAWMGrwvcmyDm6u1
	W+jNdu712xyjvrUgCblSGxUekSJkb9D+3HNMHLKVItOOTb8iXuIt33x1fnkjZ9IjfR2EDzkkzD6
	nO+GnMVLT/nnA4oCpQ2HJV0DFMDPuoxj7WnSP6ms6o0QWGorGm+QsYk6S7DnN6Oiw0Ns0jgvU2S
	bxLc2jC6JQopVyt8Oud16HFSv3iQuevTj6C0K2FFvlIc2RsgqivXOd20ZsZ4hYeooIsODh/AQS7
	vn0V0GHER1SRdtMDLQOGokM1dfKlLnVztfi0pGB1s7E/QsvPGkm3euCeAvwEl+iv47pRLIeLVRw
	Tb0lBddcQ==
X-Received: by 2002:a05:6102:598d:b0:6cf:f288:f372 with SMTP id ada2fe7eead31-71d5d29891bmr547553137.28.1781165444712;
        Thu, 11 Jun 2026 01:10:44 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-71d906f0fd8sm499530137.4.2026.06.11.01.10.44
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 01:10:44 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-6cfb0a137c9so4696295137.1
        for <linux-fbdev@vger.kernel.org>; Thu, 11 Jun 2026 01:10:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/V895mpnqhfIIN+UnGSoI6U/SdJ3RBueuEOTQkJLO8cp0d0ddh27gsU2GZeYitEZNr4Wkga1s6MXdd4A==@vger.kernel.org
X-Received: by 2002:a05:6102:a50:b0:631:26f6:7021 with SMTP id
 ada2fe7eead31-71d5d08c7e6mr549819137.26.1781165443791; Thu, 11 Jun 2026
 01:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610025014.5913-1-islituo@gmail.com>
In-Reply-To: <20260610025014.5913-1-islituo@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Jun 2026 10:10:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW_+WE2uUyqAEhSqT7F4pWseO6Gygbw3tCo7LpAJB2C4Q@mail.gmail.com>
X-Gm-Features: AVVi8CdVNKXrG0x1HHGz_rLBLe8j66H4QINxyVuJFwMPwOBF3fyFXz7IkA4-6yQ
Message-ID: <CAMuHMdW_+WE2uUyqAEhSqT7F4pWseO6Gygbw3tCo7LpAJB2C4Q@mail.gmail.com>
Subject: Re: [PATCH v2] fbdev:modedb: fix a possible UAF in fb_find_mode()
To: Tuo Li <islituo@gmail.com>, deller@gmx.de
Cc: simona@ffwll.ch, tzimmermann@suse.de, kees@kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tuo, Helge,

On Wed, 10 Jun 2026 at 04:50, Tuo Li <islituo@gmail.com> wrote:
> If mode_option is NULL, it is assigned from mode_option_buf:
>
>   if (!mode_option) {
>     fb_get_options(NULL, &mode_option_buf);
>     mode_option = mode_option_buf;
>   }
>
> Later, name is assigned from mode_option:
>
>   const char *name = mode_option;
>
> However, mode_option_buf is freed before name is no longer used:
>
>   kfree(mode_option_buf);
>
> while name is still accessed by:
>
>   if ((name_matches(db[i], name, namelen) ||
>
> Since name aliases mode_option_buf, this may result in a
> use-after-free.
>
> Fix this by extending the lifetime of mode_option_buf until the end of the
> function and using scope-based resource management for cleanup.
>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
> v2:
> * Use scope-based resource management instead of manual kfree() calls.
>   Thanks to Helge Deller for the helpful advice.

Thanks for your patch, which is now commit 85b6256469cebdac ("fbdev:
modedb: fix a possible UAF in fb_find_mode()") in fbdev/for-next, and has:

    Cc: stable@vger.kernel.org # v6.5+

I believe it needs:
Fixes: 089d924d03d5c17b ("fbdev: Read video= option with
fb_get_option() in modedb")

and that commit entered v6.4-rc1, i.e. not v6.5?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

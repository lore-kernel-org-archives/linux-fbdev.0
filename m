Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E00367F40
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335455; cv=none; b=iaNCfN7jqfT6TC7aAE+Oq/KpS7UTafjOR8JI2aEYG3R3FtEAZM3BFM0es/w1pWg/UfEqMBWiqFSHC1ukp+pnoKauC3AjQHA8Vjyz3XDArFPj4jy7lGePpw0Hind73FJ3I9EWG8LPJocn5xbBf+PAy7zztl/z1fuQ78HgXsFW8Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335455; c=relaxed/simple;
	bh=Il5EilNKbQmVM1qv4XgxLAe02Z9+zxydkwUqJc2BPRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqqph4ik5Ovdnpv+u0+dQ04VjIGeGDrzkoNhZl1fyq26OrCjevuZQyIKY56uOEXbeFnSlUwdN3ZTaHBz8YofNYft2wTjSqTKDYBRXsg5wolAUXe4xMcFZjyLMO/vYZsMGsLUAzy/aUw9Luzs37SO7Shc2F2Ex1YuMQr0VHChlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dbdcb85067so6554399a34.1
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 03:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335453; x=1776940253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9HEDsaws+1AaPEcUyrGjtCss1Kv3jZQFAB8Oib7mmY=;
        b=FPeRoA4GynROqUGSizaUz7BO7z074S5kiAUUK/1sUmxIBwu63v1l0oGNryrB8/RJef
         8mhscsSyaKyn0AidgWVlJHsk0SEci5bMSVZmC5BQeedOuzUI0AbjqQcTwnweDWB5YV+y
         xCww0KSyHkIzKwZWuBpjl1CHNvuqyH+jdbZWSD/UvfUga6gdtUmMAVDz6xjki3do5onz
         U8SwsRuXMVRo4gvFGpnWrIpN3WXDDGzSMHNMf7O2oCsosRkHo4v09d6oGfRuT9p8v5+o
         Xe/3n/asl/AH8Ihdqea/4eXe3i+qwzKjBissu9PB9AQjDomXx0mEaS99M1VFu95WNGOp
         05nA==
X-Forwarded-Encrypted: i=1; AFNElJ+r9SiWn/2EXuGUNWss8YUnV/kxHmGU97YGQTt+rDh5+cGK9C3TNb+KDB9WeVz4i3TwbFWgIEzaY50/HA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPK339AB+wEAd/i4NMSWi/DPG/IkpliNx5JVpTtHMHmwODa5s0
	tPwM9SDKYlkKIHg/JK48FJ+2uiOSl5YbHT8O/mJZ7Cf2WJxVZyv7DKAIj/glD+xo
X-Gm-Gg: AeBDievLODGLh3Lt4BVVbdj5eKTosOQ9d7kb590TkNghDdyUqy+8P3oTyri0IPhtdUX
	MKFa7ZPanZB8mJUcUvWrD6J28J32rj8WeEBlR92P+pahPNt0NzbJuM4jwocRMTlLQqOE2kbWh76
	ohHn6YMNCtXXGFt373jO2sdEiGmkRySUkeiAFt2cXrDpN5wBRm4d40KTbYU6iaPBaTnIXMGUw8h
	1EwfDYCs5AC+sf083uCDVIuL7ZuLd2lNySuV7R6v5vIy2xMZWPwiwFBhuvWrQXPZA8++yx8PV86
	LrdRc9x17RQAAwBfILYkk1v2TF+VFlvwe3soYqksDLP2hgmdlCAyNGE+noiAj435FFzdqoEjPRs
	CW0wxVWonzjwUibheLwUl/SuJcguy3PmUrw70KybdzHG8tZeqOycZNrmP49WUjDms1oWipCQYf4
	yIJ3JyU3kopCJHBRYnx7gb8xQhTffSaTcBTd9t3I6rgeDWBkvmORV/JDobUND+5GfvoaeljFyt8
	Ig=
X-Received: by 2002:a05:6830:25d5:b0:7d7:57c4:367b with SMTP id 46e09a7af769-7dc27fe671emr16375258a34.28.1776335452668;
        Thu, 16 Apr 2026 03:30:52 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc76a123f9sm3185408a34.2.2026.04.16.03.30.52
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 03:30:52 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-471618e20a5so4028502b6e.1
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 03:30:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+vqtcZ4HSVHqrgVaWDq0mVDPXSitL3TTGmPjEdM+enJpm97ifNVb0UwGbZE8bKJEhYfKUd6hi/KOqfCg==@vger.kernel.org
X-Received: by 2002:a05:6102:c48:b0:608:cd24:354c with SMTP id
 ada2fe7eead31-609fe9b0d22mr11966750137.3.1776335071251; Thu, 16 Apr 2026
 03:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.794680738@kernel.org>
In-Reply-To: <20260410120318.794680738@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 12:24:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVerN6Pz07CQH+hcvT=-ZD-r9VNrSrGzTQZBEsuecK_ig@mail.gmail.com>
X-Gm-Features: AQROBzDRGGELVSySTko37h6zEj8YoV3p6pwZDCVQUlUW6sZbw_W5mbJzFIh35nQ
Message-ID: <CAMuHMdVerN6Pz07CQH+hcvT=-ZD-r9VNrSrGzTQZBEsuecK_ig@mail.gmail.com>
Subject: Re: [patch 18/38] lib/tests: Replace get_cycles() with ktime_get()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
> get_cycles() is the historical access to a fine grained time source, but it
> is a suboptimal choice for two reasons:
>
>    - get_cycles() is not guaranteed to be supported and functional on all
>      systems/platforms. If not supported or not functional it returns 0,
>      which makes benchmarking moot.
>
>    - get_cycles() returns the raw counter value of whatever the
>      architecture platform provides. The original x86 Time Stamp Counter
>      (TSC) was despite its name tied to the actual CPU core frequency.
>      That's not longer the case. So the counter value is only meaningful
>      when the CPU operates at the same frequency as the TSC or the value is
>      adjusted to the actual CPU frequency. Other architectures and
>      platforms provide similar disjunct counters via get_cycles(), so the
>      result is operations per BOGO-cycles, which is not really meaningful.
>
> Use ktime_get() instead which provides nanosecond timestamps with the
> granularity of the underlying hardware counter, which is not different to
> the variety of get_cycles() implementations.
>
> This provides at least understandable metrics, i.e. operations/nanoseconds,
> and is available on all platforms. As with get_cycles() the result might
> have to be put into relation with the CPU operating frequency, but that's
> not any different.
>
> This is part of a larger effort to remove get_cycles() usage from
> non-architecture code.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Thanks for your patch!

> --- a/lib/interval_tree_test.c
> +++ b/lib/interval_tree_test.c
> @@ -65,13 +65,13 @@ static void init(void)
>  static int basic_check(void)
>  {
>         int i, j;
> -       cycles_t time1, time2, time;
> +       ktime_t time1, time2, time;
>
>         printk(KERN_ALERT "interval tree insert/remove");
>
>         init();
>
> -       time1 = get_cycles();
> +       time1 = ktime_get();
>
>         for (i = 0; i < perf_loops; i++) {
>                 for (j = 0; j < nnodes; j++)
> @@ -80,11 +80,11 @@ static int basic_check(void)
>                         interval_tree_remove(nodes + j, &root);
>         }
>
> -       time2 = get_cycles();
> +       time2 = ktime_get();
>         time = time2 - time1;
>
>         time = div_u64(time, perf_loops);
> -       printk(" -> %llu cycles\n", (unsigned long long)time);
> +       printk(" -> %llu nsecs\n", (unsigned long long)time);

While cycles_t was unsigned long or long long, ktime_t is always s64,
so "%lld", and the cast can be dropped (everywhere).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

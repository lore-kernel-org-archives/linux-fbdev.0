Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AAD31327A
	for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775984200; cv=none; b=USR0K92QlEfXlPJoU5YvksXSDZWn0MaoKtGuVksB8pFfGGUUvaDstNfO4VTN0iXRKHRIyJbBUgtZJTY2GYWqFT8PRGSxx+x4GIwCds8dZlcRBtwK5s+xJdP4IQyHdeC1j2eEOsB5nUzb/ap8pysqaQg7iVoycVdLr83Ptbd8Vwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775984200; c=relaxed/simple;
	bh=XZtsBYJ+xUzK/w66hhh7L4ep5/Nv3d9zyXSTiNiHtzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqOKKrdxXX8+ondkBAecm7WpaeiDAkILRpWWTr6Z4rb/47qDP6dMhc15J5HFkungSp7YDEIsyE4JLJkIUesp8Fk9qjQ91sU9TTklDmcYngVMXIHY6vvKvilhLZbYyI7Wn/CLsCS+DbdMmjqjQP1ot+lXjLXt+7J9S1Oc8NHfdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rmk25eS0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmk25eS0"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d75312379so133517f8f.1
        for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 01:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775984196; x=1776588996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbDgrbrkQIZIzHMqS4zyFwb8jbE/7QCDRz8zhtNheE4=;
        b=rmk25eS0pD3r1W6fBjCHCIGG+xosVecWiNg/3nfNyAKaxOqHC0aIxIp+bwKvPu9+1j
         fAU2vugkDHatrG3Fzq7V9jewKzPcvw41odvofwZkis7b1Y4DeW1IWegwg5QbXQj7kCio
         L+ztGdtDUlhH+iJPC48SIdv4mbiVxmA7Be8JQhGglK1VOqWIq1YR4dry10OotSVrXztE
         o4/62vmfM6KQrUkxwd24yP/lrxDf8HyZquUshVzt2ycEVPZUv3y2nMTj7GvueTw7R7E/
         WKG3HtUgcwPCHxCI4T+H5u0NML0HalT4/vA4x/F5vuumDuC+b3YDtjggzfClJhOrbI7r
         R2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775984196; x=1776588996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbDgrbrkQIZIzHMqS4zyFwb8jbE/7QCDRz8zhtNheE4=;
        b=gsBP+Jnu8Xb9OAOFroO2iUInUURQ8/JgBzhfaxPMFLgFRTWxVPzfGuF5bmCcoBcC1A
         d9NkoS/lwCNdKWOTzPpJptJBe51SR83Sw66MDcRqr062ocD0U2oJ1NCw7o8aNudIJ1l5
         IsDBts1j7hh52rgReK+Ug/O9gIR7L29jP/tonTsS1E+jsIF3C1nCxkLSrPQ8qZJugeIG
         sRozl9Y9Z5gCUzDkKJto8OS2OGqR5FQ48LJUCYM7C42Ayyl86jc2NINtSFIU7+BdWP6w
         J6bNIjQ4/kVWwIGLxPXZr5hkgSDZoHLPV/6N7Q3MdqmYzl4l4xbk9o6vb3eOnF+4Y0s+
         Vilw==
X-Forwarded-Encrypted: i=1; AJvYcCVGw3qSaN1TfzM5wJ1Y7jCpzVyvOxMAxohrNWslK4WhQDv62CFQbTQzIFcyNc3fXsp6NyjPvD3NYLRZyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyCAXH7giDBuKwjYMNAul1qhSLSLl0qvaNmPnemrpTt82yQYX6
	yCW2kTDYXWq2icp4xyEK5dtHaPBpoMt9QOhzoFdBc4u1o0P/du0/4+hR
X-Gm-Gg: AeBDieu1kME80oQ/oa0b6481X6sQoaKquhLB8PPHb/g6gGh+V5Mzgruq6MYgizZtmIL
	s1vu0U2TmNaQjTo4p63fDJOByluGBkraIjiHjvS+mrniuQL4ReiVcxC3Jp3oP6r8OVp1o5a2l52
	RY2LivNEh4Oey7tebAUamtgCuD1pYaaKdXh9NuMbbhRcxZzV8ja73J4cUYsSTASLeuRixZfg5Xv
	9QGMYj+Fs1b2f6ZUxSsD3mEgcdv+XRh0XFoOAO5EsInUOoYRHDXy7LAbDja2YuB49vOPOFKbchB
	9kLfk0189Epb8/PNum6JDt/1yc6Aj7stW16CaxR/ncWW9OgPlY/cdFNf2s4FUXTZqRgZINpwYWB
	1lqqmlYRcCUp+FjHIEqeIaeqDRQx7zLSJblrNrL5h0tvmFlL3/9hNWpqNsqZrvKAc0VnJyxD49J
	rjF5cCtBf8sIKH5wuoiT7IgLGpJ6EdUzkbKmmili3QvuZ6F4wr7R74+E9CTT93t543oI4BdipHA
	LYbQA==
X-Received: by 2002:a05:600c:698d:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-488d6ac9ce5mr126951995e9.14.1775984195334;
        Sun, 12 Apr 2026 01:56:35 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm197923925e9.4.2026.04.12.01.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 01:56:34 -0700 (PDT)
Date: Sun, 12 Apr 2026 09:56:33 +0100
From: Stafford Horne <shorne@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>,
	linux-openrisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>,
	Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Thomas Sailer <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	linux-alpha@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Subject: Re: [patch 30/38] openrisc: Select ARCH_HAS_RANDOM_ENTROPY
Message-ID: <adteQSw8c65MtX5l@antec>
References: <20260410120044.031381086@kernel.org>
 <20260410120319.593798781@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410120319.593798781@kernel.org>

On Fri, Apr 10, 2026 at 02:20:55PM +0200, Thomas Gleixner wrote:
> The only remaining non-architecture usage of get_cycles() is to provide
> random_get_entropy().
> 
> Switch openrisc over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
> and providing random_get_entropy() in asm/random.h.
> 
> Add 'asm/timex.h' includes to the relevant files, so the global include can
> be removed once all architectures are converted over.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: linux-openrisc@vger.kernel.org

This looks good to me.

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/Kconfig              |    1 +
>  arch/openrisc/include/asm/random.h |   12 ++++++++++++
>  arch/openrisc/include/asm/timex.h  |    5 -----
>  arch/openrisc/lib/delay.c          |    1 +
>  4 files changed, 14 insertions(+), 5 deletions(-)
> 
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -10,6 +10,7 @@ config OPENRISC
>  	select ARCH_HAS_DELAY_TIMER
>  	select ARCH_HAS_DMA_SET_UNCACHED
>  	select ARCH_HAS_DMA_CLEAR_UNCACHED
> +	select ARCH_HAS_RANDOM_ENTROPY
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select GENERIC_BUILTIN_DTB
>  	select COMMON_CLK
> --- /dev/null
> +++ b/arch/openrisc/include/asm/random.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __ASM_OPENRISC_RANDOM_H
> +#define __ASM_OPENRISC_RANDOM_H
> +
> +#include <asm/timex.h>
> +
> +static inline unsigned long random_get_entropy(void)
> +{
> +	return get_cycles();
> +}
> +
> +#endif
> --- a/arch/openrisc/include/asm/timex.h
> +++ b/arch/openrisc/include/asm/timex.h
> @@ -9,13 +9,9 @@
>   * OpenRISC implementation:
>   * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
>   */
> -
>  #ifndef __ASM_OPENRISC_TIMEX_H
>  #define __ASM_OPENRISC_TIMEX_H
>  
> -#define get_cycles get_cycles
> -
> -#include <asm-generic/timex.h>
>  #include <asm/spr.h>
>  #include <asm/spr_defs.h>
>  
> @@ -23,6 +19,5 @@ static inline cycles_t get_cycles(void)
>  {
>  	return mfspr(SPR_TTCR);
>  }
> -#define get_cycles get_cycles
>  
>  #endif
> --- a/arch/openrisc/lib/delay.c
> +++ b/arch/openrisc/lib/delay.c
> @@ -18,6 +18,7 @@
>  #include <linux/init.h>
>  
>  #include <asm/param.h>
> +#include <asm/timex.h>
>  #include <asm/processor.h>
>  
>  bool delay_read_timer(unsigned long *timer_value)
> 
> 

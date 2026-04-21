Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD73B95E0
	for <linux-fbdev@vger.kernel.org>; Tue, 21 Apr 2026 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770577; cv=none; b=UQcE+kkOhGm2tmcEcX79XDOge2d6oImJ3949P7yHyJ44mQ0EwPrcN5+slzOkOeQj0vswUblOucnQp5Tfnz0g5mXeW97IrG8Yj7GuMxsMywDvH6J1iS99Ebkz+8SbYU6wh94DpNMqIiRVgyI2Zy6Vuc92sjuZ5RPzDKocLQ28zns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770577; c=relaxed/simple;
	bh=7J5sLUyTcEtZ5b/o54KJz2TjlXrWGH0W+oigsdVGJYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUgGYf8bFOxHA9Eb/ampr15QFqEmWhSb8pURCrmCmkH/AU7I2IByR3Of9HvBTB+/3/VMFcBHphsCvfk8HUtt4l1xzFT7eGwZiohA4OqmRcrJdLZaJhc9gj0fYyUrUddDSFYyYb3/8w8e4+hVpIZsXjWP67QLsJU4vt5xc4wWzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lU9jm6kG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU9jm6kG"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f33d28c1dso2248103b3a.3
        for <linux-fbdev@vger.kernel.org>; Tue, 21 Apr 2026 04:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776770574; x=1777375374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbepvZoiaQHnY8ojgGndHUN0tqRJnJo2KRx8HLgDgUI=;
        b=lU9jm6kGqDjqxIjkWxGDeqDvr17UMQYeVNP9rS5P3UWd7+VE4cpTrRwlYKSpCHI1KD
         zZA4+dsX0fyXlhWGoGhioT7GlAk6Cad2+kFgyXXf+ZkLjXgYuVSOk6W9JhbsksRhS+cn
         JjoUEw79Nz86BTgOmxYEMCIS5sQKYiwZ5dfniI9hbARcbUXmygsWFT4/6ZYrU7er4B5b
         AF39CTz+lEumwPTp8qh8DUlpS3e4Z+amiPfglYGt2PS3FjwfgzzvqXLqKOW/KsOHooqZ
         aJdiZQCu+ux924UJHp8L48osT1cgJGdd6A/cCTA6wbL1kWXsoMldHo20OThek5XInH4F
         NHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776770574; x=1777375374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbepvZoiaQHnY8ojgGndHUN0tqRJnJo2KRx8HLgDgUI=;
        b=tWzcf5CE6A8uCdQO2Xm7wYJPTuxdtwVc2ZaHSykXLnbEpv3LhqoDH5jrw/dGJvzitu
         7uPJakyZ1uEgqFG9tq0VH2cZm7ugMl4niBjcQ5o6jnjiiXAXOPgPeSAiJVp2w63lKS5R
         Q457Sr8wDzfdlsJDa9MgTviVFt3yP/EkCedTCjQ6jcQH2Fbs8nMii7ZCKLuvWHkPjOih
         TvBnIw+vr/8bpvea2+aYDT6nvIeHZLWmII8t45MFNSBYSGO0QQ+l0b8iv7V9xAnD1rh7
         Au+9J1xFDaO7cxbJ8Lu9IYcE1QwlzeUNPtNfFniQxMCnGH5eRnPIdzGYclRg3piRQsqr
         26vQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ak/f7WbI2DJie+cq+ynhHpYGO/zA1h8U2KK0KgGeag1qXMVtPkzlNNGpgC4tBsa+0OzdvnXkfJad+TA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpqTyqmuHjxr0AojKSeh0pXdHn5mydGWjBei7D6O2bxC09+KvM
	L7c69CgL9QeiorHUNFP7RYmWvf4An9tG5iWQwz6e3Jmwy3/h5AB+00Pe
X-Gm-Gg: AeBDiesoOocTDwoQDlQ0ZuZLs8diKtPzBgHWPJVc8Wd/HFxJpvRGqLVIxmgItylC8/d
	suqjsgh6sd2EhFnJYPLbW2B5mZy9cgPFtRtIlgKWCTmuxhAUmUpREzS3sPCnHxqumhKqyokLH+W
	C8PKRYTtwQ8BB+saXmpw+5rSwWskcwBEP5HayfGZzAgmJ36OjU6V5D1Ichtb2Kt3qKYIa02m3Ku
	RO8YSAHxRM23TDsvZIzc+7R+MT14G4yE1OuzhayFFK4FFdCwGkwWSWKMML9XnOUvtqHTMbqGQc0
	aZpHOpFh2YNlGjly/4Ag8UAjtIBBDfri/UkqWGI4BvIgtzB7cD9WJzgm3z9KLlZneOqntx1St2P
	slkI68CG92vjLMK9VrvEQGC2TdOzTtaKJHreMzqLlgBbIjIvpJOQSc+mIid40TbHQsaR7DEuUNE
	d/o2woxRI//buwZEBT74pvvTXPJEL7+Bx7BjYY9Gd+nZohJvkmqfqAVdlpvX7u/m0jY2FR0T5Mq
	0Tb8g==
X-Received: by 2002:a05:6a00:6988:b0:82f:aae5:c7a9 with SMTP id d2e1a72fcca58-82faae5d438mr7228492b3a.27.1776770573719;
        Tue, 21 Apr 2026 04:22:53 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981a0asm14155014b3a.3.2026.04.21.04.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:22:53 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:52:37 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, 
	x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, 
	Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>, 
	Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [patch 33/38] powerpc: Select ARCH_HAS_RANDOM_ENTROPY
Message-ID: <aedc9UddBSYXzrAj@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260410120044.031381086@kernel.org>
 <20260410120319.789114053@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410120319.789114053@kernel.org>

On Fri, Apr 10, 2026 at 02:21:09PM +0200, Thomas Gleixner wrote:
> The only remaining usage of get_cycles() is to provide random_get_entropy().
> 
> Switch powerpc over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
> and providing random_get_entropy() in asm/random.h.
> 
> Remove asm/timex.h as it has no functionality anymore.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/Kconfig              |    1 +
>  arch/powerpc/include/asm/random.h |   13 +++++++++++++
>  arch/powerpc/include/asm/timex.h  |   21 ---------------------
>  3 files changed, 14 insertions(+), 21 deletions(-)
> 
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -150,6 +150,7 @@ config PPC
>  	select ARCH_HAS_PREEMPT_LAZY
>  	select ARCH_HAS_PTDUMP
>  	select ARCH_HAS_PTE_SPECIAL
> +	select ARCH_HAS_RANDOM_ENTROPY
>  	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
>  	select ARCH_HAS_SET_MEMORY
>  	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC_BOOK3S || PPC_8xx) && !HIBERNATION
> --- /dev/null
> +++ b/arch/powerpc/include/asm/random.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_RANDOM_H
> +#define _ASM_POWERPC_RANDOM_H
> +
> +#include <asm/cputable.h>
> +#include <asm/vdso/timebase.h>
> +
> +static inline unsigned long random_get_entropy(void)
> +{
> +	return mftb();
> +}
> +
> +#endif	/* _ASM_POWERPC_RANDOM_H */
> --- a/arch/powerpc/include/asm/timex.h
> +++ b/arch/powerpc/include/asm/timex.h
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_POWERPC_TIMEX_H
> -#define _ASM_POWERPC_TIMEX_H
> -
> -#ifdef __KERNEL__
> -
> -/*
> - * PowerPC architecture timex specifications
> - */
> -
> -#include <asm/cputable.h>
> -#include <asm/vdso/timebase.h>
> -
> -ostatic inline cycles_t get_cycles(void)
> -{
R> -	return mftb();
> -}
> -#define get_cycles get_cycles
> -
> -#endif	/* __KERNEL__ */
> -#endif	/* _ASM_POWERPC_TIMEX_H */
> 
Build tested for this series with allmodconfig and allyesconfig on ppc64le
machine for ppc64le.
tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git getcycles-v1

Boot tested for this series on powernv9 qemu, powernv10 qemu and pSeries
power11 hardware.

Tested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>


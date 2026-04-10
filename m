Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8A3DA7E7
	for <linux-fbdev@vger.kernel.org>; Fri, 10 Apr 2026 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835133; cv=pass; b=Cz4Wv7Ou+EWGVh5iv8nRO8jHeLmPerpU2RHKNO4Z0lUwPmqLx6BAUqWGyvuoF11+6hzsWyCFefMn5/KBgROmDlPS35MaXEMpwLySzBvyvMlkwtiZRvihA8Vi70j+TXl4HqzreFOIkEXXilERmHeBp/me0oEqCXW1kQ1yRFk9xtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835133; c=relaxed/simple;
	bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQEcVluRzq/5194PqeO3Fq4KS1hdM8QQklAzH6EXvmELEJOkk/1IUrKU/qYvXcFoet0d7se4RccrkB3GE7w5l5NDLSDXahzDWE1z8wKbl6vuv4Rsp5wqhp1cDf/GG8hjmUgB7vhWZJOYcUSC97IsNhhQLdRZektrrlB+M938yqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=cs+zJ0r8; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="cs+zJ0r8"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1271257ae53so9590776c88.1
        for <linux-fbdev@vger.kernel.org>; Fri, 10 Apr 2026 08:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775835131; cv=none;
        d=google.com; s=arc-20240605;
        b=IhE5pJhX67P0XanD/+Tkqv1jrZeUjOTr4rG0S/XQfvD/ePCL0JxCz5xco2S+N6EXEe
         1eHtxxNF8gL/WEGSqjI4kB0aXNZWyLgZDvDJpsOzR42UL6xvRc2g4pl9xru3MmqEB/J9
         EumYUvlN6Gk8Y6ND4NxeqKnJKR7RpzY3X/6KJwDHLncVVIqhAaHJ5+mdlPdY2T2+q8tU
         Pf1dKnc+AndGbKNO+FLAieKqPCVEhw4qrm3rWs+mJTUMkBcGEnTg144qjoocBtqBS6PN
         v9VkoCkKEqzDOGeJO6rB9ltg0iPjI7BQfWURCDp/MfQCxYYO7R8EjInE5/gw0Ck3hc7L
         0xaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        fh=uW0J9Uphci+jiG2GXVb1kFg4u2kA0Ma9QUYfSM1xwJc=;
        b=E4eNOcjSO6Jk/rc39Zl8F4tsldid4DL8y+tUC6tBM3NbDpFvdloW5DzlmqHzWRsgRX
         5Xybf+9xyaJqFJ2UypmvtHP0dNIfNKcI2Z6KTBFgLG26feEK6oFdjKxotPUE0xRN5WJ9
         nVptSFfgTl5BXb2iAR1W1XUgmCP7VBFAslNd5tF5nzSno4kReOlllU6hiTxxcMQeLj+c
         LUkgh0Rxo3Ib62eEv/86l9qCOLMHaMcyPRFrYKgRKMcE/zzUpgAEXEkafIABg6S8FN+2
         nvUMDspAYNCLMSDIif/hr7uX6dPZzrrvZ8TcS9jyveGLXHhcRSULkGbRXjpUmx2qHWa1
         e5WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1775835131; x=1776439931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=cs+zJ0r8E1VxbeERL/6orYDfRzBNN0xV+FBDuuOmam2/EuHZ7scxaUctzZ3REo2LBr
         KdQSu4tLtUeUQ/Am7PGmtjXBLQ/7knpdVClf5erC+tpkhYxe59BfVvuW88STHDIDr49T
         TpKPrBeobAalm+DfnxseCj+mCeyPg4AFXq4Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835131; x=1776439931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=kSYMUfEF3urXYwyPRjM+UkMdp58XVJPsy6+GdZKBjaEjbte8K4+3+ODSjYtsNAWfjy
         7GxQ/QknYc+XWLd7g0NPjHx1SZXRRzF1WsAP5hUImf0yng1NrRMFVd0HG3oik3fA0M0B
         WsrXQIZfexybPtv1iBBLdDI15ocDJdCDwmKBDnWbNmz44mkjnh1morWGULznlQwbdRXU
         ELGuIHjBwhIRciIdPS4xXfcNu45c41IHAv1bumm9n+6V+5+IAB1FzZ5F3nBQ++O2y5br
         /VZ4aTNYsy5AMovmKKyRZKIQUvB3Wtot/KQ6jZF+aNLU0wv2WiPULbFyMG0VNkoDzdcE
         tlpg==
X-Forwarded-Encrypted: i=1; AJvYcCVMgD06SK2iIQhV1yulaCjcWHQx7eLyODmSdfU4SSmrUoEx6jSXBJlWSNAIXNrR5+HT59acU5K694oJtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwngF5wDTaxcyoZb9/ENgcJt046+4euwEZ6i6Sj3ytIdz4X81N
	o+akA3yfwn1+PhFojK2uGHt+bmT6lfF3mHCXbt/t1b7932vfbxZ7fqDA+L7g6QDy26j4LBZ9u6n
	c4NHvELz8ROB1expuOwI7VR4U5EKsvhhr9ge0qquW0g==
X-Gm-Gg: AeBDietpC0yM7kzvgxqQ9LFzmhBOQZUh7VbW3wCpht06ONQmQ2EjQ9JyI8cEcSP+fAX
	kF5OVZIpaR7xzyqYrruWKdTbKMUO575FJywgqaUzOS0nMPi65K74nsqZ3AsUuJBQHOCA1W40D5S
	tLdaAGJSvW1FRkIJR4BzhW7t/02OQFIWHJK1YCy7MarF2LLTaE4CuDE4u4FJDug97itlUkdxqY3
	gMugfsForgxLNIT/nsL+9l53izAv65309EW5mDuYP/koPwUMcTRmuylt5Bd+0oYVXz2gpiNKXGT
	pE+P
X-Received: by 2002:a05:7022:6097:b0:128:ccb7:7fa3 with SMTP id
 a92af1059eb24-12c34f069f8mr2159203c88.34.1775835130696; Fri, 10 Apr 2026
 08:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 11 Apr 2026 00:31:59 +0900
X-Gm-Features: AQROBzAnX-XEClLFV-qWYFUzCuq4P43sNZviESiWFI1yCPXm2VtVZ2QkaUGJoPY
Message-ID: <CAFr9PXk7qK8-2JWrrfgXHoS9JWTRL+WobLjmAesyCE9VLL8ZyQ@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, 10 Apr 2026 at 21:39, Thomas Gleixner <tglx@kernel.org> wrote:
>
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.

I have built and booted this on my Amiga 4000 and it apparently still
works so FWIW:

Tested-by: Daniel Palmer <daniel@thingy.jp>

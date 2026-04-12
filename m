Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA8D37C107
	for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776000187; cv=pass; b=efi8nELAfUZxqnLSit/tgk9WU3CyZ6gpaFYuuLS9jojKLDuhKnzyiOU3CwoBuNm66MnTbAYXRK5vJbZpfUOeEbSgKBFHwgfSJXu6uz7OtCwJMxiha6UskxZihNCfNGkBJhSwraiXqTU8yKEaoVYr0+HwfqlaY2vZirPjTJCDgWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776000187; c=relaxed/simple;
	bh=1p6x7PvyQL+5PGqdAnx23TY8v0cVXdqCOnUZdmPD2Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ng4tRDlopiGY1SIQhRNq8Jkv6BFMVVBNBzASKGygQFn8R8CGigqwaJ6q8OV/scKIoOReyrPtejx1XzeJ2cCw2cwpm5Xdzpm8ZodtxA6j97SpvxKAExfdXJ0vLx4yE8oE21TItu+yVX7+bOUjrjU6xVLwxRkY4XZjvswAkJNwfCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dccArJm9; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dccArJm9"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9c1da7ac63so541556366b.0
        for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 06:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776000183; cv=none;
        d=google.com; s=arc-20240605;
        b=ZTZF4qtfpflO3RUoLernwHAm2P5Onblo1az/OEeYdBKAqPBEP1cbYNRnFXoQMcuai0
         /bt6drtsfLCV1GlazWAY82vU7REmxoZzJ1wWageh3KoOf3pf48mrlKgv4t3HvNtGvBL+
         9HomGTVmbxh4exrp8a10EqRmPY0gbUzph8uNHG859UQWBb1s3HxssogrbNIa64Zzy7jB
         TRJk1jDyOwGD8WFsO61dwBD6qUZ60LDsQFb9l7Rg8dd8ZlJeIBKZMnnH0yjmZbU75Qsb
         DjAfSgyGQ4MdHejpRWhZ3+31AUG5gnACBmjgqonnTtgEv5mdBaHDHzXizp2JtOhtmNvW
         KdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        fh=W3w8V8r9Z9hRxdURsoPesa7fRD5eY6lPlwz5Q/EBuno=;
        b=Ft6dQzmN2TiQZi8/AfkTYZVQ6MUp/gP9sCaFy6T9ORTZmumyCBneQ+rAHfBwuanlyD
         9Rsu0Zyy9fO2jmkpPMLyf+EAYXoz0ubUVNOYjkKcaa5i4dmQmwmXYnMfIoXOyWRdgvIf
         d5gfa75hlcOlrlD74T4Twu2jloRO2rpkIMimCn+kKyA1ubFyl4HYwo1OHL8uByXbgwBn
         xlRin3YWmynhgFtSqTLRO8Ojhwe6Wk4qbNZ7U4YfcUilpUQtl7AqOM9Bz5eMuh0370v+
         6nN/QgdLPPGH3Gj8NKb6xGA9In1K5jfiTJobf4YPcg5q3EKpo2VPKjqmkK4efAkRR+1M
         vucw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776000183; x=1776604983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        b=dccArJm9v6h9Fdk8lDGNWZnQG14AQ9ZokHDnv7DAL1GW0R6BDoMR0waR0wHnO++sNY
         YJPJSDf/Eo4Jqw4GQ8Gz/T/rsLkNap5uTZ+EpwANfeQ1dFGXyG88+fN/49+h4JvC9C7c
         2+asFn0yzVsL4n2hJqrH+GINWtCINsNrMCDz6yHqeLWKks0EsNy7ssNes4vhdFLCd+tg
         k2Ys2/EuxonOOeyCkSNs/L20e6zSdmHhXIY25hzHxXat+VjZowRiCo0VNk9bdjlPvxYt
         DV9owUMCQ8VWv/4Ldm8HtUCj9QQlhYJyZr8JnJBv87EbzYIfO7KpnQu2sRPezsHrfV9J
         1U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776000183; x=1776604983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        b=OSNYoRNk9d11FsQ0aHo1+SqXWOfGJQeVm9Us+asGsXhutuvRKwi8+CIk1VbNd/53BI
         trclLW1GdFUs3CC64MHmxj4kaFDG7/DQGV89lJDPx5MunC7U92Vb/+r5hKLIL6c6xXL1
         6zQTi0gGPe/cNMvZm/ZUBc6ZqvlPcecJsDMjAr6UrEKk7AldpCIgVAW6tRAXIQvVK5ik
         XUWi8P9bTmVwgpw3xFKUcNe5FIBRYAgqqXjq94dpi2/ed5TqD1M1e2VuPFOwhCD/smBk
         NHFnoVTFtinzB55Z5JNAX6W74Hw1yA6pvWl1YLzTG7fkNV0STfwq08emKIsoB8Z1gp1m
         hp0g==
X-Forwarded-Encrypted: i=1; AJvYcCXSqFxCcNWU9XSS+WBS3/qfDJlJgbqGvbgCYRMbkxhq/2XBaL5dk4p38Hw3IJtqe4DwqjDHyzlsCDmqLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1nrG7JcbdvgIw3Gcko/uQhBNDLz+9+eBuS/veajujV3PiS2TL
	i6OMvLhwmp4ubFVvmlW1mF//qaqEu575MWnx44vcSkXa9U32VAwWgNJJYFckK5ZTFHqon3dt/ol
	OTptTbp7WueBFARkWAidZypWA4/ZMfJE=
X-Gm-Gg: AeBDietwSOLBTLaUOp2yJVZE4n0oq8Td3RuQGHp6/dKO2v5Eym0OdMo/JLgiWRmqijB
	fCkc+p88gW5I4RISVR3IY/gGv39LYshJIcpAqD0NyolUGgS3dfn0afxZSTHcVzsQpGZg0Y2aYHj
	H14Iin+9ptY4juH4zVpqHBSkwTfhK34ooa0hlCFMjyoRCyqhVER1oZmwrGNltGsPyPM0dIHb/lX
	eupL6cUxJWxHzb1fovWLdHkfRqKbeOaAoJQGpL76Z2/HDEWU2zLo1hlfOa9UKhmaYoyhcKiksK0
	9v56+blvit4Dt9VLJmVf4gyBcBOusYFWKvSeFsWB
X-Received: by 2002:a17:907:e113:b0:b9c:6ef1:ed18 with SMTP id
 a640c23a62f3a-b9d727aa4fdmr352963766b.25.1776000183133; Sun, 12 Apr 2026
 06:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.131582521@kernel.org>
In-Reply-To: <20260410120319.131582521@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 12 Apr 2026 15:22:51 +0200
X-Gm-Features: AQROBzAeMsaeSVePCJ__tEd4f2rWAY6MixXzp_fii2b8vyUpLt4xjSbtYzENFaw
Message-ID: <CA+=Fv5S68wZQapeaYTspOfsuGk=nBj60sx-ojHBSqrxV59Q+ZA@mail.gmail.com>
Subject: Re: [patch 23/38] alpha: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, 
	iommu@lists.linux.dev, Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 2:36=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch alpha over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
> and providing random_get_entropy() in asm/random.h.
>
> Remove asm/timex.h as it has no functionality anymore.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: linux-alpha@vger.kernel.org
> ---
>  arch/alpha/Kconfig              |    1 +
>  arch/alpha/include/asm/random.h |   14 ++++++++++++++
>  arch/alpha/include/asm/timex.h  |   26 --------------------------
>  3 files changed, 15 insertions(+), 26 deletions(-)

Hi,

The Alpha side looks fine to me.

I've applied this patch on top of v7.0-rc7, built a kernel successfully,
boot-tested it on an Alpha UP2000+ (SMP) without issues.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>

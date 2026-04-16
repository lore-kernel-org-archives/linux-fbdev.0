Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ECA396D2B
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338916; cv=none; b=MG0tn5mw+4Paf397eIVxKm/NKexHbhQM4W2w5m9x3XQQFZkQuQ8gGTgJ9pk4dkmh1xLN6q/HqXCIPczz75a5T3n47wyA4IA+qT8IpcWxoiXoBy5Ys15Pk+Cdwgegt5d1L/hruqYgdT/nzGV/iC5/6G62ybO/crPvyMdXKiI3Hus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338916; c=relaxed/simple;
	bh=5RcGmn3E6IkK/4PLTUVN24XJ2jAiV11BodM4t9S5uGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eri3Hq/tdi0ftwELoShShWI3P0AXAlM+0J+2sBZLcWFHoQH38XBNfAMuguRUfMCoUNigqreTO7MLLT7EcrGPAvC7miMb8MkmX0Q2rVYQSJF036zAj2EJERhB5yIH1rMfPR6cu9ntuwWRgQyJ0o8IAtk9a8AYfSnTihoc45sgh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8aca4e14411so58177286d6.3
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 04:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338914; x=1776943714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6jqlHRyBmHp78NPQbVn/INUSPCxYZ/sUXVIyq1nXfE=;
        b=SitmtvJkZu5XeOzaq4iVIfH63GkPYLmtXOUf8e4KpVMlenQyolazUHy/iK/NtHU8+j
         Yx0FxndA8aIs4Pbk4qwPc3XY1fePjSlhU7oArtcYe/yfu/yPcOVV5FlEDjl61Ox5lBfq
         wQytlYSaCKppjOlPgS9ASHjqEec9zYsO3Ltrdt1msiZZQu5ozSCdCwb9BDsxc9NYMM0/
         n/NNmsQ1B6QiyWV5vp7bcx3yRCYcrNF+fw/Z8YPVAKjUu8WR63xibE2chHrZ+6ui3sBY
         0EbSCs1EJTcxlfXFFqTlMwzBTv8Kw46qHokXbJpvnoMLhnlc00JJKRaQmXw99kgD1ldd
         bQQA==
X-Forwarded-Encrypted: i=1; AFNElJ/Xtgiaft2G19myFCcmzRmi1RX9Pm0TxYlDUoL0q4YXyS07+dFpHHtM7i/oob/xrBrRmdXUmw1iFl6A7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Y/dBrTdeBJZzSIlv94lWUuP9m/EYN/9jEtgRVaOxOri6jAOb
	jkMzjYvRg3rHESBZzFdIr9jPPFb36C9I7m6ZiZwGKcMRgqdMM79AM3h2E+LWx5QY
X-Gm-Gg: AeBDievnW+sPifW/vxdiUJAwn7Vz/jloS6tEMUWPc9fQ9RXtAc9KXbQUTUjfw+Qt56A
	PeJym4eOnBoFNakZkPVILVZqWKiVwv73N31I6j5Rpd1iKPOIsRt1kXDQJZRXrg+YekcDcRx6XN+
	8wQAgHL23USXsm3ebhw94btyzYV2N2iuY3PcLbMpppAg0/KkQL7Xz7TAxIjD+XdSqeAVn4btWhl
	xnvh8PgPGQsaGf9oKyqyZOX/d+HnyWZ9kW0JO9mbZl4fh3hZIZrRodDRhKTdn9Yp83RzxwM7ZlN
	efrt2UyLnly4kDvb6T3ostP2wSSE7cpLvC13CuCmv1udHzkGvRQcTMyJ08UOp5pR44duFdGvVIO
	jeXDE/rCTAf7RhXjEiyj8GWoz7e848W5TDKLq8d+Krv+9BYaqal02zrLQXJAXCpi7vpwV3meJtp
	KvBlWhQbfdzrSmuUVbdppsrfBodnyRd6IJGRY4k7L7S1MTKQncqSGv6Rirv4mkL54oRsZw0ALdd
	DI=
X-Received: by 2002:ad4:4ea7:0:b0:8ac:800f:10d8 with SMTP id 6a1803df08f44-8ac86139b9emr424677826d6.3.1776338914102;
        Thu, 16 Apr 2026 04:28:34 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6cda5a2bsm33947076d6.33.2026.04.16.04.28.33
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:28:33 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50335b926c2so59657661cf.2
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 04:28:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/s1qdLTFJ2NHyipvSQCyIi+z7nckP7mCAa/VPJaMgwhoyQfllaZnj1GqaaeQVUzebPo90gaIVznYvyZg==@vger.kernel.org
X-Received: by 2002:a05:6102:6044:b0:5ff:c64d:2283 with SMTP id
 ada2fe7eead31-60a0157295cmr11348128137.30.1776338547396; Thu, 16 Apr 2026
 04:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
X-Gm-Features: AQROBzCJ6rVnwwfhi99PI36wWXAFQ5DEgo1zw3RhVwYNSXoxkTYAcgIxt5Z0K1g
Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, 
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

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.
>
> Remove asm/timex.h as it has no functionality anymore.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

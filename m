Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05A391E64
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338899; cv=none; b=GDB3w9dKgeFDHSEB3N5ZgGpXnBNAlZNPTggDNa0mC/+fzTzeqOAIN1x55PjLtYNd6xrAzquPrjd0VChjYDQ8GU/PiZeBxvoN4wLV+s11WBOKhXnG9+ZWZISnEWBjGMtLhCpxmZJp45n1P9n5G4GCrw7pLn4YXIDvKXqLE0jp7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338899; c=relaxed/simple;
	bh=onL90hyVAUlPY0ASaWQwK2lX8QEYr5m106IAfPoIE0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIbphrQHBm0SdZr6OEuLMZA/VieZUNBEvbTYS6MbUIsT0Uro+hOtKTDJg6fd7Kg0kLgnBP6d7iyAzSWspcegVBnlms/pPL8bmLanEFxDkcqJiZKnKvt1rmnB/GKSZjv9ZextBRohBeJ7exWMKVS+lkF9CCpoxJpGU2fsh6rqs7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506251815a3so65641901cf.0
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 04:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338895; x=1776943695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N28AiHhMQm9a3ncbvMl4jwXcNZbOrN6OiiJm2DjJOE=;
        b=b6P8XudZYor4EfvSr0tgrhpkoe44kK4/4yNktNC6HwrV/ikPF+EqE81PtvIhq6pUTs
         oQu1ane908xhHx3l6F8BzoOBha3v/aIm2fB30SZeeipnmAzLEcJUc5z6fvrTHQOudr+W
         X/6ON/DBOOwc1vnEYF55Rjh/gch3EsGCC0AXvPMB8Ws8RM3W3zrmS8wwne8IA/TDnlJS
         BT0AafpP/Sgti0HypeYkdBkpMXdb3hnB1PGCihUFmwOI4dthjNz3SjNqZrehB+mk48D+
         lh9l0QTgblTgFkB7jrUoxVkEfKB8GbmNq6ld8XRgO9iIfm3YeI1zL37S8GFzF0cfZrQ3
         LfDA==
X-Forwarded-Encrypted: i=1; AFNElJ9xd/Mvi5Lt4fMRsWDLVoEBqHNu/gkouyqZJhIt7C75v5EOV9ZP/KmKz+qJj64Z482nNckg/pL3nvWBmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywym7NaO7GljC86DZcFXPZpkTOdKTflNPhD06fd/fhtb/s2eQ1C
	TlNdLgQtozlHIwgJ/05tXc1dCO7eYtUWIAtTMTqpVoUWdW52E/+/YhpSxZsx8xta
X-Gm-Gg: AeBDievitmxYiNQn4fNS5oJQ5W4qfF26Z1s3baRj5GLAU93XwKj7kWxEoEZj4KoWo1q
	j7eQmdDRCm62wkv8LiNtgTHDwbZRN3peOGoPiQEwsIiFSknNXH5b0G2FNFwpbYhzTiJCmF4jDA0
	y5kB4599zsvHNmygtTjzMTUKxz2UkzsZJBybZLMYYByQ9sJbxbixf9UUU5gQITvmYxYdLoyCyLx
	0jrvAv8mupw7Tgikzp7cHwqmDtjxw8XOcTQcgc63hV6B3AHy3cE5HXAjgh5HhA+qtMngKgxNOHO
	Kp4Hql/kZHXXoPrXkqBIS8HJ5mEyAApR3eKIiawoKKzdynWCw7AkiZcFagv5+Yk2RLpNdlmriC9
	+DFTvG6teD9gY3NrzTJ+9AFzJPRJXUI0BgjBEN9bliYeFtsoC7Y4+iZo0KGzVk30GuJ1cs5TXPq
	5m9sNqjDDUBksL2ojFM3Udnkn9nmgMWL766EoSzNLeZZp68O7aR+bnxkM+LnYDf9dFH9xBjMtC6
	lQ=
X-Received: by 2002:a05:622a:229e:b0:509:4406:44e0 with SMTP id d75a77b69052e-50dd5b15e71mr397672171cf.27.1776338895504;
        Thu, 16 Apr 2026 04:28:15 -0700 (PDT)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1b016a2asm44725141cf.31.2026.04.16.04.28.15
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:28:15 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d67a483d3eso851124885a.1
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 04:28:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+OHkHBxssoEMVo3VElF3tTEgjy+jVFFLGHGQoTmmOmLp/wREq0dJLAwFSK7eA0fKTmyDVfkXFjfgb2/Q==@vger.kernel.org
X-Received: by 2002:a05:6102:3fa2:b0:608:1b6e:f4dc with SMTP id
 ada2fe7eead31-609ff0c50e9mr11028119137.11.1776338540828; Thu, 16 Apr 2026
 04:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.045532623@kernel.org>
In-Reply-To: <20260410120318.045532623@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
X-Gm-Features: AQROBzCyA8BqoTVnHFn7fWQMKVWyMF2wrQlYn44P8f0X0RsdCOwGnnxui8decDA
Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
Subject: Re: [patch 07/38] treewide: Consolidate cycles_t
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
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

On Fri, 10 Apr 2026 at 14:19, Thomas Gleixner <tglx@kernel.org> wrote:
> Most architectures define cycles_t as unsigned long execpt:
>
>  - x86 requires it to be 64-bit independent of the 32-bit/64-bit build.
>
>  - parisc and mips define it as unsigned int
>
>    parisc has no real reason to do so as there are only a few usage sites
>    which either expand it to a 64-bit value or utilize only the lower
>    32bits.
>
>    mips has no real requirement either.
>
> Move the typedef to types.h and provide a config switch to enforce the
> 64-bit type for x86.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

>  arch/m68k/include/asm/timex.h      |    2 --

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

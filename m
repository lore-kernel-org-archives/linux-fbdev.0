Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0DC3A7F48
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338920; cv=none; b=n3gSaUNkAr4nybyD4e2jpyeR2/zVB1rSgxlJQAqgGDoCw/rAa59d5C1fNfB4UpHLwRQV8EUvGyheBPqw3A8tozyApnm8yOo4X03eZAb4UYrXcsGjIp7JnUuzakJkjUP4T2wfyE4xLQYewuSWLwmp1nzE2Q1Aw5H3528FHrokfew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338920; c=relaxed/simple;
	bh=FSgVIzpnraycKQsxAztrNgNSM9On/XU1ftEj+pCL/gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBpMo+CNFEWcREKJIV+ifbGgVhTWyTltQXu/S2Mfm6v/OenDcAflwXAIzk0o7B0D6UxKF1luOFWqkPWbZ+NvhtjT8OuPrxvQkJ0Fur/izDHFouL/Z0J4CZ+EUaU6RCq8IRThLYYgmPubyKJ0DSnOIE4uyXjUO8UP6FOe6IplHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so6984318a34.2
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 04:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338918; x=1776943718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AptjVPQ97g683jPGYCmYUacoTRTAG/3/TQY5t1TSdkk=;
        b=K/CL+hC0QaZAcxNz/kDnY8GmZjrmTV1X9Hb0Qo8/mPX4yxHEzSpm3XQbKeOP3dQSyV
         M+/qxElm/fPH69rmNsMo2hB/zaDvG7kwT/vCnvHCsobgbUi21Zsiw4tnNizWjvVzPv63
         v9cMfL27PqQVvruQI9tmZhEHy4hsJPC1wtvgoxyluGhzsx4tbXZHPxxjO388/RiQXhes
         On7vNDBhzy+oXORr5UPVnwnsBtfWGPArVR9r6pDBqK1XSP/fTyX21opeU+R1KfWAUOGa
         vqpy4nRoK9Nuibl9lcXMFBANO0qJhizjYfHk9oeqVGZwCfOJSvHg8DtUUvLPomRZiArj
         OJzg==
X-Forwarded-Encrypted: i=1; AFNElJ+OydwH8m+J14D7tjwqYsQBr26ZBmsf6EFH71CMf6qUzqsMcUdnxx0bJG3p+rofvWPgXJeqGmsmIRlKhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHGE5a+1X9DKp7pUs354jim5OlgkJKQxyg2yycmoN+G6j5V/7X
	XlcmLdl8BfoC8RoGmgTSTCHu4ve10ETkjGf43Xu+O3H77hx5JQnF186uTeb4BuBj
X-Gm-Gg: AeBDietnAvvVTrrsKtWW7CPQbWp8U8qgVGUgFvQ3+NjrRTQuY4prRK42wCAusfWEdE3
	ZdP6REGPvS26YaIkuRj2mfeqRSYDBW2r4o2DFKcAPDzvY4JyzsD92GhoK1OFVQvUxRnbYtukBd1
	6BNCIEpM4xWUyzGwHMisBYFBZaysSDqphhhziIHlkSQNfvLnA/vVXEWw73oHymtytWa47ytYPC1
	YxRP+CoHImQVEf+dgT4ukYu4+F3SGmy6vhS7O5DCb/+v0iyQXH5kKqSUdY129OHCXBtu4Nmllzn
	rloDk2HpxsvXFYv00vSLKv07zF7XnrlJMMlUT7nITgZbwrAHNWPa8FyRd1JDTyvLI/q3Ik3p8Hs
	IzKQdZEf/lT7QJ8gIjLwDvYjcwHiMtk3niaLvplDhCF3GXPXPSttAAEKT/BBrbl1aSpCsC1Du4u
	nSOUoVYl9PgDb7jDJTD556ZQqHTJT8moiWSr/xBDEhTchknKql32LMbdTnT/87cfykJtDiKgg=
X-Received: by 2002:a05:6820:168d:b0:682:4005:5f0e with SMTP id 006d021491bc7-68be8fccc73mr12853121eaf.59.1776338917786;
        Thu, 16 Apr 2026 04:28:37 -0700 (PDT)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-426896e953csm3856710fac.18.2026.04.16.04.28.37
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:28:37 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-679b072ed3aso3595567eaf.1
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 04:28:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8QZ1WOb2BrAgk/cbWtzDkW/IlckBEmR8tjk4W7ycbyW3QmpO3wL06xX+sDNA9mOsDTXXKM61OXjf60aw==@vger.kernel.org
X-Received: by 2002:a05:6122:788:b0:56f:1ed6:1d29 with SMTP id
 71dfb90a1353d-56f3bca6059mr11244615e0c.9.1776338533353; Thu, 16 Apr 2026
 04:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120317.910770161@kernel.org>
In-Reply-To: <20260410120317.910770161@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1aShz8esbYzJ7T-0Na6++_Yi315aCiUx0Cnsgod5uUg@mail.gmail.com>
X-Gm-Features: AQROBzBwwjc8yd10cT00Tu5Dl2qrCYQStWr3Lcobhh8coMrpPeCH9vhBSNokYJk
Message-ID: <CAMuHMdX1aShz8esbYzJ7T-0Na6++_Yi315aCiUx0Cnsgod5uUg@mail.gmail.com>
Subject: Re: [patch 05/38] treewide: Remove CLOCK_TICK_RATE
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
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 14:18, Thomas Gleixner <tglx@kernel.org> wrote:
> This has been scheduled for removal more than a decade ago and the comments
> related to it have been dutifully ignored. The last dependencies are gone.
>
> Remove it along with various now empty asm/timex.h files.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

>  arch/m68k/include/asm/timex.h       |   15 ---------------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442C2E285C
	for <linux-fbdev@vger.kernel.org>; Sat, 12 Sep 2026 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176586; cv=pass; b=Xh0T+2RaS8eiCGL7kKMhj1KE6vpaN18LRKvxdZ2nykftGWJbS2UhdMFqINZnylJ7lypsOYx0ETDCPRpAq9tlfgYfMOIyWGxiZWALw9HiqbjFd+6+wSC6C1QkAiszFXaiDAUHQzPEgkyXggqGx7tn3eUFbGn/VvVU0Ri5ff9hx/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176586; c=relaxed/simple;
	bh=MqFZZ1MZCCOk3B2AWbqhU4vVtD/Z+SwXDy5HKI6vso0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obWk63JuHcJczXJv5yqv1IHbsm7EMlPChMQ7ry+l9fs0kNl4x7bCrzZ/RI5ImuYdjQTnFSr5kcK1icPabz8XhqC0vw9PXqfie+7iWCPltfzJp0iahxxYj78BASX8ZCk4+16kt4AKXWcBPAlVA8k1a0R2Qojb59Ou5Y32rbcAQZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=QAqLa2iA; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="QAqLa2iA"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fe517774so6416475ad.0
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 18:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789176583; cv=none;
        d=google.com; s=arc-20260327;
        b=AjSvcZG1/lvTJgsU6ytwgdsWluFKfjcqRjTW4XNi0LWwMI5rC4u//4Ahv6L+PCrGD0
         yFdqOvQLZprlGEjfV8wJBHEOg/NSFHs+ql5ybGwXQdCaFibu6r95TJv2UcAY0RyFVmdV
         7YQf2q5533Dv0k4vanIBku+yl2eSY4fAUrAh1GOjDKZUcDNZOR7ZihV/I1EH4omNge7q
         G9pw+ogNweRdDueXNO+9X3jzY5Q4rT0k+12MH0H9Qu63uW+G78Zb8I1dkgR6lW8ZDRfg
         OIiqTHF8hUqKEkyr3iDkQkPCQKnxft3FrVW1r9o6zNGyVnE3pfSXIV0CRCHDr+xExCL4
         Rm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MqFZZ1MZCCOk3B2AWbqhU4vVtD/Z+SwXDy5HKI6vso0=;
        fh=/WK4BR+ontQ6GACyJ2XR8d+Hc85e4ouEDddNMYRxzUE=;
        b=ddXfMNEoBpizY/XOIH9G1a1j5wf/WyhgJ+rHIX0Y5Pa5fcndmU0UqoK1tOrtvulDWz
         3mTU8XtFuYzBiKFjIkqO4jt2zrRmUeNM8nmx6dxSA4H7kz1+k5xGutr7Azj9U3b/ukuE
         xWAZyH/Ieae3z2IaUi/pi+diF/x6XQCtcYwhFKIHxeLO8RqS2zGzdPCqZVLjqG12jYSk
         gXaHxR5KzZ3R8gwoW8m6jojJiK6hulWcKZ3D8H1Lq94hbL+fvAtRUHGohzFAkhDwG6eK
         B8BpnIdn2ElSZ2tMwFzq1qIFebr4omYve3QMgC95A4ca0Xw6ikb+F3SAq/7KW++41kG4
         gEsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1789176583; x=1789781383; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MqFZZ1MZCCOk3B2AWbqhU4vVtD/Z+SwXDy5HKI6vso0=;
        b=QAqLa2iAbwvbRxmC6B/DPpQl65ZVNzEquWN6wGgAhav0o7h1rYsToOePhjX5FWfOwV
         2QVaUBzUttmd9Bo86TSJ6STiOqDzCq4lJcczZXWAE7fbGVZ3m8PWgwWu+anMzWklqRTP
         /wcfwddYmq2X1nPNtWMdy+IL2+QUWEynTsNoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789176583; x=1789781383;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MqFZZ1MZCCOk3B2AWbqhU4vVtD/Z+SwXDy5HKI6vso0=;
        b=sjJ48mx9c88071wqJVPjffftxPcFgxV8zjOwJjW0dJaWwLy6cPFzcpFzTCKg9Ql9k2
         xWoN7WKlssO4Kjcdcr7x/olBmV4IoNXUxC8TZnldnR8h4F3JRzwNpfCtD/eU34n3Me56
         FO8AXBDaxh0cqCQdlSluzzPEpk4/K1ZGEk4Zwyj6oACe5vTUH2nxlTSFqojwpiY+qxUv
         uShsc29Dq3cLa6T4mNA6yEyEhix0tnouuEh+BzU3y185piDugNu/ar+k6MQHC5TOetIm
         1M3fJErXGvJDxDwS11NtGJSuaoB8WvDHkEUjMTXKIFRMy03NoTaM1GJRvKn4akPJYURD
         n5rw==
X-Forwarded-Encrypted: i=1; AKwUvBxsZpZSECCNpJdGyMEDn8NIoy2kzZAjWJJRGKIzzunmNOSzYS73Zy8/OvM6XdMIQmZrmE6QUW/uXX3JBw==@vger.kernel.org
X-Gm-Message-State: AFuF++nkGJ6VZQtjRCGuhcJaDYK7RrMpgwN2LNRhwIzq66EulAjgj4ku
	bZOQJUYJer3aRqXOkSX2f0/663UjL6AC4HI9yUBzPhSHKWJG1/FfNjE/KcVnD0AKTOMBXTUQYtN
	y38R6k3ZTQPok9F49FOjTB6ECfioxvupA4QvzS4OvjA==
X-Gm-Gg: AYBFou2ohRKxfg4awioFHgyc02juUQ5RRxW/D4KOMDdG1AVebEK16zdNMcr3lBddWCM
	AwyS1/Jc1tpT6jHx6lhC/h1qQDi6K5K8HC1nbcWy6ICXVRrSZYJCzz/Zv9vHCaDt7VVpuJGpCzd
	E9mJajRPOW/fZzTPQi8e4JVyEPz6v9Gr2NAlOkIt7h58RO9AUC43RqJW9F6+Z2Uhh9sIDGKgu8m
	r0Iq9AvmQTfUSOEJJKWyKHgp24FH3UbzJGHuaJB2HKI5+u1wU/lqXSPoeNBkaVmrhNfkqcpcwBo
	/qQcwewxS2aaBnwFFPxNxKflz9WDOAJj1pXSl72Hb8WDwjFDQOzPEQ==
X-Received: by 2002:a17:90b:4fc2:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-39d9bc42d1bmr12376403a91.6.1789176583130; Fri, 11 Sep 2026
 18:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
 <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
 <CAFr9PX=_FmMdR4TeP+tqURZdZCTjw8UYxAxeszs_vcpTbX+_aw@mail.gmail.com> <CAD++jL=zaF1zcTv6Mta5Xw69WeLC30NRcH0_pkSkLJJ0UtnZHQ@mail.gmail.com>
In-Reply-To: <CAD++jL=zaF1zcTv6Mta5Xw69WeLC30NRcH0_pkSkLJJ0UtnZHQ@mail.gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 12 Sep 2026 10:29:30 +0900
X-Gm-Features: AcwNN1UYIuhyU3FVES8GlXYNI9phDxlCK3dBrZsiSwUakZtphqfaiRPyo96Awf4
Message-ID: <CAFr9PX=tVOzqGU4k0zSzXheuU5z5LZi4LSGdUvjChrSTrbyjJg@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Linus Walleij <linusw@kernel.org>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Drew Fustini <fustini@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo <shawnguo@kernel.org>, 
	Karl Mehltretter <kmehltretter@gmail.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

On Sat, 12 Sept 2026 at 03:15, Linus Walleij <linusw@kernel.org> wrote:
> I would say using generic entry would be a prerequisite for
> doing m68k SMP so we don't introduce *more* entry
> oddities, but after that I'm game.

I have started this for one part of the m68k tree (68000), but it's
one of those things that is hard/frustrating to test on real hardware.
For the last few weeks I've had claude create a QEMU that can boot all
of the m68k supported machines to Linux, Netbsd and their original OS.
It already found this:
https://lore.kernel.org/linux-m68k/20260828094940.3882602-1-daniel@0x0f.com/

> As SoC maintainer I see that m68k has a lot of technical debt
> like drivers under arch/m68k and no proper hardware description
> (such as device tree)

I have m68k machines using devicetree... :)

> There are things like
> amiints.c, cia.c, ataints.c, q40ints.c etc that should be in
> drivers/irqchip. So many time.c that should be in
> drivers/clocksource/* and many other unmodern things.

Would be easier with devicetree. But is anyone crazy enough to go
through the pain of merging the devicetree support and then arguing
about devicetree bindings for each of those drivers only to be told
m68k should just be removed?

> Albeit I think actually going and fixing that can't be super-hard
> in the age of LLMs. So listing things like this likely will just make
> someone go and do it. :D

Once you have an emulator that the LLM can operate it can do the
change/build/test/debug cycle all on its own.
With a test harness it can even test the changes work on the real hardware.
But I don't think that's enough to convince people the changes are
worth reviewing/merging.

Cheers,

Daniel

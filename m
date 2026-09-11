Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529B03254B0
	for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137514; cv=pass; b=Fa11wt65EwEwTpKdbowGRzfQvoyBUC7N2GE3WH3BFDW5IKuAd1jLAXsdunQGFOdyru2roagETF94x/O9xohnCQ3TJgoxDkClmdSsV+UqNN2814K1BH8ula1pJbESaKmGdivsc8xzGFhufovE+HXy2Hcn7/H0t1iG4eaNuyMhvrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137514; c=relaxed/simple;
	bh=XLpKjuu4srfrU1du6/lAaUzD7jl948KYiIqSg/FlWVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8AUajxE8QFK0F8L73yel1HVvjzLsn4Id9Tbm2wHCW7AKoxYi6Y/9eRyCkRDpL3LthDiNMxqEecF8jhU7I0nQLERmgY0xrrg/bWGhy4acH6RrxqYTHM+Erlzo3MFSbjk7GaVxBZUZjiRv8e0IRvCPsNBs6q2e2QKiQ2+m2vJ0Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=HB8Y+RT4; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="HB8Y+RT4"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8588583a7c3so9079437b3.2
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 07:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789137507; cv=none;
        d=google.com; s=arc-20260327;
        b=pnOPaq4+Eu2jzY+t9DvkZC5e5mCo2qRwm555uvQRkDdXAf3PDrQM9KiS8JIuNBcFaJ
         ZRv5WRujs7mGKXbFetBU57NXfiNgkSM/f7AWCoivTt3xQENW/h3c7CFnnHtnnBp3SiTw
         nnluJnW5/uDH0df9tsv40ZxuX8uyMCI32boy873t23rE10723h2EgVFfjW1pZZYy2I46
         dDNf0gY9s1HTZqi0Z7UZO+KL/SVc586BHrgpGIXxhvrihay5fjPJS/ca2gzXbTJ7sZ8P
         iJE4EVEuWjLNosl0Q36whQV1UGs4g19guQ8yUlhOJOBTM4ok2NpQ2bEUvRk6l7Vqsajp
         klnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jpJbb5DSDD0uOBnoN5sYAo9U83labpJz6g7jqXOS7q0=;
        fh=C2mCMncMZNVoyhM1gMXQ9TeXAcVO+1s7F05qMBpE8HE=;
        b=KMrdtBFIgcJnN4Rig3L2mP+OlMJ6r87vbs+VGFfnYvCjfujTuVmREuRArR45efCnMQ
         d53WnO4C6ntAGO+9SHP5BJootkCFZLbaKDYk7nCPeWfhT9G3y683sh3mzDomDOKiZf1/
         neEpqGd/RWT9iPAyjmpNVkHqWneGr474AR2gdXcvi8wXcE7WQBOFOzLKD1yadhYsTqEV
         IDluTCeI4IQNV5ef0u2XisdrOFFXZVJmzEnfnmxh7V0y1lwj6TsTAYQpbv0TJ8RL0/xQ
         Yn+MLPzLWq7XZvFMSlncEcNGGNca7U0q9znmxvNIvPL57BZHlETuXRvf9IiiJsDt/3Gf
         D2nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1789137507; x=1789742307; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jpJbb5DSDD0uOBnoN5sYAo9U83labpJz6g7jqXOS7q0=;
        b=HB8Y+RT4TRPooM8mqpi8DeLFRTPVsBx9aCjZB/tdFSV51HaKr7YUqtjHQkphkOVbT6
         uuwIWKH3SAN0TzGoi7GXFe0YJRT5iKtXrRz5k8GxzTLnZPeidsaT8lGynlHxy7GjzZ9r
         wzrI72QggorLaBikBSbsEG1noEYrmgMFuOan4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137507; x=1789742307;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jpJbb5DSDD0uOBnoN5sYAo9U83labpJz6g7jqXOS7q0=;
        b=HmZKqm4FDUj9h3uID4YSfldodPVbwMlQWXSxRss17XYik499Cy6OeznpzvgJ2t2zAs
         brehLQdlvh1MjiABOaVkXS8oZ+EGVNOuGN/+Nyw1RFzQWOCEIuG/2cq3hRo13HX4zOyH
         YU81KHyowt2Q1mDJzbHC3IgYKXqgUY2sWaToaN7+uOVTPuz0kMzqmbxYoXwMzjycA0Ry
         tMFWwL4FQWcuEQe11h07No8k051YuV+MFZb5L7xlCYffv7O5dwo5H7QLoQQmrWmy1vaP
         ImY5U4pB/S+dM1XW4760RhHcVqxvI4g3sDGHx74KMv3RiOe2UKl+bdTCh9XItk3IZzaN
         prRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpEwskTzCPmhTcUVkJG3QcaKOvUP7DwGxM8vaGVrvJIlLaej0bY9HHJaAGA/htxDTr35Q9bpYwdn0oxg==@vger.kernel.org
X-Gm-Message-State: AFuF++lWiRS7QZ+iVL1Jxlbb3U+/GVCb8E9AtX3SB709q7J1+/F7UziK
	aJc7aLp7nyEAl88C13VMsgp8ZLzUBnZhZdgATcJl90/KxxuQGCIqc4pgF3EAorSijL8rbAFq+hb
	wyDCUYYyRLNhL8fnOjZEANqW6Xa/p/NLCA9gYNxDQew==
X-Gm-Gg: AYBFou3WH/iZ9GhQ4SRQo7ypwdVbe03cd5MM5crzuQCGB1pjQaBbqv0VN1Sc/+WPetv
	dBrMjLglIZu39AvgsVW9EWplvQM7LEHlwsHZjsQWUTHgJQB7z2AXTBrU+19v+lQFCZtbPA2UJbI
	x8jwKILGB41swL2dwKr2ucqR6+THhZXmaAxAnNlBTj5A/oCjymry5MFTL4ymvWO3CJhCCzAJvaT
	PC+BiBI28ao3X2kzsXwH+QryZ117rxaw7g7FTky0QfW2oHcrPFXk0cd9zFphoo0AKo5f2rd3AGu
	dbwh4KvsjcVTQD3s7NJAYC+OcDqaQaxrNbncwow0oHi3C2v74HY9X4FRVwGc4gfO
X-Received: by 2002:a05:690c:399:b0:873:5bb2:6c10 with SMTP id
 00721157ae682-884b7316b4dmr14810657b3.58.1789137507274; Fri, 11 Sep 2026
 07:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com> <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
In-Reply-To: <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Fri, 11 Sep 2026 23:38:14 +0900
X-Gm-Features: AcwNN1V8w1uOymS_yob5PvYfeWzm1NprI6fjxQoUm4Mlo3gyAoZUnypuVT5lDl8
Message-ID: <CAFr9PX=_FmMdR4TeP+tqURZdZCTjw8UYxAxeszs_vcpTbX+_aw@mail.gmail.com>
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

On Fri, 11 Sept 2026 at 18:11, Linus Walleij <linusw@kernel.org> wrote:
> - One camp that are enthusiast like yourself. That kind of people
>   are running the show inside arch/m68k on Amigas and Ataris.

I have SMP working on m68k (dual 68040, real hardware) among other
oddities. I think some people would get a kick out of seeing it but
also I think some people would also ask why we can't just delete
everything that isn't arm64/amd64/riscv. I'm putting off sending
patches like that to avoid everything getting deleted. :)

Cheers,

Daniel

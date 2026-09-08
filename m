Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3C44349B3
	for <linux-fbdev@vger.kernel.org>; Tue,  8 Sep 2026 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895365; cv=none; b=ZNYLBpkposHmDSQChBgltlyAaDhIEYL03uXk8qoKfn+PF71ZQbzL3/k5bzNjVt0RzYCCTGgRMyOPPPlQ527lOTx80x8qFeg7oWs3ywlmFd8oUGj4d/Sy7xZa8EM5jLbtBw+z8341wN0FQ12dkBv39A4dXRtoZO8CuXfBTOeRsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895365; c=relaxed/simple;
	bh=BL1RUYoOl+2DCnnljwHrTpWKc1vt3ozShPXUSpVHg8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0FoEQyad1ALlm4YjMsCPQrK5YCQs8LbtnuKWG/dZeMUTII3sDn3vZcGjgxj+Eknzd4jLxIx0wx9e5bVvgj0+dlwtWp6chnVJalqL53F8Y7ywW3gem/aU3WHsUwrfeZ23kJLbbe3zBAswslidhTlKyxLa//z/0k+HBKwrmMjeR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IldMupf/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IldMupf/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso41216125e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Sep 2026 12:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788895358; x=1789500158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GVs4+8gm56Wnu6exUObCNgkOQEYDE8t6OW3Oqkq6qd8=;
        b=IldMupf/CXO1fJhcChwVffZ26pAdYEuJJo7n3NchFgpe6wbStMGfI4utvCihSq3+Mx
         QfakSVaL/MJcsyxLgiVpLhVZFiyd8ScB3t8IUALrvbnZWyWN17avGp9xQ9S7P4++LXdU
         LUlfBZMoh7BO7j3i9dt1eIczOoUyh6xGljMyldbvy7aZbl9McjsggHDOzBBQdaTDXM7h
         T05dJ6nI49n7G0r3JT59zHl54FDUVXNFF31hTE4azXp5dODZo1yxFt83JcwMmjJUyP59
         wMfR0iaSQSzgKmfqD4f+FZODJ2rym9Fks8lUDFHOufvKk5rwLwpiVRfU7SdRzD88aQWa
         rObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788895358; x=1789500158;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GVs4+8gm56Wnu6exUObCNgkOQEYDE8t6OW3Oqkq6qd8=;
        b=UESBCtqRLcfCLYfdZPvlwaVTu4+DloVIA4eVVds5csbx+3O/aJiM0uPWYh7UNB03hN
         IrWfTzF2dSy6s3XN/ttPbvmQMw13zO1dMHcT97B2dv03wKNrTdaEVH/JRjnTEG4YjJ7i
         Wb2rEzdBT1ksSgsYX+gcxyhVIdezjWkE7rc5qBwYOmYh6ujuk5ocgtivX4DH4S0+SOxH
         d8h3wBWLzgHc8aiM+Y+VMBG9bHpe2gLyOzLpEpq5/dWU6E1rlsUU+4gmYZczUMkaBHqT
         DUZFIjDDGkEifzi63MzB88H4gD8TjQ94E2xgDpPULGt1d16G9AV/e/TZnIxvjNBrvZtp
         etUw==
X-Forwarded-Encrypted: i=1; AKwUvBybtddXnmsecu4tgtX0JVdLkhDRDHsPfbaueq1JoNawS3HX60G3bHJcCtjAjC6NOmNqrr1EALXFgN650g==@vger.kernel.org
X-Gm-Message-State: AFuF++nNbObsrZRd6eIOVt2smnbkEcYdMNuwWG2mYNYRfiJHBUgQJRok
	s24ss/tqjmLHgIFp+c+p8rnxu7r//qrei2TWRPPrB8dYHi7aIDEMbW4q
X-Gm-Gg: AYBFou1KqJkt1QYH/KAdmPes+UmDoOxM3yYnsXPTuHzbRN6u35AHR0Pe3KOsGvGCVwu
	ECdI+0f3+TyvNqBzpfnnn6BS+V/gPw/rvydHgkgL6m3wNPcOLev2Jj5kKZc0HRUYvE5YsTE3p9H
	xoIVCQQSftw+5Yi2+uAYM0vYinJxGdSamXE6wrtBVbuj5Q6/NDe/xfP5RX23vO/Iw00zRuPK99w
	+h7fzA3G2MAFbhsZrs+Jlx2E6xhxmv+NABO+iSx+4+dXvws1LZAKAWRLAZeycYvMqN8FWnF1v1z
	P4zNrAKrqcSjYUEERbXVsw1593PJV3NNAjhxr4qU/lSMSvfLbxiwvi0Si4cSWPbbUrW6Ta5OS1I
	Ru73FVifaAGIa1UGCbtz29YOXhCvI9/la+HKuKycNAtafj81Et5X5QKZa/XdIS69L3HHKIcN8M2
	+Q3Ah24hGFJOOaOsh6pzqAADSU/qDj88z6IcDX2vqmZsSm3h5aq7sEdycI46bLsadRQbbxD7D1R
	Tp1bmUwHxIMGVnPalJY7Dfv4xssXqW3fvUEYj3nkUTSCW5TE5vggWn4tItiKgFz+YxXn0RloIW7
	gk/pb429Gl8MXNfyCsn3yH1mZSCoIg==
X-Received: by 2002:a05:600c:3ba3:b0:49d:e79:612f with SMTP id 5b1f17b1804b1-49d0e79635amr157041045e9.26.1788895358151;
        Tue, 08 Sep 2026 12:22:38 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485881353e8sm38080321f8f.1.2026.09.08.12.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:22:37 -0700 (PDT)
Date: Tue, 8 Sep 2026 21:21:22 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Stefan Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
	Shawn Guo <shawnguo@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Helge Deller <deller@gmx.de>, Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-media@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 06/13] ARM: omap2: remove omap24xx support
Message-ID: <aqBXOemS4boakDGt@gmail.com>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-7-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908152808.3928630-7-arnd@kernel.org>

On Tue, Sep 08, 2026 at 05:27:56PM +0100, Arnd Bergmann wrote:
>  86 files changed, 60 insertions(+), 10696 deletions(-)

Note that Sashiko skipped reviewing this patch, because it exceeded
its current 10000 line limit.

> -CONFIG_ARCH_MULTI_V6=y
>  CONFIG_OMAP_RESET_CLOCKS=y
> -CONFIG_ARCH_OMAP2=y

With CONFIG_ARCH_MULTI_V6 gone, CONFIG_ARM_ERRATA_411920=y a few lines
down can be deleted (savedefconfig drops it)

> diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
> deleted file mode 100644

perl scripts/get_maintainer.pl --self-test=patterns now warns:
  ./MAINTAINERS:19896: warning: no file matches	F:	arch/arm/mach-omap2/*gpmc*

> @@ -560,13 +533,11 @@ void __init pdata_quirks_init(const struct of_device_id *omap_dt_match_table)
>  	 * We still need this for omap2420 and omap3 PM to work, others are

Stale comment about omap2420

> diff --git a/arch/arm/mach-omap2/voltagedomains2xxx_data.c b/arch/arm/mach-omap2/voltagedomains2xxx_data.c
> deleted file mode 100644
> [...]
> -void __init omap2xxx_voltagedomains_init(void)

The declaration for this is still in voltage.h.

Thanks,
Karl

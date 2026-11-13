Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558885;
	b=CaKX6eJfRiRwnPshMnY+qrUgc0J27olLx/3CZbgG+S1VetisY0FBr/dSXFiJ6QRoA/N+
	 rn79VJyI1RBBgM/yv3fFwXza1lgLy5NjuYsNC6JGHQK0XC3deDNBAO4dEhPh3coYIkkPP
	 j2PdgTzyjkTcif3hyPsGgR+1Gh1ENbdOI6VrMLePuRq8GS8/K1UHSVA2IbJ05SHw/Vuzw
	 S60EMwdVWMzHI/Xh5E+r/WYmGTY7bWjnXX3vPpkY/77xFrrMdqNjL4JnluWxFS5JAUXzE
	 z2TpnPv3ZOHYpGhlhoPjvrPVpwsDc6WxsgM/GAKKo3YmWionYb6vYmEX3t0YJ5jFXMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558885;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=nLcP4qFeNLouEfcFHqryAopJvdLx1pDFyoiPx7iQi5s=;
	b=lAVKSBNTzII+2WoDRhfraJ1KD9G+uXnLeFINxI3vv1A5VTWbnGWQm5Ul2xHc2UUwUUS+
	 JCXpsf2Y5KwvXg1ndCCCjcD59T5hm05pJ+EglfJojBG7ohrHtQGUJxycUusSIfJwIw8Bg
	 R5mAq9fY/LYHEkpk3QRI2IBX2QSpTbF9+qOSextapj/wZhGNNJbh8uujgzouAoCVk75QR
	 3vM5JYFJAEhefP+6czlRRDJo/Rpj9HI3ID8885aTgHknEcfACq/D420XjYm+N0n+w6MiM
	 fjy/mh5yhk8Kn+EO4VFmAvnqVUWKHDHZYQP8tKb41/c8NxOzeTDmF+w2Q2VhqnU1VLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jCkrKTkJ;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771FC606B1CC;
	Fri, 13 Nov 2026 08:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 771FC606B1CC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jCkrKTkJ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 62A7CC4F774;
	Fri, 13 Nov 2026 08:34:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C8B28601D5;
	Fri, 13 Nov 2026 08:34:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D95C11BC06F0;
	Fri, 13 Nov 2026 09:34:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794558882; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nLcP4qFeNLouEfcFHqryAopJvdLx1pDFyoiPx7iQi5s=;
	b=jCkrKTkJ6QntopfsCVx823gb7wx1QWSubytve2jZR5DHrBI86oUpTLuYKxTJcyOckDIn8Q
	hqgT0HrVRA8aF33hwVhKx9bEnJVwBm3JeV5zNlcSSur/y+LTadEhSR0RFX92RHAUgiOZdP
	L1WMeUYmc5CuO6R70gWZwGvtr672ys3rO5jewh1rk/E9I+K8Hk1sq146EGEnaOVnP54zvu
	EbAXMMD3j1EOmhqA+E4rje/6WcR5uT2EglFv65T5WQjOqzU6r1a2V3KJHp+imahldsxXG/
	WdiJyhA+zX0X35beD1SFoa4eT3te76FuG6568Kelqjz7cwy+Y+xEhGpG7mYXxA==
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] backlight: Fix kernel-doc
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>, Petri Karhula <petri.karhula@novatron.fi>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261112192744.850142-1-manuelebnerli@mailbox.org>
References: <20261112192744.850142-1-manuelebnerli@mailbox.org>
Date: Fri, 13 Nov 2026 09:34:18 +0100
Message-Id: <179455885818.1992209.12136301208667386859.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

> This comment describes a struct as a kernel-doc. Format as such, fixing:
>   $ ./scripts/kernel-doc --none drivers/video/backlight/cgbc_bl.c
>   Warning: drivers/video/backlight/cgbc_bl.c:29 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
>    * CGBC backlight driver data

Please add driver name in commit title:

backlight: cgbc_bl: Fix kernel-doc

-- 
Best Regards,
Thomas Richard


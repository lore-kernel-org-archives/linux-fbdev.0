Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93703EA63;
	Mon, 19 May 2025 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669656; cv=none; b=iaYju6aY2eJUE/hKHUnlocHPkPQchCwui21Jm6YxCX5DQ1pMVv3ASy/iyqnxYtUkMZ6bwXtlgpuHXkjxrNTW536NKgcpaycc+LxGtaPmHoyX9VlleJyufcHsVgQXDUFeVNHI3fhWz68C0J3r7nc0RrLXsmhZbohDEEf5wO7zFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669656; c=relaxed/simple;
	bh=2+V9IH+62eHNR7r2+4CrfZMQ6O8FGeivvEmO7ZCkLJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyqgWVSHgpLQ4tc4925MXndYBYhDVLl0XLEx/WSc3pAoP9hFiX29ysA562UqZHfqmJMsJPLrZK+37ZcpPlFgrp6tLXOiREwyezdi5SyrMdyvlAWM5xfaeFifPeAKYt9DJ0oR8IE6ti+tU+QpILTLu5Eb0xj+eMnxAOJyOi5W+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JnEbd1Yk; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JnEbd1Yk"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8BE0C42E7E;
	Mon, 19 May 2025 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747669652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpIHfuwXpeYEx8QkXgjwWqZInjNQyntE9cjhY6vEq3c=;
	b=JnEbd1YkBHKCppq0wWtn4AXrDAPeC7XR/Bw/usI+H0c7GtFr+dPPciNz9WaQk+7mU80BAk
	SrWIf+sOD14/IS1JjgReVPaJasBvK38hcdYppIYkK9DgMrSXwQZP/xiOTiATOsbT9vixBp
	UU7pXNviayTOoDwSA8TLRw2lvltA9y3cviIXS0OEvFk03F/npjs5fDP9ZnaZIdOkdIiEOl
	pjX3HzTuhtqkqhcfqGrWwOVFSs6JD44EnBVp28XAJMZ8/pHx3a2vyhvOGS/YRZT26O+0i1
	B7t4LRwx662korGpXeSzWeh62Dz6HxjGhWkTjE4jjsen9gX5V24c5Llt8nYhGg==
Date: Mon, 19 May 2025 17:47:29 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, Tony Lindgren
 <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Jean-Jacques Hiblot
 <jjhiblot@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Saravana Kannan
 <saravanak@google.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v5] backlight: led-backlight: add devlink to supplier
 LEDs
Message-ID: <20250519174729.44fa1f7b@bootlin.com>
In-Reply-To: <20250519-led-backlight-add-devlink-to-supplier-class-device-v5-1-76d6fd4aeb2f@bootlin.com>
References: <20250519-led-backlight-add-devlink-to-supplier-class-device-v5-1-76d6fd4aeb2f@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddujeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtkeertdertdejnecuhfhrohhmpefjvghrvhgvucevohguihhnrgcuoehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveeiffefgeeitdelleeigefhjeelueeuveekveetgeffheeltdekgeduiefggfdvnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghltheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhinhhgohhohhgrnhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvlhhlvghrsehgmhigrdguvgdprhgtphhtthhopehtohhnhiesrghtohhmihguvgdrt
 ghomhdprhgtphhtthhopehprghvvghlsehutgifrdgtiidprhgtphhtthhopehjjhhhihgslhhothesthhirdgtohhm
X-GND-Sasl: herve.codina@bootlin.com

Hi Luca,

On Mon, 19 May 2025 17:16:39 +0200
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

...

> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
> index d2db157b2c290adc3a159023e9e2394fc877388c..8fe645b5b75447d009e1045dcf0c62d3bbc5425e 100644
> --- a/drivers/video/backlight/led_bl.c
> +++ b/drivers/video/backlight/led_bl.c
> @@ -209,6 +209,19 @@ static int led_bl_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->bl_dev);
>  	}
>  
> +	for (i = 0; i < priv->nb_leds; i++) {
> +		struct device_link *link;
> +
> +		link = device_link_add(&pdev->dev, priv->leds[0]->dev->parent,

It should be priv->leds[i]->dev->parent instead of leds[0], shouldn't it?

> +				       DL_FLAG_AUTOREMOVE_CONSUMER);
> +		if (!link) {
> +			dev_err(&pdev->dev, "Failed to add devlink (consumer %s, supplier %s)\n",
> +				dev_name(&pdev->dev), dev_name(priv->leds[0]->dev->parent));

ditto

> +			backlight_device_unregister(priv->bl_dev);
> +			return -EINVAL;
> +		}
> +	}
> +
>  	for (i = 0; i < priv->nb_leds; i++) {
>  		mutex_lock(&priv->leds[i]->led_access);
>  		led_sysfs_disable(priv->leds[i]);
> 

Best regards,
Hervé

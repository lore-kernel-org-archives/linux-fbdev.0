Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E15257452;
	Thu, 24 Jul 2025 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342162; cv=none; b=Dqjzn1MssIzC4t+zflj0jJJhyxySvfr1xe5LOuhr+exOhSlN+glLrXhx91weM74u1NKysKAIWlYZITdDQ2iiFhKdrj3SVft335YRuOkhqYnm4FWLL+hmmGJbZVuuWisnTXO7Oc5Zbyrfh0F7y/wQEUR70iXp845WdJa9Gg1JoGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342162; c=relaxed/simple;
	bh=i2q1X4v2wQxxKEohFKgZoAdvi42uSXAKH7PFNMJJ9BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4D0dFj8yBPlXBv0Wh6PKOCociqSuItCuK5nqTNsT+NdOohupFy8qF7NHh4dVgOe+aRNXG3NpBmeIaBTljy1Cu98jSmYoUJiXeCtMib8c443P0W4v2MlkU2Xe2QXcUJawrH4zFDZdIJUO3ktsGHJf3wGVA/oDeKsokUALfz0Xc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HZk7I5do; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HZk7I5do"
Received: by mail.gandi.net (Postfix) with ESMTPSA id B6345442A5;
	Thu, 24 Jul 2025 07:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753342156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HuSxSBGWYzg8ppmBBZ57GZxUD2NpVmKocyw7538elEk=;
	b=HZk7I5dom0NaZoXNr7ZUaqCxtTPCZ9rz0oAw0TPqYZch3Bberm1JrviipRsaYO21Rp2/tj
	Lx/nw65YKNim+MQMGp0GMWNSo61TbL8Q/zQIvl/v3pRAqrA3q1fcOefiLZgiW691X8+G6B
	ughoeNwQHn9YeB86iUa70KScN23mmKSPuflIZfEearVnbhBqPaa96nIOgGlc0rOawf4kdb
	ZNonISBCN/9qZUZTNykQMimw7GdCPN0IGGLjtUspiZg36Uf5qS/izBTMEL3mTB2ExZBSP0
	gPcIp4yhDNdL1+6sbK6f9M9kAsxAxIPSEsH0P34HuZm3gfIyyztCTa3eIoPIOA==
Date: Thu, 24 Jul 2025 09:29:14 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Helge Deller <deller@gmx.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: atmel_lcdfb: Fix potential NULL dereference
Message-ID: <2025072407291424126a1b@mail.local>
References: <aIGg7erPjz1qJQ1F@pc>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIGg7erPjz1qJQ1F@pc>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegieduueethefhkeegjeevfefhiedujeeuhffgleejgfejgeekueejuefgheeggfenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmegsieehmegsvdhftdemkegsleekmeejledtheemrggsvgelmeduhedvvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemsgeiheemsgdvfhdtmeeksgelkeemjeeltdehmegrsggvleemudehvddvpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepshgrlhgrhhdrthhrihhkihesghhmrghilhdrtghomhdprhgtphhtthhopehnihgtohhlrghsrdhfvghrrhgvsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepu
 ggvlhhlvghrsehgmhigrdguvgdprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvhdprhgtphhtthhopehlihhnuhigqdhfsgguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexandre.belloni@bootlin.com

On 24/07/2025 03:56:45+0100, Salah Triki wrote:
> of_match_device() returns NULL in case of failure, so check its return
> value before casting and accessing to data field in order to prevent NULL
> dereference.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/video/fbdev/atmel_lcdfb.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
> index 9dfbc5310210..b1017ac9c73b 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -922,6 +922,7 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
>  	struct device *dev = &sinfo->pdev->dev;
>  	struct device_node *np =dev->of_node;
>  	struct device_node *display_np;
> +	const struct of_device_id *match;
>  	struct atmel_lcdfb_power_ctrl_gpio *og;
>  	bool is_gpio_power = false;
>  	struct fb_videomode fb_vm;
> @@ -930,8 +931,11 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
>  	int ret;
>  	int i;
>  
> -	sinfo->config = (struct atmel_lcdfb_config*)
> -		of_match_device(atmel_lcdfb_dt_ids, dev)->data;
> +	match = of_match_device(atmel_lcdfb_dt_ids, dev);
> +	if (!match)
> +		return -ENODEV;

This is dead code, it will never happen because atmel_lcdfb_of_init is only
called from atmel_lcdfb_probe which will only be called when there is a match.

> +
> +	sinfo->config = (struct atmel_lcdfb_config *)match->data;
>  
>  	display_np = of_parse_phandle(np, "display", 0);
>  	if (!display_np) {
> -- 
> 2.43.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

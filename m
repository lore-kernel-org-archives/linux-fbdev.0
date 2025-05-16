Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DFF255F3E;
	Fri, 16 May 2025 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421254; cv=none; b=RWrfvJ8Xx41YyjxuD1qyYNnH4yRiE9BiEqUBTlog37k05ZmXP/ra4KA73Wl0Xu0+zFaDQPj7hdQmanaoeJuZSHLRUz3n5NuSh+nfRfkbP4ftcBTrDua55J7fOid1LlAP+ae1ewWT72xm953pLbfW8RWVtGaCEhrWFnlxUxxwHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421254; c=relaxed/simple;
	bh=a2dOMHP3kj4+jm6fRlYBj5slYaX05QFOPhyjS1UDZxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPRNpUlEzwnQF1oQAlc0oRvg1ZOJqrX99ghY+zBa9x33gQwHK9yAGy/0LuD6ssMS3Bx5z5EPdvdCcQ7RCsXpKYRYEx+MW22M5CPCACB9xxJfv7Fd2QGtk3/GzFV11u4RE4KxWsvdwiRrjEtMmmNLlUKDut9RKAr5GGAVoap6iKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Mh11vKnp; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mh11vKnp"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D57543155;
	Fri, 16 May 2025 18:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747421250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lqQXD9Q9jfyGYo4y6j27XcbvfdwUtHoucCG3UKJI5E=;
	b=Mh11vKnpY6MONWDMsThK7Cqb138ZIMoMt5g3566QT39UcP4s+R/AphtZisgoYg2wMrmt26
	uCHmHUiwoBS/d+k4ypoFmoU6PwGx/5SCPw242o5BRNbZ9Brta2/XM7w61rXy0V+DVsjG/b
	4gByw4R4GGCDNAs0Z8TrpkuGwtLCZsCp5ggAIFAQPv+ZXfY2zCZEr639AnTYMvwHL69Hv2
	rmhO3i28gLr471jhvk2d8qisOXRIPRK77FLgicXJTG8vVCLvWg44teiH4UMa2O0LPJDCWa
	lBct2WiiHT4TnLlHeUmE5q8g3BWDWEggx1CIZdBzdqYSWyy3OApp2llreF768w==
Date: Fri, 16 May 2025 20:47:27 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH v4 6/8] backlight: led-backlight: add devlink to
 supplier LEDs
Message-ID: <20250516204727.4d87e700@booty>
In-Reply-To: <b5d2b71ffc38eb1980ce72994a20e8f6ee7869bd.camel@siemens.com>
References: <20240917-hotplug-drm-bridge-v4-0-bc4dfee61be6@bootlin.com>
	<20240917-hotplug-drm-bridge-v4-6-bc4dfee61be6@bootlin.com>
	<fa87471d31a62017067d4c3ba559cf79d6c3afec.camel@siemens.com>
	<b5d2b71ffc38eb1980ce72994a20e8f6ee7869bd.camel@siemens.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemrgegiedvmedusgguugemledutddumedvleegfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemrgegiedvmedusgguugemledutddumedvleegfhdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopegrlhgvgigrnhguvghrrdhsvhgvrhgulhhinhesshhivghmvghnshdrtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhto
 heplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhgsuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Alexander,

On Mon, 12 May 2025 12:13:54 +0000
"Sverdlin, Alexander" <alexander.sverdlin@siemens.com> wrote:

> > I've tested the patch wit LP8864 LED as a provider for led_bl, removing the
> > underlying I2C bus. The patch avoids the crash for me (by removing led_bl device as well),
> > thanks for fixing it!
> > 
> > Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>  

Thanks for the feedback! I will have a look next week, perhaps sending
a new version of this patch alone (outside of the series).

> Would it make sense to add
> 
> Fixes: ae232e45acf9 ("backlight: add led-backlight driver")
> 
> ?

Probably.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

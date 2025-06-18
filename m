Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC722EE97A;
	Wed, 18 Jun 2025 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259954; cv=none; b=auiiF6iMImvZqMqZn+V7L9e1IoKGJMNOPGmxCHrOfC94YL0voM+Q8rqsShOI9iIpu3LML55AZKF+4U3THxh9zSnc7L/7BHkU2YkJ2lSnJ761iSlDU2/LT1hQU/qivDxlRyrjaIyo7o9iTIfVOa6YvZZYTKxefuNSt5c5S8a6yaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259954; c=relaxed/simple;
	bh=U2qShf+f0BBjvB8R4BU0oiMW0/1u3Biw9w5U1eKbw5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwisS3l5GrgF3Tut+Bur+Ug+7vFv83F+vr2v9eoHAR7Qt0IHkz3LsFVXK3NYtNO7ykpuE0mzduZmghbKTdwe7FgV26/mUsAz9degCKeVoSNcAI9KMfyqRIow3OHIRkK74cHruUWC5+9//ZaefKzDwqUdwORVFbI//nUH0wYd/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=kBAG2d/k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OqXrceS/; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="kBAG2d/k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OqXrceS/"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0AD4211401DC;
	Wed, 18 Jun 2025 11:19:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 18 Jun 2025 11:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750259951; x=1750346351; bh=WO/z6nXKHh
	mPKqTYhrdKPVyjJIEwheeScnSf5HObDQk=; b=kBAG2d/k3jYQcWwudKuhwnZoIg
	bT8BGaGnO89+e2XdGsV8mXWAXXeBpDnr3+Z8+pd/GFblR4xe8NpgIH1hQ1cBEq2I
	21Lfl2whGWeFJkTqu/p+LYyNhUx693Pi4jcMu8aCbtnT8HWBmcJl3hFhYb2xRuvR
	ePneY+oeIhsWCtMyGUAu/I06c4iCMBjXsS06bp4nfy+zWPm/lYE8SREdlpRSCpcZ
	xb5w/BN+lOKxIgcfFILV5zQfPBrY+fR5vFk40JxbL6gu83NLM4CNiQgwxeQo9rqP
	QRIVojQgY8cFyf0OpFKqd5aQ3Rz2DA4jQ558rNT/AfiLnISk+uyCxFVH4EWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750259951; x=1750346351; bh=WO/z6nXKHhmPKqTYhrdKPVyjJIEwheeScnS
	f5HObDQk=; b=OqXrceS/LN7ABzPOO7vhJH6ksoO3UMevC6RoZWmTsilbltXbhiN
	sIXM/OiSLFfDsTyhAuy5Opu6ckXdUJi73JxF38E9IkJ6ns2McCvVp3hxkhMlvr9B
	Oue7iDYv/UztIqRXeQfPuGfKQYD+7yv7DQ/37dAhQHVoIM5rW7oj4BNNrbeJXlHr
	4Dvwq9XcUWsCfyMIcICAfmcKobCBeYNMNCJQldN0i3eQye/emLZmRavWcH/Ld4T6
	6323urQz6KmEzMZc4JGwR2iGHuJw52BEyBy3lPtb7PWRJEkl5xegpKHJNVOJ5YwI
	ZFIT1vgL/waOce4NKSC8u3oqGEKOePE2w8Q==
X-ME-Sender: <xms:7dhSaJIP82tX6p7DEl8JOHr7c7Z5DNE5mzALKcty1TNEdbzeKHPKiA>
    <xme:7dhSaFLpCJXfsREoXkQR-5wOmgpFpFCsPWijN3ug8Ltqvy_ocTWGwRItNy_zBXkgn
    1SP4pn_gwYpTWOldtU>
X-ME-Received: <xmr:7dhSaBtcY6EJYMGN10cQtbN9EXV3QKTaSmD_dCuSEleLlb214gX1gEO4UE89FqQa6CwcxU_DBm69Tmogtmr6ec8VXzARWf7jxus>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenuc
    ggtffrrghtthgvrhhnpefgvdffveelgedujeeffeehheekheelheefgfejffeftedugeet
    hfeuudefheefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepvdegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpd
    hrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghl
    theskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhinhhgohhohhgrnhdusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdr
    ohhrghdprhgtphhtthhopehjvghsshhitggrrdiihhgrnhhgsehoshhsrdhquhgrlhgtoh
    hmmhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:7dhSaKbl1ZMotpjMQtM5yHRTHJc6TdIhRYJX4-2F-PuetDl30Wj4gQ>
    <xmx:7dhSaAawsQO09J05y418B2N8d7WUoBEceWh2y08wPM6ASdEcmHVvAA>
    <xmx:7dhSaODyOzGssvtqXZgRJie55tA53yYoxKaT8Ks5LuYffaw0oOepFw>
    <xmx:7dhSaOY62WvDxdzEWfY-d_WOEyGTNRpVaFWfrFDJvIs-quOX6EAPJQ>
    <xmx:79hSaGULqo-ojzHZEr62DhrX1iqgwD9W1XclI2m9nwJuc7QEZNUdEZIk>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 11:19:08 -0400 (EDT)
Date: Wed, 18 Jun 2025 17:19:06 +0200
From: Janne Grunau <j@jannau.net>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com,
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	airlied@gmail.com, simona@ffwll.ch, fnkl.kernel@gmail.com,
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, sven@kernel.org,
	alyssa@rosenzweig.io, neal@gompa.dev, deller@gmx.de,
	support.opensource@diasemi.com, duje.mihanovic@skole.hr,
	dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 04/12] drm/panel: panel-summit: Include <linux/of.h>
Message-ID: <20250618151906.GA103923@robin.jannau.net>
References: <20250618122436.379013-1-tzimmermann@suse.de>
 <20250618122436.379013-5-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250618122436.379013-5-tzimmermann@suse.de>

On Wed, Jun 18, 2025 at 02:16:36PM +0200, Thomas Zimmermann wrote:
> Include <linux/of.h> to declare device_property_read_u32() and
> struct of_device_id. Avoids dependency on backlight header to include
> it.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/panel/panel-summit.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-summit.c b/drivers/gpu/drm/panel/panel-summit.c
> index 4854437e2899..02aa1ec287d6 100644
> --- a/drivers/gpu/drm/panel/panel-summit.c
> +++ b/drivers/gpu/drm/panel/panel-summit.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
>  #include <linux/backlight.h>
> +#include <linux/of.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_mode.h>

Reviewed-by: Janne Grunau <j@jannau.net>

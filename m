Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951943ACF0F
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974365; cv=none; b=K2ltjucRgS5imk8y/VbJqYWSKo+kbUhIqx0b5kO6Eo8tnPRkVl1o4VhzqW+mILI0bx2LNoc3nZ5+zN4CECsv8Y+T97OTgv/fTHHY9wawb7GXmGBYZRLgdCG/ceZI4LD2l9JWbQ1B+Ky7bXya+UWb+qrg9+i/KYcLTWcbet+VKxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974365; c=relaxed/simple;
	bh=EBJQpWLY6zS3lPstVd9MZs+Q/9KBP95hHmwtpJd2xBA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=TQ+PUNJ2PvXLSf4VqWl60wflW02Yx2vITPgiJywN56sgvqf4riimcXmX/eV2KmClXhIRemGJlQZ7yAL+FVVDwNFRTbuSclRYZROLpw16TFgpihBVDI31vW90nmuDdJRrQrGyVspaM3s+J+oUP46MJnXGH5+o3Fd5c5W7ht68e2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oIGWPfNv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oIGWPfNv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EFDF41A0E34;
	Mon, 21 Sep 2026 07:06:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BC2FD60339;
	Mon, 21 Sep 2026 07:06:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79EEC10328ED0;
	Mon, 21 Sep 2026 09:05:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789974357; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lc3Q5bHjC9Y5EjOyv/5Amr9ZepClgh/msjX52TvdD9I=;
	b=oIGWPfNvDSRbuhkeQtz7bxBJxWZYBW2cPZXT+UaEDez5iBFH2fF/5qtRmniX5pWZGz8E3K
	q74f2AJxyvO54Nw2fgwxH0oY7iv3GFATtVa9GXDdxGNpeQhgcdnuS6q/aZMlIuCUtu+/sb
	4iQ+/XyCd2B1VnpR+ZPSGkDM+9JVT+5mDsBCyziy25sxPBu9ZcbPg0GoNguKP1G05ucFLL
	BMFC/U3CxdZw/9Kl6afCteUQDoNtTYjQ7SnsgvWqFB0O14Y0n8Bh2fmJ6XlJf9nitdwE1Z
	dm61Uq7NAkZqZJzwTtkc5Gro/DbLRu4zBMjgv+5b5LNTZXEZV46O9KlQTh9fTg==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 09:05:40 +0200
Message-Id: <DLKSY3W6CGW1.3C0J6DHKV8P2Z@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v11 13/74] drm/bridge: Fix NULL deref in
 drm_bridge_add() for legacy bridges
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Dave Stevenson"
 <dave.stevenson@raspberrypi.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>, "Chen-Yu Tsai" <wens@kernel.org>,
 "Samuel Holland" <samuel@sholland.org>, =?utf-8?q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, "Raspberry Pi Kernel Maintenance"
 <kernel-list@raspberrypi.com>, "Raphael Gallais-Pou"
 <rgallaispou@gmail.com>, "Sandy Huang" <hjc@rock-chips.com>,
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "Andy Yan"
 <andy.yan@rock-chips.com>, "Algea Cao" <algea.cao@rock-chips.com>, "Daniel
 Stone" <daniels@collabora.com>, "Liu Ying" <victor.liu@nxp.com>, "Phong LE"
 <ple@baylibre.com>, "Helge Deller" <deller@gmx.de>, <kernel@collabora.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
 <linux-rockchip@lists.infradead.org>, <linux-fbdev@vger.kernel.org>,
 "Sashiko" <sashiko-bot@kernel.org>
To: "Maxime Ripard" <mripard@kernel.org>, "Cristian Ciocaltea"
 <cristian.ciocaltea@collabora.com>
X-Mailer: aerc 0.22.0
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-13-bc12954a0688@collabora.com>
 <ap_Tr_Viqy29f515@houat>
In-Reply-To: <ap_Tr_Viqy29f515@houat>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Sep 8, 2026 at 11:24 AM CEST, Maxime Ripard wrote:
> On Tue, Sep 01, 2026 at 09:50:37PM +0300, Cristian Ciocaltea wrote:
>> Legacy bridge drivers that embed struct drm_bridge in a zero-initialized
>> allocation, rather than obtaining it from devm_drm_bridge_alloc(), never
>> run INIT_LIST_HEAD() on bridge->list, leaving next and prev NULL.
>> list_empty() compares next against &bridge->list, so it reports such a
>> list head as non-empty.  list_del_init() therefore runs and dereferences
>> the NULL pointers, panicking the kernel during probe.  Only builds with
>> CONFIG_DEBUG_LIST survive, with a list corruption report.
>>
>> This affects rk3066_hdmi and the i.MX8 LDB bridges, which still embed a
>> bridge in a devm_kzalloc()'d struct.
>>
>> Initialize the list head when it is found to be NULL, so that the bridge
>> ends up with a valid empty list head and list_del_init() is only reached
>> for bridges that can actually be linked.
>>
>> Fixes: 17805a15d175 ("drm/bridge: add list of removed refcounted bridges=
")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://lore.kernel.org/all/20260731175016.C5D591F00AC4@smtp.ker=
nel.org/
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/drm_bridge.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
>> index 2c457ad74f3b..a8b6df5c13ea 100644
>> --- a/drivers/gpu/drm/drm_bridge.c
>> +++ b/drivers/gpu/drm/drm_bridge.c
>> @@ -453,9 +453,16 @@ void drm_bridge_add(struct drm_bridge *bridge)
>>  	 * If the bridge was previously added and then removed, it is now
>>  	 * in bridge_lingering_list. Remove it or bridge_lingering_list will b=
e
>>  	 * corrupted when adding this bridge to bridge_list below.
>> +	 *
>> +	 * Legacy drivers that allocate the bridge with kzalloc() rather than
>> +	 * devm_drm_bridge_alloc() leave list.next NULL. Such a bridge cannot
>> +	 * be on any list, and list_del_init() would dereference NULL, so
>> +	 * initialize the list head first.
>
> "legacy" bridges are ambigous and was also used for non-atomic bridges.
> That being said, it's now *required* that bridges use
> devm_drm_bridge_alloc() instead of kzalloc, and we warn in
> drm_bridge_add if it hasn't.
>
> So I don't think we should merge this patch.

I agree.

I theory all drivers are be already using devm_drm_bridge_alloc() by now.

In practice rk3066_hdmi is actually still using kzalloc, it should be fixed
to use devm_drm_bridge_alloc(). Are you OK with doing it in v12?

By "i.MX8 LDB" I guess you mean fsl-ldb.c, which was converted in
9c399719cfb9 ("drm: convert many bridge drivers from devm_kzalloc() to
devm_drm_bridge_alloc() API").

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

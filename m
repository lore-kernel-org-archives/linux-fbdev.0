Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535DE37702C
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789975284; cv=none; b=Hj/UrHqU5xyXeMajl4f5VcUdWrHnFfSTu4XGVtkCYFdnBcmyi4kYQUu7cPjgxlShzG61Ebnttz2r2iu7kp8TknYE518IOlJkqTmX3ZltpnDxmlRExi/AWAtX5XHaxuEuWT1L+f2VLtuVo1gYeJMt8cInLri/QT4Pr9368+ngTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789975284; c=relaxed/simple;
	bh=MhtFxF8EFZDCfDFuRbNaPAiWflspoG6eI5OTMlmfgqM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=t5QdvfAcnR2J5tONq6JoI9BECZMy100CPXPiC4gltdb81bgEZVPUwXSYXzq83jpItvmBmv7dX4MewI/a0fEVzakRULlkIdslrg6D92LMNCniYuhhxcWASJllpNu9DGemkIPWcGVT7YNgAXh6PQzZTj5djEB2gUchz/mcBtRUQlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zHnAy6Yh; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zHnAy6Yh"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B66124E40CA3;
	Mon, 21 Sep 2026 07:21:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 76DA460339;
	Mon, 21 Sep 2026 07:21:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D6C61032800A;
	Mon, 21 Sep 2026 09:21:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789975277; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nxoDYhmIzh2JJPIArEyFT+HN+oVRry6II7QzeYp2Ns8=;
	b=zHnAy6YhRwPKGEf0y9dvmZY6PdyuCehyShuLCcQ9hRcoCEFxRx6BMqRv8J/NByWFUTsOPO
	UybaskuxoT1S6hcjn+xsLjoN+6jng6MfTBuO5xYPusGsKOsfcltFGCd8hmOVwuvALGc3V0
	xftL6l0nCepix/p2nb+MZHpik/f1U2Kye8vARp3Pa/djqdjtwJ/dnZYQp+XUYAB55Rof0s
	Ut/KyIf5rzHYGLrPdtLZmUmGXlE5329asARgMt2Hd1t7zwpB58v1iuHV0FQfDsYazTgD2Y
	Hn9NI9L8z87aSohbMMp24WzHI1zro2CeqOZxWYuGQqFE/Fhxvj5KmIfS67tOsw==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 09:21:04 +0200
Message-Id: <DLKT9WH655L4.37F4JBC3Y14D8@bootlin.com>
Cc: <kernel@collabora.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-rockchip@lists.infradead.org>,
 <linux-fbdev@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Cristian Ciocaltea"
 <cristian.ciocaltea@collabora.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Dave Stevenson"
 <dave.stevenson@raspberrypi.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Chen-Yu
 Tsai" <wens@kernel.org>, "Samuel Holland" <samuel@sholland.org>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, "Raspberry Pi Kernel
 Maintenance" <kernel-list@raspberrypi.com>, "Raphael Gallais-Pou"
 <rgallaispou@gmail.com>, "Sandy Huang" <hjc@rock-chips.com>,
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "Andy Yan"
 <andy.yan@rock-chips.com>, "Algea Cao" <algea.cao@rock-chips.com>, "Daniel
 Stone" <daniels@collabora.com>, "Liu Ying" <victor.liu@nxp.com>, "Phong LE"
 <ple@baylibre.com>, "Helge Deller" <deller@gmx.de>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v11 12/74] drm/bridge: Fix unlocked list_del in
 drm_bridge_add()
X-Mailer: aerc 0.22.0
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-12-bc12954a0688@collabora.com>
 <DLKT61DMSLFT.JA03R1SO6WNU@bootlin.com>
In-Reply-To: <DLKT61DMSLFT.JA03R1SO6WNU@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Sep 21, 2026 at 9:16 AM CEST, Luca Ceresoli wrote:
> Hello Cristian,
>
> On Tue Sep 1, 2026 at 8:50 PM CEST, Cristian Ciocaltea wrote:
>> When re-adding a bridge that was previously removed, drm_bridge_add()
>> drops it from bridge_lingering_list without holding bridge_lock.
>>
>> Both bridge_list and bridge_lingering_list are protected by bridge_lock,
>> as they are concurrently modified by drm_bridge_remove() and
>> __drm_bridge_free(), and walked by the debugfs 'bridges' file.  Running
>> the list_empty() test and the list_del_init() outside of the lock may
>> therefore corrupt either list.
>
> The analysis appears correct, with a small nit: __drm_bridge_free() canno=
t
> touch the list concurrently to other functions, because it only runs when
> the refcount is 0, and all other functions tounch the lists only when the=
y
> have a reference. (Should this sentence be wrong, that would be a big bug=
!)

Ah, no, I just realized my concern does not stand. Indeed
__drm_bridge_free() can run concurrently on a different bridge than the one
being handled by other functions, ending up in modifying the same list. So
your comment is fully correct:

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Apologies for the noise.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

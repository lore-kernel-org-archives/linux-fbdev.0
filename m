Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC864C10F1
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009527; cv=none; b=tY5lzdcpl6BwGCl3syUsckouy9dAsql2bPGucHyGXEQSJ9joAdg8L/zoTlhkJXx6zJRdJuVugUjwT61GxLrcRuIOxbeQTdqDArSk4ggUn0g6LEo0chDhiYQ6GZMkyjfPF7+5iLcl2VYUOBzuAZOXw5oAWMMNoi1+IFMPVLKF4Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009527; c=relaxed/simple;
	bh=8qpYRBQlVULXYBwXUjPqr/j/KUQsqav5QY98Ap0DELo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=TmE5VGAmbE7OIj7E3Z93OTRNsHXSNYum7khKGl7FbM3Ro4WZ8whPob58aNbf1AMQZdwXP05PB7Z/wXoBULHsWgedMAofyRH4adlH+CXsEgyfa2xyYiNiurqK8m9Ygerq/jKGe41PvSzv2DZAcSYrxpXui4sjLUY4W5xbAbcF+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DOj1Y41g; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DOj1Y41g"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C077D4E40755;
	Mon, 21 Sep 2026 16:52:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8CF895FFB2;
	Mon, 21 Sep 2026 16:52:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C859C1032913F;
	Mon, 21 Sep 2026 18:51:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790009517; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=E8+TuwKUE2XBa2SuyOFw2XhfA4p/VrA5lusEOG2wO70=;
	b=DOj1Y41gnblEuUbAcpP3/m5HMMS+8CCXjkY0nVms96dcQJVAg6eDcUo/6D1ViLtXTvg/t6
	dHQ7g26/B+Pl8hrOF9+FnEzM5qlsuFK/Qpep/KPqvJrDNIsGzH497zB30KindqOD11tjQU
	sVWzDA/oXW+BOeMjwphAXxrivYUOp7/mV0KOP+uqH+upCyq8Ed6J8v95Zu+EatW8JEmDya
	EzYiR1FyK+9ONJTnTx+Ho5A5MA+ZZdNDlSTWwXpMDgv3vhSYT2XghlFtBaVDM5Du/0Vp9s
	nKPzT/Qx4U8tvu2vyp1PkjsWu18hnjG7QKoc6NyrPox5y8/8QrUygXcs4LqaSw==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 18:51:49 +0200
Message-Id: <DLL5EWC41AQ4.ZVQI9FO4EEVN@bootlin.com>
Cc: <kernel@collabora.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-rockchip@lists.infradead.org>,
 <linux-fbdev@vger.kernel.org>
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
Subject: Re: [PATCH v11 14/74] drm/bridge: Fix unlocked list access in
 drm_bridge_attach()
X-Mailer: aerc 0.22.0
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-14-bc12954a0688@collabora.com>
 <DLKTC338JONX.CQ6L7JYQ4UDD@bootlin.com>
In-Reply-To: <DLKTC338JONX.CQ6L7JYQ4UDD@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Sep 21, 2026 at 9:23 AM CEST, Luca Ceresoli wrote:
> On Tue Sep 1, 2026 at 8:50 PM CEST, Cristian Ciocaltea wrote:
>> drm_bridge_attach() inspects bridge->list to warn about bridges being
>> attached without a previous drm_bridge_add() call, but it does so
>> without holding bridge_lock.
>>
>> The list head can be concurrently written by drm_bridge_add(),
>> drm_bridge_remove() and __drm_bridge_free() while they operate on
>> neighbouring entries of bridge_list or bridge_lingering_list, all of
>> them under bridge_lock.  Hence the unlocked read is a data race, even
>> though it is unlikely to change the outcome of list_empty() in practice.
>>
>> Perform the check with bridge_lock held.
>>
>> Fixes: 76f1a9711b83 ("drm/bridge: add warning for bridges attached witho=
ut being added")
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

And tested with bridge hotplug:
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

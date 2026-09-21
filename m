Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15FE3769E1
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974981; cv=none; b=RFHDkrux1Os7VOhPeT1nfvC9iYyqlKWhQc5jMm0Wmmt89MRa2UxSTWDUDCgxp7ZMBvgb8vMAmh3x+Jnl/H1OyY3wD4wJr5YCIQn3jy4EaPjFutlWnPQpQ0xAuIJfnZRmUJb5X6ohvD6eFncJg8jqhHQqES3JNUOzl2mMky7erqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974981; c=relaxed/simple;
	bh=+UbXVbiv3+mKlBxfmn386LNlU9JQqXtzpOtZI91giBY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=kOZ04m6mIqyHJiNRN8U2O9HoEB+uiJ+ZcjIDOFghxbI4DJRZUqHZUaHP3UX0e+FUEA3bBtGAsN+cJ88oulBu2rKg+wocbZQObypRYV56YwPAO0nXzKBbtPdaQlrShMBY48T8L39RTTSyr2201YSlOoCE3AUayoHqQee+EwNt94I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AcujFY3u; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AcujFY3u"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 152CB4E40C97;
	Mon, 21 Sep 2026 07:16:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D669E60339;
	Mon, 21 Sep 2026 07:16:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A850610329100;
	Mon, 21 Sep 2026 09:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789974974; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pzbi36ITGsS4iWNXxtdP65zumc/0Hv+pIAeGTi+GcQ4=;
	b=AcujFY3uHm7+B7r1K++AlwOGnnnaQ6IU4z6IlMfOnRb/Rbb7s693ivo55BOAi8rpbWFYb7
	AJMthmWmZWixUW19PScUjnWdVmxbfZj/hiqx63zdpmcZ76XxfZ9C5N0aFwc3YQW6eNbfyJ
	W9ZPdRsgcyomRJWSgV2ft/aQqXVY/7Y/HYIi8BaFQPyk/1Fs5KGUK8tLKi+bLEm/ux4tvd
	qcid/BryvhoRufogP0l/4GxIEgglYPp+6R1uvwypfsJkQ/b32iRZBndLyq5nnLv+sbtsIT
	mhuvd67QwmP92llw1IOBVr+3lZQlxS8H4PGg4RrxtvV7qg3v0HkwAEbuFEOfOg==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 09:16:01 +0200
Message-Id: <DLKT61DMSLFT.JA03R1SO6WNU@bootlin.com>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, "Dmitry Baryshkov"
 <lumag@kernel.org>, "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>, "Chen-Yu Tsai" <wens@kernel.org>,
 "Samuel Holland" <samuel@sholland.org>, =?utf-8?q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, "Raspberry Pi Kernel Maintenance"
 <kernel-list@raspberrypi.com>, "Raphael Gallais-Pou"
 <rgallaispou@gmail.com>, "Sandy Huang" <hjc@rock-chips.com>,
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "Andy Yan"
 <andy.yan@rock-chips.com>, "Algea Cao" <algea.cao@rock-chips.com>, "Daniel
 Stone" <daniels@collabora.com>, "Liu Ying" <victor.liu@nxp.com>, "Phong LE"
 <ple@baylibre.com>, "Helge Deller" <deller@gmx.de>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v11 12/74] drm/bridge: Fix unlocked list_del in
 drm_bridge_add()
Cc: <kernel@collabora.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-rockchip@lists.infradead.org>,
 <linux-fbdev@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-12-bc12954a0688@collabora.com>
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-12-bc12954a0688@collabora.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Cristian,

On Tue Sep 1, 2026 at 8:50 PM CEST, Cristian Ciocaltea wrote:
> When re-adding a bridge that was previously removed, drm_bridge_add()
> drops it from bridge_lingering_list without holding bridge_lock.
>
> Both bridge_list and bridge_lingering_list are protected by bridge_lock,
> as they are concurrently modified by drm_bridge_remove() and
> __drm_bridge_free(), and walked by the debugfs 'bridges' file.  Running
> the list_empty() test and the list_del_init() outside of the lock may
> therefore corrupt either list.

The analysis appears correct, with a small nit: __drm_bridge_free() cannot
touch the list concurrently to other functions, because it only runs when
the refcount is 0, and all other functions tounch the lists only when they
have a reference. (Should this sentence be wrong, that would be a big bug!)

But definitely drm_bridge_remove() and debugfs can run concurrently.

> Perform both under bridge_lock.
>
> Fixes: 17805a15d175 ("drm/bridge: add list of removed refcounted bridges"=
)
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260723015004.1F5711F000E9@smtp.kern=
el.org/
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/drm_bridge.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index afaae272347c..2c457ad74f3b 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -454,8 +454,10 @@ void drm_bridge_add(struct drm_bridge *bridge)
>  	 * in bridge_lingering_list. Remove it or bridge_lingering_list will be
>  	 * corrupted when adding this bridge to bridge_list below.
>  	 */
> +	mutex_lock(&bridge_lock);
>  	if (!list_empty(&bridge->list))
>  		list_del_init(&bridge->list);
> +	mutex_unlock(&bridge_lock);

The fix appears correct too, and consistent with the similar
mutex_lock/unlock() below.

So, with the "and __drm_bridge_free()," string removed from the commit
message you can add:

+Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Thanks!

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

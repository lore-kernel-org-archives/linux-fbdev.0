Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610624DA9B6
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009518; cv=none; b=KX2huleoO0qbeH2zrntLpKxm4YM3p51s81Dgk1f6xazCKyS9fHk4/9bAUO+GScgQSoPxwlg/DBmahWsaRNWQVBudFUOreRxXpSDLT89xQrCx2/ZqhYg1geZnfq+AU+/M7x5DCdVYDrR/TQDdNyAnUq5VirYQS2DJEwh5drxy1RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009518; c=relaxed/simple;
	bh=/s+Rm5TPnXMuq1eSozgqOKlpb07HdyEVcwVTo15Mu20=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=YMzDLOhxcQujN4mTf8Emew1rDoFTStzIk5jyd3ckTcahmQjrMvXj1v6rXlWwg4LQkLyNNAhRxnkU6C5bcMjaQXdedf395Sd6fNLreLIHlT6Lg+j9w6EGGyIvmY1vS6rPeu8O5VEf191KQp2MqEeGkzahiZhydPG0Mlvx6RISBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IjYWD3xI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IjYWD3xI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 465AE1A0D88;
	Mon, 21 Sep 2026 16:51:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 04BCA5FFB2;
	Mon, 21 Sep 2026 16:51:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 59E35103291BD;
	Mon, 21 Sep 2026 18:51:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790009502; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cSwoV7JYFKwWDkDL4IDFclIBqtgIii8ZsKhV2r0CgdE=;
	b=IjYWD3xIKW0KiAwSGgakYrxt0r+vUYd0qxiCiN/UWCsb/Lzv6F9MRJMiln7kdo9fS0L97I
	MsXakBjOTJ1+zKqPla6JTpP36tNNijKQuc05p4N/sYCzdy/c7URDCf+uJa5rryyF/pGD5K
	CvqGwT/3RpwqR10lvWnK934ts0XBX+qWLGQw+t4WaJu2BG8/qPF+HiQ1510dHvF6L28CmX
	ioTpVmqh4beeqW3L3IIl55sutm8DOpW/zT1po1oe7QbGwrjZOVXRXmuApmKzwv2DLncD2H
	1SpLtpGpNxBgOe0ek/Ku+tmxFQw0ujiCLjuQSMInGOlC5v95Mxni3AZCvi3qHg==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 18:51:25 +0200
Message-Id: <DLL5ELBGGCIU.3LL2QIE4I4MDS@bootlin.com>
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
 <DLKT9WH655L4.37F4JBC3Y14D8@bootlin.com>
In-Reply-To: <DLKT9WH655L4.37F4JBC3Y14D8@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Sep 21, 2026 at 9:21 AM CEST, Luca Ceresoli wrote:
> On Mon Sep 21, 2026 at 9:16 AM CEST, Luca Ceresoli wrote:
>> Hello Cristian,
>>
>> On Tue Sep 1, 2026 at 8:50 PM CEST, Cristian Ciocaltea wrote:
>>> When re-adding a bridge that was previously removed, drm_bridge_add()
>>> drops it from bridge_lingering_list without holding bridge_lock.
>>>
>>> Both bridge_list and bridge_lingering_list are protected by bridge_lock=
,
>>> as they are concurrently modified by drm_bridge_remove() and
>>> __drm_bridge_free(), and walked by the debugfs 'bridges' file.  Running
>>> the list_empty() test and the list_del_init() outside of the lock may
>>> therefore corrupt either list.
>>
>> The analysis appears correct, with a small nit: __drm_bridge_free() cann=
ot
>> touch the list concurrently to other functions, because it only runs whe=
n
>> the refcount is 0, and all other functions tounch the lists only when th=
ey
>> have a reference. (Should this sentence be wrong, that would be a big bu=
g!)
>
> Ah, no, I just realized my concern does not stand. Indeed
> __drm_bridge_free() can run concurrently on a different bridge than the o=
ne
> being handled by other functions, ending up in modifying the same list. S=
o
> your comment is fully correct:
>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

And tested with bridge hotplug:
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

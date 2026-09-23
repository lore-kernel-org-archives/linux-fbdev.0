Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0034570FA;
	Wed, 23 Sep 2026 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157121; cv=none; b=adKC16iUE67NoYIBEN/MwlmHkXl1Fupwan9/1Z8/LS4KZBrfEhnl4vjhVK8H0otJ7cHaXsLUhhC4YwDCXZcynGLM+Ns3CY3lubdibiwoRrK4ZyasWZvqtfkNj2lOj63h29DIz4VNSUF20OzzP0XMWw87tvnMUniVKUPHNfUQF9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157121; c=relaxed/simple;
	bh=OXBQm4V4eJgEVpad6/p+Mp7d9HIfL1PDI9hjlsHu7CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhLCkWTjxj4/i1lyI9oGAWqhH36PT0t8GZ8CH87RBQNC1cc57poUQcObROZqMuOHDG5YYZgjZd8c3evrJcfm4IYv6BmjgryJ+18q3yWJZWru3LJuBsFsuqldkODkPiK/cZ60Df1ScXDUnWTrH9es/PGRlKSbZdYbQ7D9elzPGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CZKCgZbG; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CZKCgZbG"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hqXLM2X8GzKn9j;
	Wed, 23 Sep 2026 11:51:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790157115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGmQmcU6nGcC18gst/c1lOQz4TJAHzdj/MA0mXZlKY4=;
	b=CZKCgZbG6y8Jh6iBQuevbo4X2YLgYdqoLdnnKeV63ytkSZhkQRlEhm7ANMYuMNF/Tdk9AW
	vuaYVsoL/ac9vOFodcOrZSxjcgxcfc7DWIh1rJ+65P2wTTaoOXEXH8iX3k2kFF4cCT77Em
	btpAFaRXLI8ThR+pzkPiddIfIpQ6/Qrg3JhPmj1E2vjlbwJ3wgIlhT7C2fqAZZFRYHpkbu
	xCBYiYj5xNFlg0NNGMq0bK72YlK0VNExo4bYyRLwN+9iEArDvEBS7S3oUwkGh499B+u1vg
	TX+66Wx25gBpWNsfbCRAdPsVjKQPXo7MiK5k17yGv3ImqXFgg5enhFsAFliAmg==
Message-ID: <588442c7-2589-4026-a8f8-e03f944318c3@mailbox.org>
Date: Wed, 23 Sep 2026 11:51:45 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 wayland-devel@lists.freedesktop.org
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
Content-Language: en-CA
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 079bfa1140171f5da20
X-MBO-RS-META: 3rdb1snwyxz3ufm4r4fm5o4bk18hbw86

On 9/21/26 17:51, Nicolas Frattaroli wrote:
> 
> + * .. _VRR-MIN-NUMERATOR:
> + *
> + * "VRR_MIN_NUMERATOR":
> + *	Default &drm_crtc integer property forming the numerator of a
> + *	numerator/denominator pair of a frame rate to set as the minimum VRR
> + *	target rate. Set to 0 to disable.
> + *
> + * "VRR_MIN_DENOMINATOR":
> + *	Default &drm_crtc integer property forming the denominator of a
> + *	numerator/denominator pair of a frame rate to set as the minimum VRR
> + *	target rate. If :ref:`VRR_MIN_NUMERATOR <VRR-MIN-NUMERATOR>` is not
> + *	zero, it must be non-zero.
> + *	Otherwise, must also be zero.
> + *
> + * .. _VRR-MAX-NUMERATOR:
> + *
> + * "VRR_MAX_NUMERATOR":
> + *	Default &drm_crtc integer property forming the numerator of a
> + *	numerator/denominator pair of a frame rate to set as the maximum VRR
> + *	target rate. Set to 0 to disable.
> + *
> + * "VRR_MAX_DENOMINATOR":
> + *	Default &drm_crtc integer property forming the denominator of a
> + *	numerator/denominator pair of a frame rate to set as the maximum VRR
> + *	target rate. If :ref:`VRR_MAX_NUMERATOR <VRR-MAX-NUMERATOR>` is not
> + *	zero, it must be non-zero. Otherwise, must also be zero.
>   */

Is there a reason that DENOMINATOR must be 0 when the corresponding NUMERATOR is? 0 divided by any number is still 0.


Either way, should these rules be enforced in drm_atomic_crtc_set_property?


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

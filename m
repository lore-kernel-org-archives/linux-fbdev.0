Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449769;
	b=uCSjhoqdN/Q1gqWVI4nAl8K3ucO+tiz/aj4oTqDSaovHNZbVL8KYF8GvgUkEnfeE3ccH
	 7jSoRjPdiG7u3ku54zm9dGpX/uusDI8bNh9PSgAfEk9VKd5jkyCw+mukwLa4c5oQuHf6R
	 rQm5afgKWTRqK4Fyj5D6J9E0CasdKhQYwXpToMmn6Y/HJxfeokarZECCFKXnyOxEXDtLm
	 J2leyBebPHxRPYh0+0bJ8ym6IHLs+eSTMGYvpdyDfChbcRcR/hNHZ7tue9RGtF0zCC2CR
	 57GE57LHvzmNRj5zprlY8e+Zjvh1NuhehHixQ5quOcC0ITX1Mjpv6gOBTRnQltb03/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449769;
	h=Received:DKIM-Signature:Message-ID:Date:From:To:Subject:In-Reply-To:
	 References:Cc:Content-Transfer-Encoding;
	bh=ogU99soocUNAyEPeTznDE3E4dl7rtcgWRc2b1gTGjxY=;
	b=aYo3qK6ucWhTTDu75BDKvFt9lokV+RcHkMAOjWbkGfiKvIm2XU5kDwOBHRKTow7ANAGb
	 m8Zfe3KijESZyH3kU0I0Y2vwVSN1W3GJTv6PzD4XOMItlMi8R3gdVIdSIX+hBQyZ8mqsh
	 ZxgI7qcQCppfjmIKngXSlKwxC0CwfDJCkB+TAJ80T2rs+cWHDunoa4uV03c/H17bbVsWi
	 RBQySje/6maEM05wusylx0tilm+mhmhSIiKzjGgTLVNCCyECHtPtEX4GDNLRNzqMChWi+
	 o+0ReJaVhp2qLvTO7stxfqG+mYsUtVphrA8Um1N0rsedEDcsk4BZDzzLkDIKI3oJA2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AsKPwXYO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E80606A31A;
	Mon, 23 Nov 2026 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AsKPwXYO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB231F000CA;
	Mon, 23 Nov 2026 16:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449768;
	bh=ogU99soocUNAyEPeTznDE3E4dl7rtcgWRc2b1gTGjxY=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=AsKPwXYOYxgAIR1jYhhjlxzaPCpWcxmf5T4hw5nToJppZY+VG3updxJULSflHR5qN
	 YpuyJjV2wIFTkDIjx30ulOpinKPOHucmRMZbd/BUMNoEMglunojM6oY4jSoAx0Ejjc
	 ZoE8VR7uiZXKPrrkQDVN6/9iWv2yc8Z+79qyuYslHgOJ3mcmeQEIphJjp7d8l9fK7z
	 Ba0OnqUpUslek5mlEkTGiSBu21jX5Kg/xI8SkUy59T0FgDEYyWvSc5VEj9du8JLDOy
	 UfbCmd2mPfLydPyxiF+G9qw/Iw/1WQev04siPm8yV8jx6yzWcQZIQEKGTPURAzD0Jj
	 pPJkLwUG4YrFA==
Message-ID: <844a6063c212561296f2275e9cf4b1ee@kernel.org>
Date: Mon, 23 Nov 2026 16:02:45 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 16/25] drm/tests: connector: Add HDMI max_tmds_char_rate
 init coverage
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-16-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-16-20e8a33a2286@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Hans Verkuil" <hverkuil@kernel.org>, "Helge
 Deller" <deller@gmx.de>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Martin
 Bugge" <marbugge@cisco.com>, "Mauro Carvalho Chehab" <mchehab@kernel.org>, "Maxime
 Ripard" <mripard@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thierry
 Reding" <treding@nvidia.com>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list

On Sat, 14 Nov 2026 20:03:40 +0200, Cristian Ciocaltea wrote:
> Add KUnit tests for the new drmm_connector_hdmi_init() extension, which
> infers the connector's max_tmds_char_rate from the HDMI specification
> version advertised by the driver, for every known version.  Also
> validate a driver-capped max_tmds_char_rate against the version-inferred
> limit: override below, accept at, reject above, reject when no version
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

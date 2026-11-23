Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447896;
	b=1f27gUMv6ijjgf9M/PW6V0njY3EmPQOHSCBOuixsDVagXIrQNLIQ2pq9qfWilZ7J8ZMK
	 Zhxfjv9yv/swJfRtRYNH5R4BMoC+w8yPKVvdo/PDsmoAOfqz829JYeWNleZ/MW8VCR9yx
	 x9bZv6PoPlBGt1BXyQQ0oTg6MgDRwj9Ftz/G1tdJxYe9dsFVypC0dKAS19C3FLHb9Iyi0
	 jpuUhzB1nylIFYlN7nWZfRRUu3fv/zUcF9p4i3UvLldYwSSzdbGuHki0Q5kpCj7mSe3xD
	 WnRxCWt8Q4agKa9qnJ5mWyxbr+TwloGFIpbU3TKxtFD24bdlApcfOljmoxk/EVv+Scw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447896;
	h=Received:DKIM-Signature:Message-ID:Date:From:To:Subject:In-Reply-To:
	 References:Cc:Content-Transfer-Encoding;
	bh=saLnfNPmsNs2Ceg6gcANcLn87Y4bq8AO+/qeu4LIL6A=;
	b=L4k+RxpIIaBTKuTcnlf3VxqjUhG8ZtO/y1cT/U+l+aSNalAjLYSXUENZfRuAYtxOfS2V
	 7dzBKKnnZWK8jqK9Hzf0v3eOiqqkejYUPJWH6L+8aH/fLuFs3h7HkDpYfb2DPguF1O8ym
	 k1bFmUQ3lpONpYER1L2c/JYlcz60H+OuiBXrbLONHIGq9CwkDwxuU6M0WLh5AmLFgINHP
	 Osi1ZhqpnKszQPTKv08un4r8gXnRdHQNWJ2SXgcE40HE+WIYvjOtEyFUmGyVzBgK8DncO
	 v4hIJEg2ggi0IezHVNxNm0mqRzYoeidAe8bt4ZHKhR5ijZ2hSBZqbeNPr7QiiwjPo/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hq4tuU7Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E57F606A31E;
	Mon, 23 Nov 2026 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hq4tuU7Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016811F000D0;
	Mon, 23 Nov 2026 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795447895;
	bh=saLnfNPmsNs2Ceg6gcANcLn87Y4bq8AO+/qeu4LIL6A=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=Hq4tuU7QWrB22/kGIC1JjkwS64OmbEFEpd9j3wxh5d3T2U20wm8+M6xA2BhJMv4/a
	 tbOUMmbDkfRyDPrLd4XhlUhf9J8NZR7FCBWOhz4QceL2k5VJCJHuyLg/jxjFuycCMK
	 5lBBRhYZtKF6kOxw6YgVGY0DkDXe6uZQgHXF6nqWB9NvItIVsIf1Ar70vBe4gYzd7o
	 7SnNFJwtJv67tmUE+BoAv72CLbP3bye9CrtHpnR/w5OjUEpWWa5MtSDY1AR5lYp+5f
	 AxMfB81CtjQ47xY21y5QWC2fv2vj7Dc7zV+F2vHrOHzP8x45oLpe3WnzXnidcERruI
	 fyRvS02NxNwhQ==
Message-ID: <1b1e27151f140aae552460189a1d608e@kernel.org>
Date: Mon, 23 Nov 2026 15:31:32 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 12/25] drm/connector: Fix comment in
 drmm_connector_hdmi_init()
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-12-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-12-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:36 +0200, Cristian Ciocaltea wrote:
> The comment related to the computation of maximum TMDS character rate
> refers to a non-existent caps->max_tmds_char_rate, a left-over from the
> early stages of development.
> 
> Update the statement to reference hdmi_funcs->supported_tmds_char_rate.
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

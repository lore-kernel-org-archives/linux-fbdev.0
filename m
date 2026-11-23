Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439250;
	b=aHi9UY9+YuvNwn7BUfSXYu8Qd2wdyC5wD3+VSEZcDGYx85dEkArujDppdagDtPr43usA
	 HHq0ILPBHN422K3/oqgYMJHyOlFcl4FqwDVVxagSswmmp4i2gxLLtN8JjyJzi0HK8SoI9
	 ZHNyok9xsOS5VW6lfGzzuA2z3e254lQAKW0IG6DCoeTMK8f5uG8GizbzSQfqVnGmGwHQe
	 V+KBVtIl5Sr+sRcmgiNvZVms3bHlZzhVHLIKyuV5r5OrF+cXGYHuZeDeIBbZlQxDWrulJ
	 KLrbgAvrK3IClRj67l50gR8755BPnJAOX21RMQEFY4S+kg2QvnM/D9DIPXZLA7ynGMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439250;
	h=Received:DKIM-Signature:Message-ID:Date:From:To:Subject:In-Reply-To:
	 References:Cc:Content-Transfer-Encoding;
	bh=vdxhRaQriSkjmU7uxkOrG5krlgZH26MSD++dFcw6b/U=;
	b=YFBzxqg4IsEYECRNgS/omYaR2UnPnkEbsNw4Z1m+AxcMp7ZT55S93Gh/9uKvdWfhLV83
	 wpweM694JGvC/QORDUqQLOHZ2GvyWZm+yCMTOjYTTEK69lEvkBt69KoK8LxJB2Q+7OX8X
	 YvRPg+ury60R3YQ1rcd0K2DlNR67NZAK01KQJAirzb01NQSSRcCnYremFzBiEWRzFysvn
	 lRXw01YJTnZw5Tl7tyTN5sH8BbVNIA3cUWSkwobmJ4g5O4HbN7+AhmorSsrmKZQVDUJfe
	 egJNezAdaJIEWzm9TePNy2Bbd2Zq9o6y2AKFGch1QZqMH2c7W9OWnnyvmwZCVfCy+KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ay3g793d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427E4606A31A;
	Mon, 23 Nov 2026 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ay3g793d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA611F000CA;
	Mon, 23 Nov 2026 13:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795439249;
	bh=vdxhRaQriSkjmU7uxkOrG5krlgZH26MSD++dFcw6b/U=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=Ay3g793dsN2YBA+eUW3PLAfPKW2d8RoGpfOPAWBeb3ceXlZW23XpDxQRg+D5JIgXZ
	 YyYRtnmp5jAGLJpYzdYSpQr+TXGfDJaCVUMM3S9AHRnkghdNpwCaZQo/3TB20oAq4F
	 TTFTjxe4ZHCxBK37C/aNryEDW0915ymNfVGCw5Di8tWL0jhAy+xZF1QxR2dMdAyp94
	 4Di7JTSPQAHqYd9a70HZ4fiIchq8W/8ZNintFh/emVhqsHapoxqZk+GZLM7gBLX584
	 Gw/EUujZbIWvp5FYd6yL2NpR6q06fpIqbqOdHWEqsyIhTHlVtIrjj1kvLBQyPAVaWX
	 1A0vJdRR4PEJA==
Message-ID: <88513b81069770339040ceea59f8e0a0@kernel.org>
Date: Mon, 23 Nov 2026 13:07:26 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 08/25] drm/connector: Drop redundant hdmi vendor/product
 fields
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-8-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-8-20e8a33a2286@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Diederik de Haas" <diederik@cknow-tech.com>, "Hans
 Verkuil" <hverkuil@kernel.org>, "Helge Deller" <deller@gmx.de>, "Igor
 Paunovic" <royalnet026@gmail.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Martin
 Bugge" <marbugge@cisco.com>, "Mauro Carvalho Chehab" <mchehab@kernel.org>, "Maxime
 Ripard" <mripard@kernel.org>, =?utf-8?b?Um9iaW4gUsOkYmVy?= <robin.raebi@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Thierry Reding" <treding@nvidia.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list

On Sat, 14 Nov 2026 20:03:32 +0200, Cristian Ciocaltea wrote:
> Now that all users migrated to the new drmm_connector_hdmi_init()
> signature, vendor and product are provided through struct
> drm_connector_hdmi_funcs, a reference to which is already stored in
> drm_connector_hdmi.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

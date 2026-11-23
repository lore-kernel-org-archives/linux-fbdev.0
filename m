Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439279;
	b=SgekSTFuzwX/ouTVC4ynSY5jU+NlLYhEB66KedIlZQAsVLJx4ySFODae9vi69nxQCHI/
	 fwKQdEgBeX72vJDL85H/mXCaMR5K5dCmSS2HhmQ2fz05/CNm7uMokD1k56IKsqnBA3gDH
	 XpAa6R/bxyBdeIzo7mFK3b0L6AHedr1loWICSymD/wT+SIzDmO+Mo+jilpmxuGGNZLgu9
	 0xPxcsiIDEArIEZs0qV/OhO/6GtMysY/N2dL38mzC7edQACsQSHlcZg+MHzWFr5tyh2SN
	 bW7jKU4TNHQesXDEd4mipPhpy2NI7YcwIRWZmK0ykJcL4hBGkIX2NfY1vFe2+YCn50Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439279;
	h=Received:DKIM-Signature:Message-ID:Date:From:To:Subject:In-Reply-To:
	 References:Cc:Content-Transfer-Encoding;
	bh=LKa2vsaDvtaWNoj3QpEStf5Hs24zGtCTpUXk/Yj/O2k=;
	b=Xq/1iHyXXI0SGwAORPK/G51eyeJRF29IDHsXQAllvIbnKjFI7wmTscI9OaQssun+J+jE
	 0jYcqGxJYemj3rgDHhTR97SXkOQwzOTrRfGhwYEpmnsuDz8y5npEoW4y0FHFIIpybG0sP
	 JhOYJG/0gy9C9gWQ4AqbKMLxMsbHbYrd4OcixmqTIY+TXBRDEB6GxeRBi5raCYE+5YJxP
	 Iqgy5tpb+JoW/GA+wnej91AP/Ew8gbD9TngJTV0RX04hSepIdUEoKhHsuMHyOmIzWipL3
	 3TzcvinTy2cKfPkWdkARWY+yysOoAoraEYHhfOptQlTw90vO6E0FE+KQZllKzTGCR1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DK4j4JVl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A5A606A31A;
	Mon, 23 Nov 2026 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DK4j4JVl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02431F000C0;
	Mon, 23 Nov 2026 13:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795439278;
	bh=LKa2vsaDvtaWNoj3QpEStf5Hs24zGtCTpUXk/Yj/O2k=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=DK4j4JVlbEivXv3TjcwcBwzD5AUYazUJ6ef11A73UhNJRpp9blOC3zziE1sENTJ7n
	 4/9sbQTirzrP2gl1KUSCFR12zIO7vYE82+3nwkNCMOZ7Pv8yc1/fp1H1Qm9T7eTflW
	 L/EMq8zh+4kpHX3VvBnm6snCwpkUT5ZIu9KtTDco33fg+N6Rt4bYqJBrMKiq7Wc0+4
	 xTth6wqo6XdV9sZeay++YZrOZ+PUnpHdRl1AsBbS9RJJUjotbDclRjgjEKKxYu/PZ3
	 4QLhXXPdUey7uGk57zF3pC/Q3HNWNxSd4p2WlZBZlytxxePyKFzR72J6V3k0Ib2faN
	 SXC6eLgqO324g==
Message-ID: <98380c565736e8f2b72dd0299743d57c@kernel.org>
Date: Mon, 23 Nov 2026 13:07:55 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 10/25] drm/connector: Drop redundant max_bpc field
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-10-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-10-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:34 +0200, Cristian Ciocaltea wrote:
> Now that all users migrated to the new drmm_connector_hdmi_init()
> signature, max_bpc is provided through struct drm_connector_hdmi_funcs,
> a reference to which is already stored in drm_connector_hdmi.
> 
> Drop the redundant connector->max_bpc field and point its users to
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

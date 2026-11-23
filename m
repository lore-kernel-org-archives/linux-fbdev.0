Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449836;
	b=wpXQHl3wYiF0z7dVEvsQhIikY7dNRceHbTliBAzNJXmALx+4zae+alDs3OLTLZFySFxI
	 fzsFCGrfFIBWWUSku3smggBsvrJ3dzhfy+wzJYTAlY0ThecNmazk+ZcOGiaN06cY0ByBn
	 ahWagqG+dGwqXvx4ewvSvf4vxs1oLXdc4AcU1QtyUyaY7p8ncNCdrVT1qMaUafV96iTcA
	 hJRJDHl403HypVMvM2beF47m+OEUOy2gKvOjKkOc5MiYjE2nYFOgbmxDuyUJ+kD0EF/VW
	 A7rHUUuZa1Daj4iGKGEBNRsO8kw2eCfe6qY0wV8Gcb+r6FUJ2MJgfG2UBw+G4kgCIqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449836;
	h=Received:DKIM-Signature:Message-ID:Date:From:To:Subject:In-Reply-To:
	 References:Cc:Content-Transfer-Encoding;
	bh=ImikEajVtw1Ud3tQpZGQiXNpkN9E46qiLZ4YF5GFcnI=;
	b=aCB8KTRQbFYOVA0LRD3kLxXTQNPL1nvhhgOE/rXSVndIMyvhyEnVaxfcSCoOwIEMmA8U
	 jIzwu6prVVP73jld+8JY4lQHAhLycnwEG8K1/8tLzRb7ox/0LdCbZNFcFEYJELTc8rkxk
	 FvNLHwQ+AWJ3KpKM5RZ5vFlnyFa6V3i3OAZkkbNHqnv4LmAnf1+IgWSrHkEqrW2JVznxx
	 TX0/QMxzy4V2KwWrjA5H9tN97j6WIYFxcfRxLNTPwkSUQrwmewGZhmaZvs/pdyYJcvKz8
	 uEIEjm6W0x0N1QsbwBizMBRpjYT/gwd39GC0L+TULyF+lX5LuxFeAE062MBxaoVEH2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HiApJnJl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98BF606A31A;
	Mon, 23 Nov 2026 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HiApJnJl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32651F000C4;
	Mon, 23 Nov 2026 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449836;
	bh=ImikEajVtw1Ud3tQpZGQiXNpkN9E46qiLZ4YF5GFcnI=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=HiApJnJlu/SccLq2ljVGGeLFPZF+cqxJVBPFtlqcGngaRUW39BeRybbHS7k7pZKio
	 MJv2luvLilLBnGzqhlyto0eKesX+g/+HVJYsCw1d0tBpaStcgBunE8KX1UemD4kyjC
	 1PCiHjFwGs/YqCXUMeNTgO1IiTVFRVadLDM3Wof6HgVGc7Qq/zoOB0+exvw0nu9NG2
	 hY812pA8oHgKatmV/OzfHalCZJNPVpK8R4TFOZFOlPZxdwVDdugwZ3MR9vTH7ApcRr
	 KsDV4N7aS+Gq3/pk/B4tTkZEkkqvWtPp2zsHR5RhbCBPXprLZL7cOnnegXcFXvFLYk
	 UyAQw7RmXSCgw==
Message-ID: <b59e98094e10e9baa3309019c729d576@kernel.org>
Date: Mon, 23 Nov 2026 16:03:53 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 17/25] drm/tests: connector: Add HDMI source-side
 scrambler coverage
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-17-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-17-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:41 +0200, Cristian Ciocaltea wrote:
> Add KUnit tests for the HDMI source-side scrambling validation done by
> the new drmm_connector_hdmi_init() helper.
> 
> Connector initialization derives scrambler support from the
> driver-provided supported_hdmi_ver capability.  Therefore, connectors
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

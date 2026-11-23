Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439264;
	b=IzJ22Zk72EPrn5j7EQGMNgyU3zWUOwLcE1ANjg62S7wLGApy2j9mB48zQxu1x2iCv2NN
	 NqvPcHjukhCnoNPglTvqVBmVps5TVB7YKGzhfpPmmCc9PpXtS7hRreJHfLyS4MKJT7YMr
	 P781+3zzXbcSOXdOA8SRSHtZgLjBZva3LshGyZKxQK5SdqqPeBnNKdtpTMfoP7v1HwR6Z
	 9O0P5UetYfSjhB8e6w+Lhe1DO39/UZFzSKm2O4yV+ru53gAUm1Afw0elz/QYnSOcSdSlH
	 d4GUxJeahA9w75aqgDPOzgpPtz4S8crpzG+tew/ldKAPSaMuIW+IwTkrNHCrHbSyZMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439264;
	h=Received:DKIM-Signature:Message-ID:Date:From:To:Subject:In-Reply-To:
	 References:Cc:Content-Transfer-Encoding;
	bh=9OlWkQM+XFoN1Gs95fD/lZlKv7wZ9cKWXpxYEv3AD9g=;
	b=NqboXPeZFjWGOuWTn6clQE/vaMt9C7gfI6lCArPRKa0Q37SlY71q/L12Ek+QXM9OKwq4
	 o6t/9ctlzTDyFWGle4lY5VbYz+kwO9eukx1Lyvlf1yryA6S3xlT5vlO3t3KP5+OLG5bnO
	 ycyLTgU7gMek86Z9oywPtdQX2+T57vIOMv8+rHvCFUk58z8/bjHQovuBqYQRpzubiXfm/
	 6iYkMELsXfyZf6KNtG+PG0iQ/G+Rt3JmtJxYR2eVB/mP9l3rUZtmsTkJPAdCv90/84jNO
	 20st2Mvxo1NrSknmq5elbwC/3vWF2m+uDE3cHCs/Hgw5ShwrF7ntMEWvtzX/PuxOHRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnb0gqJa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6595F606A31F;
	Mon, 23 Nov 2026 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnb0gqJa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615591F000D1;
	Mon, 23 Nov 2026 13:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795439263;
	bh=9OlWkQM+XFoN1Gs95fD/lZlKv7wZ9cKWXpxYEv3AD9g=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=hnb0gqJazK387+u2EVsGIBflv5BRGabh1+/e68fIAp0LpW/GSLj2dey8mo2V4esdD
	 07JfjdvM45fs3Zm59mN8WA19c9ZN8De+bYmfBZ8yxu5lGqTuljKdYn3tlyw+i0spoG
	 C4giAORXw1pORS21HEcnFL9yIJhSCJ5tQ/Ia1Uz8mXgkyMcQQvwrkWi0yYyqt/Mwa2
	 baEI/C4665/euuzOS8k1orEm7fWbvUCxmr6HvaOEXAf9bKFOcJTUbWbwHDGJaYc+P6
	 YiBz8pDKinek7XEJodZtaWUPet2z20utNtqGYAf/R5ojRE1RylRVljwx/SHOEUNqfh
	 fvGb3WPU6+Z0Q==
Message-ID: <2fddb3794c21ee97aebfdbc14f29ad9f@kernel.org>
Date: Mon, 23 Nov 2026 13:07:41 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 09/25] drm/connector: Drop redundant hdmi
 supported_formats field
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-9-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-9-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:33 +0200, Cristian Ciocaltea wrote:
> Now that all users migrated to the new drmm_connector_hdmi_init()
> signature, supported_formats is provided through struct
> drm_connector_hdmi_funcs, a reference to which is already stored in
> drm_connector_hdmi.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438382;
	b=nGp5n3nUWdjBfMZ1zLfZA07rphEDt4CkIB4R6AzZkHEJkD5e1MEb1DKg/4+roPT17Z6P
	 bGV09ONIHK0WwUv7nm4qA26Yl/4/x52V0g8VdafRh/p6CqTEF3JMdsw4wxsFXm5TyxcFy
	 NUm2P7dxYOEjF+2hfx0r9Enj2z/hJOAvs85Vr+N7BcQNUQImgaPLn9GhStE5fLEjfo+RE
	 qDHr3Ytcf/ed57X6xggfQlMnvHyjyecR1haNzZZmeYO1S6G/9qcn+MzR/Ls6dPr63ryCo
	 2drih1NiR9I+pInEWKaoonxkEMYm8YUu1V55kSk6iWdlT4O40PB8R0drWrcmg06NkXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438382;
	h=Received:DKIM-Signature:Message-ID:Date:From:To:Subject:In-Reply-To:
	 References:Cc:Content-Transfer-Encoding;
	bh=HU6ScoabHL06Z0tq1jjSkMGrZ76XZfdtU4bDDbS3dPs=;
	b=pBnWhVssQZhvbA/1CEMx6iB0SDygBrRdnw2qGvlZN8fcfO8jnSB8hQ25IsRfX7kWlN9F
	 2DoEPpmAEVNW36KPuAuwu655+5ZlLbcWsPmsSvEhp/rpr5Fm24ooFI9rXlrv8AY8od+fa
	 8cbxTfHGvLOdcSRMxr8XCPmPEkc9SrtodGwb4qLzcrlSyS1/Oehgw64ZmYDoo6sWa5w/1
	 asjwNkjJBu3dhSiSuyP8SXBRfQq74T0zA5Qa7Y5R7cZ11uaZrb/FYOXmI5wDvjw/sWRh9
	 5UGyXzsMqQHtewJ1hXOUoDkZlb5IF1gtLZXyHCtHVGg92Emz3iVIK4ndJ4u+1DYMMIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Jf/OJI0u";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D097606A31F;
	Mon, 23 Nov 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jf/OJI0u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C029D1F000CF;
	Mon, 23 Nov 2026 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795438381;
	bh=HU6ScoabHL06Z0tq1jjSkMGrZ76XZfdtU4bDDbS3dPs=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=Jf/OJI0ufwqrmkYaNVEMPsk8kCX+SBiA2TZUjqVJ9buukz8Jsj1xYGL54wcE0dUI9
	 Fl2HQFgAebH62FGTr8L45Sl0TLC8u5l5jKoMASn+vJkK9pCTOOKx8SoOIfWPOqJZ5+
	 a7MLPs+k6DnK2H2ishQlbvZoIBHz6VNSSfSKVRUzTI4ZuDpFPzRnX64gWZn7baxEKt
	 w/JYKhFX7OGYjYOR4u63AZJZft7lM2f1tEFJznOHQhVXaOks0Z3F6Ez8QX0m9qyJRg
	 0aUdCzSieTzXw4E3D5vJ5O86D2UyZcrYAwAg0XjQl4eCtSzb2cL3YB9BIhSuAUogWP
	 IKQcY48qfAvbw==
Message-ID: <bc455d63f5e201cd12d81dbd29230bfc@kernel.org>
Date: Mon, 23 Nov 2026 12:52:58 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 02/25] video/hdmi: Define SPD InfoFrame vendor/product
 field lengths
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-2-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-2-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:26 +0200, Cristian Ciocaltea wrote:
> The HDMI specification defines the SPD InfoFrame Vendor Name and
> Product Description as fixed-size fields of 8 and 16 bytes
> respectively.
> 
> Add defines for those lengths and use them in place of the related
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

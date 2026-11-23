Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438664;
	b=uPmbThejGqo3JjPtUrPweQgtZrfHU2livAHQGe+6KhpBwrejLLi/GQ5LlFwJuIGxMVxZ
	 n7fPvc4YocP8XVUpiiX5AEJo4cQ9Mh9WDAv0o4bsKIsOLVMEuNx6ggniYa3nbRERDX1PS
	 iRpf28x77CZ/luLCqnp2toqFSBFm/Gc005xnoZSDJxed7ib1o08l/GsZJIg6SBWJTKH7a
	 pZscuev6lodkFvk8HCfzmJyBIZ7ZreJNV17DnZZ58mGWs9mIecq6fT6YDUd7OsYcJmr1N
	 iM9r4yf/r579T7xj3xkXHgOptIFqvqUJXO97QVf3gMCriy3pKC0c3c6sbAJZh6ZQD2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438664;
	h=Received:DKIM-Signature:Message-ID:Date:From:To:Subject:In-Reply-To:
	 References:Cc:Content-Transfer-Encoding;
	bh=zNq/MlEjOpYgXITeVLi5w4s9w4CqSYphZ/ocF2OCe1Q=;
	b=HBkC2bxlYvjbZdnYyvXjB6/zIoJ1ZIKvMBQYiJD3XYPvihsf9ieD2jQh1tAjazas9PIS
	 pa19dX5h42d232gfEwEXRktLqAc2t7mJmf0puleu+CnodmWno0v7OnG+60k/NZ+pSG/Pi
	 Z7ERrAkwLuEa1BuPy3fXtWsk3Qq/UgYogI8dkT4AZjqK6DKM8Tr4Ww6ZwaBgB8Hlb9I/z
	 yn7FVFaeJhrKujUiEB8RwOhlM71TA5KSdHWzxvo83IHGiTSpCHYxTD+3ZXlnAIqERY81R
	 XG50HBJ83Ct3HPPSlVy2yECwTWcdTf+ZJ46k1VYrdLuGBRXCOSAcblEjTmIK2crF65w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUidxd8E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6D606A31A;
	Mon, 23 Nov 2026 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUidxd8E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3F01F000CF;
	Mon, 23 Nov 2026 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795438663;
	bh=zNq/MlEjOpYgXITeVLi5w4s9w4CqSYphZ/ocF2OCe1Q=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=LUidxd8E92aKROlErK0iYasgvyjOewYoRm5sY/9Z8f6OmY9GVu0U2qY1GI0vwIexc
	 O8S4MSTO4UXGRzNRX/wsbsQkke8AEi24fUSwEJ2HS+/l6R58a+ttVxx35wBZxipBlW
	 RN/WOdGQ4Ydjj8rFKFzh3SkUaakC21YdGqF07D9+zUZ2Cpsl8Sh1qLwfr0zpFod5Zj
	 97v/DZy/axkFROCP0muODpntkfPt4+IF4N6crN0NIfWDXB4i98wd6scP5TYhrHH3d0
	 Eik7E7yDxG1YW0VefTvSKmCqxZqQcSZC3MvUcFdD/MhK1ectdzL2eb/1DrUBDKXHdg
	 GzmefYEwvoUYw==
Message-ID: <26dd97eb96195f3884e7dc55e677eded@kernel.org>
Date: Mon, 23 Nov 2026 12:57:41 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 05/25] drm/tests: connector: Convert to
 drmm_connector_hdmi_init()
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-5-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-5-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:29 +0200, Cristian Ciocaltea wrote:
> Switch tests over to the new drmm_connector_hdmi_init() signature, where
> the vendor, product, supported_formats and max_bpc values previously
> passed as arguments are now provided through struct
> drm_connector_hdmi_funcs.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

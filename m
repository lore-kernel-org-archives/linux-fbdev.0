Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7880029
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525048; cv=none; b=NyhvF7TSCuERVOEg9wblm2G7zVovCFY2dW9i2qS6Vbp0jZaYmjNA6mFDh7DhlsOBfm7jTx1oylgZRy9PYzznAebq3qPDhOIXeNFlq9LttvDB04pbejGaTsD4mceJE7hHwezs5FOdiJox2y7moUau124BDxrmQbUaWl0Gn1F5MW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525048; c=relaxed/simple;
	bh=VZmBHDbDaMcqMXJTlZiyWU3F+K8A+VN5Afy5vgX0SNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7o2h2cgLJhlSGi0hbz9eJY9jOPQylOG2Luhuds+BeXVi7FZmF6LMBy+ZjNUJP+hGSCs5SCAp+D2Aiki8i7UfetYhYxAkeuJ22EkbRUfb2NepOb3deoydWXdVyR4AnubYa55lsOdHzfUpKAbAWA11GfTNMwtQE0cRpTH5QMKCrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [213.70.33.226] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rxm8b-0000OP-Ei; Fri, 19 Apr 2024 13:10:37 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: javierm@redhat.com, deller@gmx.de, airlied@gmail.com, daniel@ffwll.ch,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v3 31/43] drm/rockchip: Use fbdev-dma
Date: Fri, 19 Apr 2024 13:10:34 +0200
Message-ID: <2131772.TLkxdtWsSY@phil>
In-Reply-To: <20240419083331.7761-32-tzimmermann@suse.de>
References:
 <20240419083331.7761-1-tzimmermann@suse.de>
 <20240419083331.7761-32-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 19. April 2024, 10:29:24 CEST schrieb Thomas Zimmermann:
> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by rockchip. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: "Heiko St=FCbner" <heiko@sntech.de>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>





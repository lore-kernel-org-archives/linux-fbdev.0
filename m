Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4E54CF77;
	Tue,  8 Sep 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881081; cv=none; b=hxmDczX8F5pGYHiEywz39JP92KOUmPvO7dEbX7M9ZJys56JyDGyVKiO2DKp3zuWcC1PR+ie3Xe3pZ1M4r4bP8OF+HAa6x5XAAvHkYd2Ol09reF2BL5NjmUmEyIGvWGZp4J0fiF8i3qhtXcOpLwrkbclxWqS3C9KOlEnwngyKjlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881081; c=relaxed/simple;
	bh=PXr5c7hHW/s0gvhT0j+z4lGvWAuoX1i8hPPjZMT8+uA=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=F4M+PQhU75TSAkgSyKkyClesOVjCFDlWziysdtXLz15FiWUznFIje6yZPWrzRkzozr8VK8/9IXyCikqJj08hi1GthA2voSLBpy8PlA0UHSvojMRCjaYeHvkbh1HM6+ubg9j1+kVh1OZ6+kjKpo7wFnMvDhS6S3Y1bzMDLP0GzGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3q4EpWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3q4EpWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754501F00A3D;
	Tue,  8 Sep 2026 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788881074;
	bh=PXr5c7hHW/s0gvhT0j+z4lGvWAuoX1i8hPPjZMT8+uA=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=K3q4EpWoRgrPNlSeSgNpfZ/yI6QNSgEXebIUQysMzS9lcIH6GnA9d+0Oz1u7sN0OB
	 WERrfZHOKMY2L+Ydrt0DDGUdTDbpbJ5DiNxPrasZMSlnjVSLIh2Yy+/1QRUG1Q/DWa
	 zdMa4xcP1MnmgzlZUBgnq8CwOyKsrQEEwEWNL0DhWzXvBMtPwu4h35DxY3oEVdUpKB
	 VHwxn8hFD9QDqLSKZ/YlhZadelUmd2a6xg8ucp5Cck1Iyw28BmZbYm+9XGHt2/nmjE
	 /d3DHkZ5GPFnHNdffFdImrqOmYWR9gUws86GEFky/8PpMqRkVdjVKlFt75OeHNj9sN
	 g0prrKv5Lbk1w==
Message-ID: <027090776a56ad67876ade0f31039108@kernel.org>
Date: Tue, 08 Sep 2026 15:24:25 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v2 2/7] drm/client: Add acquire_outputs callback;
 implement for fbdev emulation
In-Reply-To: <20260709092215.168172-3-tzimmermann@suse.de>
References: <20260709092215.168172-3-tzimmermann@suse.de>
Cc: airlied@gmail.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, dakr@kernel.org, deller@gmx.de, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, jfalempe@redhat.com, joonas.lahtinen@linux.intel.com, linux-fbdev@vger.kernel.org, lukas@wunner.de, lyude@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com, sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tursulin@ursulin.net, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

On Thu, 9 Jul 2026 11:15:58 +0200, Thomas Zimmermann wrote:
> Add the callback acquire_outputs to drm_client_funcs to inform an internal
> DRM client that vga-switcheroo is about to switch the physical outputs to
> the client's device. Allows the client to prepare its internal state for
> the upcoming switch.
>=20
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

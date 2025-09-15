Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BA7341ABE;
	Mon, 15 Sep 2025 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947943; cv=none; b=Tm/nuM44fHwrydJ96frUjyA4mFSBxCuyVKabTsBiBz6At26hMH0WrS/xZ1JOn8EbeAEMzGIWGbuBzQc+Omm7+93UXLI6uCYsMbpuNt7gIXRJXSGcUxMOLnXPHuENiZvKcIAG5fQ4z+7fdqR6HwvdwcLGLAoilkjyCv9JGJ0b84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947943; c=relaxed/simple;
	bh=ps5J/2DiZZaZALrpYJv7qOm8LVVHiYQgbB13On5S8hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csi8TEheDzD+/C1xEZBGTbcfrN23Nt9wv+e0798cuILyGIMDb2YjRHcJrns7cXJj9b3i2IVsXir4vPbZw8cV/RKYun//OqUFPvO23Fa6b39hsuTkzjaCOvWxdnoQ641F8o0HTFFCURlCTrB+zYQBi1wCJMbAgV09wdzmUvPpLxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmS/Vo21; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmS/Vo21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2EEC4CEF1;
	Mon, 15 Sep 2025 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757947942;
	bh=ps5J/2DiZZaZALrpYJv7qOm8LVVHiYQgbB13On5S8hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mmS/Vo21BRD8mRQMpNk4G3zLBRL1lTZ+I8/bL1wg0v/acaTcjlwR1yLqPqOzn7o+g
	 i5K8F8QFOxIMfCjUrvuIK7eLysVkrvP01pRRNVpKklxtCd9ydO8DAFrHznZxg9CTYV
	 wtDkAFc35jVCWqqDs19gsP+Ab/j8IHtiw8vpNKdpZO8QGEyKXFANA/igYzR08SHJ7x
	 OuP7FJrKVTpb9+zNxFo+0uieUv6+X6PrWE2hKtyPyOCUpyXjNZxsh83cxaTFB4Rh7W
	 U6KP2nAyVpU+r/v0bj9++QC7zmWH0e66OPrvfjESyuoGl+vdwHLO4J1CtLSNT+LfSe
	 d/OZQyDPYDsiA==
Date: Mon, 15 Sep 2025 15:52:15 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com, deller@gmx.de,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	airlied@gmail.com, simona@ffwll.ch, fnkl.kernel@gmail.com,
	j@jannau.net, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	sven@kernel.org, alyssa@rosenzweig.io, neal@gompa.dev,
	support.opensource@diasemi.com, duje.mihanovic@skole.hr,
	dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
	Nick Chan <towinchenmi@gmail.com>
Subject: Re: [PATCH v2 11/15] backlight: ktd2801: Include
 <linux/mod_devicetable.h>
Message-ID: <aMgoHwP912AEQcY0@aspen.lan>
References: <20250715122643.137027-1-tzimmermann@suse.de>
 <20250715122643.137027-12-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715122643.137027-12-tzimmermann@suse.de>

On Tue, Jul 15, 2025 at 02:24:48PM +0200, Thomas Zimmermann wrote:
> Include <linux/mod_devicetable.h> to declare struct of_device_id.
> Avoids dependency on backlight header to include it.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Nick Chan <towinchenmi@gmail.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

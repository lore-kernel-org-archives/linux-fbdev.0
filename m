Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA852C2369;
	Mon, 15 Sep 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947655; cv=none; b=f1lTUCXeiAILts0CdqvIkyaKIQ5DchG9vgnsC2sS/263YBzDsqJnKHdyyoOvY8wExheRQXt1WqD5/kbnJUx3VRQiUGiaAGWYKbMDRFwYc1smsArBju+RHdyCf4l1flVeq/G0KEH4UKzp8DOtiNEpmL6uzYBA+BbC3Os9K7YALgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947655; c=relaxed/simple;
	bh=isLYgistNjdaFJ+IvtazUqH5mG3/5S4jIQ9w4kszCSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVg0I1YgvMEg6THzFX1Amg6ntsPeQYBAZlJpsxO+LLo+U1BNLaujkA8Du9YXn4w2VxPqiQ5trNz+IY3mOprFKAuo+LHFCX/O+3Es3NOLmgt4veSfYTw1oatRr8oyvf1SQYsAF9XJFt4Z5r8qx02u47khU7mH7vXRXbK8DbWFUVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4wlMhtj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4wlMhtj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B8BC4CEF1;
	Mon, 15 Sep 2025 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757947654;
	bh=isLYgistNjdaFJ+IvtazUqH5mG3/5S4jIQ9w4kszCSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4wlMhtjYAOghN/Bw6VK9WtBE24NGMCF8oPJ9UZHSrMfKsq0/B3OdwmPRJ5yz1sGa
	 OVjs4KV9tXx/GrndpwGtSpX48JUEtmtPKsZ5MbGv/LUPTizKZALqwjzGu68hOzB5ql
	 FzXbyT1kXtp13oCs381JOyrWuZsJoBQ1XLv0n8ABkubTTcZuuiM2AYOM0ViN4MerAQ
	 4VptVba9101kMNZ6kWvM9QXHn8hbA+JcFNVeucYKaF4NxAi5UCp3fD0SxzrBmMyZNx
	 xky7ydLOm6XZ+ESqYeA6gQ8Jr0QLzQJu1SEJOQ0Zj/U6soM2QrlUeKptugAFYg0kGa
	 6T1Qt47mcIgCw==
Date: Mon, 15 Sep 2025 15:47:27 +0100
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
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 06/15] backlight: Include <linux/of.h>
Message-ID: <aMgm__4sUSKYxqDt@aspen.lan>
References: <20250715122643.137027-1-tzimmermann@suse.de>
 <20250715122643.137027-7-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715122643.137027-7-tzimmermann@suse.de>

On Tue, Jul 15, 2025 at 02:24:43PM +0200, Thomas Zimmermann wrote:
> Include <linux/of.h> to avoid dependency on backlight header to
> include it.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759E73BBFB6;
	Mon, 10 Aug 2026 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358998; cv=none; b=UgonTGv1/MeTV6zB8fOowHvN/ShLsVuz9WgzSwA+2zGl6uKN+HRmdPMl7P2GxmViRcX7E7cjpEH87fpcw3IpJkhQCJUbTuwHPR6qeicJF1FTTqRyNPav8Ra5BH33mMnfOcQgq/uVoyN4WspcyFfAL3EFj7xqRsXoTmy8nZG1EhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358998; c=relaxed/simple;
	bh=Fs3/u+71IIDjhvAd8xv7/reFVFgf9XyvOxFprvtR1fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+wDcroY1OgSoTe143haOFsNygZl4TSw1jJwUNh+jbQbVtmta9FMXeFvhYuTcQZs3ghAA532K9V4LTaDI/K/YANWstV0nHs3USsU+I356UaJUI98M0BMSAU5l0gv2QHcfHGkECQK6XU0zE621a6MwVhR3T8XYzDACQpqod5ZJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBtxRDsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBtxRDsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AE71F000E9;
	Mon, 10 Aug 2026 10:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786358995;
	bh=RaJC7eVD/36NvdnYJwCwQ4K3pxBaVZu1wRfSuJdGsOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hBtxRDsWG6DEw5xYp9ulLnip7mZHLQExr/EKAJlj+5OXGJvi5IXZK57LPN6+WpIDL
	 jzUHXYKRRkgNf6AwmpyVfe2bzMGC1D9+UC9xzfzpXwLcNCrLmvsh4n6T2OsJ29zOpV
	 1Q84W4PCiq/4emuyqHTroEtNv7j83dAV1v34ahncRCTNycXPZ9md4+7E84PFoZC6pm
	 TX2Bj5DC+pUaVaUqWDcyRymbrlXGG4R13MMZUz0Tz6bO9on65oc2AUFyEOAquoP20G
	 7Zdh5FdxxWWrDIdyF4ggcVXDCxBLhfF64NwAfZ3Uh6NQA9iY3Nb4HYSUSxZZiCqJv4
	 LSUeZa9fL3yew==
Date: Mon, 10 Aug 2026 11:49:51 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	rdunlap@infradead.org, duje@dujemihanovic.xyz,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH] backlight: ktd2801: fix unmet dependency on GPIOLIB
Message-ID: <anmszwHSUVcZ3Dbk@aspen.lan>
References: <20260719024902.151710-1-julianbraha@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719024902.151710-1-julianbraha@gmail.com>

On Sun, Jul 19, 2026 at 03:49:02AM +0100, Julian Braha wrote:
> LEDS_EXPRESSWIRE depends on GPIOLIB, so its selector, BACKLIGHT_KTD2801
> also needs to ensure GPIOLIB is enabled. Otherwise:
>
> WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
>   Depends on [n]: NEW_LEDS [=n] && GPIOLIB [=n]
>   Selected by [y]:
>   - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]
>
> This unmet dependency was found by kconfirm, a static analysis tool for
> Kconfig.
>
> Fixes: d95963e309bc ("backlight: ktd2801: Depend on GPIOLIB")
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

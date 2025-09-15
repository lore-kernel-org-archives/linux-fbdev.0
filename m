Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9C327A2E;
	Mon, 15 Sep 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948502; cv=none; b=tPrZIO3N6kF+NNes/PkzTzgyZh2IizBueZzKH/n8C9Gr6/afe3yqBRfPyBHUCyEP87c6h54nl3vb0bYgBNfZXWHREGm5LwM4z0wNKZlA/a6DZ9KiIp/S5UB+eW6uRX3N7PAXBVgv0eZw8kITZD6KFIpdFrudVY3LDRTjt8tXan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948502; c=relaxed/simple;
	bh=+0i6RikQC6DfYiiM+/GamuDmLEyTAbg8j3Lwj+lkcTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMBjoCTgyLHO3qm6YQpDfLmGTh+HhxSI+HyAJFe05XPV6uog9MxdYu2ICMZgB9IF7WmVyDJJIQAdCFtuy64v/OuCnyRqTrKBNJ82v+h590qdhlR4khpqUG2zmRCHESjoFhL9EaCryfKgJnkVm5b5Q9Cnx4h8QnUzJsfDWormV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqJlOyb4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqJlOyb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C476C4CEF5;
	Mon, 15 Sep 2025 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757948502;
	bh=+0i6RikQC6DfYiiM+/GamuDmLEyTAbg8j3Lwj+lkcTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqJlOyb4u8dmfEH9xbldImMZRZQ85dwUmfhkUuUpDfbyva9VqHjaKc9MzztA4vVki
	 chZ5OqV3dwxrwhKpmvTDOSImagN1Tf3y0+7WlysTXgEvoZfSeLj7zNrHhLNiuT1j3x
	 hKnV+LPaPhzZOPSKiNjeiSVvJ0KSUy/DVXv/8Ssufa41BQ/As2e95mbdUK03jNGcrJ
	 Fj5/t8PAhN2sh/02gINWNH5uMVELU3JzuvwIGaJ6dAjkKEL6RO4JHS72gkNgDttyKy
	 Y4H7YfB6t0zKhB3+UXTF3Cq/bc6r3+aCXy3TZ9v94cZLfoEkal70A2i3um88KDlvb6
	 YXwK5kFAnLIvA==
Date: Mon, 15 Sep 2025 16:01:35 +0100
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
Subject: Re: [PATCH v2 14/15] backlight: rt4831: Include
 <linux/mod_devicetable.h>
Message-ID: <aMgqT8crih7S79Oj@aspen.lan>
References: <20250715122643.137027-1-tzimmermann@suse.de>
 <20250715122643.137027-15-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715122643.137027-15-tzimmermann@suse.de>

On Tue, Jul 15, 2025 at 02:24:51PM +0200, Thomas Zimmermann wrote:
> Include <linux/mod_devicetable.h> to declare struct of_device_id.
> Avoids dependency on backlight header to include it.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

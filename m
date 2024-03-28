Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0AD537E1;
	Thu, 28 Mar 2024 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621974; cv=none; b=mjUsrrBJciztde4riB7dwr5ndp7cgcSdGn0Lz5rvSX+UHqjOxlw/hH5X0iTUvt/LPiqwoMqgpDrsszFuj2jROkyTURB0LdGJUx2ZHseGOcvdk9esVV7tTXjviggosldO9h0aOVMVIohRvS271LxLlmVTfQMB4P45smNV+8U7Lwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621974; c=relaxed/simple;
	bh=OjnZXo6Q9uDkGmIDHFIa6XgV3eDBiEPaBDR+3c4XXrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUZXsDYhgEObLAxniUN1D8J+H3P9ZbxXthib0dY1TR6PxVZ1nPeDxdUO//KnjrMfc/tF9V4VYFH5Q0YRS15FZ80s+dOf1q4YoNTP2WQyASK5f+3ho2I8/HliG0S0snq92VxzEfxlFI6SjAfRxJEgcXpc8aRItJZ7x5ux+RDy3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB90J5XA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB90J5XA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E461C433F1;
	Thu, 28 Mar 2024 10:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711621974;
	bh=OjnZXo6Q9uDkGmIDHFIa6XgV3eDBiEPaBDR+3c4XXrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MB90J5XAetTAhGkp36UhtimN7sGX8q7bMdb3bYZQhfawv/QLXsuDgqwNYuF7Ur8v4
	 HCwiH0xZGF3dCoFWXgWIJav5GXgpsPrbF2IZPP9scPq5I1nU8W8lYR4e8M7LSNF+ws
	 3lv5coUVqaI+NQcXfIPnmVckRXF+QCjsV4Iri56t8Er3/Yc4K8lVwFrvagm0UIEF24
	 OoLfjUQMKzvC3CzY3zKVf88R02Ra+WIbsjeDygI1moDWsoeqoh9j7C96gvNNjbp12H
	 eIa0yn27M8aeqrUMv2IRhviXR5JtHmxZAmhbr15cT51dWPPMEb3Mb/bFERfRLFd4UW
	 p4ZUmovLC/tOA==
Date: Thu, 28 Mar 2024 10:32:48 +0000
From: Lee Jones <lee@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de,
	andy@kernel.org, geert@linux-m68k.org, dan.carpenter@linaro.org,
	sam@ravnborg.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Immutable branch between MFD, Auxdisplay, Staging, fbdev
 and OMAP due for the v6.9 merge window
Message-ID: <20240328103248.GY13211@google.com>
References: <20240319093915.31778-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319093915.31778-1-tzimmermann@suse.de>

Enjoy!

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git ib-backlight-auxdisplay-staging-omap-v6.9

for you to fetch changes up to 4551978bb50a8d59b49629deebacd73478a8b1e1:

  backlight: Remove fb_blank from struct backlight_properties (2024-03-28 10:16:26 +0000)

----------------------------------------------------------------
Immutable branch between MFD, Auxdisplay, Staging, fbdev and OMAP due for the v6.9 merge window

----------------------------------------------------------------
Thomas Zimmermann (6):
      auxdisplay: ht16k33: Replace use of fb_blank with backlight helper
      backlight: omap1: Remove unused struct omap_backlight_config.set_power
      backlight: omap1: Replace FB_BLANK_ states with simple on/off
      fbdev: omap2/omapfb: Replace use of fb_blank with backlight helpers
      staging: fbtft: Remove reference to fb_blank
      backlight: Remove fb_blank from struct backlight_properties

 drivers/auxdisplay/ht16k33.c                       |  7 +---
 drivers/staging/fbtft/fb_ssd1351.c                 |  4 +-
 drivers/staging/fbtft/fbtft-core.c                 |  5 +--
 drivers/video/backlight/backlight.c                |  2 -
 drivers/video/backlight/mp3309c.c                  |  1 -
 drivers/video/backlight/omap1_bl.c                 | 47 +++++++++-------------
 drivers/video/fbdev/atmel_lcdfb.c                  |  1 -
 .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     |  7 +---
 .../omap2/omapfb/displays/panel-sony-acx565akm.c   | 10 +----
 include/linux/backlight.h                          | 25 +-----------
 include/linux/platform_data/omap1_bl.h             |  1 -
 11 files changed, 26 insertions(+), 84 deletions(-)

-- 
Lee Jones [李琼斯]

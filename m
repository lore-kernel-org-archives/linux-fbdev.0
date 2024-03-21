Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD0E57B;
	Thu, 21 Mar 2024 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711045266; cv=none; b=LBE+3M/EMvu7HcUi++c1jxAXuVvINK6d0PcZJ3xor3nYAmtCc91vHzhEJFUTLIsgTH7K1r0kFBCTMwpSq76+nQK6tWz6sEAOBKxkTq3ycetikGRXYvpSQIachtlzKjduqfp8RhWYlDzxBcxryHE2ZTEGmyQA0DnHsj2qirHDg7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711045266; c=relaxed/simple;
	bh=ws772LLUo2NYBpe+TOV5Ew1eplmKjtjeSFBhExfwHl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twMAtfbE7yDKg124hGIUUcD5e71uLxHBaVK11lfJjIZUZhjFncpUBqWY+URllnKcfoH/JjN5aevdP4gdchLVk/II2qdVHrldipwgi7gvup7Y5iJTzsc4dW4MFgTXq7UsNyXZUkawrvvycrcAPhO9dXSTZ9tqKJs7XPRHG9vEQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWBVo4RR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWBVo4RR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971D4C433C7;
	Thu, 21 Mar 2024 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711045265;
	bh=ws772LLUo2NYBpe+TOV5Ew1eplmKjtjeSFBhExfwHl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWBVo4RRJzUlUL7ViIUBdyWP8q1KZhV1RZopZzohV+GcH56jbISx+T5hsSsp8Z5u3
	 LakHKg2b3EqDyhuSioLa6eF7f/bnp6tLGITEM9zwyX87ms79fUcaQULjr+lZK+hDzD
	 cIz0MreCHhwPuDg96Z7KYpgoCC4pK2P69r2I1wWfZecC+6dhXNODJNrebHANafLg0G
	 NsLARGQZiQP/yVfAtRLpSg2ZiAnlKwn1P3HvwhIb/46Me+rGcZGreD0UTs17m5WB/A
	 XxbCMg9WkEPfv9uIRC+g8VOFe0ZHBiDFs2jFSD62G63B52tW9oJD6U92AASo+GWaM7
	 rZoSza4ofnEkQ==
Date: Thu, 21 Mar 2024 18:21:00 +0000
From: Lee Jones <lee@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de,
	andy@kernel.org, geert@linux-m68k.org, dan.carpenter@linaro.org,
	sam@ravnborg.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 0/6] backlight: Remove struct
 backlight_properties.fb_blank
Message-ID: <20240321182100.GJ13211@google.com>
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

On Tue, 19 Mar 2024, Thomas Zimmermann wrote:

> The field fb_blank in struct backlight_properties has been marked for
> removal. Remove it in favor of the power and state fields.
> 
> Patches 1 to 5 prepare several backlight drivers. They remove fb_blank
> or replace driver code with existing helpers.
> 
> Patch 6 removes fb_blank from backlight core and drivers. This resolves
> another dependency between backlight nad fbdev.
> 
> v2:
> - omap1: replace 'power' with 'enable'
> - clarify commit messages
> 
> Thomas Zimmermann (6):
>   auxdisplay: ht16k33: Replace use of fb_blank with backlight helper
>   backlight: omap1: Remove unused struct omap_backlight_config.set_power
>   backlight: omap1: Replace FB_BLANK_ states with simple on/off
>   fbdev: omap2/omapfb: Replace use of fb_blank with backlight helpers
>   staging: fbtft: Remove reference to fb_blank
>   backlight: Remove fb_blank from struct backlight_properties
> 
>  drivers/auxdisplay/ht16k33.c                  |  7 +--
>  drivers/staging/fbtft/fb_ssd1351.c            |  4 +-
>  drivers/staging/fbtft/fbtft-core.c            |  5 +-
>  drivers/video/backlight/backlight.c           |  2 -
>  drivers/video/backlight/mp3309c.c             |  1 -
>  drivers/video/backlight/omap1_bl.c            | 47 +++++++------------
>  drivers/video/fbdev/atmel_lcdfb.c             |  1 -
>  .../omap2/omapfb/displays/panel-dsi-cm.c      |  7 +--
>  .../omapfb/displays/panel-sony-acx565akm.c    | 10 +---
>  include/linux/backlight.h                     | 25 +---------
>  include/linux/platform_data/omap1_bl.h        |  1 -
>  11 files changed, 26 insertions(+), 84 deletions(-)

Is everyone okay with this being pushed through Backlight?

I can send out a PR to an immutable branch for others to pull from.

-- 
Lee Jones [李琼斯]

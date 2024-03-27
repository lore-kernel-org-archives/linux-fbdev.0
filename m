Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C2A13A3F7;
	Wed, 27 Mar 2024 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550504; cv=none; b=Ueiino+RMNYKb34c3W9q7HqGdfJITkyfvkBj4UJXjmuuNQ5ml+LPnTtUQTXjmZro9t6MARr3+r2YZHsNdxHMXSscv1v1qCbFXRZH5nCBWg5SLAZNRIzAn4Xq4+161PrFd+dCq4beFG1pXubF8bjhdqpHy7AqnTs6L2WV8KYZdvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550504; c=relaxed/simple;
	bh=J5RwImEVko3XXHlw0U1eaYiyHIrUU00GRqnsbrUSwkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4ukQeI0hFl1xRYPCW1dpV45lqipeq9D8YNWz9CzRv0Z9rBPeA9mBzCAWPbXSqssZfPnj3cYMirWczBeAwmZRrM9Ik8+7pZnZw+ItIVF3bAS7Kdc5vyHZeDFZbM+ovksPXJj2w94lOIjWe9xFU6BcViy15ZhqVEULABOUvpDFiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEi97qAG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEi97qAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF28C433C7;
	Wed, 27 Mar 2024 14:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711550504;
	bh=J5RwImEVko3XXHlw0U1eaYiyHIrUU00GRqnsbrUSwkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEi97qAGxxDSmBrAC7IzOexogPNDn/APGkN2rJ8itsCq9qcKcloXZLBGX8Zp7MhvS
	 uzL/ceINB5eQySXzxrejzkVO2pP2dgOUKcimaZ9/WttzaMS/S9Bf76agvM+wLteZMm
	 0LMrYtpO/2v6FS329OVSVLfisw4akytslQpZOEms1ufa9mfCaCI4Zx2VZTePxe+Nki
	 ySQYif7aCvXM4ca+9/xXRdeEM7YgV1AREFYvzmUORz/8wTnNY10cJSl0Iayh6fJbq5
	 LWwvWWFmQNGs4nlakh2UFyBvm1Mgj2XlTh3459Ib/ZsqZi/vr16EKkqpUkLF1bNc2g
	 fSP5XRbH0L4yA==
Date: Wed, 27 Mar 2024 14:41:39 +0000
From: Lee Jones <lee@kernel.org>
To: daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de,
	andy@kernel.org, geert@linux-m68k.org, dan.carpenter@linaro.org,
	sam@ravnborg.org, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 0/6] backlight: Remove struct
 backlight_properties.fb_blank
Message-ID: <20240327144139.GT13211@google.com>
References: <20240319093915.31778-1-tzimmermann@suse.de>
 <171155045756.1586093.3975287359071936779.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171155045756.1586093.3975287359071936779.b4-ty@kernel.org>

On Wed, 27 Mar 2024, Lee Jones wrote:

> On Tue, 19 Mar 2024 10:37:19 +0100, Thomas Zimmermann wrote:
> > The field fb_blank in struct backlight_properties has been marked for
> > removal. Remove it in favor of the power and state fields.
> > 
> > Patches 1 to 5 prepare several backlight drivers. They remove fb_blank
> > or replace driver code with existing helpers.
> > 
> > Patch 6 removes fb_blank from backlight core and drivers. This resolves
> > another dependency between backlight nad fbdev.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/6] auxdisplay: ht16k33: Replace use of fb_blank with backlight helper
>       commit: 7f17d16ea8b470e068bf53835bf05a995bc445db
> [2/6] backlight: omap1: Remove unused struct omap_backlight_config.set_power
>       commit: 06239b0914ad09e3f051f5f36280206f09533622
> [3/6] backlight: omap1: Replace FB_BLANK_ states with simple on/off
>       commit: c42cf539bed201cb774c65b8963faf7aaf5633f7
> [4/6] fbdev: omap2/omapfb: Replace use of fb_blank with backlight helpers
>       commit: fa10b6597b12a384357f422bb160d2833d2bba22
> [5/6] staging: fbtft: Remove reference to fb_blank
>       commit: d126df04320d4d82bc85273b8af89ea0a22565d3
> [6/6] backlight: Remove fb_blank from struct backlight_properties
>       commit: 95342cdb3f438d378f48e4db188aa217b9b0a66e

Sent for build testing.  I'll report back once complete.

-- 
Lee Jones [李琼斯]

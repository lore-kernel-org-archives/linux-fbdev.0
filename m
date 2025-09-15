Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8A321D3CC;
	Mon, 15 Sep 2025 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948471; cv=none; b=FVTVUQKMI0CxiBLQboBZbVN36lVl8vU6BUFr7RIIR6+k1QGnmDgiCdXBGOUE7nRuAvqlDQ2UkKY2DoSwk19dnYlUyiTLqBSEVOJXfbdVpXPWfFKBun2DAmH7+rQUywpNB4bbucpbecqI+eRAXGGxZNALPNt0hOBT2fCSMWOUE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948471; c=relaxed/simple;
	bh=z0vvKjrNnbzohkI8G7KdLmDE1Sza+Ghgjl1k3I/cZus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFFEEgH7f78k+jd7KbsTopSqY7uckgpbV1mvOxkTBWhgk5rO0xTxqhSDOwUMk3xZdBoDlEdMmXW5/tAHY1e3wtoKG2xaGcdhj16aB/tR+xOy9gXdbe3wSv2p7Vo+xXGrNh0R/S1LAoNIR/taaIM9SIdU6AIcaFrupm65r9u69wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4pyKPGl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4pyKPGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B2AC4CEF1;
	Mon, 15 Sep 2025 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757948471;
	bh=z0vvKjrNnbzohkI8G7KdLmDE1Sza+Ghgjl1k3I/cZus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i4pyKPGlIG0QOHu7CV1l+6FD65J4tSTt9q76gucq+drVv8UquOGGHgWeHMlY34tFl
	 bf7UIFoIZZHAtNs2JSfUIJJ+lemNb0lJhhkJBQXghrUa3+2SA3wynWu3TMeLmTm7ea
	 XARLu959v0QcwDTVRiZeZGVpT8oK8pH6luSM1CaPQIyNoISCvvKAzl5XkXsPxTcYRv
	 lJKssGhU5jDjkqP8tm/ILybIZptGFBiquoA0o/xM4gK5y7yURzu7q1TUh+WEj89wfC
	 srs5mEOVaCI0wC8+W8DrEq/3g4jpoov4VABTijNuCKUu0ywgxhA4TfNl11w2JKvzJ6
	 +kv31KGcVF/9g==
Date: Mon, 15 Sep 2025 16:01:03 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Rob Herring <robh@kernel.org>, lee@kernel.org, jingoohan1@gmail.com,
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com,
	deller@gmx.de, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
	fnkl.kernel@gmail.com, j@jannau.net, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, sven@kernel.org,
	alyssa@rosenzweig.io, neal@gompa.dev,
	support.opensource@diasemi.com, duje.mihanovic@skole.hr,
	dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 13/15] backlight: rave-sp: Include <linux/of.h> and
 <linux/mod_devicetable.h>
Message-ID: <aMgqL-ZeSkICqRih@aspen.lan>
References: <20250715122643.137027-1-tzimmermann@suse.de>
 <20250715122643.137027-14-tzimmermann@suse.de>
 <CAL_JsqKSjQy8CVohbVL50kn=o_kPVUsAUFjYvNC3mpcA7pm_Og@mail.gmail.com>
 <26a9a762-23bc-4367-9cb3-c2b081d641c6@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26a9a762-23bc-4367-9cb3-c2b081d641c6@suse.de>

On Wed, Jul 16, 2025 at 08:39:03AM +0200, Thomas Zimmermann wrote:
> Hi
>
> Am 15.07.25 um 15:34 schrieb Rob Herring:
> > On Tue, Jul 15, 2025 at 7:30 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > Include <linux/of.h> to declare struct device_node and include
> > > <linux/mod_devicetable.h> to declare struct of_device_id. Avoids
> > > dependency on backlight header to include it.
> > struct device_node should be opaque...
> >
> >          /*
> >           * If there is a phandle pointing to the device node we can
> >           * assume that another device will manage the status changes.
> >           * If not we make sure the backlight is in a consistent state.
> >           */
> >          if (!dev->of_node->phandle)
> >                  backlight_update_status(bd);
> >
> > Well, that is ugly. IMO, we should just drop the check. A DT built
> > with "-@" option will have phandle set, so that's not a reliable test.
>
> Not that I disagree, but fixing it is out of scope for this series.

This pattern appears in several places. It is used to guess whether
the initial state of the backlight should be on or off (which avoids
flickering artefacts during boot).

You won't get much argument from me about the ugliness either. However
this patch makes the presence of this logic more obvious rather than
less. On that basis I view it as moving in the right direction rather
than the wrong one and therefore:
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

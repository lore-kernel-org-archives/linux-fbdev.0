Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648832673BD
	for <linux-fbdev@vger.kernel.org>; Wed, 25 Jun 2025 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864910; cv=none; b=MxhHLE3JZOg/Xe5lZ5F3+pv75bjt/+GIjoRyl48fcfKq4FcWtFBxArnH+ENmdvu4fkLy8hUKaHA0RT0qdeZvJdOvHpyCcl5n7/nWMmwVScWU6vkUgYxaoNcAUADhWQgIzLKvHxQX7sDd6S2ad2R1CU1NDNIK3pqrd9k0uachQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864910; c=relaxed/simple;
	bh=Nv4m85cnQM5lCBdZxqzQavDUdMWkhV6xtY3hfsIHTTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLAJdkf4Q0OWYssu+8h4KZFe9gYqe8UIsrZQrO85UCsKY2IevPWIni/er4AqYmpsfqMxNSN5Vo6hSVgeDTiH0HP++YfKwMcUjFQzxPBA65eVrDzvsuV0a9nOB/WfN4MErhMKPz9/SaGemH8lspjgU53iY3VZAK0j96trRgbBM5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=a1X3H2yL; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=an/A7ULk; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="a1X3H2yL";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="an/A7ULk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1750864835; x=1751469635;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=O4nu8mefJbyYB9Pt62QRGWGhat2XpUcP+oPL1CGj9B4=;
	b=a1X3H2yL8v7P4SnvtjpcYSzYCDLMsRmv/8xxRbhh0VWKm1M+OM2Q2RBGLsZgXmCEzDEi7vEiLriV6
	 sGSExYqKFH5YT+1nyGFYLTrXMVBODPYk6WBFPvjtYJ09djFErOtpncj+qw+7nEaIBeDUBmqE1jMzDd
	 dx1v7v1JCv1MwqJibYHvCzGJyyvQkVfbgUzxwfVOa+uuuxczKKx/uuUxTr3dm1m7vjVTq9d7cCqxKm
	 72qfB6lKxOL4vW+ChH3J4WsitteUF52qUWyMOEY0VB9m7t8xQsq6mjG6mwVDLbv+F82wBUXqnEOMS8
	 L1GAn6TJt9eqNJoEp6Nguj0TnDPmNTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1750864835; x=1751469635;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=O4nu8mefJbyYB9Pt62QRGWGhat2XpUcP+oPL1CGj9B4=;
	b=an/A7ULkJGe/vIKIMyryjrdRMnV19OwHwIWB1Fkwk2Rz76GeXX5uaPCxZUoLqCMtdTqgHtUnW2uIc
	 81Zh8GgDQ==
X-HalOne-ID: ef3a532b-51d7-11f0-8665-f78b1f841584
Received: from ravnborg.org (2-105-16-150-cable.dk.customer.tdc.net [2.105.16.150])
	by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id ef3a532b-51d7-11f0-8665-f78b1f841584;
	Wed, 25 Jun 2025 15:20:34 +0000 (UTC)
Date: Wed, 25 Jun 2025 17:20:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] fbdev: remove fb_notify support
Message-ID: <20250625152033.GA183878@ravnborg.org>
References: <20250625131511.3366522-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625131511.3366522-1-arnd@kernel.org>

Hi Arnd.

I remember I stared at this code before, good to see it gone.
There is a bit more tidiying up you can do.

Also, I suggest to split it in two patches, it itches me to see the
driver specific part mixed up with the fb_notify removal.

	Sam


On Wed, Jun 25, 2025 at 03:12:22PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Commit dc2139c0aa32 ("leds: backlight trigger: Replace fb events with a
> dedicated function call") removed the FB_EVENT_BLANK notifier, and now
> the only remaining user of the FB notifier is the metronomefb driver on
> the PXA/AM200EPD board.
> 
> This was introduced in commit 922613436ae5 ("[ARM] 5200/1: am200epd: use
> fb notifiers and gpio api"), which converted it from an earlier version,
> but as far as I can tell this can never have worked because the notifier
> is called after the data it passes down is accessed.
> 
> Commit 867187821e5e ("fbdev/metronomefb: Use struct fb_info.screen_buffer")
> broke this further, and there are likely other parts of the driver that
> no longer work.
> 
> The am200epd board support itself should have also been removed long ago,
> as there are no users and it was never converted to devicetree format.
> 
> Mark the board as broken to prevent build failures and remove the now
> unused notifiers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-pxa/Kconfig            |  1 +
This is mixing things up a bit. I suggest
splitting the "depends on BROKEN" out in a dedicated patch.

>  drivers/video/fbdev/core/Makefile    |  1 -
>  drivers/video/fbdev/core/fb_notify.c | 54 ----------------------------
>  drivers/video/fbdev/core/fbmem.c     | 15 --------
>  include/linux/fb.h                   | 21 -----------
>  5 files changed, 1 insertion(+), 91 deletions(-)
>  delete mode 100644 drivers/video/fbdev/core/fb_notify.c
> 
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 10e472f4fa43..edefc953e4f9 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -69,6 +69,7 @@ choice
>  
>  config GUMSTIX_AM200EPD
>  	bool "Enable AM200EPD board support"
> +	depends on BROKEN
>  
>  config GUMSTIX_AM300EPD
>  	bool "Enable AM300EPD board support"
> diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
> index d15974759086..ac8036209501 100644
> --- a/drivers/video/fbdev/core/Makefile
> +++ b/drivers/video/fbdev/core/Makefile
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_FB_NOTIFY)           += fb_notify.o
>  obj-$(CONFIG_FB_CORE)             += fb.o
>  fb-y                              := fb_info.o \
>                                       fbmem.o fbcmap.o \
> diff --git a/drivers/video/fbdev/core/fb_notify.c b/drivers/video/fbdev/core/fb_notify.c
> deleted file mode 100644
> index 10e3b9a74adc..000000000000
> --- a/drivers/video/fbdev/core/fb_notify.c
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -/*
> - *  linux/drivers/video/fb_notify.c
> - *
> - *  Copyright (C) 2006 Antonino Daplas <adaplas@pol.net>
> - *
> - *	2001 - Documented with DocBook
> - *	- Brad Douglas <brad@neruo.com>
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file COPYING in the main directory of this archive
> - * for more details.
> - */
> -#include <linux/fb.h>
> -#include <linux/notifier.h>
> -#include <linux/export.h>
> -
> -static BLOCKING_NOTIFIER_HEAD(fb_notifier_list);
> -
> -/**
> - *	fb_register_client - register a client notifier
> - *	@nb: notifier block to callback on events
> - *
> - *	Return: 0 on success, negative error code on failure.
> - */
> -int fb_register_client(struct notifier_block *nb)
> -{
> -	return blocking_notifier_chain_register(&fb_notifier_list, nb);
> -}
> -EXPORT_SYMBOL(fb_register_client);
> -
> -/**
> - *	fb_unregister_client - unregister a client notifier
> - *	@nb: notifier block to callback on events
> - *
> - *	Return: 0 on success, negative error code on failure.
> - */
> -int fb_unregister_client(struct notifier_block *nb)
> -{
> -	return blocking_notifier_chain_unregister(&fb_notifier_list, nb);
> -}
> -EXPORT_SYMBOL(fb_unregister_client);
> -
> -/**
> - * fb_notifier_call_chain - notify clients of fb_events
> - * @val: value passed to callback
> - * @v: pointer passed to callback
> - *
> - * Return: The return value of the last notifier function
> - */
> -int fb_notifier_call_chain(unsigned long val, void *v)
> -{
> -	return blocking_notifier_call_chain(&fb_notifier_list, val, v);
> -}
> -EXPORT_SYMBOL_GPL(fb_notifier_call_chain);
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index dfcf5e4d1d4c..82ec7351e7da 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -498,14 +498,6 @@ static int do_register_framebuffer(struct fb_info *fb_info)
>  	num_registered_fb++;
>  	registered_fb[i] = fb_info;
>  
> -#ifdef CONFIG_GUMSTIX_AM200EPD
> -	{
> -		struct fb_event event;
Drop the fb_event definition, it is no longer used.

> -		event.info = fb_info;
> -		fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
Drop the define for FB_EVENT_FB_REGISTERED

> -	}
> -#endif
> -
>  	return fbcon_fb_registered(fb_info);
>  }
>  
> @@ -544,13 +536,6 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
>  	fb_destroy_modelist(&fb_info->modelist);
>  	registered_fb[fb_info->node] = NULL;
>  	num_registered_fb--;
> -#ifdef CONFIG_GUMSTIX_AM200EPD
> -	{
> -		struct fb_event event;
> -		event.info = fb_info;
> -		fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
Drop the define for FB_EVENT_FB_UNREGISTERED

> -	}
> -#endif
>  	fbcon_fb_unregistered(fb_info);
>  
>  	/* this may free fb info */
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 05cc251035da..520ad870b8b2 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -151,27 +151,6 @@ struct fb_blit_caps {
>  	u32 flags;
>  };
>  
> -#ifdef CONFIG_FB_NOTIFY

The Kconfig symbol FB_NOTIFY should be dropped as well.


> -extern int fb_register_client(struct notifier_block *nb);
Drop forward for notifier_block, last user in the file is gone.

> -extern int fb_unregister_client(struct notifier_block *nb);
> -extern int fb_notifier_call_chain(unsigned long val, void *v);
> -#else
> -static inline int fb_register_client(struct notifier_block *nb)
> -{
> -	return 0;
> -};
> -
> -static inline int fb_unregister_client(struct notifier_block *nb)
> -{
> -	return 0;
> -};
> -
> -static inline int fb_notifier_call_chain(unsigned long val, void *v)
> -{
> -	return 0;
> -};
> -#endif
> -
>  /*
>   * Pixmap structure definition
>   *
> -- 
> 2.39.5

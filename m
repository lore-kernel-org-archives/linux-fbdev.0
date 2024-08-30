Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABFF9474;
	Fri, 30 Aug 2024 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002274; cv=none; b=BBd6YPW7A7TXjMIPsUYJoXzkXdZTxw6+zYg0aLHwRQpU1/gtQ2ywrubxHC3U0IYZ8TgozqXrqWCogfPv7qIdiQiqhhSPTtxApCiOZGCKJZArjHN8TBusW4s3qjQG8g3VqrglmyUF8q5D7+1EvYzd9X9gU7IfRo5H43mneHCN6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002274; c=relaxed/simple;
	bh=f2HCDSTkTkCbIafIoSatL/nTKpy+odGB0YR86K1BIL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEjiDm4Ws86Cb6M9IHlX0taIw8ygQfaqGgMNGagzsa4LyDqtpyvwnQs+b0LlhbPtzTNa+W3rG0PkUrUblorImCUwRfPsNLB0ilEkTkMSPyaS1dL80UL3KXnl9sZd/R6ZOPUyhxw/XSgBoBbmQLBgP1bCMB99cf+sZ57UQzAOfLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UkIGCMlj; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UkIGCMlj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725002265;
	bh=f2HCDSTkTkCbIafIoSatL/nTKpy+odGB0YR86K1BIL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UkIGCMljMuRbtSoV000F3kIuCGjuuKCG5kjxKHGD4W6C/z1H839STQYJkAa3Mwkc5
	 VYEp5C8gkhkcfymnyfODbTCbrgknvwpMmjJsKBJ6vWVDWnAohNlT1Cs3r3wFsklyhA
	 rjYBvhwCfG3DeKQBO10nR7O90EslWIQzVr+ML+j4=
Date: Fri, 30 Aug 2024 09:17:45 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Helge Deller <deller@gmx.de>, Bert Karwatzki <spasswolf@web.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, Peter Jones <pjones@redhat.com>
Subject: Re: [PATCH 3/5] fbdev: Introduce devm_register_framebuffer()
Message-ID: <8b52669c-4c99-45e2-8b5e-9348e5e00f70@t-8ch.de>
References: <20240827-efifb-sysfs-v1-0-c9cc3e052180@weissschuh.net>
 <20240827-efifb-sysfs-v1-3-c9cc3e052180@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240827-efifb-sysfs-v1-3-c9cc3e052180@weissschuh.net>

Hi everybody,

On 2024-08-27 17:25:14+0000, Thomas Weißschuh wrote:
> Introduce a device-managed variant of register_framebuffer() which
> automatically unregisters the framebuffer on device destruction.
> This can simplify the error handling and resource management in drivers.

Bert reported that this series broke his framebuffer ([0], [1]).

[0] https://lore.kernel.org/lkml/20240829224124.2978-1-spasswolf@web.de/
[1] https://lore.kernel.org/lkml/20240829230438.3226-1-spasswolf@web.de/

> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  drivers/video/fbdev/core/fbmem.c | 24 ++++++++++++++++++++++++
>  include/linux/fb.h               |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 4c4ad0a86a50..d17a2daa2483 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -544,6 +544,30 @@ unregister_framebuffer(struct fb_info *fb_info)

[..]

> +/**
> + *	devm_register_framebuffer - resource-managed frame buffer device registration
> + *	@dev: device the framebuffer belongs to
> + *	@fb_info: frame buffer info structure
> + *
> + *	Registers a frame buffer device @fb_info to device @dev.
> + *
> + *	Returns negative errno on error, or zero for success.
> + *
> + */
> +int
> +devm_register_framebuffer(struct device *dev, struct fb_info *fb_info)
> +{
> +	return devm_add_action_or_reset(dev, devm_unregister_framebuffer, fb_info);
> +}
> +EXPORT_SYMBOL(devm_register_framebuffer);

This implementation is wrong, it never actually registers the
framebuffer. It should look like this:

int
devm_register_framebuffer(struct device *dev, struct fb_info *fb_info)
{
	int ret;

	ret = register_framebuffer(fb_info);
	if (ret)
		return ret;

	return devm_add_action_or_reset(dev, devm_unregister_framebuffer, fb_info);
}
EXPORT_SYMBOL(devm_register_framebuffer);

Bert, could you test this?
Helge, do you want me to resend the series, minus the original patch 1?

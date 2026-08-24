Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AE63F54C6
	for <linux-fbdev@vger.kernel.org>; Mon, 24 Aug 2026 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563044; cv=none; b=tPCNfqq094Q8d120HRDkKk7NszLAM9HF3yE33vy157srmgiCvFT4KKFusZQINxuMf84+8FwRXk4O5xXMsn5dZwhLUG4YPC5fudO/Ulfb/7g2lyBmnyI4CwqWriz6ndNMmnD1+UdLSGQPGlQPUwrf1KLPhvHeqcFTCGYly9yxe7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563044; c=relaxed/simple;
	bh=UYJh2MdQumhQG/EQROPql19ITOL7tikzrHjRGItiHmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZ1P6YUMXZ1czpeMOPXLqzpk9Y7gUY6YBUUEzdaVolnqxba7eGZ5IrfviCrcSAGH/MmNX5UOxIEg2q0uXKigwwRAWZx1GJjRABXvb04XyTEt9M1B5sUGLYB4SpXsluT1lWZiuHhkzzwVNijTIU4w1lsefJ+u8pPu2/UMRaGnyQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=akqef6Ax; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="akqef6Ax"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-476a130c138so3199855f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Aug 2026 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787563039; x=1788167839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1KWOdEO9XQSV3ds07vANFxSNMOkEh8mcBPlw2ud0ZcY=;
        b=akqef6Axy7C2vgALYbN7SAqk9ay1qLQmpaR3NmVbO320MNpuuhdsigs7nQm3Y9IUCq
         GKKutHCm1tKBciicTkLCKhTDuIPoTFwSNQoY2hQ4oRTw56amFAOq0NwUSiJTdpdsJTYX
         su0wJPzWILENU0b2iWbStIIU4lNU55K8v4hMNcgh3krHTT6LP88b26Hb+8YeiItWAKh/
         5l5N7mncNZxAPSsyM44X5fs6gc55C9yM09pZMfDolyY/URlMqHlnpIEFO5RkyfPPcmDS
         F3YHfn1+m30Oxd03Ea+Oo7shVXDrXZ9Go+uck3Ns+/P7uT+uHBUYhdfwkyzi5whvBEyh
         OGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563039; x=1788167839;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1KWOdEO9XQSV3ds07vANFxSNMOkEh8mcBPlw2ud0ZcY=;
        b=bJDgR3OE9xFm49OwfY2Wi7IdBRNdm0oqVpxcGrLke4/7PllHLIZrS2UcWXLmSSQV15
         rTrvHwOd3H/BD1YotRgkEH0YQmUGYE8lxtrIw7WL50hiiWQyX9HCVjFFrl1t8bHftRis
         2FPDhrP0uwrSBjmljXZn0HQpaaaHPPYp6ff23hAYIpL5MiRx2fPOKekBOvzp2Dc2tk4p
         N9EH6ZkVk3KtFlPAaVZUJIOz2OH1+vBqERZngx8/6OOdGvfmZ4LzAdFbtfzb1roEOurS
         Mf9qdpClmDjSw4Tgf1skcA8JYh9Wbv5R3v35X5zpxq8iMjAkML4pk5Zv2Wy/DxESAllW
         pi9Q==
X-Forwarded-Encrypted: i=1; AHgh+RpZXJjYTh6jaDy4pc5df7B5RaQ4gbzftDvpDbvZ1kcscrL1WWJo5bzCEf+VKk3ZEu+m/dKywMiLwR+JcA==@vger.kernel.org
X-Gm-Message-State: AFuF++ltoySI9qcCjiR9HrTVXKR/io5JZSmmhSBGi+juktHMsTbsy0NL
	e6NSebjLTH2C3YHaNZmRKi/ns3jX7qEljKQUwnA1WJwPoXtOSF2PowpQJVspGakS49U=
X-Gm-Gg: AR+sD10Jpf2lKZd4FaoTR+A6wAlQ1oqPR3sW66VhZa8/rA5H+z9oc9ahLGcMJA6YiHm
	ckRI3xr7m1ZdE06vzN4VGVtOsu4qYIdr9T8HLqLVN003bvlIONApeiIJDUK2ltyMm0DUL0gtb3Z
	9+8m8VBlwCHV35vHtMI8LFIwzlehQyrj+V17EOiY1D8qqTDVkfjNSBons7ucqFWtzfxhhCBAJRv
	rs+SxLrbgHeDtIjVtvWdOquQBrV8LrIDtd0jalwKISrfWIcatwgsDsW7mg1RhlQCMUVTuQTlmJC
	vqBS8VV5bbKUSrHTedtSf3pM7dlPpSfz+Cdad8eKGkS0518RIGPrCStM/cohwLEiyGeRAezDY4Y
	PJMoQZ44OiYLfAWMPq+ySi6A19pf3ddtbviPz35D2M05W1wVujApLSRvSu8t1UHo4dscYRMohna
	pR8u7ZnDVYriyW9J+CLT6pvBmkBcrLcRmBHYeXJhMWtSr7c7I5r/R1dOctWlz+z3mlvZ7rHuarH
	ot7ZsUOBb2GQ/mntcdi3Jd3BxUyqJJgm9qk2G72IBhTy9EbRPcgekdaRIsMxq9XaSyqEUbctkci
	hLuMPdet3wjNC/yLBmkil4jKL2p6upDjSGFS9hjdAEyc5hVBOGsDuWre
X-Received: by 2002:a5d:59c6:0:b0:47f:773f:2d68 with SMTP id ffacd0b85a97d-482c0ba3307mr32820982f8f.16.1787563039461;
        Mon, 24 Aug 2026 02:17:19 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9bfd2bbsm7567131f8f.18.2026.08.24.02.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 02:17:18 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:17:17 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	Andrew Davis <afd@ti.com>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 1/2] backlight: led_bl: Add devm_led_backlight_register()
 helper
Message-ID: <aowMHRSOg82oSBmV@aspen.lan>
References: <20260817170817.1933046-1-alexander.sverdlin@siemens.com>
 <20260817170817.1933046-2-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817170817.1933046-2-alexander.sverdlin@siemens.com>

On Mon, Aug 17, 2026 at 07:08:14PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> The led-backlight driver could so far only be instantiated from a
> device-tree node with the "led-backlight" compatible. This makes it
> impossible for a self-contained LED provider (e.g. a hot-pluggable I2C
> LED controller) to expose a backlight interface tied to its own
> lifetime.
>
> Factor the actual backlight registration out of the probe path into a
> shared led_bl_register() helper and export devm_led_backlight_register(),
> which registers a backlight class device driven by a single LED, without
> device tree and bound to the caller's device lifetime. The backlight
> device and the LED sysfs handover are now devres-managed, so the probe
> path shrinks and the explicit .remove callback is no longer needed.

Please can you split this patch into two pieces to make review easier.
One to introduce make the backlight device and LED sysfs handover devre
-managed and the other to introduce devm_led_backlight_register().


> diff --git a/include/linux/led_bl.h b/include/linux/led_bl.h
> new file mode 100644
> index 0000000000000..e38e4d62bf653
> --- /dev/null
> +++ b/include/linux/led_bl.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_LED_BL_H
> +#define _LINUX_LED_BL_H
> +
> +#include <linux/kconfig.h>
> +
> +struct device;
> +struct led_classdev;
> +
> +#if IS_REACHABLE(CONFIG_BACKLIGHT_LED)
> +int devm_led_backlight_register(struct device *dev, struct led_classdev *led);
> +#else
> +static inline int devm_led_backlight_register(struct device *dev,
> +					      struct led_classdev *led)
> +{
> +	return 0;

This should not return success; it has not succeeded in registering a
backlight.
> +}
> +#endif


Daniel.

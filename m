Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1143F3D3CFF
	for <linux-fbdev@vger.kernel.org>; Tue, 23 Jun 2026 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214877; cv=none; b=u9eFV+bApMwsNlstWc47DGXHRau7D+6hZajLACtqea19C2dMKTCFQcFk0dOSMl6ycZMk/1RW76Br1HHQ3k7ADa0E/CDPRrVAA5hObLwZZSi2owZqLgj8mnFTcOuMHDM+/Y9uceStvv33lSYW52dvVhP0SUrBVz8Q0GYQ3b+R6vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214877; c=relaxed/simple;
	bh=tVCetBsdG4d8Os3a0w62LGVEUED/BfzGfIpqXKQhEPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dfjt6daZxXxyL/Tjyy9ko5CWEQKGjD7xLS9RlCPc2yKp68aShqUtRoCk9gYLqSogDofBF0La6RonMqiszv7iXjSYhcR03Y0KzAoBEbtdNtzEWc7fhm0s68IUBtMRrRl1ukAMA+VXhgr3Dxn4fMwdGmczuAvH2Wx1wxM+mxejJ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=a+8qS5IH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="a+8qS5IH"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-462cdb88d01so642530f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Jun 2026 04:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782214874; x=1782819674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lOYI9zsM4oIZ1rh6HmaZ/ht7QHKafqKi5GGpopSOq5s=;
        b=a+8qS5IHSaaH8pXG5IgGduzDEEqtkeUnnIo72qtRBPobDYhkF7p3imI7VrvVapoGe0
         vvoTyoPFcuGzSOGKTtXXjXOVKWjRr8/3h0AWwS8HQQqk0LpElYEk/0/07EpQ4N+Xn/OC
         IWNeg0NI4JP9n9tt9GMsG/4TPdSnT1Ijj8YESGHeFSkRIZX+wjp1fyL5GZU05xsUXziG
         o8COHFPk2BSgIcy/TYr/CarTP2pGfng/1DU2IbW8/c64soBbYFSpmEdUw/rLy822HD4U
         dRN1NP6w+VBsIKfKNW2XSvzYvez1WjDOCyuEGqD4NimrINpafB3/1P7R0Hz4puhmE8yA
         m32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782214874; x=1782819674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOYI9zsM4oIZ1rh6HmaZ/ht7QHKafqKi5GGpopSOq5s=;
        b=ph2Ea8XRsItiCK8dH+Lre4HAQYlSfXL4Z77MvoTqtKwTPe5kyW1LCw2nFM0mNs39Ew
         5om1HiduBFVsS8mZjDjuZJcks2Xtz03vJo8YDD90YSxMYljT+I5Ac8pzH6iv9NrF0N3+
         SoAV28eqOaXRmc+XX5Kp9nNGOOw0lhVQ0OV+yvzBEGenhXSLFd5kAXmEtPqA+4NPqJYn
         KgDRROn/YTdvvuvwwigVwYb24aiHECarkCp14c3B0uE0V3Ji5ujD+t8f3eFfs4OzmER7
         7ZTWauZcdg0+BkohUtudnHPHxW7dTJZlP3dP/VhoqnmETbrQjGXorQf0H0NitaeFvJSu
         pvYA==
X-Forwarded-Encrypted: i=1; AHgh+RprN81V2+qtCjUbRWHI7APgJtv7javgxvyhXq/y0xlESsuim/VfR0DXbJT0qnmuu8iR0MWjgG5tkzRN3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrssU8WDg1kmGeG/c7AtHqi2nSsBxevRa1H3+O8oRSC/x9YX90
	iCmvVk100gVtnnJH545r6JriL/i9REo/PUiPkSMi5NL5nppb399/EgGqrXHoKoZQf5o=
X-Gm-Gg: AfdE7cn2Up9fRU42jFllbx0t+uXcuHDOy2GXr5AwKEKBBPQQlXnsho1d2kpJx4oJVD9
	UCd4bDCDWeZgERTJDR4jTjEcnaqG1LVjPAQgHqrXBTwn7PBDAQitxR2ehcAwiECHrvxs+fZhXHq
	9dLcappB94ZZCNF2I/jEBm4ATnsmlunhUbyhIp9wRnxuVLBwFkKDF7C9XCzEMw1rkGWHGR6Ln/A
	dRK9/sSdzPGfIANZ9yIMEaHUtkZMjHOeAC5kDlgOykjk0qqJPDL2/cKeQv1kKYwUMf74HdEgiDO
	/max8Jd8WzbsDVcUwlIHVvURSCsH5ChoWXo5LcnM20nMaIZRDkGp3Db1yMeXFmIat59v260bJVF
	1g90Mib+R8q3yMmWLHdl4kLGl0w6p8kBJDGIFb7P6zlgB3H8wtA4kFu7jICsO0Bs8xt2v7QfmlG
	WVBzr1f8E3I4VO40KaGPzPDavSSNxtoeiMAvmJSU/+35FJ4QxaProfh5Tv4fbZ/YiqoxKHSIFTS
	bwlEhyr0d9Vb2TrG4u9UDk5MZaMbHCtcfiM7xq3abdoIWG7PNtwwNgnt9kLVVbygJkzEGh4UA==
X-Received: by 2002:a05:6000:38c:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-46a7f0ac242mr5028245f8f.5.1782214874182;
        Tue, 23 Jun 2026 04:41:14 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4666678828dsm34329541f8f.19.2026.06.23.04.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 04:41:13 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:41:11 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"afd@ti.com" <afd@ti.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"pavel@kernel.org" <pavel@kernel.org>,
	"lee@kernel.org" <lee@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"danielt@kernel.org" <danielt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"deller@gmx.de" <deller@gmx.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] backlight: lp8864: Convert from LED to backlight
 class driver
Message-ID: <ajpw1w150SXm8Gbi@aspen.lan>
References: <20260615120353.3409035-1-alexander.sverdlin@siemens.com>
 <20260615120353.3409035-4-alexander.sverdlin@siemens.com>
 <0b39450b-559b-43d4-a1e9-bb6684691cb5@ti.com>
 <acb13aca040ab72b9e53abee3a5c8733ebc5b8dd.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acb13aca040ab72b9e53abee3a5c8733ebc5b8dd.camel@siemens.com>

On Tue, Jun 16, 2026 at 07:17:23AM +0000, Sverdlin, Alexander wrote:
> Hi Andrew!
> 
> On Mon, 2026-06-15 at 14:51 -0500, Andrew Davis wrote:
> > > Move the TI LP8864/LP8866 driver from drivers/leds/ to
> > > drivers/video/backlight/
> > 
> > Why move it? You can register a backlight device from any directory.
> 
> I'm personally fine with the driver residing in drivers/leds, it's
> just that currently there are no combined drivers there, the combined
> drivers providing both interfaces only live in video/backlight.
> 
> But if it's OK from the maintainers' perspective, it will be even
> more consistent regarding Kconfig symbol.
> 
> > > and convert it to register a backlight class
> > > device as its primary interface.
> > > 
> > 
> > What do you mean by "primary"? You should be able to register with
> > both frameworks and have the driver interop between as needed.
> 
> Well, I only meant the user's (or my own) perspective, sorry for confusion.
> 
> > > The motivation is a use case on a hot-pluggable segment of an I2C bus.
> > > The generic led-backlight driver (drivers/video/backlight/led_bl.c) is a
> > > platform driver and as such inherently non-hotpluggable.
> > 
> > That isn't strictly true, there is platform_device_{del,unregister}(), so
> > whatever your mechanism for removing the I2C device would be, the same
> > could be done to the led_bl device before then removing the I2C device.
> 
> led_bl is not really designed to act on dynamically instantiated devices,
> it's very much device-tree affine (of_count_phandle_with_args(), etc...)
> 
> > We don't want to have to move every LED driver that could possibly
> > be used as a backlight to the backlight framework, the led_bl.c
> > handles adapting LED->backlight as needed. So what you really need
> > here is to de-couple led_bl.c from DT so it can better handle dynamic
> > add/remove. Then this LED driver simply could register a "led-backlight"
> > platform driver to handle the backlight interface, and remove the
> > backlight device when it itself (the LED device) is removed.
> 
> The mechanism we have regarding hot plugging currently is just I2C bridge,
> which de-registers and registers the bridged bus. So no additional drivers
> are required, as long as I2C devices are self-contained and not glued with
> platform devices.
> 
> So bottom line is, I'd prefer to just add the backlight interface to the
> existing driver, no matter where it would live in the future.

Is there any reasion that LP8864/LP8866 is unique in appearing on a 
hotplugged I2C bus? In other words if support for dynamism is added
specifically to leds-lp8864.c rather than in led_bl.c then what will stop
the same dynamic tricks from being adde to other LED drivers?


Daniel.

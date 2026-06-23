Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13230C17D
	for <linux-fbdev@vger.kernel.org>; Tue, 23 Jun 2026 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782220684; cv=none; b=pZaxR6ruyZxkkioMJoONQc/lGI9VVvNyC2WjOPNEPgGz6yp5LvCzYQZaJ6jBIaPQD0ASTGXeqJu7p38s0bsiIDkObzsiNIV8umObj5ah/8XAUdxyng9Y3gwZDCm6FcldCQfg1E+NRM51xZuanDtxFFg32FJB38Law5uJvVdhAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782220684; c=relaxed/simple;
	bh=QWksKsu3aFjbz0U7IDFysKky5YyDvWjjH+s0LaexQxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWl7kJPq//4CffZJk32P09DuhmEyvbYjRUpaZP6tPyUNhPj9dhBp0pfJ7uiBCPlsA8iJD3KEVfICQIbXBe/5aLBLmHLEq1MQTZUEGDuaPRFEoRt/aYTNQ500utgYQPJA/4l4oAxaetDurRwY7f6rbRVVvVyo+L1HWaYfS/HvTBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=LRUJmFDC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="LRUJmFDC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b7866869so55629095e9.2
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Jun 2026 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782220681; x=1782825481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQjsOKmDv4bAeAAg8kHxPjywYyxr88XeXI1w7+vf02M=;
        b=LRUJmFDCPthifYRMfZhYIydgCNTbxhaAg+fwOLgzNj8ZVf8RkBIVX6dwaigUKzLs++
         1QbcBRqkV6/V5rIROWULa/4il6+DXssu0ODMgHHxZMNf9qSxLPLDLdR0HqRcRyHijn5r
         HjbhBzlT7dxKEPFLAqxzPbrYk/9EFXZ9fmY4XAf4Jq4rBMV8TZxZkYhfvWc7i4tPFGqB
         E51EArs9o1X93L7IHgMYpK0iV3UJ7ynnwbt7fLycxsZAIXHHA3CP5rZijioxBkz39JGX
         xgeKE+PjZ6dNBp1W4rcM/smOx5In9Y8SlpocKbsM+D8vXUrZH9aYxKitHWQcCfhHvJ8b
         I+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782220681; x=1782825481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQjsOKmDv4bAeAAg8kHxPjywYyxr88XeXI1w7+vf02M=;
        b=BUBDoPQ90L8wUGrllq1LjnpdHaA6SibZXTxaUhcXZN94E+bUOXKf5XmihaoI9M5EvR
         2Oum9gkfRJ/V8XWCwmqVR/N9p7fx4vj8m9x8SGp9RaFd2jQnUsqfkMfSqNAagKHhcA/Y
         qC6glWGhQfVhysxmhpfdLvpG5GEl8bFvQic28Fji4N+1qt9mDKBB2n+pKF47ls2i8UYl
         rTqV7P8I7XWGEJ8ANmeYWhNTBx8dedhxYLhMv2dl0urcX4IOR/Fig1ZhpTgPyuCjnibT
         yxZcR/IeUgD4tfy7hjS0j+akenBrs85E5laHWHZfGjTjgEwC7P5K4bpo5M9CQ510m4mU
         e8Kg==
X-Forwarded-Encrypted: i=1; AFNElJ+PogdTJ1kvxkKvrOGVhsQDin3GuZb5PloRaV9lJr3uxI3PLKOH1hOa0+SIPKNtaGfr1eXuRNdKQmmK5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4B4wO8XRQvOewIAAApPXPCVjVgmeeJXMSforHoNKKJLk6wHLV
	eaafJdHgR1MuvEM9EZoMDxteIjwkJjFO5xo+dqPnK+OzKgz6PaypOpim79oZkrbIivE=
X-Gm-Gg: AfdE7clgsK7S3X+FGm7owabOdt6+EhiOLkqC3Wa/6s1tg5tgNN6QynvHaXVe1cijqeG
	iGmlJwhlvI3wgWtsRUQYOww9ZVzc3whtxyRd1Crpod5hh7lHcHjspV152m5iwOWG48M/sRaJMrX
	eAdYKPACj+yxJP4boq/iGxuJ7OOrx6i76K0oha6jNG3o4cVCngqKHaS5Q8yR4Xs5mzjTukHtl4H
	skySt/DBm+yYoDzoE9pzRlDk4VPws0orKz/uyFk9Yq9r3mGLdHICEQczZCiPMHoZm+D+vibNhH6
	oXGrWITNZ31hg07009WipS/3VkWRbxkdqJmpX1Qel1SCLfqZYpbLWfWUeW4EKZpsRfV3lGa6e4E
	Nb0wk0nlERNIYWR+1qhkrcDYBNdZGZFmU2FHodm6i/sb1X5ZEqdgz0f7cc+KoZyaNoMIxNqOAiE
	I2OgHhpHU79EvOsIWSn41cqjX9VLPfeQpEMRg8yVhCNKD2Zv0buQJMJmIHeEJZQF0RxYsDkrUga
	eLu+Y8aEuCnq8WCLhZisGsUqYlkN6HlkJHrXX/Q8HD6Q3j14sdRCkpHHfXU7rnxW5w3giL21w==
X-Received: by 2002:a05:600c:1548:b0:492:39b6:5a30 with SMTP id 5b1f17b1804b1-4925b38f01bmr37906055e9.35.1782220676494;
        Tue, 23 Jun 2026 06:17:56 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c5de7sm35009927f8f.15.2026.06.23.06.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 06:17:55 -0700 (PDT)
Date: Tue, 23 Jun 2026 14:17:54 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"danielt@kernel.org" <danielt@kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] backlight: lp8864: Convert from LED to backlight
 class driver
Message-ID: <ajqHgqKsh4CpMm1I@aspen.lan>
References: <20260615120353.3409035-1-alexander.sverdlin@siemens.com>
 <20260615120353.3409035-4-alexander.sverdlin@siemens.com>
 <0b39450b-559b-43d4-a1e9-bb6684691cb5@ti.com>
 <acb13aca040ab72b9e53abee3a5c8733ebc5b8dd.camel@siemens.com>
 <ajpw1w150SXm8Gbi@aspen.lan>
 <aa34231591d2e5f848bdd74524abb4fe85123444.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa34231591d2e5f848bdd74524abb4fe85123444.camel@siemens.com>

On Tue, Jun 23, 2026 at 11:59:16AM +0000, Sverdlin, Alexander wrote:
> Hi Daniel,
> 
> On Tue, 2026-06-23 at 12:41 +0100, Daniel Thompson wrote:
> > > The mechanism we have regarding hot plugging currently is just I2C bridge,
> > > which de-registers and registers the bridged bus. So no additional drivers
> > > are required, as long as I2C devices are self-contained and not glued with
> > > platform devices.
> > > 
> > > So bottom line is, I'd prefer to just add the backlight interface to the
> > > existing driver, no matter where it would live in the future.
> > 
> > Is there any reasion that LP8864/LP8866 is unique in appearing on a 
> > hotplugged I2C bus? In other words if support for dynamism is added
> > specifically to leds-lp8864.c rather than in led_bl.c then what will stop
> > the same dynamic tricks from being adde to other LED drivers?
> 
> LP8864 is not special in this regard, not different from adp8860_bl.c,
> adp8870_bl.c or lm3639_bl.c, which would work in my application.

The most recent of these drivers adopted LED support in 2012 whilst
led_bl.c was introduced in 2020.


> So I just wanted to add currently missing backlight_device_register() to
> LP8864, but there were no such dual-API drivers under drivers/leds/ that's
> wht I started with moving LP8864 driver into drivers/video/backlight/.
> 
> led_bl.c however could only be hot-pluggable either if one actively
> creates/destroys platform device somewhere in the code programmatically
> or uses DT overlays.
> 
> Just adding backlight API to LP8864 would be much more idiomatic, I'd
> say.

Maybe.

I think I might consider the drivers above to be historical anomalies
rather than idiomatic examples.


Daniel.



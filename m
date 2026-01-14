Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C1239B493
	for <linux-fbdev@vger.kernel.org>; Wed, 14 Jan 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406020; cv=none; b=tEHShLOzbYlZkUDG9/Unr+aTDPKrcDtRsj8zClXKo4i353+vjuzS8L3HwFBZSQW5rUXQqcVd8FJis/Ay+AjP0v8Jv9PGtDMtsxYIHVgWHKNTymOD6SKQOolFBUCnmBJGp5gMpP8U5U8e/y4V1m5inye5weiDzDNcx9VKEJFdQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406020; c=relaxed/simple;
	bh=MjjY0CZe9m074IFDhBfEpVxdyYS7Z3Q8v4zhohpRutw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4Vviv8NLhNN4aNM4Dqe6jgMSrXTvMIbUggPt7fNOTiMs8joemeeeTUHTCjW6P/ZwySRwrlamfGqLSAN6TN9aaez63QV4f2JdvipzMGzT2NOqCZseDEJW9zK2H+UR9GTrC6fIEMjEx9EQb/InE5EbypJzhOME3xPaTV017ixjRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=hQOHDn7T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="hQOHDn7T"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47d493a9b96so51003135e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 14 Jan 2026 07:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768406017; x=1769010817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mrePS2BeC/5/zU5iIVNiA/HxBMqtaGmBB9n2hBMQrA0=;
        b=hQOHDn7T8PjZDNbgPW6/0eJb4z6nY8heDKKRssw5W6YsE5B3CgY+QUeaMtbG5HIozl
         BDLBuXvzh89+smKariIFQ7c90ZLHqF628Z1MqBVZ3Q0VPI2tRK1eLhvGW0OojO9/Yey5
         0xvtKFtmC/LqrRbPA6uFHC6hOnai1pCmRQ4cQxni+Ukjf1sv+M+V74u7x1+rJRu+ZEqm
         Cn67cB2aPBtozrafM2L2mXNDWC6YaMd77RDv+KdgxTi9bA3cbnjMlnHqeJ9cYxgEv2tR
         BTXWeUnO6BTE0YiKHa0DpdhBbZ0sDkFAKWi+INFckGy9OStXhLXTnm93tG7D8WZHQdU3
         ne+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406017; x=1769010817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrePS2BeC/5/zU5iIVNiA/HxBMqtaGmBB9n2hBMQrA0=;
        b=Om+inYEzasLhqVLY6etJwFjQFQ2vYQ52Zql+j7j6LC2BaQlWqc/rcWTJd2uhoCN3XR
         OjsicvJcjkGfsnh7MEPVgoFV2g3y61BhVVciuiXPMSPpluF2yA/eNwL7XslDkBYDT3hc
         1tjcHVBJ+uaGhfubJutFzlt/oSSHYkUGwWa1jLdzQx044AG8pLpnhn95zXhZtZGThMCM
         zyDCAhzi2qmSOHwmEPE6J0ZY2sq/qEyBa3kprtCVkwT70InR5pHAASZXuCcGUbXGgBwM
         xnGNUL8SbIjXDg9YpzMfoWm3sXCo6YMk4uYRULA4/ZmU0o5cao0ceaPAFHqtwk2FPv7R
         zaAg==
X-Forwarded-Encrypted: i=1; AJvYcCWhYMhlHsCgzEDAChPaiywdv7dM7x1Ow/9rOWaVY0N16tgTxVOi2x1VY3dN2hm2LjiEowoldEwSxTbcGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGVOT6kEgPqlQRmkuYqK8lYG03g8XCHrrgXC6ljs0fU8H4sVx0
	W5HKXbMk8+68268on2NDXTLbunOeHYBaVNe/8iGe8axqPkvTh7M197CJnKN7UK97bwM=
X-Gm-Gg: AY/fxX6OOWPZ4WKpowbbMcN1UOir7QgjIfMSfiGalYma9ZLIkdWiTF/WE7Flc/3Dff4
	mQtKi7QGeEt6o0CA+pE0LUj7jMCwBKVygeSV9EPPiMpvbe6KT6ZAqoLQh2cU3JxLtG5gmskOQiX
	14P0DHH0d8AOn0A1M1xZlx9q0nqpkvYYuW0OJEXcpj9wXRHMuTHaUZ0B1WhqMlBYStt9TPnPiTE
	6ilyuPo4xFijoJDv4B1XXRRI67sUtnNnq/DS3hvTjs2lEmNjSVZbzP06jaa4GrsgRxJ739ObaD9
	8OCherNLadSwFrHtcuC/9l041uhOVjqbZMaEYWUF1A+7DhL+SA1xxQNr80h/Iyg+L1WogLvTEvB
	wGVecxgINuHOQ6n42W4fvoCVbcTON4fcwXi+AZWo2FPfyea/RPA7TnBASHcR6pbstQyLfwsVmzZ
	fCvviH1kyg+o0xjU6aDMxc/YLZio3HDTPn6+yTZBjYAnBiUAlQJZfh97u/fA8XF1GRmOkRBTkcw
	LXHPXr68hJ6fw64up7+eEjINs2OWN12TOOJ2gP1rmJO1DSUArQQcENCyU+UWsRR09rtiTJR9lrm
	VLLic0A=
X-Received: by 2002:a05:600c:4515:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-47ee339455dmr35015355e9.18.1768406016823;
        Wed, 14 Jan 2026 07:53:36 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee870sm51184009f8f.36.2026.01.14.07.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:53:36 -0800 (PST)
Date: Wed, 14 Jan 2026 15:53:34 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: tessolveupstream@gmail.com
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: backlight: gpio-backlight: allow
 multiple GPIOs
Message-ID: <aWe7_hFpmO0E2sJe@aspen.lan>
References: <20260105085120.230862-1-tessolveupstream@gmail.com>
 <20260105085120.230862-2-tessolveupstream@gmail.com>
 <aVuKdAyXfWLs-WJI@aspen.lan>
 <c182df66-8503-49cf-8d1d-7da17214b843@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c182df66-8503-49cf-8d1d-7da17214b843@gmail.com>

On Tue, Jan 13, 2026 at 10:15:53AM +0530, tessolveupstream@gmail.com wrote:
>
>
> On 05-01-2026 15:25, Daniel Thompson wrote:
> > On Mon, Jan 05, 2026 at 02:21:19PM +0530, Sudarshan Shetty wrote:
> >> Update the gpio-backlight binding to support configurations that require
> >> more than one GPIO for enabling/disabling the backlight.
> >>
> >> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> >> ---
> >>  .../bindings/leds/backlight/gpio-backlight.yaml      | 12 +++++++++++-
> >>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> >> index 584030b6b0b9..1483ce4a3480 100644
> >> --- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> >> +++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> >> @@ -17,7 +17,8 @@ properties:
> >>
> >>    gpios:
> >>      description: The gpio that is used for enabling/disabling the backlight.
> >> -    maxItems: 1
> >> +    minItems: 1
> >> +    maxItems: 2
> >
> > Why 2?
> >
>
> In the current design, the LVDS panel has a single backlight that
> is controlled by two GPIOs. Initially, It described as two separate
> backlight devices using the same gpio-backlight driver, since the
> existing driver supports only one GPIO per instance.
>
> So the maintainer suggested to extend the gpio-backlight driver
> and bindings to support multiple GPIOs.
> https://lore.kernel.org/all/q63bdon55app4gb2il5e7skyc6z2amcnaiqbqlhen7arkxphtb@3jejbelji2ti/

Right. So, once we support multiple GPIOs then why limit it to 2?


Daniel.

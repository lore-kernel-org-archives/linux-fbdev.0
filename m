Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17082045BF
	for <linux-fbdev@vger.kernel.org>; Mon, 17 Mar 2025 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231660; cv=none; b=WTk/gJ81GzzGU0HMu9mTYoO5pNKsKR3qvSeGz45xy2gJ5lcGWGe0dukhz4K1j7iMRpQw9eHhaT6kelERnW/VP4LapGH3GrVcZQRYfmBzCXE0GeiqtBGSDpR1YAW7JASyOKgCWKep2KgvF+zeNeCezVFjC2uZv5zTNzhDE/weyyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231660; c=relaxed/simple;
	bh=+jPeFoGNXioGjBUoxk5UC37tXUcl6Q+Xub93zb2WEnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwQv1PW+TbC7EOCpX19ryLqxGJCkcev3jCCU2tSyDWTImK2FAi0PqVci9Sq91Sc19wpWvRxeu5KTIB6BP08s5nJEzNXFnjxtktnmr6ZuOc4jwIE6cSujBMlIR8jvPN4WHxHzv+o3Xo8M+MdUHOFxRwasVMRMDWzPSfKoG/kCp24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=d6pwUbth; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="d6pwUbth"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39727fe912cso1115596f8f.3
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Mar 2025 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742231657; x=1742836457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd/helYOE9uVmXuMlkncjSq63BGQQdsjbLjgrGPTsCU=;
        b=d6pwUbthtNFMt7WXWjtt89OHbij4hXtMwqqxWmIKUzd3LgCAG3//XUWafN2S3dOHi5
         N+iiWgjKNWN749kBqMY3lE8SEJ1VLkv1dR4s4ZwHPUob8+YS11O8bsVugew5w/WZk9Cv
         3W8RFuYw7Ra0J2r+oMApoIoNpJAJHE1JBpfqhhbU0ug4WejGaPM/6cGehGt5ooN0CoFa
         Bf7bRg5rHlRAPH2io70o9H4cpufmbUVsc0gc5wNC5377ghQ9ZstDFMo7xIChTqEn/Ng5
         0ML5keoFPSlah1VxIHM9R+bui7EbvvK0yXx4X6Pi+EzfHwOi9pf9HVYga3dDf7KADtTl
         NMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231657; x=1742836457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gd/helYOE9uVmXuMlkncjSq63BGQQdsjbLjgrGPTsCU=;
        b=otW9U/vXDNSh3vdU6GYxM4Xlz3NcJNJo7xdMmZqCiOwKFRZgKQupv9pdFlMiMXY35X
         /CIXw3AKOSVMndZH34iRh8UqRIjSznZnerQlkqswl5IvWaEjugXsnXsZZiHvz76rsviJ
         RPkaeljQhVlxWq5iPguyLaK58tjqZDWBWEupklEuwCTEDwTLcfcOEUiXl2ZbGZAlKhkg
         63rvfRzitXDmN/G/ZJnQQl3P6eba5pJPYhprHDjxDPnbruOZjr89r2wDiUT6NhJac6Oz
         7iHI404zNTWPc+WbpfaJ0W6fNOk9mQiAQYrXIClXE5/81PNhXuobdmTgo4Dq7SrT56LE
         Q4zw==
X-Forwarded-Encrypted: i=1; AJvYcCVua7oPJ1PmLaUnQovDJ8+PPInrPzcb9JZL5p5zs/ZBt8uHyEwOfKJ8u9CTmaB5wT4r34CzgdyI7r/s1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOvmcc4lk6yQR6kcDZOz86wqK3mZHFxgMS1fuKXBIjHC0s6Nfr
	EFjlgN7LfKzWB+vQ5SlCA1z2ZzUSiiIwYkiFPWrDUhUKJ9KrP82T+S/uUHSYezI=
X-Gm-Gg: ASbGncuvRIgawcNTkSxsWWsULNDgPvtocelA/xkfXhsjAkX45inhjgbOZ/JzRpeGUr8
	1CmrNUhsRMZ0ToHQxDKLUoLg8NfLlwM3xJc9uVbVYzo/AlLlIwfjM1VZGW2Mkf0EQ9+w0x9aWX6
	Z6vevdrlZWP0JNN7odLGhefa4TDkssFAjZDKQGaJDgIyS9uispH99rcQ/QSpHYm2tj2uqZex1YB
	s43/JwI+Ri5NHf0Meule2UDIQFAnw00gXlTQPxgCk5m/bUNX44bNcmoQqmYO3BVL/yOg91y9vam
	0d/PFqlk9LThH6K3VNoZpYD+Y9UHYEBsWFXl3Hfw3Gxara6gPCmm6vp993Gu2zjwaaOSajJ2eCY
	bu8osdV34Yi2tFze+Q3alcvkbxL8=
X-Google-Smtp-Source: AGHT+IEvhbfXifzPVNQRpvuqSbPm83CJxXhCqmpCNZkF+yY+5ZvGojK1oVkGDDRJOqUBKsdKLDhpeQ==
X-Received: by 2002:a05:6000:2a8:b0:391:10c5:d1c6 with SMTP id ffacd0b85a97d-3996b43e7ffmr584748f8f.2.1742231656991;
        Mon, 17 Mar 2025 10:14:16 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffc49adsm110267575e9.24.2025.03.17.10.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:14:16 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:14:14 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Lee Jones <lee@kernel.org>, pavel@ucw.cz, danielt@kernel.org,
	jingoohan1@gmail.com, deller@gmx.de, simona@ffwll.ch,
	linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 00/11] backlight, lcd, led: Remove fbdev dependencies
Message-ID: <Z9hYZnbxvJSi29d1@aspen.lan>
References: <20250306140947.580324-1-tzimmermann@suse.de>
 <20250313165151.GE3645863@google.com>
 <f3c245a4-d932-417e-a0e8-f0453c9bc2ef@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3c245a4-d932-417e-a0e8-f0453c9bc2ef@suse.de>

On Mon, Mar 17, 2025 at 09:42:11AM +0100, Thomas Zimmermann wrote:
> Hi
>
> Am 13.03.25 um 17:51 schrieb Lee Jones:
> > On Thu, 06 Mar 2025, Thomas Zimmermann wrote:
> >
> > > This series removes the remaining dependencies on fbdev from the
> > > backlight, lcd and led subsystems. Each depends on fbdev events to
> > > track display state. Make fbdev inform each subsystem via a dedicated
> > > interface instead.
> > >
> > > Patches 1 to 3 make fbdev track blank state for each display, so that
> > > backlight code doesn't have to.
> > >
> > > Patches 4 to 6 remove fbdev event handling from backlight code. Patches
> > > 7 and 8 remove fbdev event handling from lcd code and patches 9 and 10
> > > do the same for led's backlight trigger.
> > >
> > > The final patch removes the event constants from fbdev.
> > >
> > > With the series applied, the three subsystems do no longer depend on
> > > fbdev. It's also a clean up for fbdev. Fbdev used to send out a large
> > > number of events. That mechanism has been deprecated for some time and
> > > converted call to dedicated functions instead.
> > >
> > > Testing is very welcome, as I don't have the hardware to test this
> > > series.
> > >
> > > v3:
> > > - export several symbols
> > > - static-inline declare empty placeholders
> > > v2:
> > > - avoid IS_REACHABLE() in source file (Lee)
> > > - simplify several interfaces and helpers
> > > - use lock guards
> > > - initialize global lists and mutices
> > >
> > > Thomas Zimmermann (11):
> > >    fbdev: Rework fb_blank()
> > >    fbdev: Track display blanking state
> > >    fbdev: Send old blank state in FB_EVENT_BLANK
> > >    backlight: Implement fbdev tracking with blank state from event
> > >    backlight: Move blank-state handling into helper
> > >    backlight: Replace fb events with a dedicated function call
> > >    backlight: lcd: Move event handling into helpers
> > >    backlight: lcd: Replace fb events with a dedicated function call
> > >    leds: backlight trigger: Move blank-state handling into helper
> > >    leds: backlight trigger: Replace fb events with a dedicated function
> > >      call
> > >    fbdev: Remove constants of unused events
> > >
> > >   drivers/leds/trigger/ledtrig-backlight.c |  48 +++++-----
> > >   drivers/video/backlight/backlight.c      |  93 +++++--------------
> > >   drivers/video/backlight/lcd.c            | 108 +++++++++--------------
> > >   drivers/video/fbdev/core/fb_backlight.c  |  12 +++
> > >   drivers/video/fbdev/core/fb_info.c       |   1 +
> > >   drivers/video/fbdev/core/fbmem.c         |  82 ++++++++++++++---
> > >   drivers/video/fbdev/core/fbsysfs.c       |   8 +-
> > >   include/linux/backlight.h                |  22 ++---
> > >   include/linux/fb.h                       |  12 +--
> > >   include/linux/lcd.h                      |  21 ++++-
> > >   include/linux/leds.h                     |   6 ++
> > >   11 files changed, 205 insertions(+), 208 deletions(-)
> > No immediately obvious issues from the LEDs side.
> >
> > Still needs reviews from Backlight and fbdev.
>
> I'm confused. Are you not the backlight maintainer?

Lee is, yes, but this kind of comment is usually a hint that I've
been delinquent in my backlight reviews and records that he hasn't
looked at the backlight code yet ;-).

I'll get on it tomorrow!


Daniel.

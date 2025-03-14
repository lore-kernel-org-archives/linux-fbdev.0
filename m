Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732421A8401
	for <linux-fbdev@vger.kernel.org>; Fri, 14 Mar 2025 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941605; cv=none; b=bgsQQCNJ/oEvdN64tauQD9etZl7OxzQZV1L4oPc0h+7oGutkmRO8nXOrT6E/k1Hn1RECUCZcB3fbC7zdq0q5/+MxqvcEwHB9iRj7qHSOlx//mKirKU/kZo3hp1D7oULZpij7lZPdUauvf2r8BXZW513OPFmZlI0/b4I9KABnjzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941605; c=relaxed/simple;
	bh=5i8E/MG/ET8Y/f8RgRL9nj5/2/2eqNKKd+MBxazAWD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzVTgjKVAgRBlt1p6xwrMw2L9aYAXV0i8X/LtQTKOsRp++YyjY5BC11tYEa+jKkoKxsUYUuH1hlxIoc4HHif7PfetFLF1f1yziQsnLnJNCUam2X0Nl8l4mdkXlXUrF6ZjuLg8jhId+SiKR9AiIDKFlvmCIdr0QvT9ycugTOZsNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=VX7H3XTv; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VX7H3XTv"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso1901939f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Mar 2025 01:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741941602; x=1742546402; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zTD8i7ehrtWGXAGvlrD7ICGK3PvUyLJ6pHY0HnCJJW4=;
        b=VX7H3XTvtr4WB15Af/SGQVpQ5E7er5KY9WmsCUlVwiMGuur0jlMUht9KT4eEUcbjNu
         MR072FjmITNThvn3SkfqU3vMB44XVPLuZi32nzb1unXn6Eeu7UeNixztTOMFDuDKE8cU
         7lF1Mh6ERMWuSASij1GGNylKHUPiO+PTsUqjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741941602; x=1742546402;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTD8i7ehrtWGXAGvlrD7ICGK3PvUyLJ6pHY0HnCJJW4=;
        b=wboamHwMDg6bUJAeMvC6B4CA6LO59Q98tuY0CvUdw5jq0o48MQuoQfgDJSoYZKd25p
         nleWgrgbXPBg1uUFSOY7vuTBwexiBu183BsIadh2PXATrq/PW9OZTTH2FzewQ9ya3xP+
         oSWD9Ox6ExUoc/JCJH/n6Y309GkEUUohLR7x7ZJyHbDPWXlKtCpWMvyCWeszfP0F63wB
         XTX5W3vS1MbP6riQmWgUCuMc/fV1GK9BpLBmGVWC1AbSL0QR7M25Ho2fuSRDcmXO6Khw
         iGFluid8fHryaInXVfnqIudKiJfDbMiL0KOT55s55raNRXwaA0PN29+jjtYe6dg0exyc
         LNtw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ0DcwXgqAQryrw8l1cwKhDx+TP8f22FkwLZl2HVKjWqDvgyYrh2zvSlT5ltHvfhSBkmvfLgGyrEwm3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6ha5V9N44YJ5Nn4oBp72cm5ByK+D/kdV2/vCRwiNH8RDDnM7
	WfqktLMo0smmeSIiARVl/+hFuYV4r+sUMBhBzl6OFsgR1FpcJpJfVadMOPSZB0I=
X-Gm-Gg: ASbGncsRZLxm+Dw2Uy7LulUkoxOp6dK/xSweDmLj8NaSHCv1mSALTdsyxGJUgSylXh6
	tXPatZUsGTBsaBxOBamAINic3s2Exl4svfGVbp8I65u/+w8QADVlXasj0dQl86h/ZLL7q8fh4rp
	KFehnc3w7fpVJWX74+WDWH3n9Z/R1nFtLWGk0Pv4tErqSAdwNHe9unzB36LKnPEJhfZFaprhGuy
	Lc7E1REorbdGd6ySUyXmO8oEwIV4pXBfn3f00sROZBlNukZM0DpCjjk0aEdXx2Raw12jWtN72Eh
	/SP2j6yxvcUZP6akA9asP3BpkcpVOcIj5BRaAaPvokl+0YxIA/Gii+3n
X-Google-Smtp-Source: AGHT+IF3El0IcCegrk7kxsLbPhk6T5yA/RlbcCrLwdVepuvGVFRDQsO8rTnEsFvIbEpHMtRzd+Cu8w==
X-Received: by 2002:a5d:64e8:0:b0:390:df83:1f22 with SMTP id ffacd0b85a97d-395b9b10ed6mr5683819f8f.25.1741941601570;
        Fri, 14 Mar 2025 01:40:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbfa90sm9932745e9.16.2025.03.14.01.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:40:00 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:39:59 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Lee Jones <lee@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, pavel@ucw.cz,
	danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	simona@ffwll.ch, linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 00/11] backlight, lcd, led: Remove fbdev dependencies
Message-ID: <Z9PrX6Qz4io3M9xs@phenom.ffwll.local>
References: <20250306140947.580324-1-tzimmermann@suse.de>
 <20250313165151.GE3645863@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313165151.GE3645863@google.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Thu, Mar 13, 2025 at 04:51:51PM +0000, Lee Jones wrote:
> On Thu, 06 Mar 2025, Thomas Zimmermann wrote:
> 
> > This series removes the remaining dependencies on fbdev from the
> > backlight, lcd and led subsystems. Each depends on fbdev events to
> > track display state. Make fbdev inform each subsystem via a dedicated
> > interface instead.
> > 
> > Patches 1 to 3 make fbdev track blank state for each display, so that
> > backlight code doesn't have to.
> > 
> > Patches 4 to 6 remove fbdev event handling from backlight code. Patches
> > 7 and 8 remove fbdev event handling from lcd code and patches 9 and 10
> > do the same for led's backlight trigger.
> > 
> > The final patch removes the event constants from fbdev.
> > 
> > With the series applied, the three subsystems do no longer depend on
> > fbdev. It's also a clean up for fbdev. Fbdev used to send out a large
> > number of events. That mechanism has been deprecated for some time and
> > converted call to dedicated functions instead.
> > 
> > Testing is very welcome, as I don't have the hardware to test this
> > series.
> > 
> > v3:
> > - export several symbols
> > - static-inline declare empty placeholders
> > v2:
> > - avoid IS_REACHABLE() in source file (Lee)
> > - simplify several interfaces and helpers
> > - use lock guards
> > - initialize global lists and mutices
> > 
> > Thomas Zimmermann (11):
> >   fbdev: Rework fb_blank()
> >   fbdev: Track display blanking state
> >   fbdev: Send old blank state in FB_EVENT_BLANK
> >   backlight: Implement fbdev tracking with blank state from event
> >   backlight: Move blank-state handling into helper
> >   backlight: Replace fb events with a dedicated function call
> >   backlight: lcd: Move event handling into helpers
> >   backlight: lcd: Replace fb events with a dedicated function call
> >   leds: backlight trigger: Move blank-state handling into helper
> >   leds: backlight trigger: Replace fb events with a dedicated function
> >     call
> >   fbdev: Remove constants of unused events
> > 
> >  drivers/leds/trigger/ledtrig-backlight.c |  48 +++++-----
> >  drivers/video/backlight/backlight.c      |  93 +++++--------------
> >  drivers/video/backlight/lcd.c            | 108 +++++++++--------------
> >  drivers/video/fbdev/core/fb_backlight.c  |  12 +++
> >  drivers/video/fbdev/core/fb_info.c       |   1 +
> >  drivers/video/fbdev/core/fbmem.c         |  82 ++++++++++++++---
> >  drivers/video/fbdev/core/fbsysfs.c       |   8 +-
> >  include/linux/backlight.h                |  22 ++---
> >  include/linux/fb.h                       |  12 +--
> >  include/linux/lcd.h                      |  21 ++++-
> >  include/linux/leds.h                     |   6 ++
> >  11 files changed, 205 insertions(+), 208 deletions(-)
> 
> No immediately obvious issues from the LEDs side.
> 
> Still needs reviews from Backlight and fbdev.

I looked throught the series and it's a small step, but I think it's the
right direction for where we want backlight/fbdev/drm-kms to head towards
long-term. So on the series:

Acked-by: Simona Vetter <simona.vetter@ffwll.ch>

Cheers, Sima

> 
> -- 
> Lee Jones [李琼斯]

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

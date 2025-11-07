Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666592C21E4
	for <linux-fbdev@vger.kernel.org>; Fri,  7 Nov 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526965; cv=none; b=tZtSKp8N2WkJevTGgo/41QWnEBO4qJ2ztIWgaLa1jKSeO9VknL08LAqyaU4b8g9qkkINUY/JZG19/jXbF0ucIMQxymRYWA4QdAi5t0L2PRwGTOVrWlM5TDVGwEpDbcXCZDBt42WQFcR2xgHs6kVXzWrfnCWcXKJwalz2yUzy3LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526965; c=relaxed/simple;
	bh=RUD1Jd43ZASIpcsxuX1N2ssGIFWOzPtdxIFtmeCDnJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gf1euj1ggTrF3dnL/1GS8d+Qj5N4v7F8GeJzzutHd30ttKvAjlb8L/EDJzfiKcsVXNjsFK/dmMtM1VCEpDGQ+qBWgbtF0BPvaJLgSE1axvOf7dEZrjptK8TtLMkCZJVLtR3L1Xk6Xat2Ho9xd5W7ZGEy8GjshIXoTZnZHteS/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=yABQUk8U; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="yABQUk8U"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so587407f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 07 Nov 2025 06:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762526961; x=1763131761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUD1Jd43ZASIpcsxuX1N2ssGIFWOzPtdxIFtmeCDnJw=;
        b=yABQUk8Uc1TtA2DtluqrZ5DqW1jAnyQmQp6Q4nOI6qjXTbZOiifQc6yL0Oq6cnE7dD
         rseThXB9Y76pqLcOgm2hyqUOtu1hbX5/7ju1g+Q5K67iG6XmaMW476rQ4fgDYC7rPntT
         mKs10oTo/H9McJb++b9bL0BHpLjaun7V/+/sMVW364dlCfN2o7w3W8S3rBBThT2M49Fh
         uxxYMR3ce1WCbBPNpdGdjOXtgIWW1fsqXugwD3rNP9uhzxKLPj3I8NI+2XnWw7Pn2jF3
         F01kwc9IqLpXdqDJe+izWd9aKsrHV1B6uapjCLyi3EVwit/59n0vlBivEXljB8SdkO6e
         mRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526961; x=1763131761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUD1Jd43ZASIpcsxuX1N2ssGIFWOzPtdxIFtmeCDnJw=;
        b=rCZlF+3Em77mvJn0h8oMacEWPvvtfgOobDjW9WO0nYfCXl3kt9kVaMEql8gCXpVaSx
         KN349Zi3EI7BZGIOPJnvNAZvPcT2zL0Z8YtF6VMWdvEAbpfaKJ2VDmhHlGOokQy+8ySO
         0a9+Ib7qdXhcYfAeVoOXnOl8iZQOOrqf955sJCphjTbzJfnKF7W1Rbv3cuPEYs6LKemQ
         myLKFgaveFWMN6HwUN9GbOrBhmzFiDnAY1MYSExBJnMso267rOzlV+z9yXrEclCRCjEk
         NsScnRJRdaQJFo00nRWQRPHDW5rW84TNtyR7SKGBxwXlEYVXc6zP2K1VDn054A54k+tj
         PDBg==
X-Forwarded-Encrypted: i=1; AJvYcCV/MjIuXKPVhpjTO32b9Jninqs1wNOP2Vxb0siTfeykIxuj9M1oKN/qIBXD0S2QAfEmuRuA20peHFIi2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyThN+GJDRuDXsEUPHrM9S2fl1DfLMJ7xcy6CRtaTRoksb0Atse
	fpJaAEvC32ccyFVnmaw6qxsANvYAowvVd8DMPFO/1wJVKdgOeYWsUMbMprwW/Tkxcuw=
X-Gm-Gg: ASbGncsYcLa01ks3aCFCLlKQA5BROz+KQihNU9QCVib8ROyiVhwsZWsau+vYHF0v9V1
	eOHoR0bbcE6InnYHmT7FNzjnfOA5sAyGfhhZEHvODOeW8KAxYzm/kjpni/d56HMhRXgCj3lBmJP
	9TvbFg5Gob2ocHMy9L+YFy3mavl9RmbojuB+/Bd2XbNPWqFLU/yIpSg/uBSnjYQO/y0ep6GEp9I
	j1pitPLvdE+TX510cGitJ/QS/26lua5UpEJEb+7LmXYFWGX1DzIUKipQmMxBfjNjGA/ewm3n5tB
	hmxhK+yCRlV5OR6FNY/Vbf+6YjbG79I4rCxCeZIVh1Z10OQ+uRNqCtNal16JJ3c8e3wIN/kQCj6
	OFREJWrNTXRqIYr9UzljFxrvMBXxUrxdG3itmHzXybjjC535X3HWspzAiC2KznEyefQ7PuoRKVW
	vQjjz3N4L3kmQQRZ/85paJ18XBWMalRzzPDJla0PAr/AfsP5jnSvVc4MSMoKI=
X-Google-Smtp-Source: AGHT+IGVSynVCb+VhjrR6Z2aEb6MRhX4htxmgyYFU/R10GQ6nAy3fDU1kADzW8iu4OBmJz15vaN2pw==
X-Received: by 2002:a05:6000:200d:b0:427:454:43b4 with SMTP id ffacd0b85a97d-42ae5ae8448mr2952999f8f.48.1762526960292;
        Fri, 07 Nov 2025 06:49:20 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm5596030f8f.9.2025.11.07.06.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:49:19 -0800 (PST)
Date: Fri, 7 Nov 2025 14:51:15 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Lee Jones <lee@kernel.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Pengutronix <kernel@pengutronix.de>, linux-pwm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
Message-ID: <aQ4HY5Hncv1fvxVk@aspen.lan>
References: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
 <aQNRK5ksNDMMve0x@aspen.lan>
 <t6wtfnmnclnzwdpbmdcalvyf3mulmpexnryolxkygqkpx7vdwz@dqwbwvlzawrr>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <t6wtfnmnclnzwdpbmdcalvyf3mulmpexnryolxkygqkpx7vdwz@dqwbwvlzawrr>

On Fri, Nov 07, 2025 at 09:00:33AM +0100, Uwe Kleine-König wrote:
> On Thu, Oct 30, 2025 at 11:51:07AM +0000, Daniel Thompson wrote:
> > On Thu, Jul 31, 2025 at 10:47:18AM +0200, Michael Grzeschik wrote:
> > > Currently when calling pwm_apply_might_sleep in the probe routine
> > > the pwm will be configured with an not fully defined state.
> > >
> > > The duty_cycle is not yet set in that moment. There is a final
> > > backlight_update_status call that will have a properly setup state.
> > > However this change in the backlight can create a short flicker if the
> > > backlight was already preinitialised.
> > >
> > > We fix the flicker by moving the pwm_apply after the default duty_cycle
> > > can be calculated.
> > >
> > > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >
> > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
>
> I guess this tag resulted in Lee picking up the change. I wonder if you
> share my concern and who's responsibility it is now to address it.

You mean the ordering the backlight registration versus setting the
properties in the probe method?

I definitely share the concern that there's a short window where
something could request a brightness via sysfs and then have it
overwritten by the remains of the probe method. Likewise I can't see
why there would be any problem moving the call to
pwm_backlight_initial_power_state() before the backlight is registered.
Thus I'd be happy to see the backlight registered later in the probe
method.

On the other hand I don't see any problem calling
backlight_update_status() from the probe method. This is a relatively
common approach in backlight drivers to impose the initial brightness
on the hardware without needing extra code paths.
backlight_update_status() is guarded with a mutex and should be
idempotent for most drivers. Therefore it is OK even if something gets
in via sysfs and provokes an update before the probe method has started
it's own update.

In terms of who should follow up I've got no strong opinions on that.
It's worth noting that I don't own any hardware that uses a PWM
backlight so I'm not in a position to test it!


Daniel.

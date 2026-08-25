Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B0717BB21
	for <linux-fbdev@vger.kernel.org>; Tue, 25 Aug 2026 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649327; cv=none; b=Q/cZdsV0/qj8O5mUFFavE+DUHOQ56SrEJYL5wzyrLZdHyGIcCYrHabho6Y8r3sw2nL51x450I9i5IwNAnsUNFwExthg1qI9TQi3oHbIxdzfNBNGQB+MlXcxAKobVNufUAjX6SRg19NH7DKRDZlgXLj83c3clIg/xKswbxig5Tbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649327; c=relaxed/simple;
	bh=KQG7I15zl1cZ8xoz0nJUhoyELZuli5z85AXKE7Cy0D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLGy4+ehSimKPNE6DXzwhsHb2K2YEPHF7VSEGLfiMWgOk7AJbg+XXIad3vbB570mrJVYfM4blU6o1UfeNFT/3duZuf/OAXRCXtaINfFmX+Yj4LJNdK/gciElAzexR6mU1nsxamPAS6VaLIgcISRXI7q+ccTw1wkThARbANnQyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=R5ZLpaM7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="R5ZLpaM7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4998590d392so18762565e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Aug 2026 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787649324; x=1788254124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KQG7I15zl1cZ8xoz0nJUhoyELZuli5z85AXKE7Cy0D4=;
        b=R5ZLpaM70CU5oOvUDOWx3aSdVWl4WCG+c7HRNIiEwUnuZRPGb5Gi8n6St7HQtbUvjZ
         wPaLuGtd/LikNUsxHKAVYOuiC5CxGqU+moyqk71GO5z49bKCmNtBfxRYuJdUVevU0sKA
         6QJSTBexzISdRCs2gnMc4nDIGzA9DJzMvMdY8d22NK6tpAwxGK3xwIDNOSixcPfzO127
         xJuzAZAT289aXZwjFqNNKpkgSrhMFs58k/RYw/FzHRa9PvqrY1E8Sy8ZDIZyHyFatwjY
         H2HfoJ5VSv28PopiMb/+SRfxGugWW/vcCF4E7DLHLYbmk1UPMQ46LooWA9HczPKOnxHR
         EgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649324; x=1788254124;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KQG7I15zl1cZ8xoz0nJUhoyELZuli5z85AXKE7Cy0D4=;
        b=arXBuC3uxF0cW0GTD97ZlSQjzOl3KRlFagchegPVXKbzfYSziSoFaO0HJbBKyVOJhp
         wlw7Cztu5KO9pRdQDfjkIeFoGZrwyzBGZMOtRvsH8RFoHZa+ntMY0aCxexxvTckEYNvW
         1wS2WZ7g/7j+zrjU9XuEYDre3QgPMhl9YTdPTtQSe1h920dgo2TIF+4AFrEBel5sZK6R
         TAlGVyPcInKVmwpNTvHRqecrKLeOatPbnjr88KDKMYcC2ExIXNxFTwjjsgbnbQnJt4BJ
         dOp708pseXv8L0/pdvMt+CPo5r//OrRXlJ2bKNKH1JawYnT7DcAaVJacNsLZi7LUy2j5
         ZBLw==
X-Forwarded-Encrypted: i=1; AHgh+RpbKQwLDkRMUICZqhY3MytLS/9epixoSpvkYZ/dWnV6cmm9mC2vs4Ln51XLfVCxayapG2m3mth3ZflTxA==@vger.kernel.org
X-Gm-Message-State: AFuF++m6JeTiRzUC9dQPMcN2vKzroB54Z6uL7iGpHV2TuAEFOuzz/kw3
	54S+9SWG/u/ES6y00js6Vub7dCpO4PSFOPg6k2l3mlW1xt31ci70Cik+24mO9AxBYdc=
X-Gm-Gg: AR+sD10r6seLbYJ1BptkEmd1PRyAfHixadzdixByYtue8HddFOFgsjZr9sQcMO35BHV
	YsCP04FLRAHhXN37/aLt9SFzNXCY8n23C1IQPWzknwbFowB+Tfz8CnvUg83mHAnJnNVaW907rwh
	3S8GfJpFMMTAb+h1Qr8afrBiQiLeEbPwoDA/vYptJLvc9Kl+FepfWN35P1BVSMRKRYfQbRiCie0
	OkXOgcqiQzXpHNPJpNuWQ0SHama6M4aASSWphGd+R72ei1OSm+ZUQICJKehcl9zXcMFsGDd1UvS
	83b3sAQshYPPTMUZJLR0It8rjiOb1iszp96avb0gvvb7pP4HhEAyYGfajnwjGHTXNeMeleuWFd4
	hUxNgR79XdEiRPTD7UXzXOhBvWsBxkUhIZk8CVQt5j+BAc2WnWtyM/IPqsvUc/25SBFGticMx0p
	Ef5GlPOASLj5fb0j69hkmcu4uvwl59VHvtfLw/gSnZTLHuJSyUih+NVTsNP1IHWgmHxKAS1YrAL
	GyeQjnBz8N0rR0IAQdVucThC5uJaphcxGyx2c4gNKoLq5FSHWjUfJ1bXTqYTecAy5Mua4FOhOly
	tyZgVepjm2s/6a4GYHq+Uuj6XhipQ9ZbKjQfuTyfB3lyBg==
X-Received: by 2002:a05:600c:c493:b0:499:7aa7:eaa7 with SMTP id 5b1f17b1804b1-499b845c184mr414028865e9.15.1787649324060;
        Tue, 25 Aug 2026 02:15:24 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d65c326esm20415775e9.10.2026.08.25.02.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:15:22 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:15:19 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Andrew Davis <afd@ti.com>
Cc: "A. Sverdlin" <alexander.sverdlin@siemens.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: lp8864: Register a backlight device
Message-ID: <ao1dJ1Ce6qcp9USk@aspen.lan>
References: <20260817170817.1933046-1-alexander.sverdlin@siemens.com>
 <20260817170817.1933046-3-alexander.sverdlin@siemens.com>
 <aowP3K7sgXKnsonS@aspen.lan>
 <fcdc4b46-dab7-40fe-9b1e-c5c2e2ef8dd7@ti.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcdc4b46-dab7-40fe-9b1e-c5c2e2ef8dd7@ti.com>

On Mon, Aug 24, 2026 at 10:39:19AM -0500, Andrew Davis wrote:
> On 8/24/26 4:33 AM, Daniel Thompson wrote:
> > On Mon, Aug 17, 2026 at 07:08:15PM +0200, A. Sverdlin wrote:
> > > From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > >
> > > The LP8864/LP8866 is a display-cluster LED backlight driver. Expose a
> > > standard backlight class interface in addition to the LED class device,
> > > so it can be used by display/panel stacks that expect a backlight.
> > >
> > > Use the new devm_led_backlight_register() helper, which spawns a
> > > led-backlight device driven by our LED and tied to the I2C device
> > > lifetime. This keeps the driver a plain LED driver, requires no
> > > device-tree changes and remains backwards compatible with existing DTs.
> > > It is a no-op when the led-backlight support is not enabled.
> >
> > ... but when led-backlight support is enabled it will prohibit the use
> > of the LED sysfs interface.
> >
>
> The commit message states "in addition to" so both are registered still.
> The issue would be in the [1/2] patch if it disables the LED sysfs interface
> as this might be unexpected behavior to not keep both interfaces active.

Yes, led_bl disables the sysfs interface of any LED supplier(s). Note
that this is not changed by anything in the patch series ([1/2]
rearranges the code slghtlt but this has always been the case).


> > Having zero DT changes is a nice property but it seems rather fragile to
> > change the ABI the userspace must use to manipulate the LED based on
> > CONFIG_LED_BL.
> >
>
> If this was done in DT then it would also change the API userspace must
> use in a non-flexible way (DT is also considered a fixed ABI for a board).

Agreed, although it does allow an existing board not to change userspace
ABI based on a Kconfig option.


> > Is there no way to explictly configure which ABI should be used?
> >
>
> I wonder if there is a good way to have the actual use of one API cause
> the other to be disabled at runtime? So the first one used disables the
> other, but that does sound like a race.
>
> Maybe a mod config to disable the LED-BL path and keep the simple LED
> sysfs interface would be enough. Or maybe a sysfw entry so it could
> be set per-device if needed.

Mod config isn't "nice" although it might be a good enough solution for
what is probably a fairly niche issue if nothing better comes up.

I'd also note that a mod config would also allow the driver to error out
when CONFIG_LED_BL is not set (with a hint on the logs to either enable
LED_BL or set the config option) rather then the current "secret" ABI
change.


Daniel.

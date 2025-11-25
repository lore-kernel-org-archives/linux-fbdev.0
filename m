Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3913B293
	for <linux-fbdev@vger.kernel.org>; Tue, 25 Nov 2025 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070232; cv=none; b=TqGMC+IHXY4V1Qf4pl4yqeatL6W4lA7/b/CmaVtzOEIUhk+B4DQtBW2GuAR5oo2chvgnYCy6dvSc6oCFrz4FKETT+XPvq03f5o9OGCj1oqxNmbJKoA3TKzDOAYjOdPO/Ash6XhXJj6hxi5gCsX8E4QVnn/WFqxlvrNhDuW+cHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070232; c=relaxed/simple;
	bh=qoUjUBW0n/hYntU5akLq3FGKyip1eaPu2ULnov3s/M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRedC4g9x7laCg6r/Ce7ogCs4Ch03RIgyAWQWa7QEDVAhKncba/kkKwlFYo3I+lyFMMHY96dBs2VwMhf4uj1QizcpVIjbmB3VFtiFxy1LQ0g0tz8AutYegSppZId7N4yeVBIAGIc9yY6R7VF5q13TcBhRelnIU4Ro4rzuqRfG8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=xylirizr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="xylirizr"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b2dc17965so5095991f8f.3
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Nov 2025 03:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1764070229; x=1764675029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vcYZq0V9wI5Ih/VVpvXT3ha6ZvwMnj0ifXs9GGriRN4=;
        b=xylirizrbhsFnq78DnPYAnkPVJ4BO+QUoeo6oJoVD5Be0kZpHkTHGbG6yW4BMRC/qk
         nW5dNUv31XwMioS7WXtl3QWw/zuundzhlPgVbdOC1pkUuWd9GeTqbZY43oI1dpiBhjCT
         OuNR6IGXcpRBYKeadzpiyw6KYzauV+PLmANEJqgUGz5kPRvDGh2CqclXlaj/atXJ79Jh
         gS/GjFoWn/tfjVhI2O/7A3Hd3KoQg3DFxsvQaSlHb/B10rnF3wN7QcXAvgYt6Yu8r4Ze
         nhEfYvR9fJNfhYWRdZPXM6NfaHYJr45RDo5bap4i1KqNCNNHZZbIgFfLPVnxaE3PyJm4
         v4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764070229; x=1764675029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcYZq0V9wI5Ih/VVpvXT3ha6ZvwMnj0ifXs9GGriRN4=;
        b=nmqlaPBtI7PAPmzromw1aLl/eSXwxW3d97IvAeljSpAxkWtCBxmHABZkqIzbxQw6N3
         mC54qmtFN33zKalom66Qv5eSeoKphSQtp17QrAMXZZkDNfcxyN/tkoD1I+cdugGrctFk
         +zKE1XyAXLgG3ui1PG9rIrEBokX29NSWhIUzZl77TlIKW3E5MmpCrMFuLxfEiL6o6zsR
         j/u7q+6O5yiQtpqTjGusVQKwmiyZrUxqgHb181WQQboKAXKMrZNC/PT3MKfx31M4WlK/
         5W+1FQU6Gpd2N5T/9kV0KdsisslgnAa4mO3FjTkBlirODhUxyPKz/L2HpcVlRwRt4xF4
         KJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvpzHMds+7iV5jzo+B8x9HHHJRxxo4zIaRuRigzcGhY8r2KjFKwJH9uizpYnQsiP0cna9hbK2eI9ICEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt3RnlNHOevPwE+8ubk5Y+75Cp3sNIIohK4980PNBl8KXhd5dn
	praGHT5hypKac2BdSAFozdEEcCr0xXitHqNfhgsQg5Cvjx9JFkQkiNN38YI5UcNtNk7e+nwadYU
	dEmKSU+w=
X-Gm-Gg: ASbGncvBDp6iTVk81bXw7rNCIXxo+tK2hPgfKGRdrVuSCxTLMRlwabeAOXuJHYHz+sx
	pMozA+7u45NrrsxNem9pvioxfDVW82VybDYHv3GbfQ4HFyecHTffwrMC4YpEjfp/lFnRarlgThO
	Q6J1dXu+S2JD/BVABoxHS19Y7RWhesE/OuByQpPXz9k45vOHyQVO7cxMgvsnOAajWVQyg6DB93E
	GH55Fr9M/uGaM9qCSw8AOmI7ydcRXaWhct5ckqkluZuvcv6RJC1JzHGsLYx3PiIo+U1Pe39aa5J
	3c/c8OuJZPMuPwYUNUScuMRqkNV4kL0ly0Vu7pdTKkGOFDT0FxrXbEV+lgB+mnNIWn/Ii4HHqRM
	XEZj/mepzEPe4vtI9vZTZF+PTlFTfO0HIh2l3kOs3pYzI8jIeoG2br4WfH+fooHFD8256Yniokm
	VB7cuUeV2jb3qlofI843D81cnrk0QDEqPj+4MXEmxX08rJpAoIRVR4v7mkRSpm1QCFmRuJGg==
X-Google-Smtp-Source: AGHT+IEumK8b3/5kjOBvj8Oiu+dANyL2I+Rp0YSuQXsAfKV+gSoMX684uwjAqtKAsBGy6Gspp6EKyw==
X-Received: by 2002:a05:6000:1ace:b0:42b:4177:711e with SMTP id ffacd0b85a97d-42cc1d0cf97mr16706916f8f.37.1764070228512;
        Tue, 25 Nov 2025 03:30:28 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd9061sm34007441f8f.41.2025.11.25.03.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 03:30:27 -0800 (PST)
Date: Tue, 25 Nov 2025 11:34:18 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: Daniel Thompson <danielt@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Pengutronix <kernel@pengutronix.de>
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
Message-ID: <aSWUOoyusb2BJ6QA@aspen.lan>
References: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
 <f492d4d3-751c-40a3-bb93-0e1bb192cde7@sirena.org.uk>
 <aRxr_sR0ksklFsw-@aspen.lan>
 <aSVnulk0yfAd4UCx@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSVnulk0yfAd4UCx@pengutronix.de>

On Tue, Nov 25, 2025 at 09:24:26AM +0100, Michael Grzeschik wrote:
> On Tue, Nov 18, 2025 at 12:52:14PM +0000, Daniel Thompson wrote:
> > On Fri, Nov 14, 2025 at 02:09:56PM +0000, Mark Brown wrote:
> > > On Thu, Jul 31, 2025 at 10:47:18AM +0200, Michael Grzeschik wrote:
> > > > Currently when calling pwm_apply_might_sleep in the probe routine
> > > > the pwm will be configured with an not fully defined state.
> > > >
> > > > The duty_cycle is not yet set in that moment. There is a final
> > > > backlight_update_status call that will have a properly setup state.
> > > > However this change in the backlight can create a short flicker if the
> > > > backlight was already preinitialised.
> > >
> > > I'm seeing the libre.computer Renegade Elite producing warnings during
> > > boot in -next which bisect to this patch.  The warnings are:
> > >
> > > [   24.175095] input: adc-keys as /devices/platform/adc-keys/input/input1
> > > [   24.176612] ------------[ cut here ]------------
> > > [   24.177048] WARNING: CPU: 0 PID: 0 at kernel/context_tracking.c:127 ct_kernel_exit.constprop.0+0x98/0xa0
> > >
> > > ...
> > >
> > > [   24.190106] Call trace:
> > > [   24.190325]  ct_kernel_exit.constprop.0+0x98/0xa0 (P)
> > > [   24.190775]  ct_idle_enter+0x10/0x20
> > > [   24.191096]  cpuidle_enter_state+0x1fc/0x320
> > > [   24.191476]  cpuidle_enter+0x38/0x50
> > > [   24.191802]  do_idle+0x1e4/0x260
> > > [   24.192094]  cpu_startup_entry+0x34/0x3c
> > > [   24.192444]  rest_init+0xdc/0xe0
> > > [   24.192734]  console_on_rootfs+0x0/0x6c
> > > [   24.193082]  __primary_switched+0x88/0x90
> > > [   24.193445] ---[ end trace 0000000000000000 ]---
> > >
> > > which seems a little surprising but there is some console stuff there
> > > that looks relevant.
> > >
> > > Full log:
> > >
> > >     https://lava.sirena.org.uk/scheduler/job/2086528#L897
> >
> > Michael, reading these logs it looks to me like the underlying oops
> > is this backtrace (which makes a lot more sense given the code you
> > altered):
> >
> > [   24.133631] Call trace:
> > [   24.133853]  pwm_backlight_probe+0x830/0x868 [pwm_bl] (P)
> > [   24.134341]  platform_probe+0x5c/0xa4
> > [   24.134679]  really_probe+0xbc/0x2c0
> > [   24.135001]  __driver_probe_device+0x78/0x120
> > [   24.135391]  driver_probe_device+0x3c/0x154
> > [   24.135765]  __driver_attach+0x90/0x1a0
> > [   24.136111]  bus_for_each_dev+0x7c/0xdc
> > [   24.136462]  driver_attach+0x24/0x38
> > [   24.136785]  bus_add_driver+0xe4/0x208
> > [   24.137124]  driver_register+0x68/0x130
> > [   24.137468]  __platform_driver_register+0x24/0x30
> > [   24.137888]  pwm_backlight_driver_init+0x20/0x1000 [pwm_bl]
> > [   24.138389]  do_one_initcall+0x60/0x1d4
> > [   24.138735]  do_init_module+0x54/0x23c
> > [   24.139073]  load_module+0x1760/0x1cf0
> > [   24.139407]  init_module_from_file+0x88/0xcc
> > [   24.139787]  __arm64_sys_finit_module+0x1bc/0x338
> > [   24.140207]  invoke_syscall+0x48/0x104
> > [   24.140549]  el0_svc_common.constprop.0+0x40/0xe0
> > [   24.140970]  do_el0_svc+0x1c/0x28
> > [   24.141268]  el0_svc+0x34/0xec
> > [   24.141548]  el0t_64_sync_handler+0xa0/0xf0
> > [   24.141920]  el0t_64_sync+0x198/0x19c
> >
> > Should we back out the patch for now?
>
> I would be fine with that. But actually I would like to see the
> proof that without the patch, this backtrace will not trigger.
> Looking through the codepath, I could not directly find a case
> where this should happen.

I took a look at the logs Mark provided and I think the problem
is a divide-by-zero caused by calling pwm_backlight_brightness_default()
when state.period is zero.

It emerges as a BRK because the compiler recognised there is undefined
behaviour. The zero that we divide by comes from a ternary condition in
fls(). The compiler recognises one of the conditional code paths will
result in undefined behaviour so, it doesn't need to generating code for
the bad code path, it just injects a brk instruction.


> Mark, is there a way to rerun this without my patch?

I have to admit I thought this was why Mark provided a bisect log!

Anyhow, unless someone can refute the analysis above I do think we need
to pull the patch.


Daniel.

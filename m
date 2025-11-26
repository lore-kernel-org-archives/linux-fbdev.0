Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C292FF66D
	for <linux-fbdev@vger.kernel.org>; Wed, 26 Nov 2025 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764166830; cv=none; b=CaY3VMAM407ggAPcIMvJfq5jkCQdhWproVmO+AW2qQEyYk0tuBflpoq/23mXnHq0De5SoNZZ/wjyj87sDdIhrxlAp08tUnF38I0pLN72nv4Es7cmX0uiAsd/z4NIlfZ62AasmDaPSjaO2ncl0SRVZJtyz+00uFrE1vuGsvDyt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764166830; c=relaxed/simple;
	bh=kR8KCrtjkrqH0dCBDtoBNt6Co87mHfxvKHk9SsvTfbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPWmof5X2GHlqR5yEI/6FPHyU1gXmfcy56/QNomt69pOu2hURXDvUJ/ZNts0U+YYLgjh+m8MRmdYLKsoqa2FVJ7r5c9Sg1TSU6ADbwk7OSXr0yqOHL5P0YBoZG9OZaeJyX8WJnwYi9BGQIEFLA3HL3lppoa/ilJzhkbk/qdQiTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=cfWqkOAz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="cfWqkOAz"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b38693c4dso2976246f8f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Nov 2025 06:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1764166825; x=1764771625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K+mX3K4EZWXpumEvNCBx9+WunDYcwtTk4SgV9tqSlww=;
        b=cfWqkOAzIgRIvSUFk2ZXxvBtX6kFCDRmxCScKsEwEs/GRFYn151TfESN84/7yH6zHG
         mHs5ziMnku2mhDGIfMdWabn5I48clydmj/EIL0aoNFr6lqKLq2/oaAJDd8IEYjZBp5c/
         TDeX8TYXidbaGOt5dkDlSNm41tAQFMLZ5D31FfmrqzkMWDZlaZKF68ejEf4nAnaNBn1s
         0qL35hVyrbn4/hsiczDrcyBS/lpqzfg/HijqhKS004TA7ACMW2NP4M202zF4tnffR4qe
         otxi1B7cVo/9JOEDv4tYhVk4+0AK/s/eZ0YLPi+eH9UK6flufCAiryQvgFMjL0C7Jbh9
         DP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764166825; x=1764771625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+mX3K4EZWXpumEvNCBx9+WunDYcwtTk4SgV9tqSlww=;
        b=DsaUVZXMVFlH1yvnC/XeXfRph1AcJKcBHyFw79wg/i0wZi686M1UJkP/oD6oBRRz+6
         AXnB/Ilh7pjx9yqE5ec9pPGrZP/4MlLQ2ku912hWdHFzoVtVj38+wGvv2Mvu1OTKinTq
         VQqGAK20k1f/s1XzYXhK90LEI6GBf1uJiIBxmZxQr7frpXJhMUWYYbhlnGEthMWs1z2K
         +/tYL/riUixTouwYwdNzHYyu7TyLTtOp5mmw6cdwT17g86y/grkqbhan1Z2woaLG4d7C
         ofCqAxGX5E03NM8BGQ3nj+FYeeNRCvWAy3lnu9wXc+b1z5eEMt0BHPcAF2uQGzi1RDWO
         f9hA==
X-Forwarded-Encrypted: i=1; AJvYcCVrJ7QEeeZOESMU468qqsm/G9CyAU7+6LzEOd8jtBSJVs5vl2jUiH23gS0SU7MYuHZKhnjl5nc8puPr2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIb07T7uJkKP1jvfU1obnrcqqvARd7HW/wJPhf/VbQMpR7+Fbs
	SR8Ygup0/7Org+m+VNYM8hWoU/P0Y2n18RpQc9weG78fi+zvG3ukldyoUWdyQI8ZEwM=
X-Gm-Gg: ASbGncvk72KGK4R0ydZbUbawOyBcVLiYdjDiCseFMIazIPkqg6cGwsmO0KcnXG72QH/
	W2uXFaYlt6GX509ebKIrnEDrcusTqLAwHY+wMiG5KtvQT9fv2ltSSrIicp3L3hQ5c/l1Imic582
	Qruw9bPUcyw3s6ukT4JqyFhf5bo2AJ4FlrrFGLQrdm2/6vk1hwFD+msTK0o/QvVpPLAGtCvD0aM
	EXXPVyaeDFJqHRjwh0D9D1+MGGzBIsGnflBYMNavBHVDENZ+YWB3bSdwp0X2rvRVzl3iFtZ1RNP
	jvvrWRD8+bBAiDF7qOY8HyDvZ+UeuTf/3ZRRDtou8n0lCRgVCXM7Nk25DGnm7GT3/pCgtPjqScy
	3hIDb09Q3wIp5TGZK1+xbpoITetbh94kbcQP5oBS1B0CMogbXgmDpjnQVY4Z+g9Bw9h0H0yv8r+
	r5QVX+dgLlhdoiU1kyB47PZdFwRuyzGZ0setxY9AnzwzcoeZUrn0Tnf6vUut1sViYkTEfqJQ==
X-Google-Smtp-Source: AGHT+IHetDpaeSCLD158eeBfnLMa77d0GWcu9KkUU/dpWWOreiarVBFn16/gIezMUQj2z9CZm6a8yQ==
X-Received: by 2002:a05:6000:40c9:b0:42b:3806:2bb7 with SMTP id ffacd0b85a97d-42e0f1e35c2mr7360017f8f.6.1764166825367;
        Wed, 26 Nov 2025 06:20:25 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba20esm40814603f8f.37.2025.11.26.06.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 06:20:24 -0800 (PST)
Date: Wed, 26 Nov 2025 14:20:22 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Daniel Thompson <danielt@kernel.org>,
	Doug Anderson <dianders@chromium.org>, simona@ffwll.ch,
	airlied@gmail.com, alexander.deucher@amd.com,
	christian.koenig@amd.com, lyude@redhat.com, dakr@kernel.org,
	deller@gmx.de, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com, jason.wessel@windriver.com,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nir Lichtman <nir@lichtman.org>
Subject: Re: [PATCH 0/5] drm: Remove remaining support for kdb
Message-ID: <aScMprMh6Eh4JU5D@aspen.lan>
References: <20251125130634.1080966-1-tzimmermann@suse.de>
 <CAD=FV=X_-t2AF5osp7Hamoe7WYE_2YWJZCaPaOj=9seSbnwwVA@mail.gmail.com>
 <aSbwWLTLe0bMhOKV@aspen.lan>
 <054f60ca-b898-488f-81f4-14eed0a1360b@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <054f60ca-b898-488f-81f4-14eed0a1360b@suse.de>

On Wed, Nov 26, 2025 at 02:32:32PM +0100, Thomas Zimmermann wrote:
> Hi
>
> Am 26.11.25 um 13:19 schrieb Daniel Thompson:
> > On Tue, Nov 25, 2025 at 07:26:33AM -0800, Doug Anderson wrote:
> > > On Tue, Nov 25, 2025 at 5:06 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > > <snip>
> > > > Therefore remove the remaining support for kdb from the DRM drivers
> > > > and from DRM fbdev emulation. Also remove the hooks from fbdev, as
> > > > there are no fbdev drivers with kdb support.
> > > >
> > > > If we ever want to address kdb support within DRM drivers, a place to
> > > > start would be the scanout buffers used by DRM's panic screen. These
> > > > use the current display mode. They can be written and flushed without
> > > > mode setting involved.
> > > >
> > > > Note: kdb over serial lines is not affected by this series and continues
> > > > to work as before.
> > > >
> > > > Thomas Zimmermann (5):
> > > >    drm/amdgpu: Do not implement mode_set_base_atomic callback
> > > >    drm/nouveau: Do not implement mode_set_base_atomic callback
> > > >    drm/radeon: Do not implement mode_set_base_atomic callback
> > > >    drm/fbdev-helper: Remove drm_fb_helper_debug_enter/_leave()
> > > >    fbcon: Remove fb_debug_enter/_leave from struct fb_ops
> > > Personally, I've never worked with kdb over anything other than
> > > serial, so this won't bother any of my normal workflows. That being
> > > said, at least as of a year ago someone on the lists was talking about
> > > using kdb with a keyboard and (presumably) a display. You can see a
> > > thread here:
> > >
> > > http://lore.kernel.org/r/20241031192350.GA26688@lichtman.org
> > >
> > > Daniel may also have comments here?
> > TL;DR - I'm pretty relaxed about these changes... but I'd like
> >          to know how to test the changes.
> >
> > Like Doug I only really use kdb via serial but, since I'm maintain
> > the thing I do occasionally test kdb works on the qemu console. I don't
> > do it very often though because it's a manual test!
> >
> > I'd assume that will still work since it won't involve any of the
> > drivers above. I'm afraid I can't double check that since patch 4
> > doesn't apply cleanly in v6.18-rc7 (nor to linux-next... and neither
> > does the base-commit appear in linux-next).
>
> To test its effects, ignore this series and simply clear the two calbacks at
> [1]. This is where the debugger invokes fbcon. The series removes their
> implementation in the final patch.
>
> [1] https://elixir.bootlin.com/linux/v6.17.9/source/drivers/video/fbdev/core/fbcon.c#L3202

Thanks. Explanation in original cover letter was great and there's
certainly been no harm to QEMU.

Acked-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9C239E7F
	for <linux-fbdev@vger.kernel.org>; Tue, 25 Nov 2025 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764084415; cv=none; b=NNvfAEWMhng/pJE95Sjg3W35OfuHFRftzbceaE6riYL92mwyjmd9/vIQtrr8yjHT9XzFWH7c+eY+Svh46Kscixs4YKg7uYtPP20U1TuYbxc2tD8Wa1Jvf0DeCVniWDZ7BAV+TMeBdRMapTzdWmfMo/xsmAVRAcRiapQlIHW/SLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764084415; c=relaxed/simple;
	bh=GGkXuVhW5d2HmPdrO7UtjfY83b3fGHQxRBrk96HIXmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEk50BJbVQBuL+AaGQ7VELG60FB5azjm80IxHoBE4HPeE/qQ5+ADotMu4MXS1GPcOrbNab08cpSpH88FRBl26x2yvPQz7TtSRFnaY5DG1KRH8ZLpad/gSRQKzEoGwpzE2r/zOhYNgXxixdJnjLRI3SmVjlIv12O5CD26uHVHrG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JAsgFYDO; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JAsgFYDO"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso1801664a12.1
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Nov 2025 07:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764084408; x=1764689208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCZdld6CYrWFXkrUxJ5abCqUL/Pa1DX9edqJLOysax8=;
        b=JAsgFYDONJi0LlweG6iYd3F1gd8i1v/my7WTPmRH2CqGu83MSDeYYQMt62ANSwQ9KK
         pLLv8uALpTMIJfimlrkRDGx3feKTiPcujDrHsQ8geVED9ekJ45SKzkP08adbmL6hZbfo
         ED2cmn9IrHz0SaYzg9sSoesUbqo7uRToXEFgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764084408; x=1764689208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wCZdld6CYrWFXkrUxJ5abCqUL/Pa1DX9edqJLOysax8=;
        b=q3k6g6n1Xeu6EqVTJs3Im3aJFhUgkiU89qdG7JPgHud3JyOKuBqeLmnT0Vc6sdc0em
         lk2d3+GUaKrin9AgxX6mUKrDRVAwJLzkHbLRjzj+LhAKemCnI9X5GPawdiXu3CjfiioT
         ZXYGp2od+Vfns9KCKKx0fBCEFPGzkqUvs/L0S3r2uKgl4Qg+53EhmaX1odZlr35iZlq1
         30eTZIidHi46IcKZ+m7EmqkoIgwg3JS7XKouN0fNJwW1VU+DJM0eTqY1mLFWVKZTFM8B
         SCZgeWk1olE/ZLHJVU6Ei3/8sndI2qzhyPZjP1mFi7qaMobj07GtYLEvqgSUEN8lNED5
         6o6A==
X-Forwarded-Encrypted: i=1; AJvYcCVQFhmzo+98z8HlioHhP79GoyzsmsUPYWv4kToyicHYoMOoNWZ/j3GfFQAfUMSZ1aanAO37IJIotJOTUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsC4a9AyLXOtULh9B7MynvAOurNyFh8a8PeUH1/i9+ymk+S/+W
	Ra/Lxe/H9Gj21csIx/fAcjW5v86SR+2MujnB4IOxHmDgf4fPEZfNjRRa3wnEYKtoqxL9h6+uFHR
	I+6PBwbw8
X-Gm-Gg: ASbGncsg7JWCDZKqBBm2JXM6igUB/xnWb1ry5bV0EMzYbpWf4XgDn8x7lR04zeNqBmE
	iRhUlKOXtkRYSHQ7S6DnsBi6NOunT7qHxN4yJj9R0c7/y0qe25fEDzgAen3fnx5KAQ6h72JGtUR
	pSluYCN8oOa5HC8iXktmrtZa1sfYs7hUyTBkOGp5LwKQ7mXAEz09pVP7sUcw509WXlEjdK9K1Iq
	IL1jq7T8JavXs4gkVl4aBtNY3nWfO3p1wg6BYEpZuTXpr+2fryhtZhG7q/vQe03Ve1a+BkofZ6m
	Ld1nQPvbLebRsrPl2uDjsDZ1miEu06aDpAcUXCcImXVGYplJe2tX50L2C1b0NnkpfRMkSMlYOEf
	qQ9DpiUUJc+D7j+hSFsQ3B3mNbHNUliMtFx5rkjHwBrCWQmmJMatcJtRk9KFD3wOJp+2gitHvHf
	AQCLS+ZxFDuev3AyE8ol8Qh5+TMcAfxJKHv9XyJWkC0G3XaRcGQw==
X-Google-Smtp-Source: AGHT+IGxvnPQpGwKGTH7P6olnM5sUsWp4PRdrYT6yRq0O2abxpmmoHkBMAOvWgjWV1yiFP7xiszUaQ==
X-Received: by 2002:a05:6402:1e96:b0:640:b7f1:1ce0 with SMTP id 4fb4d7f45d1cf-645eb2aab86mr2832840a12.23.1764084407533;
        Tue, 25 Nov 2025 07:26:47 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363aca03sm16537436a12.3.2025.11.25.07.26.46
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 07:26:46 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so3503994f8f.3
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Nov 2025 07:26:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtDoY74go/sBYKSgVi6lp/sF7QIIW2295rtUUfy/xpdYYrSlksrwy3l1lhmjXkLye8/OF/MT2MCaFHmA==@vger.kernel.org
X-Received: by 2002:a05:6000:381:b0:42b:3ad7:fdd3 with SMTP id
 ffacd0b85a97d-42e0f21e953mr3395597f8f.18.1764084405547; Tue, 25 Nov 2025
 07:26:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125130634.1080966-1-tzimmermann@suse.de>
In-Reply-To: <20251125130634.1080966-1-tzimmermann@suse.de>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 25 Nov 2025 07:26:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X_-t2AF5osp7Hamoe7WYE_2YWJZCaPaOj=9seSbnwwVA@mail.gmail.com>
X-Gm-Features: AWmQ_bldhiBpRCqVYkj0GufunmE0LiqT8gw4vCTv4PiT8j1h28du9Cx4NWXFEj8
Message-ID: <CAD=FV=X_-t2AF5osp7Hamoe7WYE_2YWJZCaPaOj=9seSbnwwVA@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm: Remove remaining support for kdb
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, airlied@gmail.com, alexander.deucher@amd.com, 
	christian.koenig@amd.com, lyude@redhat.com, dakr@kernel.org, deller@gmx.de, 
	mripard@kernel.org, maarten.lankhorst@linux.intel.com, 
	jason.wessel@windriver.com, danielt@kernel.org, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nir Lichtman <nir@lichtman.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 25, 2025 at 5:06=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Remove the rest of the kbd support from DRM. Driver support has been
> broken for years without anyone complaining.
>
> Kdb cannot use regular DRM mode setting, so DRM drivers have to
> implement an additional hook to make it work (in theory). As outlined
> by Sima in commit 9c79e0b1d096 ("drm/fb-helper: Give up on kgdb for
> atomic drivers") from 2017, kdb is not compatible with DRM atomic mode
> setting. Non-atomic mode setting meanwhile has become rare.
>
> Only 3 DRM drivers implement the hooks for kdb support. Amdgpu and
> nouveau use non-atomic mode setting on older devices. But both drivers
> have switched to generic fbdev emulation, which isn't compatible with
> kdb. Radeon still runs kdb, but it doesn't work in practice. See the
> commits in this series for details
>
> Therefore remove the remaining support for kdb from the DRM drivers
> and from DRM fbdev emulation. Also remove the hooks from fbdev, as
> there are no fbdev drivers with kdb support.
>
> If we ever want to address kdb support within DRM drivers, a place to
> start would be the scanout buffers used by DRM's panic screen. These
> use the current display mode. They can be written and flushed without
> mode setting involved.
>
> Note: kdb over serial lines is not affected by this series and continues
> to work as before.
>
> Thomas Zimmermann (5):
>   drm/amdgpu: Do not implement mode_set_base_atomic callback
>   drm/nouveau: Do not implement mode_set_base_atomic callback
>   drm/radeon: Do not implement mode_set_base_atomic callback
>   drm/fbdev-helper: Remove drm_fb_helper_debug_enter/_leave()
>   fbcon: Remove fb_debug_enter/_leave from struct fb_ops

Personally, I've never worked with kdb over anything other than
serial, so this won't bother any of my normal workflows. That being
said, at least as of a year ago someone on the lists was talking about
using kdb with a keyboard and (presumably) a display. You can see a
thread here:

http://lore.kernel.org/r/20241031192350.GA26688@lichtman.org

Daniel may also have comments here?

-Doug

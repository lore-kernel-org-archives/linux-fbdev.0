Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E4E30FC03
	for <linux-fbdev@vger.kernel.org>; Sat,  1 Aug 2026 22:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621735; cv=pass; b=i1dGB5DBYcQ0C14ZMNhVFpPJlqYMdRRWVr1J/wS9zGQ6TibOWrpmKRNqn8hUcdipPZYgJkxF+/Kj6YwtOYuNp32cEJ9IgPZvcHr+qSb62eoA+heHtcLUedjghbE7E6TD+tyWYe4NJDOlofO5eePIgBwb08GxEa6DLCU+dV/P+YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621735; c=relaxed/simple;
	bh=mRPnZZvS2qFMF4MYzT26qlGn6HblvmPRKe4fqm9r0Zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PX4RzkFKEe6Jmw5kpRHQcgEIuYWLQOBE8mwC+KKJTD1Y784i0dqyrcN8LbaoeAkTHYoyLfCJX0ORrou6NjMHxc9T4zzKRDgbBFvd7Du5jBUYmq9RxDgwjKSgk0ay1ZwEOZwqCsHBpuq6jeinHAhQvXYbYPcbTKAU10InsqvayXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azhtwLQT; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azhtwLQT"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-698acd36d67so3757937a12.0
        for <linux-fbdev@vger.kernel.org>; Sat, 01 Aug 2026 15:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785621730; cv=none;
        d=google.com; s=arc-20260327;
        b=QKO6OIZQEpWppa2DbtHsr9puL4539fZncEjgKQzbjeHlnt4Yi0WL5eYjl1uHtrwhMF
         f1sWEyiXMSacysMuHiAwmNxkgcikcR14BCxvE7WNHErZ9HegkWoCzGLTbaUUvqpqjOZO
         Cd1AHEsu2MiJvUtGTHT2tOpnxeHOIoYk8SjrNCJWLL/G80TXTiMbwv90kYTkrBwqwE9P
         xchZRGZKtdUaH7CjsrYfdY2Y9/0hOXY1ZXd19rtFYxa7ePEgAecLPeqL0+JPNvRMbJJ4
         9fRTPzy4iiR7Tnm3YtbJ3J5G60wjJkBffZmaXetN519qB2jqfTls+8saZH/lXHC77iBF
         Lfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mRPnZZvS2qFMF4MYzT26qlGn6HblvmPRKe4fqm9r0Zk=;
        fh=QzTuoCTz6/PFbi+wWxN0EhE8fIrVqvqttmKEts5DLks=;
        b=U7La45noMT9YaBmtLpYUN8KCLgjServnn9BGaaBGkydJQXd2lpqOSFD/ptUjK4kfiu
         F6L53INfQ/y+Dyb+buC9pXp+c1mRq4dN3c9iEZ32gAJh/Ys4Di1XdoR1kOdUo39cnUBj
         J9arWHS2KIG/EqcF20aaOu5YNCB4OTD9dClTgoxEVwJCt3PmOjNRm42FUHaQEm6kxhF6
         wOZHlyT3bsEnQuyFdMy25jgi1n5JH1tyOOXP6I/cDrE9d1cMAoIqHXUl5L0zSJPt6lLz
         secV6nF/CW2EYOKjhvSinaT+DJ6BRZ51oNRofZofqW/eo4dRWtbf1IpL//ELcip68bB+
         L2qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621730; x=1786226530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mRPnZZvS2qFMF4MYzT26qlGn6HblvmPRKe4fqm9r0Zk=;
        b=azhtwLQTMEO5+BlV41w1gHvonWDe1ABeivKg697/1yilFA592LJRW8gEUCc2Kpi/oZ
         RsirJmHqMGTlRddLiKftG1cyXojtQgHWdt7W9naAujN71T4UdOy+KiAUEtbXdZpwvUON
         2qgYWkDmUGhHV1DTbciIEPDNWmIzEE6W195SRY3UwO6d/By/6zUd3ib8Iru3W3cXBDNi
         d/2dfTIYcVvqtU2X3PtTtzemRA3D/fPvJ/EUTOLAyb9rnUmc1ad8lEWdi07FoV5fCkuZ
         pmLR2V4+ZuYlu6tDLr0drITrS9t8ffy41peTCw+SctGOrxXUVCKII/v7oLM2ffurB+L7
         lCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621730; x=1786226530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mRPnZZvS2qFMF4MYzT26qlGn6HblvmPRKe4fqm9r0Zk=;
        b=lfjDLtR0SMN6cIaUP9U7MxzGz6um33Nyd13DDFsO+bTtZ25bNcv8JWKpRCPOxAGNgy
         94rxCcP1Ggt+jLk3WsO42i+YiPGd7+DV+38XTDG+iU2aKb2q7AqNV04R7DnKDwmfv1mU
         KbFWJuJhArAHX9EZyOQC6JD7HCJL47IBtMK0HOAxMqbTSGykTMl9x7U7U00UQQIlpDNP
         eUphqJXCVigkkEC5oM/+G1teiaiM2dt7goC0KTD2HiXDawv0Z0BuBqdFN+PP+fHkhnWj
         +HtGQMORLxQhl5gJ/OSLkqef8bAMXyFtI/BwT6OMSsJiOB38R4u/UJuPbeGJhy3b54Ok
         PVVw==
X-Forwarded-Encrypted: i=1; AHgh+RqghJ26OTipTlwIbVSk6gNnSSJGxo+J1/ZaRCTPE49YXEuUKSc0uGMvZs3eGTvVuW+2SciRcyNeEatttg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2EGpPpI7P6acfVujwpH3L4Hwdu26QiUTsEdpVPpRciUEAeG6N
	Ao40Eav/CGUPDRAsszq3QF8tpQmbEbFjtKrnSGKPe1J+hKp6O1dUf+oGRsliXKSYXZGe06gruYn
	nFQB3uo59nTZUmpRZV8fq/PwzImxJpaU=
X-Gm-Gg: AR+sD11FebuYrB0BO6RoK5E97Po9JNLhU1muOkbduMqIqzE9m9JpFwyLTCFtgpVXfDy
	vAna+V2s5MXSONxWUX1DKJfltEEjCWcBAomBl3TIegRRw/I18uhjQnIA6vi09h19IQY7VP3rWOD
	Ism5hAqnkedrHCOSK6ITkHFv0pG3qcMiuRKvvITIDe+DRAIPjh9qV/+zZD+jErM7sgCLxrjBrWS
	i6v09rIEH944X46L9MO7+z8WPqnT73OhnwAR0H68epvK+oFNL/Bd0/1NuU3RHzWsw1EJnxo/GPo
	4cIYqxKqEtSdB2jMKFBh/mXLIqnCG2U9tbk8ZiAQIi0=
X-Received: by 2002:a05:6402:a0c5:b0:6a0:a560:f6d with SMTP id
 4fb4d7f45d1cf-6a0a7c5ef88mr3046152a12.6.1785621730054; Sat, 01 Aug 2026
 15:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
In-Reply-To: <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Sun, 2 Aug 2026 00:01:58 +0200
X-Gm-Features: AUfX_mwycUF1fY8pRphTmL8dbgwqxDow6kFrZA_PElLtzrxC-GpVrweyge4UTDw
Message-ID: <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: Helge Deller <deller@gmx.de>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig wrote:
> My 0.02=E2=82=AC: Usually you want to use the display using drm and not f=
b once
> the machine is fully booted. If you're using fb during boot to display a
> logo, it's hardly possible to switch to drm later in the boot process
> without flicker.
>
> So my recommendation for your usecase is to not use the kernel boot logo
> stuff, but something like https://github.com/pengutronix/platsch.

Thanks for the pointer, I did not know platsch and it looks like a good
fit for the problem it solves. It does not solve mine, though, and I
think the reason is worth spelling out, because it is not about how the
image gets drawn but about when.

These are industrial units, and the requirement is time to first pixel
after power is applied. If the panel stays dark for more than a moment
the unit reads as dead, and that is a support call. Anything running in
userspace is by construction later than the kernel: it needs the kernel
booted, the rootfs mounted and init far enough along to exec it. I can
measure the exact difference on our hardware if that is useful for the
discussion.

We do already paint a BMP from U-Boot, which is as early as we can
possibly be. The problem is the gap that follows: once the display
driver probes, the panel is cleared, and nothing puts anything back
until userspace is running. Moving the logo further out into userspace
widens that gap rather than closing it. The kernel boot logo is what
fills it, and that is the whole reason this series exists.

For completeness, since it is the usual answer to the U-Boot handover
problem: a simple-framebuffer node plus simpledrm does keep the
bootloader image on screen. It moves the gap rather than removing it,
though, because the real driver still has to take over at some point,
and it makes the logo a property of the bootloader instead of the board
description. The two are complementary rather than alternatives:
simpledrm covers up to the driver handover, the boot logo covers from
there.

> If you're using fb during boot to display a logo, it's hardly possible
> to switch to drm later in the boot process without flicker.

You are right in the general case, but I should be precise about what
happens here, because there is no fbdev to DRM switch on this hardware.
The display driver is tilcdc, which is a DRM driver; the logo ends up in
the fbdev emulation that drm_fb_helper provides, so DRM is scanning out
from the first pixel. Userspace then takes DRM over directly. The
transition that remains is the same one any solution has when the
application starts.

> Max, is this a viable option for your usecase?

Not for the reason above, no. Let me also be explicit about something
the cover letter only mentions in passing, because it is directly
relevant to Uwe's point and I would rather raise it myself.

This series does not draw anything anywhere new. It only teaches the
existing fbdev logo code where the image may come from: a device tree
node instead of a built-in PPM. With CONFIG_FRAMEBUFFER_CONSOLE the
drawing is still done by fbcon, exactly as it is today.

The piece that matters for a product with no text console is a separate
two patch series I have deliberately not posted yet. It exports a
fb_draw_logo() helper from fbdev and calls it from drm_fb_helper when
fbcon is not built in. I am aware that is pushing against the direction
fbdev dependencies are being removed from DRM, which is precisely why I
kept it out of this series: I did not want that discussion to decide the
fate of the binding.

So the honest summary of where I stand: if the device tree part is
acceptable I will post the drawing part separately to dri-devel and let
it be judged on its own merits. If the conclusion there is that DRM
should grow its own way to put an image on screen before userspace
exists, rather than reaching into fbdev, I would rather help build that
than carry a hook downstream forever. What I cannot do is wait for
userspace.

Thanks both for looking at this,
Max

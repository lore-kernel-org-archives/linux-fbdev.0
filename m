Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66E634041C
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Aug 2026 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785711404; cv=pass; b=E/FZoCU5uB3L2mzP22Cxehh6BUHK2wcoYknYdQlUSh0UvlCW8IXOCMbgVwUD4grzqQwN3BXnVIbA243LEna93fHFB5qLL3iZGOfRANqRWMkWV0ppMZnBqt6uPY6LmbminWY49vPPAwi0Zcydc1GcQqOubSmxhIJ0rc3lP/Ci8wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785711404; c=relaxed/simple;
	bh=RuFP9W4Bh5Ik9VVQIRnJcCOdTJDK250ksApEnRBF5eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uo7nbbu3CZspVnaH4+SJt1SugL5U+N6bn7qyP0wAMoGL5CIRK0zI6uhxGdGblVQC1dQshGxi5HlXYRNf7DxJjJcGDVyL4jsTVXMz75gML4BJbzRH7e8uc/Xu1T1fQvZ8BgJtA4/Tf5KBx5bUSaQvlYDilnVfLWRrS+qK+uHgRVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pY5DKIjx; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pY5DKIjx"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a0cb6e96dcso1466064a12.0
        for <linux-fbdev@vger.kernel.org>; Sun, 02 Aug 2026 15:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785711401; cv=none;
        d=google.com; s=arc-20260327;
        b=fuEQQYJuvd2js/zM38Oyk/obt8N/ZNtKgwOGzV9VUh/kTbRTxiT7Qfc4oXe1dfAchN
         VjPIRve0Xl3vibhUK8M4ZHpabSjNJpFB3Ju5QK2CFSXO+ap1zujmPQIHvRi1pzw5EkLD
         JbiaKoHyXOVhZFmZOEVifxgFH01JPvRLTU1tAAxUxZhGOlvPcfhbnyypFf9RwUoBcDfz
         YWIwkjUUJa9HkIAUJLKHD6HrZddiZAVx37thF02jrWWMbRu/Ybu4UVPDbr5+NvtyzZ0Z
         f7BYpVmsQKI+isGPoY5SPSwzxLc+RSuZmJuZzgDNLa4GLu7IaD3kTxPHxN7I+IjRbwIc
         xFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L/rMtwPDxsC52fx+U9UwvVtcGVHIIpAAwX8W2NzxXeY=;
        fh=z1ZE7V5dfXOHB2AM4EcibsNumoYFqdopS28Dip0RlLo=;
        b=nhm7dIUi+3zxpNIveisAm8htDARm5HaCZZBncgZixXdx9S7Q6N0KbiVmd4aaCHdM+2
         SGr7GoQpVxVtzquAPyOOeszc9MLt4jHSVDkOk6OepyRvhCPUeuy+hTvjZx84Z/27fcaK
         Udhm/h/+tpWix3H+tVRgGaWyfkRbWJUFmN7du/6f5CMehrzQ/FAQ04/PF00Fc+xjuAw4
         mgsU7zn8UAUDZRmki6yWjl5Js/16l4hUhN/M44FYIT+aVkD0r+67WlUB7DLPb/dt1TBT
         RO8ZTfsBc3/pPjI1wdklXtA+YIfu80GQ1fZ0CWlYRc1w4CRVhhH013PFFimJ0hxwlJJl
         4cdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785711401; x=1786316201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L/rMtwPDxsC52fx+U9UwvVtcGVHIIpAAwX8W2NzxXeY=;
        b=pY5DKIjxmaUwSJ5I+m9/Kz7n4fqOq3UfZ3xTgnzTKl166C73xVLRdIod34cYP/qSBY
         oHCn10sBMZRnLd2oP77SBVXqN5ygYav5EU2+mFf9+2eP2EmGXNNoCUZrMc0A2Y9dUx9S
         fgbRINpGG1S9+brhNwxjubSDpg1lMNPKeLtUbehlaR1xaMJag0P/5eO3SPXOCip3GDps
         YgoPn9Im/hqaiwbsKYH/drUKgbrEcfgxUdzMDhBQmYNzitlbenv0MNkRIedqtLigt1T+
         DbBa3W7ZUpALPc8jHWFGKYfE7GXlIdpvdsDzzG2Jmxa5Yb2kYeQM8E6B5cFkgN4QT6M5
         X6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785711401; x=1786316201;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/rMtwPDxsC52fx+U9UwvVtcGVHIIpAAwX8W2NzxXeY=;
        b=Y9vZoRKof2aViI0Rtsu0zU9kwQKWeQItfnFzkfZgBuU5UZm0qM95hvWauuLCRrWYfz
         1P1dUx5b3Zlllk/6cCsCbKdohiuhaoE+Qh25ycYQtd7dMIN29KcKXxvXcu+mU205bqSB
         /gkZeHAoY6GZQs2ZWJiva/vQGH0UfwQMtEijoBT/4JgNFxNDGF1uFh5oNdrmIqpKvf7V
         p53UZjkQJIkjnhUNKKbqfGNPGUBZNSxOHEcQv910naHaXolo1VLGiOKQpcP2DMWsdSf6
         GZA9yo4xNoP1zxjzLj/QQAhHai2ap3vWglWaus91ZtyoUKyVBHJHLT5D+IGY3l/VoO8L
         BPBw==
X-Forwarded-Encrypted: i=1; AHgh+Rppq0G9u3Ht6Uu60TvcGjZghKurEpBtf8CXROGQrkQ7fHxWO7Q1YUQO9/r5gfT+6S08jbB24KksAC2dJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWlDayIyYZQ4GLmVhPtNvCxylvLMoX+FlIzDSVKIZCfOKsTAbA
	K6pdNHHRzPudTRygvGF+5lV05b4fmYf7vZAHeMJFQqmQ9SySnbyxAo74WgVp8bj1s9tIaakuPWn
	q2bSi2d2PVjkT1PQUOHHqto8crdW4i4w=
X-Gm-Gg: AR+sD11nZUe053Zi9YhtdvYFdfEVJG7h1HsHBjcHDNkX/5FD2S2JaqpxVOZZRrTypNq
	Q+UvjHFGBOgjLU/SFRiqI55N0ZRfsl6kJ2T4yEiuH98/tSAxd62U8TurgKwt03SAAlZ2d3WdMUT
	TNR64PsvgsAQZb3OopvIsqdpOhhxcizzXdCu1KwGu4pRrX7cfKcN6IcxLyWsp9ust6KN+1MPQZe
	wyMnWeit+YAn/OLtnTeLYG1mdxIaYcO8w/s1GVpjrbFX3Cn6YX6LJKJP/5xLCRnT3ndlg6TDxd0
	7XctoIFeF93B86fj9eE+TUF1jLmTH2xrW1C1GP/ZSoIl5FpceVNpaWbGdJ9zOZAqsg==
X-Received: by 2002:a05:6402:5046:b0:699:fbe4:16d4 with SMTP id
 4fb4d7f45d1cf-6a0a7cb31e1mr5338151a12.18.1785711400839; Sun, 02 Aug 2026
 15:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com> <am9DGQFk6JfR6bXl@monoceros>
In-Reply-To: <am9DGQFk6JfR6bXl@monoceros>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Mon, 3 Aug 2026 00:56:29 +0200
X-Gm-Features: AUfX_mxll1BnAASKTkWyMod9VELF2y9V2Qxa3BymFTVuaD1zfm5wy-U_j9CAbIY
Message-ID: <CAEUXW=Gut0oN6VN1XouegJsQzwNYGqhAjVotGJbQdXk5bVuZwg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Helge Deller <deller@gmx.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,


El dom, 2 ago 2026 a las 15:35, Uwe Kleine-K=C3=B6nig
(<u.kleine-koenig@baylibre.com>) escribi=C3=B3:
> No need to wait for init, the idea is to use init=3D/usr/sbin/platsch so
> it starts before init (and once the display is setup execve()s
> /sbin/init).

I think I caused a misunderstanding here: when I wrote "init" I meant
PID 1 itself, not the init system getting far enough to start a service.
Running platsch as PID 1 does not change the part that hurts, because
PID 1 is exactly what I am waiting for.

Numbers from a shipping board, our 4.19 product kernel on an AM335x:

  [    1.065931] tilcdc 4830e000.lcdc: fb0: DRM emulated frame buffer devic=
e
  [    3.522118] Run /sbin/init as init process

The display is up and can be drawn on at 1.07 s. PID 1 does not exist
until 3.52 s. Whatever runs as PID 1, platsch included, is roughly 2.4 s
late on this hardware. That gap is the entire problem: the panel is
alive and black while the customer is looking at it.

> Also you can put it in an initramfs which gets rid of the dependency on
> "rootfs mounted".

Agreed, and that would remove part of those 2.4 s. But not the shape of
it: PID 1 runs after the built-in initcalls have finished, while the
logo is drawn as soon as the display driver's own probe is done. Any
userspace solution is structurally behind that point, and an initramfs
moves it closer without crossing it.

> And if your kernel is modular apart from what is needed for the display
> the time difference between kernel boot image and platsch might be
> negligible compared to the simplification of the software architecture.

That is worth evaluating, and it may well be the right choice for a new
design. It does not change the ordering, though: the display driver has
to stay built in either way, so its probe finishes before PID 1 exists.
Making the rest modular moves PID 1 closer to that moment without ever
reaching it. The kernel logo draws at the earliest point where there is
something to draw on, and nothing in userspace can be earlier than that.

To be clear about what I am not claiming: platsch is the better answer
for anything that can tolerate the delay, it is more flexible, and I
will very likely use it for the parts of our UI that come after the
splash. The kernel logo is not competing with it, it covers the window
platsch cannot reach.

> Having said that, I'm against putting boot splash info in the device
> tree as the pointed out alternative is IMHO good enough. But my opinion
> probably isn't the one that eventually counts.

Understood, and thanks for saying it plainly, it is useful to know where
you stand. For what it is worth, the objection I expected was exactly
that one and I would rather have it on the record than guess at it. If
the conclusion is that a bitmap does not belong in the device tree, the
fallback I would still like to explore is keeping the placement
properties and the reserved memory path while dropping the in-tree
image, since that removes the "bitmap in DT" part while keeping the
early drawing. But that is for Helge and the DT maintainers to weigh.

Thanks for taking the time,
Max

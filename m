Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641D40244F
	for <linux-fbdev@vger.kernel.org>; Wed, 12 Aug 2026 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786571466; cv=pass; b=LOK65YA09ZOsr1nWuNG9GvRGzIUPFxoFXv6Jcl1b/eSLMr3FbWqQG9VPA8EJ3rUq+TkRAw7c3d/uzIqSsDP5BXGfQkYXgzRBCrLZgGDVr6G0W4BCtzGUdGkSIwVgwXhu+Nko88w9DZUvKeCj9San8+//7xLailUcmmTulOcVKp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786571466; c=relaxed/simple;
	bh=Bs1zT6EItoduMrKgHUcacdfBpYcIQ+zl7jV0rmHLxas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwhAvmx4VIu/vVpmud13jRRwTpk47aGUxxC+VS+iZLg93mpdOJOxagl8D5IY1Nr51Xs+6Fyg+AtcPQm7tciq15sI9ZmbIIgqz4nuORWKGvb+PQ7it3DbeahUFTk+bb1G32DodRFzEIKeqBcIbDqIq92QY6dvq3Y7uNJ5170gNIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2Fk9Ju4; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2Fk9Ju4"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso2322942a12.0
        for <linux-fbdev@vger.kernel.org>; Wed, 12 Aug 2026 14:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786571463; cv=none;
        d=google.com; s=arc-20260327;
        b=i6rZb0D7yMPM2i/fWhx4CUdZ0hFP6yGqq9xhqrftv6Zb4T/SqtBDL6fI0pLxGF+lIO
         TJjieuBEx/LiSvb+nDyrVZwWn0/tvZfAGWHkf1xRdkmEEMbYE4Nr/Jhm4hl4Y4ZSMsVM
         d+dwR+1CAJU4QpB+GhmRDZdgiJr2gqMAs5mnuTVUIe33OJ3M2IvrLxSeVuWoc8PzqGwL
         86cbxNwhgICw6N8KnZXr2rozKUhNoovDR1aBCH5Ciz77sM1B6VaX8uEqFU9fvoLlyqyw
         Vuc4hGmuvImTtQ/lGuQGRMRk1OiZeSlfSQ5e0F9cFZpFxH39fUkC9bbXwzD/s8wM9x2W
         cViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZRbb1QL5HOmY6fyxJkNCzzNheSCQLGJpJYrLwNUFf0s=;
        fh=2C7BH6htSUNlmuBWC+Yt6XB2kwj1tqzIs6LkVirJqVQ=;
        b=O+QvxoljJyoCx2xrDyGo89KrLEl+x+ezJ5YJUToSqTjppF38cf5s7qeWAXQsIlO1Jo
         tBpiaOcA0pjDodUl4wbUFpSjwKLpAYxDMwb+I4aWx3IrxQgFamzRYLonWJZ4I+JdzjdZ
         yxJyHijnBQLVYAfovKQfBI/6fmBmOods3t+xsJjRIIETQViEseOyfXSNm+5RII/DBRLB
         RS7cgH0CFc+L79VFhoSw7nwCz6uhbxamt6hXBnd1NbyLzTiMKZHCo+a5P/LgsNUDb22z
         GONYlml1aQMKTayW6gl06Tr4MF/TBUXvRYHyN776JM0oPXQOqDiTe37w4iTHgFkTmR1P
         csmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786571463; x=1787176263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZRbb1QL5HOmY6fyxJkNCzzNheSCQLGJpJYrLwNUFf0s=;
        b=E2Fk9Ju4boY6GlSIebI6Ohz52aHPWqyArUMnk6OURe2xcx7eltFFTjxyFJMNcFuGzA
         gRyMCisuVPZ/Bq1TUFPlnwncQiwij/S1TLtzfHmuR2SpJooWa5nQYPHtjBoGCYihHApz
         ww7Uf2FlzaBK8Ki/yi4Ncbvl3qxZbGOawhvy5FU2V0QrLy9dBAnmUKpv5tuMNV379waM
         PcasgDm1TrGa4bTlg37BaZlNlJxUhaSqPQfW2NnFJxUyoilkYizyEAlR5w+hDC6OwkS1
         +Dyz4kMGNpyoNgD+E64Ez5PIMsU3n5D5zMdkXiaHhJFWT+/KYPr5/aW9GWXYbXCR29eO
         Qi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786571463; x=1787176263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZRbb1QL5HOmY6fyxJkNCzzNheSCQLGJpJYrLwNUFf0s=;
        b=Q+t/st1M0ZRPxM5HXmGK5Pnjt5rF4S+pkiRgb/yqmvswVjbGY2vXt/2jSXgo3kIU7p
         cO4th4CKrNFFgnR6Vs7BT7DKhk0/JcxEfanQCZuJ/u3vK3Cv6bhTvyv9wwt7mBP+hOwj
         TphPBDa4LDE9KW4em5qzBHVftBHT2BAOmJU4pIep7SLR8TKDi2yolVjm4hxtzOpwNWpl
         YUK2RDhc6YDoe26Fwtn0BRPWFTACS7BILS53KP2Ee4CTJedYdYIg8Lczm3N0ckiUZPvG
         FhAC4Z5iZLCtmL72D60sfr+JnurAwmM+iLkLJl69NDv6Tp8dyf5q+8zwwf4di59yxvor
         JFPA==
X-Forwarded-Encrypted: i=1; AHgh+RooFE20GVKf1tGkQIZBUZoJxxEZoyn5o0avA9z8h0O3JYBlil525KK4xB/wjl38EOR7F4MSa5IL3x9Epw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdhMysisBdhyuv63ykn/5+G9O7dqodttP62eCuNptyK7x6B4zI
	FLaaZIBu5OYAmE5nuHfJm7h2nQc4qosXrzHJUC7SgkKFD1Kt+liSb1SkNsWZ1PcbEO+qxv2VEJh
	IWGeKdAXDO8dS5Z/IufQhsGE4CU2cXlE=
X-Gm-Gg: AR+sD13EWPvH+xoSr/GRWqBwMtnjANb3+W5hiVlpzziaFK0IzSYZ9b5XcaIyk1JCXzo
	PZlxA6qWzMGKrHiCqr+MwA0ZrJqyih18SsymwbI04qFCIPQQ+DcDKq2I6CJ/k1sTTWOuimqM3KH
	L2LWHxDGjVu5GDjPFq5UW45EPTSHc7OXGbvj0wi/G9XLgdws9Gv39vKNasP9fUCKIqZt08n6XbM
	ZidkfdB5ZJRCmb0QI+5/7MMTkYH5ATP+o4aIoO4et0r8UBvfwUrUrXl7cGrFK/m1XlErG3WPXhK
	yMNUYplcDM7Ijidf2C4TKrPlw+DQ/hb4h4OaCw1kMfnd
X-Received: by 2002:a17:906:f59c:b0:c20:f913:9337 with SMTP id
 a640c23a62f3a-c2108f7b604mr49396666b.20.1786571463233; Wed, 12 Aug 2026
 14:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <20260810-devout-pig-of-performance-595ccc@houat> <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
 <20260812-neon-asp-of-completion-e9349e@houat>
In-Reply-To: <20260812-neon-asp-of-completion-e9349e@houat>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Thu, 13 Aug 2026 01:50:47 +0200
X-Gm-Features: AUfX_mxyPKLYJzGR3BRhvwNIy9Y09lt45MHF5IGyuCsk2Z_DBdXDroK9BGIUrgQ
Message-ID: <CAEUXW=H-o+fqBjH1UQG7=UTm5x1a9Cj++XJM7twvFU4vJC4UrQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: Maxime Ripard <mripard@kernel.org>
Cc: Helge Deller <deller@gmx.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mi=C3=A9, 12 ago 2026 a las 9:42, Maxime Ripard (<mripard@kernel.org>) e=
scribi=C3=B3:
> In such a case, you can (and really should) use KMS, and you should use
> an initramfs and setup the splash screen there.

Agreed that readout is the right answer where it applies, and I am not
looking to duplicate it. Three cases where it does not:

  - Hardware whose only in-tree display driver is fbdev. There is no KMS
    state to read at all, and there are still around a hundred of those
    drivers.
  - DRM drivers without readout implemented, which today is all of them
    but tidss.
  - Falcon mode, where U-Boot proper never runs, so there is no image and
    no programmed CRTC to inherit.

On the initramfs: it moves the splash earlier, it does not close the gap.
Measured on our 4.19 product kernel:

  1.09 s  tilcdc registers fb0, the logo can be drawn
  2.68 s  ubi0 starts attaching        <- 1.59 s of built-in driver probes
  3.39 s  Run /sbin/init               <- 0.70 s of UBI attach + UBIFS moun=
t

An initramfs removes the 0.70 s of storage. It cannot remove the 1.59 s,
because PID 1 does not exist until the initcalls have run. So the gap goes
from 2.3 s to roughly 1.6 s, before the splash binary has loaded and drawn
anything. That figure is an estimate; the breakdown it comes from is not.

It is also worth saying what this series is and is not. The kernel has
drawn a boot logo for decades; this does not add that. It changes where the
image comes from, so that one kernel binary can serve products that differ
only in branding. If the position is that the kernel should not draw a logo
at all, that is an argument about CONFIG_LOGO rather than about these
patches -- and drm_panic already calls fb_find_logo(), so the logo is not
purely an fbdev concern either.

On doing it through KMS: you are right, and the follow-up series should be
a DRM client alongside drm_log rather than a hook in drm_fb_helper. I will
rework it that way before posting it.

Max

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420347;
	b=duTTcPpkMj4eeUoiY8L5x2vRQ+cmLZIzVer97KGAT9r/quToLtBmDcenalTDfCfdeS3h
	 QfhOi5GfhO++aojflSni336MF+4sDsEv7eqlTr+as1RxZhK1SKyVkhWGv4BG+ogFwfF3S
	 OwxZh8U5eiZO2B+bAAzQ8tXV2dt1uCdzCIzaw8F7e0hLaxVLV4N23rY7AfFZ44sKPhSkG
	 5N9AWfidgqIiX/eL9oyAdR7bL9Z0O+b78eaXbFf/lZnE6duuuhcWc/zEKpiX4vFh7hraZ
	 o/nin44tPfJP5bHIQdGlRFkTyJGx331SjBzMdo6Som6Zw7XKorUXaqwGB7f8IuINWsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420347;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=gPjBrUC4IIvbAeHFoPzSJVURfLd/Eu+uv7trnU32st0=;
	b=3+8QP0DSYeHNCVUw/bY34hJaWKHNl5dSgm+nkXCuUFOxBJhaK8IKDbwj+ZDkkbzbecsT
	 iDjAkkHXVdklbUKBMhO1ryIfBQO8lTTSvMGhdHnNpgeXGbICxzOBb1/qyAVhurX6ecwcP
	 MNRzzRhNDeP8O28KMejnmj10B3gtqTgwpsrqqjhBZ8xBMm6GaKoRfKjV3jc24e89hmWrW
	 jAw2jUidVw2y+h1gLnQetV9kwD5kVYlenyFF1DnzjqVB5YCQaxR9u0YtMPOzNZQ9e839C
	 i3hKNuZx7HrtnyCLSIzeKNoaphw8L+TpRHihPCTIu+fDLVJJbANQTVRTNWN+p4gg/wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79E1606A32A
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Nov 2026 07:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C79E1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7d2d1b4a83aso924680137.3
        for <linux-fbdev@vger.kernel.org>; Sun, 22 Nov 2026 23:52:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795420346; x=1796025146;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gPjBrUC4IIvbAeHFoPzSJVURfLd/Eu+uv7trnU32st0=;
        b=cos4Ai2vxHO3Cz07cHCSvofQ0dzV5KUxxHhhj+44Lk0oTB/EzZ4NeS04LuOZDvT2A2
         2BdL3dpNoOkwzfSv411hbqPlJOmZiI6bNBL73G2p/QSm241J6UnkEgXFziXoSVuz+v5t
         bRfhInxTa6QUcsp95jH8ENMQfBzCHxYp+QxbEJc9+N6kaSw4bzI8CSJl76RcSULsteWB
         HpYuM3ZYkWll01+6cjpm/X4jSJ13yYyWoTfrbmDd6I5aGN/IEJO1DG9GejQpmdJTv4/7
         NO6tnuHZ9xJu0rP8VB+oAoZs4bjhJisAs1VCf4tlS8minfcawT9mR4nY5HuJunK0/BX+
         y2kQ==
X-Gm-Message-State: APuU4Z/kROCf3HvJ/brC1HscCtQygoAbSylvClCV67mdlSHRx3ml/m1b
	mmknDTalLIMZb2k7ElkW4zFw27j98GaMXtXpWeDJH5EaQYeSAe+21Rr4NM9HK4S+
X-Gm-Gg: AZFdTZciZ0xIL9ElYiuKwBG9mlgoDm6dzNYx4+DfWNBiI4RToAlkY+m/hBjPRhJebXS
	bU14Na8M8IO2TiYeawGHS4xTU7eLWFIuYrQeITPrx+je/IKrt53BWQfS9DvncmBs//r6PYiLwV3
	Q3+z4DtFAhnOyyB/DyX/1WENtpaM725TtwQU07WHupeo4oX3GCeXPyuve6SCOtWWlB0ok1vMamr
	OQkvVsEK5PiEnbSPAknd6xJPmjYI2TdLsVA01HkEh17Jn+E+IihhVR4BeaCtI6Q1k8E0s7tpTnM
	JZBseoa260Tq6upXONf9A2w+2IV/3Aze/UZsb30/hYfPUrhkP2tymKiflo37i7SnEsxsJ0yPtbO
	7kMrlnO1pUS9quNVoiLxS7yE22YA3+taPDjO4pfPK6TU0bA719qFNR2PB8kVrYzr8kU8hOSblcp
	RkJ8HU9kdG7Uc4g2nkuxBoFpzGU/ue0Dh98JbDVU+K7mq1S6Hd5VMUBzhXii1mNnisa5GDwVJNP
	Z14SS4kw8iX2Bg6XQApQa7wQEULTNH8GVlddgh4AmTgciG13t6W3MFQn13fReQJCY9bNMAGuYF1
	9uCSlfbXqI/eoeKCamQCnEgPA2VDHMaIs7ci2rd8uXG+W/z2iEaM5apm+N/wQMRMQMk=
X-Received: by 2002:a05:6102:4411:b0:7c3:3890:6076 with SMTP id ada2fe7eead31-7d739696d1dmr4084786137.6.1795420345603;
        Sun, 22 Nov 2026 23:52:25 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm10923328241.4.2026.11.22.23.52.25
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 23:52:25 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7d2d1b4a83aso924677137.3
        for <linux-fbdev@vger.kernel.org>; Sun, 22 Nov 2026 23:52:25 -0800 (PST)
X-Received: by 2002:a05:6102:c4b:b0:7cc:174b:f7bc with SMTP id
 ada2fe7eead31-7d7397267a8mr4285980137.15.1795420344893; Sun, 22 Nov 2026
 23:52:24 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120175413.176249-1-deller@gmx.de>
In-Reply-To: <20261120175413.176249-1-deller@gmx.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Nov 2026 08:52:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWyrdpVKvs=8Q+B-Syo1ZdAJvfJXFv0qiNtR9z4VnwnBQ@mail.gmail.com>
X-Gm-Features: Aa3M54qOyxN021oFFusiAroXY34uRuwIJkT2Rviou6jBcd7wAahwXo5xPECEOBY
Message-ID: <CAMuHMdWyrdpVKvs=8Q+B-Syo1ZdAJvfJXFv0qiNtR9z4VnwnBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fbdev: radeonfb: reject a zero pixclock in radeonfb_check_var()
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Jianqiang Zou <jq.zou@outlook.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Helge, Jianqiang,

On Fri, 20 Nov 2026 at 18:54, Helge Deller <deller@gmx.de> wrote:
> From: Jianqiang Zou <jq.zou@outlook.com>
>
> radeonfb_set_par() derives the dot clock from the user supplied
> struct fb_var_screeninfo:
>
>         dotClock = 1000000000 / pixClock;
>
> where pixClock is copied from mode->pixclock.  A zero pixclock
> bypasses the existing validation and makes the kernel divide by zero
> in radeonfb_set_par().
>
> The driver does have a check for this: fb_validate_mode() returns
> -EINVAL when pixclock is 0, but radeon_match_mode() only calls it when
> the output has no scaler and an EDID-derived mode database is
> available:
>
>         if (has_rmx == 0 && rinfo->mon1_modedb)
>                 if (fb_validate_mode(...))
>                         return -EINVAL;
>
> mon1_modedb is only filled in when an EDID is read, so when no
> EDID-derived mode database is available the validation is skipped and
> the invalid mode reaches radeonfb_set_par().
>
> Reject a zero pixclock in radeonfb_check_var() before matching the
> mode.  fb_set_var() calls it on the FBIOPUT_VSCREENINFO path before
> ->fb_set_par(), so the invalid value is rejected before the mode is
> applied.  This is the same check other fbdev drivers use (i740fb,
> arkfb, s3fb).
>
> Reproduced on Linux 7.3.0 using a custom QEMU PCI stub device with
> vendor/device ID 1002:5955; no physical Radeon hardware was used.  A
> single FBIOPUT_VSCREENINFO with pixclock = 0 is enough to trigger the
> divide error.
>
> Signed-off-by: Jianqiang Zou <jq.zou@outlook.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Helge Deller <deller@gmx.de>

Thanks for your patch, which is now commit b3f1631d362539cf ("fbdev:
radeonfb: reject a zero pixclock in radeonfb_check_var()") in v7.4-rc4.


> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -836,6 +836,9 @@ static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_info *in
>          int nom, den;
>         unsigned int pitch;
>
> +       if (!var->pixclock)
> +               return -EINVAL;
> +

This violates fbdev API rounding rules:
  1. If a value doesn't fit, it must be rounded up by the driver,
  2. If a value is too large, -EINVAL must be returned.

>         if (radeon_match_mode(rinfo, &v, var))
>                 return -EINVAL;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

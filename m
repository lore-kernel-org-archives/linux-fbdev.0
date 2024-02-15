Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B912AAF4
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Feb 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997717; cv=none; b=rdFSfuZYtjiCvHPmDTHihfVFCgpqYkPCdAw7m1Tp52yhkiOBXtq6l+ZphLMelKJYWABVBCaYBZoBnIVlk7TmMxJcwFhK4sZLDSu/qgA7VdpQMDCxcovNAxAsC4nxHdnoOsimFdvxM4bNh+BmgoMnroLdavHa0sAtA+sieLVwU2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997717; c=relaxed/simple;
	bh=FaR+rwTP87J6jI3GhtgMXyL1UpaYTYZi7hZBMtfoOLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIow4WmhTQnset7Kk07CkuwIYoM6HbbB/MuIqNhLL/zqr+jwOrLvwwiULrfKNskLy5ZMgrlixu5KHvULHMwMARS7x/3n3JDrSrXAL2isHEkHGo/iA2YkUbqefNEa+A9OpitOBlHb6JOQiUyhEhlrHpt8XQmKOlzs64gHhOB9CwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gny9/BCp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gny9/BCp"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-411f165ef9bso6826535e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Feb 2024 03:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707997714; x=1708602514; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DroRDiixIta52dRC0kBdYzbBsXfxkiN1Si4pySYG4VM=;
        b=Gny9/BCp7iqVOJLUyqZ0dxeN+cd4IZKyOobTfX6l/tL5oSnMN9vq8fsJKsousx9Rui
         QFsOtZnJDsRtQ1IPmENihjPXfF7msEtcwwG/iMM65yfQ8PzjPG6TUqIW5SMIuHncxH7g
         mdy9hYKroAQ9jP6kDZEtXX3238awHWQIHLqQuBFiXf3UcZRdY4vpVpQcOR/iM5xRtcFg
         CuiBiTy2QAtCs/XCmtt5oIy4lulJQZ4SBCvQS3uwN3PRjFNuliKSg8eZeFaliKa+mrmR
         Zm89HBwl/Gyycs7E95vCTg5VHyNx+d1KF/YaxjgHM6LYJK6fzePUm9mw9e3MsmD8X0S5
         Nl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707997714; x=1708602514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DroRDiixIta52dRC0kBdYzbBsXfxkiN1Si4pySYG4VM=;
        b=CEK5XoY4ETOzi0M9zue7IiByJ3IWcmt1FXBXchQifieNKlzTqw8GwZhfZ5R3qTQJ83
         CxKQnoJalpnZlVGafXQmaWHB9geBa18uHGjsLupGbdPI0t5SER713eqqMo9+Iy/hBbsy
         EKJI8VZh5xTY9COiunex091dWw8dOk408ZsvAaBMIbtpNz4ipItESFiumvdeGclWZDoT
         Mf5QCovSkvEgTrlXMoS5aN3bnY1ujkdA9zGXHqLB0pjnK6ZzL1QR3EIZ1DD7qvopV2zQ
         urNv9xWcfOrmYbKH8jdaWyygEoThcUlG4icVUZ4jrLMbG1IDIAz9XB1yVGw+b+r4MrIY
         Qd3g==
X-Forwarded-Encrypted: i=1; AJvYcCX0XIzqTN0z02VCSoe/HO+Hv3mfBCj2MI4yn+nVSks3YeBaiR9GHWEe+qcRnZhLKuVcw2IoOmPkXOzxD8KpiZ/ndhLW8bECtK+bb/U=
X-Gm-Message-State: AOJu0Yyw61jbXRum2vGKLEEz7oiSEh5QH9/ZbVcEx7LVQv2PNT+UgD6E
	HanECtV9jZcwF9zoIYWv49+WgsiI1onfH0icADmx5ACP0GQK3nFaJdnoEWtuqz4=
X-Google-Smtp-Source: AGHT+IGOdMVWbwspHZiG2UkONtI3ot5v2Yf7yd80zwMxWdUapC4d2kyA5ljlBgnTJ25oK0jtN78zUA==
X-Received: by 2002:a05:600c:45c6:b0:412:1500:beaa with SMTP id s6-20020a05600c45c600b004121500beaamr1042184wmo.40.1707997713895;
        Thu, 15 Feb 2024 03:48:33 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d5344000000b0033ce214a97csm1543569wrv.17.2024.02.15.03.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 03:48:33 -0800 (PST)
Date: Thu, 15 Feb 2024 11:48:31 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Flavio Suligoi <f.suligoi@asem.it>,
	Hans de Goede <hdegoede@redhat.com>,
	Jianhua Lu <lujianhua000@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Helge Deller <deller@gmx.de>, Jingoo Han <jingoohan1@gmail.com>,
	Karel Balej <balejk@matfyz.cz>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: expresswire: don't depend on NEW_LEDS
Message-ID: <20240215114831.GE9758@aspen.lan>
References: <20240212-expresswire-deps-v1-0-685ad10cd693@skole.hr>
 <20240212-expresswire-deps-v1-2-685ad10cd693@skole.hr>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212-expresswire-deps-v1-2-685ad10cd693@skole.hr>

On Mon, Feb 12, 2024 at 09:03:26PM +0100, Duje Mihanović wrote:
> The ExpressWire library does not depend on NEW_LEDS and selecting it
> from a subsystem other than LEDs may cause Kconfig warnings:
>
> WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
>   Depends on [n]: NEW_LEDS [=n] && GPIOLIB [=y]
>   Selected by [y]:
>   - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]
>
> Move it out of the "if NEW_LEDS" block to allow selection from other
> subsystems (in particular backlight) without raising this warning.
>
> Link: https://lore.kernel.org/20240212111819.936815-1-arnd@kernel.org
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Fixes: 25ae5f5f4168 ("leds: Introduce ExpressWire library")
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

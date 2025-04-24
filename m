Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451C820D50C
	for <linux-fbdev@vger.kernel.org>; Thu, 24 Apr 2025 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484764; cv=none; b=f+x/1FN2wnzbUG71XOFLj8vWXjRjqePW2hX1xw+9kcLR6a/isWTbXj/7HRBQzd42lV9IdQI0e8cVzuCoZEMtZZ7T/AXv1/oSKzpjOgyZp/uJGoLKPaB7X3dkM7jcQj3QYJcgWM6x25cZjH0CvyzJNTo5QFqwcDl1tz3ep1RlR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484764; c=relaxed/simple;
	bh=Pi6I9/2PW0WKwJeejN5o1HPNrvvIUYugrgLnZZJ7Pu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rg3zi55ehmTKUaRioFYUWCEDMKNyvu8qd5zui1jzEdfXy9RCUp2O6VkusjmdM80mnSUF/8xOjhnyQ+uQckhSxLIycpWtDL01MeN2kjFsXAo4gr55mn2kiy4x379MnDShA1icbbaMLZZjuChgr190moE3QTu3Q3eGzUh3MnZAee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UoWjm6t/; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UoWjm6t/"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30c091b54aaso7224331fa.3
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Apr 2025 01:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745484760; x=1746089560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi6I9/2PW0WKwJeejN5o1HPNrvvIUYugrgLnZZJ7Pu4=;
        b=UoWjm6t/7GFcSlKFXXVAASTECkjbjSWxVKDre+llaetfJy3w0ECIm235ucR3XvunVe
         hqm2Qr+Jm15HA0RcwhY/ZwqfOwWxo+SantdGnm2Mz0LnDdeH08hksMWfzo3M0PangW6u
         7fHSVCajeZXO/ZnFKyoz1eM8xQkhlYhXywe47Nf7ApBcpRtnBx0X8udLf9NiGBU1x7oR
         GvKNdCoKNcGTB4cbsoQz6gweTl4gJc3e9NhRj/Xkn5FRuK9jaOcn/F8roItWBX+cs0iz
         D6ECAnlVPtSN4lMjF7DuLAm7bi6eyJ/CwhFSskHne87mo40vlYMB/W7vlSCiAF7qle42
         xv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745484760; x=1746089560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi6I9/2PW0WKwJeejN5o1HPNrvvIUYugrgLnZZJ7Pu4=;
        b=js2xV84ZbKd429LjQvixU4UKYEXxIWtGdfVMrAXQ0aCHn7RnFKTvX/RtZMonf6A3J1
         JxPyphPGGUHXLwMpzcQXkIEf/b+lQ7ICSUfAfz4WiztE79dt1zvyTKNt8Pk0HE6ZNKno
         s9Mx+TjFViE/lCQzKydwum5TawNeCYoO/52O0rsHGpfUGOAOR2671WGldB+0iP3HBakN
         v+ylm2+mpaMTWU3Pe3oeio/X0dzXDxzqazSEPBukQybdTmZbdhrYG28bx0TVPe0l1YpF
         j3/gRHhs+2k5my71QYHXzsezWNXTqpI61joYP+KXeO4+qrtgx/iCrBXhGPsbyiIsHbM1
         XQpA==
X-Forwarded-Encrypted: i=1; AJvYcCXEiIpUmL4+dGpZzCKaNNFaU++5A+QaqxDiTl5fRTsSZF567WsqfqZiCCW463aZAnobnlcRP3aTirHvhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQmAq2q5yjxue1SAEHs6uJ4Qp+LAQKXmZSww3XnC8CUvU7XTgC
	I/TDWP3H2mRigWoNwh9HzHhqLq9B4xoMUnR0DXpIJMfdfzKEXiiDRcq9+wor0N6YNZRQ6nEXM9u
	pU8LfZzJFoGp1vsmB93j/IQK4L4x5kQCWiMPGDm7ZgiJmP5hD
X-Gm-Gg: ASbGnctEIikL28Ra6e+xMjGlsrYS3deX8iQ8hNUobvxX2+KCwhOMu8Gk9kkdursyRwl
	Rg8ez4sKBTmPwMf99fYvHOQGqaqaGQV1mGlwuE3Kqhko8N65NGgP15fwhfCVsw7I4OgMJFw2/NQ
	WqBl29a65fVKtCKMEW1Og30j6aN4PuJtZf
X-Google-Smtp-Source: AGHT+IHAB9LWhYEooDYo0NS7+cNeVroUrJMiu/TtDGjCg2QMPYKVyjyzVDKPg2dN18XgA6c11bYigJex/WlKFNej81k=
X-Received: by 2002:a05:651c:241:b0:30b:d022:2fd4 with SMTP id
 38308e7fff4ca-3179febbfeamr7382591fa.30.1745484760431; Thu, 24 Apr 2025
 01:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408-gpiochip-set-rv-video-v1-1-200ea4d24a29@linaro.org>
In-Reply-To: <20250408-gpiochip-set-rv-video-v1-1-200ea4d24a29@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 Apr 2025 10:52:29 +0200
X-Gm-Features: ATxdqUGMaYSVPrnrhvuCdxBcM9tsozWah8p2gB0BcCstcebhaxaVqziqhHfQoJY
Message-ID: <CACRpkdY0d_a8qzN2bJD+yzZ0P_twwPM21yV771YoABuVQzXAUg@mail.gmail.com>
Subject: Re: [PATCH] fbdev: via: use new GPIO line value setter callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 9:43=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

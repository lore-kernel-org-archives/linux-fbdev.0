Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5093B16A94A
	for <linux-fbdev@vger.kernel.org>; Wed, 26 Jun 2024 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402718; cv=none; b=BDsTfAT89J/YE2NYuZsO87nWvcnvSlB7T9jgopKXUQt251ZDcj1TSRQj4crCSypYXm/7NyZeVt0wJCI91laKNOZm5xuuD/4QtC7B6G2HnYLPka3I8FfGbEu2LLX3l+GBQ812vHomxWulxQUwtwc4/INnQ1mj6IeaBPPTnG/Gn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402718; c=relaxed/simple;
	bh=xpjrjZmRsZz45Y4K6cy5Tahj6SJPohhDcpzY7RpiacU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1Yzf6nsHaDBBBNm4Bqtgbb6sBxHn1eqjIXLSJEoU5lkaTwqvDHziEMY0D//PhvYf8I+kBoHn8+jtorvDOEtLXFzaJjoQiBOUbYoAwgZsXeeqSm9po6msQRnb+192uhHKMkA+Vh5CrVvPL+hyhKZw0oGUwS1/CKNtdJsBDkllHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pCDqOb8z; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCDqOb8z"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52db11b1d31so1176022e87.0
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jun 2024 04:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719402714; x=1720007514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpjrjZmRsZz45Y4K6cy5Tahj6SJPohhDcpzY7RpiacU=;
        b=pCDqOb8zFMCueR+WmT9EGBVxnpIQmDWdpMbtFnzNf6UzPhN8EZHBQ+Q1xWkUSkhal1
         5Il7irWIZ9uKZFmG37sOA9ejvdAhX2CDJwu+bNM/uTdthpDxYmk4recMlajPW5AW6uzA
         TfELVn2N2bOLlIIG7xsyl48HTu0bEP7ZmBuhkjlCYtDGDVCLi1Fglcq3REJuindlD2KI
         jx+9nt9BaZAsJBalxYt4bSl9Pb/z5oxC6UZ77LSmYNkimUnh2Xx3gBycY5O8HjE59lQI
         Hd47Jt0/4gqQx0E6tuQfPmZ9jBeQNth9/oADGqgu7cCMNLQhAew8GKRIw65LqSq8IL+X
         0FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719402714; x=1720007514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpjrjZmRsZz45Y4K6cy5Tahj6SJPohhDcpzY7RpiacU=;
        b=KvwucZTsqDsdYgyu3cGbhm1r8voB6n613/hkM9gTikVOLL7NdhiNTacCO1Fm8/it3G
         TCNtRe5/HKQcm+14q9Fvx9CQezHgWCCpffJlZHWyxHh2HksqUI0fPpeerN/JPrOvdRlx
         O/hiahGtbdF89EkiyL6YppK2mGPM/OM6RnQD8pbGuSyBm1WooTHKEDtUCyEjL6TLnEO+
         qVSUgnZy8bVmYiw6m4GxM45dxA6eQ5TfdKQMTxbY0cOuPgFtv9sFemoH7CwA7k/NqS+l
         rcuvc47/TN6SQ8WcwcIE/5bdLfU//xGMnKDqehpeHOKTmOTDqkoPqVd4/f9hZsgkilhC
         BvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe/xmqc8rXwVCIvI2L4bjYia3FMa0yj5JzTeqsdiVziPrcLMveuOXd2KQ2pkBtAzgEQF4EY9hwch3a9L0W6Gsr3YdKjOQ4Ubnidu4=
X-Gm-Message-State: AOJu0Yw9x1w0BSmeoTxGIY5k1fAPQu+ED005yFEePyWw+8QFfUuMiGgQ
	+Tv9Y7blCQp84iGe4ouSv4MCkZPPPPraUpS5JQQVDjjp674vnzDO8LT6KgYX6vbp9pyXZ1yNB4/
	OIXB6S3/tNPvzmFrVIswH3Qd2Y8/ttscScsFrOw==
X-Google-Smtp-Source: AGHT+IGn/BLs09UZTXijTnoE40QKwlRJA0amamIYfiwwfiDRAcDmK1jL7i2Ig/go5BAD0nIbt9Kry0L/xhH0oehqM5s=
X-Received: by 2002:ac2:4d01:0:b0:52c:a483:4cc6 with SMTP id
 2adb3069b0e04-52cdf7f6665mr7139770e87.36.1719402714424; Wed, 26 Jun 2024
 04:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624152033.25016-1-tzimmermann@suse.de> <20240624152033.25016-7-tzimmermann@suse.de>
In-Reply-To: <20240624152033.25016-7-tzimmermann@suse.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 13:51:43 +0200
Message-ID: <CACRpkdaYzWkBR=m=sokfXJHvWwdkDXb2r=te0i2J3WMwmFeVWA@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] backlight: ipaq-micro-backlight: Use backlight
 power constants
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, sam@ravnborg.org, 
	jingoohan1@gmail.com, deller@gmx.de, f.suligoi@asem.it, ukleinek@kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 5:20=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:

> Replace FB_BLANK_ constants with their counterparts from the
> backlight subsystem. The values are identical, so there's no
> change in functionality.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D429312F396
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Feb 2024 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003911; cv=none; b=RuC/v/nJQn6EU+UmpzJkb+w9IId6342mvc+Ni/0KE529YNrh6XRlZ03QAaE8DTFQkhAkMQm1VuzTPHOj8zbt0Ybdpv69mOlZBUoVJM95+9EL/RUSv7mEDh/7TfkEkPjHyfs7mQnfazE80qCgFuN8cgnfjNvjzOOcIZAm5VgdypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003911; c=relaxed/simple;
	bh=lUl0Pib7si2dQHCXFrZb+InEVOkZVwOiAw43kh+jhak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhCB6t2bezkuT8Rs3vHAWhw6Or8wJzqwqi9utx5sKDexguU9N92WXCzpP7geD8OGiQPc5+Xp/quRGOzscDmT4jBH62IPiLXccJGA2cWQkdNvwEv6Cj5BnpQDykQLOrrXtmMOC004ptvc6oFwpvGzubX3PNdeSB4lV9wrBgt3CJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BqGCzj/G; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BqGCzj/G"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso806111276.1
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Feb 2024 05:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708003909; x=1708608709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGh//nbX6ksAbjoH86pu+1OoxjeTYU/3tdUOfH2WwY4=;
        b=BqGCzj/G9jhFSsh2Za755/LzU6uyT+nqeNHXOXWrVvZpkLqcH6kmzgf4tPtVkwkEU0
         wyf4WLzEQMX1M5SRb9clyi+Wdlay+Rj3eHfkjDTKRJCeBQ5oJAaHdR739mCMQ0siELsY
         pMJ4k9VWaGRJ5KWxpNJKYgc2ezLDBvP27pFM9/oAuXmwlEVFp9qUZnpYcCWRIHkcj3AB
         vZ2lGqYF2zsUly9WRW5AgoT6GXIqqR4cK0IiLdb30LSDU5k9ul21dtva44MEhEtMEhsa
         4JFzDwH3I9iI/ebxA/XSbuogUGtrJJo0jsA7Qcel1rqwY+WfQASMKFs9+z71WRRioqem
         0bXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003909; x=1708608709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGh//nbX6ksAbjoH86pu+1OoxjeTYU/3tdUOfH2WwY4=;
        b=s75oMdEHsc36HKy/67bADf8ZfR4i7gAY2Yp4eJITbbI9beAWPvqYH11dNXtGtrEw5j
         VvgLmorhPjfg/PzfdpdHGx/HjBfbGqeG5rDhGlp+Dzm70HIiy+fqV8TDKVY9KQBCkSxv
         JrBL7vxCWnRmWYHagOa1QjHuCvJbQpguNT8kVTsRg+myHuAHpWfXmF0GSrrYQDocDwb9
         XaID4zhUCvdstE8gQwHbicCj6u21xxxwPWuubr6mBB9ZXx3OWq6A6a1VLbPeTrHDQdcO
         xajLLeq71fZDQ+zCAH5XrMHNrw2C/oqyASXxCPDoOKN2DgZ8zd5o6VJdsZwlFLjT/CoL
         WBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs/u99S9NM6jpuD0JTxzJprDdpAFq80euJmOFJ5SOxLsnfJoqHeJg5fLOu9HcwPs0DJPJEhk4ho9W8RbxOJmCpNuU7uCwJDEc7VPo=
X-Gm-Message-State: AOJu0YwSZ9P7N7K+F/RtJb7s4x0S6jRFc7i+pETIvTlHnIDXF7GSdYrM
	HmNE4Z+Ghp4N44B7uxVASKHnX3VTEWtCZhVKxdqfZqH1gfvcwPnXf1nOkMeU1r+YDambPYCFLG2
	84XPRmTFEZ6cSPSX+3Bq1dQ5ioGKY7igF5I+Iug==
X-Google-Smtp-Source: AGHT+IHl3qgWvQCqRJMe39KHtu2wuTpCX4Lckf3lqFQQ+kVziMGrJ7Juv/tfm7isqbWZN8sE5IWX6zuYqEnZ+zYcRZE=
X-Received: by 2002:a25:b949:0:b0:dcb:b41c:77ef with SMTP id
 s9-20020a25b949000000b00dcbb41c77efmr1387473ybm.24.1708003908799; Thu, 15 Feb
 2024 05:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-ktd2801-deps-v1-1-7feb5385eb9a@skole.hr>
In-Reply-To: <20240213-ktd2801-deps-v1-1-7feb5385eb9a@skole.hr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 15 Feb 2024 14:31:37 +0100
Message-ID: <CACRpkdYm0dNZZvzAZ-VQ+MaHeL7NmGCmCVw42WMx6BFf4Lw0Pw@mail.gmail.com>
Subject: Re: [PATCH] backlight: ktd2801: depend on GPIOLIB
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@kernel.org>, 
	Karel Balej <balejk@matfyz.cz>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 7:13=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic=
@skole.hr> wrote:

> LEDS_EXPRESSWIRE depends on GPIOLIB, and so must anything selecting it:
>
> WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
>   Depends on [n]: NEW_LEDS [=3Dy] && GPIOLIB [=3Dn]
>   Selected by [m]:
>   - BACKLIGHT_KTD2801 [=3Dm] && HAS_IOMEM [=3Dy] && BACKLIGHT_CLASS_DEVIC=
E [=3Dm]
>
> Fixes: 66c76c1cd984 ("backlight: Add Kinetic KTD2801 backlight support")
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Technically you can also select GPIOLIB, because it is available on
all platforms, so it may be easier for users, but then you never know
which GPIOs you get in practice.

Yours,
Linus Walleij

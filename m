Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F981B4255
	for <linux-fbdev@vger.kernel.org>; Thu,  2 Jan 2025 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735853534; cv=none; b=T6rJ5CWGOwE9ju882PKlUE+ZaQ4HzPw+TPIsgM86UGr11UPXjc0ok6ieQu8QJ+z9w1WrYVzrhfciGjJo65zlstL3sj7Jg0I5QDCPJW15n0VqF0GOq/2YWl6Tu8Hrr32HQiihiVvsWEL0DFKcLBwW3xOS66bpmXGoVrajcK4qqzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735853534; c=relaxed/simple;
	bh=Wtxk84fUxHeb9OopHDTm5hClINIiEiJ8Jkjyo0bNZEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIvp9EdKjlGS/alInAYYnG6A01XpDTLnJAve9vRtpIUjXXi1UFsA7cyt+sIsEZWHPtCyTNFNFrXomhx5s/yqmlOVFF2wwDMarVlrNJkTdGJ8VGAZTt35yQ5xpX8Mcg3GCI1GO3ElZojtkFdH6HuOQQbtgRS0S6uPMHk6YueY9bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EGN1QV3Y; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGN1QV3Y"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-540218726d5so12485137e87.2
        for <linux-fbdev@vger.kernel.org>; Thu, 02 Jan 2025 13:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735853531; x=1736458331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjY1FusYh1YryKHAN4zvFm2UZSdXvuV/zDLKxw4TcA8=;
        b=EGN1QV3YYDljyw1O14pYN3vIpmQE9XgnQDFXy2vj3ZuaYrhO5qdOJUCZQR0/Cy5sL2
         k+nKDglR2vfWJt5kd8gDjzr4zlSyB66Tzc+uLem8vlSw40OMJ4YqyGHoLv3RKh5Zg6/Q
         0U/eEH7PpO49saSyqFOEHAsXLB5qUTXhWBl4LkV+0gmsiTMxCr+tQ1nlZKXto+kqRCI4
         Gei5oW7zGm08+/nrbvm8jIRV+MoAFmmfq3oAc5pp1IsmescVEiD0+oeRGV0U/UbCwpat
         ShAenP2j9PFTewYwCURtnz8hu6IuCZq36qTvybOkvHkRiFg69ciPHh3j3QePp+7tGA1X
         bPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735853531; x=1736458331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjY1FusYh1YryKHAN4zvFm2UZSdXvuV/zDLKxw4TcA8=;
        b=PGvL6l+vxYOSEnShqesqkdASkt+uWmgzcJYC372xz7eSW63M8c6nItGeaIvwjz2RPY
         cxRiyzzloBSDV1Bm98QqETG1elrRaZx6Cfea/7N4YMaJ8GwBe3Ql6kn5RKladoqSPiEI
         xTjprR8MFfWj/m4AA2L96iPd2f9Mat+aJ36/n9ljxhIgDT2hA53PbK2baFEnrqDFoFWz
         ZjSv2kcx1UAHmRJkKrOwC5ENx94UyZpPwM5ITEv+a16LptomjJY87PAL3zJtkZjq7RGo
         V5sbOGs3l+QOF0yVl7Zyejwo01c1vTRhw2ixQwbXzT7CM4D0H0oVxk2QOv61MX/vKn2z
         bhhg==
X-Forwarded-Encrypted: i=1; AJvYcCUzLV+OYtH9qiFY87lBxX80zfZyh7oOlMDaUGatxmV/yOUgposLjCJ8OJW0XmvYWkLUsoWYpcKKvV0h1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBMB5mODTFO0a0OpQatpBWBu4vfRfvBLK4NWjJcWfbGveJ0OJx
	3Oi8VUiajaYJl3uc7fED+/3J7100V0Vmnm3JX/M/2m8t6KD9nOnGmwgSvICu82TuLO3NqFwlRym
	2NawBQGUEZGMCRyG5vvaSWahIzGe2oppuLXpUcA==
X-Gm-Gg: ASbGncs6fBKLYBswRxMAc5TEbZ8P2CnRiNIYw9lUgM0rXhbcPqJteIZMWwkKQKrbmzv
	o/+NnadO8W87TgofFU5EkwRf67hfHaIFw4NND
X-Google-Smtp-Source: AGHT+IFlli5v1Leswr5mSGgujdwQIN4FjO+4y/Gz8GAuOwdSl6akwXzEIS6HSR/IZ1Qe161dv3tbI4KcYzqniYCjvoA=
X-Received: by 2002:a05:6512:1283:b0:540:1b2d:8ef3 with SMTP id
 2adb3069b0e04-5422956bf40mr12610797e87.52.1735853531271; Thu, 02 Jan 2025
 13:32:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102181953.1020878-1-aaro.koskinen@iki.fi> <20250102181953.1020878-3-aaro.koskinen@iki.fi>
In-Reply-To: <20250102181953.1020878-3-aaro.koskinen@iki.fi>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 Jan 2025 22:32:00 +0100
Message-ID: <CACRpkdbfuQuTQ028=hZgRhOPiw5AbPLyoZTbRCbvNDQ-e8UajQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Input: ads7846 - fix up the pendown GPIO setup on
 Nokia 770
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Helge Deller <deller@gmx.de>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 7:20=E2=80=AFPM Aaro Koskinen <aaro.koskinen@iki.fi>=
 wrote:

> The GPIO is set up as an IRQ, so request it as non-exclusive. Otherwise t=
he
> probe fails on Nokia 770 with:
>
>     ads7846 spi2.0: failed to request pendown GPIO
>     ads7846: probe of spi2.0 failed with error -16
>
> Also the polarity is wrong. Fix it.
>
> Fixes: 767d83361aaa ("Input: ads7846 - Convert to use software nodes")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

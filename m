Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC21A17541
	for <linux-fbdev@vger.kernel.org>; Mon,  4 Mar 2024 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540457; cv=none; b=mHP6M4SoDJ2Jethz2nQFzguw4kexnm0rksq8wPQuv1YwMIyjTolGfyXIODj1NtM24rDI7ZfeHB1kDvIXb6vd2s4NQdB9HYcNZivOXsNK1CmljLxOeobq0VgTWEY4k9BMIB67WPYEYppEd16p69sAGUfAFAo4MQNMrBX45iS+Txw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540457; c=relaxed/simple;
	bh=h5skSJ29Rx6hMZ+bxWVfh2F6h/C4mmQL7SPqvYCARcU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AA9+cJ37AIHfCABl27TiOZHezYkEILq4XurMcSQ7N7c8+KKO6nMZjGASfxnGY+35B1xBt+RxB1+amzAfLFmkrIKrN04Z9ZxoLt7+zAJkomyaYGLMedESI953aZXJwWwfg5e6DyJlxG9FFUfOJH3kN57Y+uOeZux0fWj3RAkOh8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=btDQsP2I; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btDQsP2I"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d371351b62so103250e0c.1
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Mar 2024 00:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709540454; x=1710145254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yyEcn3m2A7yavQvE00TpjSl9UF2QJItgWnXnzeCS3YM=;
        b=btDQsP2IT56FcWf2WcP40xueffLSrtGE0oxbS3l0iP96DPZVY4rOlxLi7r+01vDos/
         D1ZzVTxKNMVXtQAUiXE1//XsZyERj6Xl0zb47/YwqYJIU3wa3CU+RjC34a8TKcbsMUtx
         5hasdMWTrQC1fS0R0ryyM/grqTfsUFOWLwdJ7MNykPBfZIdYU42RWbhQ4DLtw5OtDzrv
         eApK4+bqwML1Uc1fe7jrXpsQXCG0aDlfRJ2j7plFJtrJjs+Inksl9uc1UI02E1C2UB9n
         RkWR0CsSmnhG3wtsFdgekAKGMDsFgRuyepQknNOuKOc6q/dI7DTz15VAOIWme4tQpqn8
         c7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540454; x=1710145254;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyEcn3m2A7yavQvE00TpjSl9UF2QJItgWnXnzeCS3YM=;
        b=hBWPBCOzeyOs/iAl07KeWnJEX17wm7JV/NHPRSLSYG6IpyMTqsGWO+suNGyx66Verv
         H+8+PhksXF0YcMwX+/fJhNyPV/J3LNWexZHu7bLRMUq2tBmhLinaWAOrtEZbdojxR17c
         Y4inhzuMBA5sY3icxx3y9hqhh1a6wCj8h2vPrJvr6kqCGxrlSeOkXfc/QkGA2mQBNVKQ
         ZFwHhorbbEU09Ot068XoZnpO6JD7vjdMzXLwnE3T1DoLvWSpA2ENObNoSlvyjr4qtnZO
         cx2MPciro61SM6obEUl2R6jHT0Mdfl9dPCM6yMVFJHhJaFMLaAyJPA1CnDG4UJxEiyPf
         VgLg==
X-Forwarded-Encrypted: i=1; AJvYcCWmiGTg6daQC9FftgdhIksIxKSucVCIBl7dsvbffxr89dkzA0BSPeZN+Ip+qwIQEYSujQuKRZr8f+tqX1VaAHTCkqwFqrJPa33Px44=
X-Gm-Message-State: AOJu0YzonkVO0SIIJfwyQKYzW236x1M3Pc50M2C3GYENRqLze5tsqQWk
	kOvkIV+7jUTJ39EkbkmyR4FWaTzheyaXkQDWIyfrYguIhteY0v+vSMWfj1uUUFqTLPosLMJuJme
	uOzKSFJW4Sw3tf6apbqT22+YS8Z3F9iExIaxt5Q==
X-Google-Smtp-Source: AGHT+IHi5xUT6VReqMwudYvcimoxVjZtj0eGM2mqhV92LARqhWB+invYdIZQv1GlviuVLJkoncYGckQNqOnQq2cbuuE=
X-Received: by 2002:a05:6122:917:b0:4d3:4aad:a8c6 with SMTP id
 j23-20020a056122091700b004d34aada8c6mr5928625vka.0.1709540454609; Mon, 04 Mar
 2024 00:20:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 4 Mar 2024 13:50:43 +0530
Message-ID: <CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com>
Subject: fbdev/chipsfb.c:401:31: error: invalid use of undefined type 'struct backlight_device'
To: open list <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The powerpc ppc6xx_defconfig builds failed on today's Linux next tag
next-20240304.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
drivers/video/fbdev/chipsfb.c: In function 'chipsfb_pci_init':
drivers/video/fbdev/chipsfb.c:401:31: error: invalid use of undefined
type 'struct backlight_device'
  401 |                 pmac_backlight->props.power = FB_BLANK_UNBLANK;
      |                               ^~

Steps to reproduce:
 # tuxmake --runtime podman --target-arch powerpc --toolchain gcc-13
--kconfig ppc6xx_defconfig
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2dDE297yLFrAr3gigIDy8tIleDh/tuxmake_reproducer.sh

Links:
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240304/testrun/22919857/suite/build/test/gcc-13-ppc6xx_defconfig/details/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240304/testrun/22919857/suite/build/test/gcc-13-ppc6xx_defconfig/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240304/testrun/22919857/suite/build/test/gcc-13-ppc6xx_defconfig/history/


--
Linaro LKFT
https://lkft.linaro.org

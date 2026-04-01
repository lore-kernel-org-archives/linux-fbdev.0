Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C147A0C7
	for <linux-fbdev@vger.kernel.org>; Wed,  1 Apr 2026 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064814; cv=none; b=J6jyRKbu2nItySpDYmjKWdS7xMhtT9pYbD63xKE9nvdZIlxLdmZF7JF92pTL1wUSo+QxpWKQfESpoyGuVl6OJE7w5ieP7Y0Y0PgE7cJy9sO70HLjofvUMUQdV8Gi/9S79q92h8ODkmfGnN6TwIEuuNqDdOGXXa7p51YqK2jMB5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064814; c=relaxed/simple;
	bh=9h3k+SWXPgCXh3URQw2m2EnXgwEp8fqiTGDr5MkY+Cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RkWhX8kjV+M3CC+r26pu1fRafgj9Alkl5MYt41qStpOa52/6b6We9RFE5miDwe7BgTsaowaWy9shq91dTNHP8axAoAnXGLkW0S/Fuo5mwgYEBikVp4lgzVtkbmd1Uh2bUYynZzA3vjRBczbd7IY1ChseRXHdnm0vLgmyBPHrED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Kz7bYdSB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Kz7bYdSB"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b23f90f53aso47194085ad.0
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Apr 2026 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1775064811; x=1775669611; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUGrmWIs1eqe1Uc4sRH3g6ZJwCj+Y/CkFLvTuPn+h5I=;
        b=Kz7bYdSBCn8LoFfzqJsW5l6vF0lGMPkB1Ay+7wg2mQfu5i5K+Z0pXhuvp+9mDXUsCN
         /sFLOBjFPsf1EAOkc6mBhCHyCwK1cx8MGNLMcbdPhrXBhkrNN7hZ17PdJCU6pcHNUEej
         ZzIEZ97AUAbAVxbs/Le9/nP6Vn13WxWI7w0WyxLKjuo6rfrCJzDjgVE/5mLBkiDZgCf9
         wZ2PTAvgORD8Z/X4E/YtzJznt/HxeDp3h/cWUEi37WHeJkEeBhyb2fJI8N7R0Jukm6++
         JBdVRAEMKo+PNVxWZ58Xmvt+/yEV4ihREPD7I3mpEcZOmyumLH1yW0d++a/AVcxkzs1F
         BuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775064811; x=1775669611;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUGrmWIs1eqe1Uc4sRH3g6ZJwCj+Y/CkFLvTuPn+h5I=;
        b=IVwQVS7+fvRbtarLuEMe0Ge+yzFNjBYK9e0ys5P/7D5TuiYpZdKoSRHzInlQrmX3oB
         kNSkHpdkAOdqgJ9nPQPJX3m1igcbk9Pj/Lktn605A6d1cObxITTvtSvZvMi55yInLUva
         jV4LaFBJOCERKinEXdyvcnVXO50P69eQMjS/tD2RCMhA6szUHauzfYW31wivNjyPxNXv
         kpW3fYaczLCL2AzcPP839B0+epAAX1Pn0Pp7cToGO1YxzhyoRbXRUKxWrWxH5nIL9QlS
         XUXj8NHutXubzq+GwV3AZ6j9jh9TnEJ9GSoMeGwhwxFPdUKyNqE9lMok7+YxOK23qE1o
         +W7A==
X-Forwarded-Encrypted: i=1; AJvYcCViT/xmcHhXCIQrgyhbLi+P19nhf2Z1cj8qLuiD/lnV3tmEoiD+ZUJ3oPseHj8djaN6kLeFBg0Xeg18hQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSDzQ5tylHCoHvQeGfdlkST3j0h2+cLF31bIyUhbfSvE0cwCgl
	fgXBMEgxIOzgEp+cjnaHOVV95Azxo8cOlu4VSrFoxo2vnAGTYoW7/quZ7ES5C6+YS/M=
X-Gm-Gg: ATEYQzxkrcjunNHgqTEgEBdgSl4NK48qX3SoaQIYWsJnQBh9dJsW3dktalOFXpiz/CR
	ZraBmjCZQxlB15lMCRixDo6sQfXVNW/LTD0j9B3vVNw3qhqTL6J6aZ/DhHkd07s0cV0REnFTm1m
	pXFCgb5yP/P4r29nSBax1MecOKZqyCUgJ16QHGB441+fZRW/PHzrcX9Vnaqm6GXIg0VNdB3sEa+
	PhJCe9NekKDiEiXkadI+ghJDItVWhIU3bvs0mCnvcW+uAC+6ZaocF9rswWdffrGUfDONuZUegY+
	n0ly9yKm45FwWCDkH55RPiyjFL7D5E8ejd8yuRA3jCiQptuRz0ra3YFo5T6d8msTIN+rihsOSAP
	k9Fjbxg0CB1igzlfy8R6RjK2DZNS2tKQPdAXCwOFqEBBiZWPpmrNXTExixapQ9g42q0n75K2/NI
	r/Bd2Mm5NsSerzcHHREdI=
X-Received: by 2002:a17:902:f54a:b0:2b0:6e12:bb21 with SMTP id d9443c01a7336-2b269d4af02mr44706185ad.41.1775064810785;
        Wed, 01 Apr 2026 10:33:30 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbca2sm2974705ad.73.2026.04.01.10.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 10:33:30 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, linux@armlinux.org.uk,
 aaro.koskinen@iki.fi, jmkrzyszt@gmail.com, tony@atomide.com,
 andreas@kemnade.info, rogerq@kernel.org, arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, soc@lists.linux.dev,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] arch/arm: Drop CONFIG_FIRMWARE_EDID from defconfig files
In-Reply-To: <20260401082533.214103-1-tzimmermann@suse.de>
References: <20260401082533.214103-1-tzimmermann@suse.de>
Date: Wed, 01 Apr 2026 10:33:29 -0700
Message-ID: <7hcy0ivb4m.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> CONFIG_FIRMWARE_EDID=y depends on X86 or EFI_GENERIC_STUB. Neither is
> true here, so drop the lines from the defconfig files.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/configs/davinci_all_defconfig | 1 -
>  arch/arm/configs/omap1_defconfig       | 1 -
>  arch/arm/configs/omap2plus_defconfig   | 1 -

For omap*_defconfig:

Acked-by: Kevin Hilman (TI) <khilman@baylibre.com>

Kevin

Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C81D37CD29
	for <linux-fbdev@vger.kernel.org>; Tue, 28 Apr 2026 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419355; cv=pass; b=oP8X8gI8xkbfuypbDVwAS+1XL2Z9AchvsYgwn01PEwsJqHbVoMWx4mgk5IjmnONkhJX/fWZCl1bkrlc5ByRS6puBo0h8C6HE76sJnIE15B29l8ecfPtVS4jRBP5rnuvHhP8NVuqyObUKXrSR8YQ01uS9q74V0WWswrXP2ttkzSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419355; c=relaxed/simple;
	bh=p24DGe2ChYsLvCmBXf6Kp5TWFFLOr7i+/3Xsm2m1l9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VinKe5e3Tvs0Vzp7qomozAOVuokyUTE1WTx33Vdsnw2jpbUGEk9IrzI/OgYkpUgVFY1i62L77BTDk79keAILUYm+hsOz/EEYU4APXtrpbAxl8WoTuQeYaiVn/iC8aEVjqmZ1kNQpHNVm9Eiz2aJ6NrpXHxqAthimpda3JJzv2yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqhu2+sG; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqhu2+sG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad9f316d68so52940675ad.2
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Apr 2026 16:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777419354; cv=none;
        d=google.com; s=arc-20240605;
        b=hbSJ16aXmyV1h4vD9qMefGYRTtSQC+By/8/MiHqv8cIrMV8rFm5bTUaWX99t5DnkAz
         9g5U6DnQuzkV8My/PJdwnRlEw9c2H1uxbvE5U2dX7/uZJ0HehIrBoLSuwJiRe+dEgq7k
         UW2J3NsptyYOlpb6AqdAB/s+/deHoGt1Q0KeE00e7YZRQhNxoBgf3pWkCDo0DPvDiDRn
         blFZEU8tLSw/T135hkks1wOOmEYnENB3POFjVcDr+omdeiAtBLRHJpp4AFKvkCEHAMFn
         ucayNXlM3lyO9awvkoNv+FrUd+uBtWmZBic7OVzv3fjhIVJp3+w+zOhOGBSE9pCfX0Xk
         726w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0db33wYSB/VKxNPenizKPNWOjqB/3saiIIrw++PQlmA=;
        fh=dGcToyzx9m1Pj1EU76YXGn61UOdqnsYwcEaattM0DSU=;
        b=dBaPvGF0ZVspK/hWN/VNSaJRRL6CNtchcaPlq+b8NTag9YqDMiqgapshXhYWEeG4lL
         OmmTSwxSzPT6VktgAGQA+v+ZwyORG00jsvD+PJClLEJAXM0iQSogz+KsllD84eJ/GDdo
         abVMMTFDpHkfAN4bq5INl6qUtockVwtQKwZXHl3oQGKx1Ro6vsACV3+8OwF5Db4GgOlF
         bENajDhK/SA0CVqJ3YJi4/165WRTxhfMb0BNTutjM/WJHC+NbM3vhuICbroC5Yi4iYkA
         SX7sJwRshAUW4kMXbsUO7zND+XSlUd6EdXmQMfe9wLj/Q+v1DuGLebXnlpKYSthaa/Ot
         u/dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777419354; x=1778024154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0db33wYSB/VKxNPenizKPNWOjqB/3saiIIrw++PQlmA=;
        b=lqhu2+sGzhBTsyZRRos2jZ387BvKCfAcc1fKf1A/JtGEisIHLLncDhhkhhRlvdUIMJ
         Dlg3Jve5tuMahEqtI8RpjhflyeAMzsEIi3hfFO6jBbs2PLnQBwAKxE8w8h5rWhIu/b7h
         i+1ggRanMO3AgRtgI6tcLrx4Anl5NaM4VL1nKJ7UaCeVYW34Bh8SvOqkrjGoFf+B4m3z
         XwhrlcC7MepsVB3dW4Sa6QjGUZJZW5ERxk8/PwiX1ZKWInGa07LASTJi254vjO4TYUf8
         KsgPXB1etH51a2Ky1hoCINE5EHN+oYpO5Ep8rRjv2b9Dl1aRPtQdeWinaMksZwxTenym
         bY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419354; x=1778024154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0db33wYSB/VKxNPenizKPNWOjqB/3saiIIrw++PQlmA=;
        b=jkb/F1O/g2on9z7Bf+U1SkIpMPuyIunOQaCESgqkWNFM9sevRo33oX2r7EC8Un5DcF
         xPVDFUUxJw2kLL3lFOrY3wj3zo57bmeOf1kJLMpUVjTSNTMj0NVXJj+p7+8u65y6MAMz
         E/3moDbvTcrfg6zm34yb0TJ9W9fW4gxi2uWx6+ayQvtgyu5at8e6ERAUj8rOSMGwsVN5
         piJpkx7xCzycbv37UbDaxlgjHOfEYWNSw/dTJv2Uco2wO+pJvUbZ4xkxEwYPSOEUS/rh
         TK1Y6zc25DoVSYNAbavP912J6GueOPTXl32l4RsXmB38AwsBthMENbl5wEX3CEDH7aT3
         b18Q==
X-Forwarded-Encrypted: i=1; AFNElJ9af3hehfqB7aozQynGCRwrHDDQvmXvbexZorBZBPTC54P/yacJf3huw1SnLb4rD2Crrkqo+XBD8mshgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ipizCa+1XAy7KhQ2T4tyO/hsPEMk7dH8KfWhnKOD/HaznMO5
	7NCtsKIIcoK98xnfwdSi0OmVpFAn9987Nnxhz8/BWi7wNzNdEh+ku8qQEAI0yxtdbEFrQ4Vxgvy
	LUn0k2F9bkb9TnDGrC+mNuiT4Z5lOJms=
X-Gm-Gg: AeBDiet3py5FhfXMIw34m2j+k1XYqJAELjC9QB+gnQbcdUFq9VqmLMhZrFRnn7n6Rk3
	ziyGsAm+DEJX8m8cfOghvaNR/S27QQJZton+37hR7QlXpJ1cGMAmeE9/DKdiZytBff3HTGkQwPK
	ytR1+tN8wQ9bW1QrE/T7owiCJjbskzq9s2hV3JnqLv7XV0+rDvaMKTDKJmVocWrp5KI8KkyeF1j
	gZjsEJwWitUBpOMaljtuo2HYkXzMKLFSJdqEMznFH7thb0Z3FHUgJNQsCNve5G5/KcAqgUDHZZd
	gyYkc0bpXLT2IJfMcqGIh5J1iZdybwdXu0bYqQEsVaHU3PEVwrk=
X-Received: by 2002:a17:903:1c5:b0:2b2:4b4e:e4d8 with SMTP id
 d9443c01a7336-2b98730ca87mr13536075ad.4.1777419353607; Tue, 28 Apr 2026
 16:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org>
 <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-2-0caade5fdb32@linaro.org>
In-Reply-To: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-2-0caade5fdb32@linaro.org>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Wed, 29 Apr 2026 08:35:41 +0900
X-Gm-Features: AVHnY4IUG0aEhSqiUeS0javv0LFZ7gitoer-tm54oLakxbwVeIPwDa7HUcbCYTI
Message-ID: <CAKbEznvPAYFUt-ykH7rCQwMFUq6N68B9x7Dd97WRDm3Mvj34fw@mail.gmail.com>
Subject: Re: [PATCH 2/2] backlight: Add SY7758 6-channel High Efficiency LED
 Driver support
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

> +
> +static int sy7758_probe(struct i2c_client *client)
> +{

> +
> +       /* try read and check device id */
> +       ret = regmap_read(sydev->regmap, REG_DEV_ID, &dev_id);
> +       if (ret < 0)
> +               return dev_err_probe(dev, -EPROBE_DEFER,
> +                                    "failed to read device id\n");

regmap_read() seems it can return errors other than -EPROBE_DEFER
(like -EINVAL,), and hardcoding -EPROBE_DEFER here might drop the
actual error.
And maybe would keep retrying probe forever

How about this?
> +               return dev_err_probe(dev, ret, "failed to read device id\n");


-- 
Thanks,
Gyeyoung

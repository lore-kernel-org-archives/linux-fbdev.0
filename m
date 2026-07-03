Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DF437C0EC
	for <linux-fbdev@vger.kernel.org>; Fri,  3 Jul 2026 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068630; cv=pass; b=PBtawLNOTgjDJPF8BA+V19oM7LTgCvX5mQqLbEe5aEoxCEp5PQS7R6ToIr3+eW5F43Hn9xmZiiRUJyY3fZPjwwwCPT91aai2GhkIwpT80O3vto8s/K0QsUtCkjMKBbaUTdmUJ/xGtIjEsKpOoZGhiEbRZcbQ28W/od0TOzSN03Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068630; c=relaxed/simple;
	bh=JIGfUZOnaS68j2TExBUBX6hHqwIcodMVFuEw4DTpCW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wu/1pYGn9CCn907fynRGqmKQk6NVCLCuc/DjmGqNcaOexU5PD4tjgpkOjFS3l66PPgelzoSpMxNRf56ebGqTitJCFnYa1AT9J5ycdFSklsTzGIuvWpLscwrQUAU275WaeziSpFD8c0P2W/vYfmNlPVKpLpotPSqaMFVHGkBTHmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp35/55s; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp35/55s"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37fa06b39b4so293012a91.2
        for <linux-fbdev@vger.kernel.org>; Fri, 03 Jul 2026 01:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783068628; cv=none;
        d=google.com; s=arc-20260327;
        b=UIt3Xw0s2K63pPS1HlzK5ZXeaSKmkcsJdClwoAHdy7hl/IZ26sP8FXWUAh03BcsLb8
         zUtAZFEbZo5cmB5aUndvJCkwz+seY/wNjhY698Lh1CKgIqcu82NYzWk/Cj1sjyF7IDqo
         pdqzJcN1YPx3zjRDO46me81StyFnR7NN7SkhrlqN8CakaLeFJoKl3wBO2E32ZxcARTyc
         7y0g5ybLwasHNqaojESay7rQHxFiUiUlmMkodVocqLMz6L5NYS3pX0CdKBffc8eKK30c
         E0pw4Fl3VdlvwzJwnfyXADfADHmE7b6AEVaxlKTGTw1Db/fEIZ+rAcM5GjP+bf1+c1Lj
         nr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JIGfUZOnaS68j2TExBUBX6hHqwIcodMVFuEw4DTpCW0=;
        fh=nzS9Ddj3qkmCERRDAvb2jGbbijmswa8yUPS0ovKRsIE=;
        b=AUvpwp/NR4DS3o0unEalgFhQCSAgIHHwRL+/x4BHa1YEGBTyxhrT3xRmMA5kH7gSFi
         g9b71NjiNa8hnoZ2yG9/58Y6pSesf/4t+puITwX9m3wslSXxUIwoHSsKW1L6mJJiia7j
         P0Gev0loKfSRDVUj9MBICVjQ11fzRlcNETfLihLOIzQAK7A52w96ozQyKCV4Ji8eY/Ap
         O/EKSGWPagoe1UUxPEGsz4DeY08I2R7aC3/TqAvpMGNuq8UAyHGD/Uyh+TUbg8VaJUTq
         6o5ZVhmPW2G47bmAOQsdMy8l1ug3KqNRSBuiL5qUgy79Fqg3KhlwfR80eaXjy1dIaT0r
         Gfbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783068628; x=1783673428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIGfUZOnaS68j2TExBUBX6hHqwIcodMVFuEw4DTpCW0=;
        b=Yp35/55s2vBK2gEHGs8sgoI4osunm/jZFHkATgRYASC18u4qN6qcDOA83y0Cdxh+o6
         662moOywNpzPRSm6IfkxhQGHxJCFKGZuWl7sBT+LyeT8WG3ey8TijM8RdF2Wb9UG7IHf
         Z+u8B/sfKHEOfDIhY1mm2KEYg7Hd/7HHLOj5jVWz0EzKOSpm8yhwNRd9Xa+5gBtEt+qA
         J1yriTyygEOyXJgZ2983NY98/f9+OH9YXN6AoD/E2fMB+hnW0yiaFpi2qnP9Axtd6LWw
         Y19k/WHx59Oz1dyeGCfMHMJSwufeMXvUd+o79pWRAM7jVwsUyEbjAHBnvzl8qk99dTuw
         Ql8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783068628; x=1783673428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JIGfUZOnaS68j2TExBUBX6hHqwIcodMVFuEw4DTpCW0=;
        b=NJSeCsnfpxqXxwiM5MuGMqeO5vc0FfG2QtCo3uYeXXg8hC2LKGfZ/8jo7k96vt4doB
         nJSGLaEOUynBHi7ZyRphAQWYRWOdGc5/DzAZzN+luYsRq57bmuhxyDWPn+OMFCSTsHlg
         uP2vhD2Sm2BDBd7X66phkMLyTbEfDzeRZV42JMqJiLVPLwDSnvWVTcwX/8bggdIemyi9
         MJVokw4VvFqxe/053qxErjj8aBDST2kxuJ5MAzG8U0VD/8RJNqD4oV1OeeyVbu5921It
         MjFiGFs4v3qEAW4y+gAlZJ14Qlcz5f0uiy0V2RUwTd0TfVq3Qn2+YWdbr2vBHLSY4OY8
         6v2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrOsTxxsqkp3AcFWQWWRIg7OoSFLsBPex1tXspd/6srA8+2hHRBwkFgSKqXnObkF0W0vPnrsSpmsROEqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2vsqD4aNq9VTa4cCTX87RZ7WnJ2mqwWBiUGbjiPazCBkEOfPg
	RxYnW5eGIy3jO9Q7LR56owTzQbfsryFmLfDOPq+0EiSQQLdXoS+2CdkkGD+4ka19S1UmxmBP7//
	CMfQfBEmDxjduywAcCXm8HbrfuHjw9G8=
X-Gm-Gg: AfdE7cltyskSQ/+ktDq8MkQgS0cxa5MytN8mQI7DACCK2vk/UARlh6VZ/deMHqljHU2
	Ch9meWeu7ZeW6l0uzBImpIUIBwQWOs4xRzUQvcopXKeySyVabPGCnd33LuesxqXH19e9qKI0b0h
	638Yoi/FWt4fsa2FK7sT/rkvUUUkZOZlG5U8q+atRQc7M/QooBTt+JBc3YRGul+T8MirzxF5DZS
	NwKQOdRa4rnsnHirxnI/I/Ha2Ua7/Kdgm/4w2c1rbzBFBXYVoCpsL2VZAfsk6RqHcdefcBYy8q3
	GGSX5omjTf4leyvzloEEtQ/y4vb63A==
X-Received: by 2002:a17:90b:4ac7:b0:37f:9ce1:cdb2 with SMTP id
 98e67ed59e1d1-380aa212cd2mr10449000a91.32.1783068628598; Fri, 03 Jul 2026
 01:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260702161828.GB2108533@google.com>
In-Reply-To: <20260702161828.GB2108533@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 3 Jul 2026 11:50:17 +0300
X-Gm-Features: AVVi8CfxYzwSfzZ6fk5dLYRyOYewH3BnmAC08YjOJmTVCgpVqq5v1ruOm9aDpBE
Message-ID: <CAPVz0n1Pozgz8DBt5BrYSktVfE=D5E41oy+fMODGpx-L-qQ3YA@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] mfd: lm3533: convert to OF bindings, improve support
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 2 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 19:18 Lee J=
ones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, 17 Jun 2026, Svyatoslav Ryhel wrote:
>
> > Convert LM3533 to OF bindings, add missing VIN supply, add support for
> > setting mapping mode and LED sources based on device tree.
> >
> > ---
> > Changes in v2:
> >
> > schema
> > - maximum led sources for leds set to 4
> > - anyOf > oneOf in ALS
> > - improved ALS descriptions
> > - adjusted example
> > drivers
> > - dropped devm convertion of irq and mfd helpers
> > - all als configuration moved into lm3533_als_setup
> > - added regulator/consumer.h
> > - lm3533_bl_setup set before sysfs_create_group in backlight
> > - added check if LVLED is valid
> > - LM3533_REG_OUTPUT_CONF1 > LM3533_REG_OUTPUT_CONF2 for LVLED4 and LVLE=
D5
>
> This set looks good to me now.
>
> Let me know when you have all of the Acks and I'll merge it via MFD.
>

Hello there!

Jonathan and Daniel added their Reviewed-by for IIO and backlight
subsystems, so I assume that should be all required.

Best regards,
Svyatoslav R.

> --
> Lee Jones

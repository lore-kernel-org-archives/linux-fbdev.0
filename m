Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B873559D6
	for <linux-fbdev@vger.kernel.org>; Wed,  5 Aug 2026 23:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785972024; cv=pass; b=MTyYjXKwmdXxG/rh1G1jzRbmaqQRr1xv92shPPojAqCkGeoZOxfOVLp9GAGohHEwnvsWsKhMOyxRoNDV1XZdIBdT1UC/Za3J/MgGSJAEBySdCSDhPsef0LcX/lP8tD03aVqVMku0cI3TETNiVf8SYH5WxgNxJiTR83eR/AtoAT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785972024; c=relaxed/simple;
	bh=jmKV0c/Se8u8yIt0ZvgkJGPo9dNxUWC90XubqPM7Phs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u86uz2/ZqSgo7qKPMMeLljby5tKoTIYeTR1kerHBQkdlnINI9gYeTg4ZeY7116kfJw2T6seQsuQcfkbK3JgU0eCGsge4iKw0oE7MiH9k3SsdwFz+lJu4TFcxhnX+UiimKpxCp3p5FvUgX4qFum/htqGp+s4xdSwxaoouUNAvBsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpjWlL69; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpjWlL69"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so1771820a12.3
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Aug 2026 16:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785972018; cv=none;
        d=google.com; s=arc-20260327;
        b=IhQPsNRZLM+pYgmGpyMa3yUnAbpQgyLfvEi7HHkp+Ho2anGcVYiOAhOY7PjnQBYKs5
         sv3s0hq3iV0uCrXBtvucENPwG6GdHce7xLTkdJCeJtWX+oMIIr9Yed4PEaxKtvJmr/dv
         QrXU2+egE/7UmEYrbNc8t1NxZh7g7o0JUmjnh9ooq9NON5/eEwunI9xTRxm0NwG6INOy
         UlBb2YTT3/VdJaYhlbedXMaEAqjTNG9N4mflUTNDA86SEoa3GsWkDjRp81XAwytxTKmu
         7h0i9Dw6MNs82z/r/VW2mAB+m6m/GrRiMmK+DWOn4miGCSLiABDaGBUEXzdN6TEdPqpS
         uXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2BGPSf6QpIXJkxFb1vWvogj5MGQC0tI4OVE79dWp2GQ=;
        fh=4LtbgmunMGTFaxpoJGeLx0ep91rq2ELxnJxlVQRInzg=;
        b=kZFcwY3iyn5uDMvV9ul7vT3D6G/aKOP7zfoPhIOr56NNV9Lue0cxNzgZvcY58Jc7UT
         UkTfMjUTdaUkV20vU+xzwyOJ2mKl3hIVBVxWn/tedvSEzy7ZI9YWWstJN/um4DGv9Gxt
         Uy7aHRUqSaHQTvQiwtOvU1JYEKaIph2IXTIJCbDRjNUndRTpBbX+MAgdu+15UYaCIPDk
         4CEZ7G8TW6//zQ+KFIOWJAUxqX/uGc34acsnI0lnH701nHrJCRL31FiP9lcSZyjnF+FW
         4QqlFvqdYhFqXRavykzv9biCy8NVH4yPxIJ3AupBtW4mzGFbv2V+YRnOuhFvH2B1O6KL
         0aNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785972018; x=1786576818; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2BGPSf6QpIXJkxFb1vWvogj5MGQC0tI4OVE79dWp2GQ=;
        b=hpjWlL69af9NYuq09BB4fDqIuoO5RQrP4pZJ3LAw9euMyIinTo/OOWBiXzv7OYpQmd
         LmOMRIV6GtNFGr/BjP6G/XR4ONTXOE5oKkty00gfjjOX3BvIPawzWAzyITeIQ3Tti2ec
         S4OFvAM2Hi2Sr4i1J8djF46ki88Oz8ebUsiJX7rxA1/cRqB1LeQiDx5iGn/N0pn4gJqu
         +xsdVsow/GIceuXREJUsxisRc/KKvtScZKciFZW5XSucBUiiVF7KBgKoGWSMfnrMT6aM
         oToCvcpvKE9UWdbKKEpXnkYhrbvDoRD5oraoaGgf47UZQKPgxANe5NZDJpPQi9gc9qkj
         OE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785972018; x=1786576818;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2BGPSf6QpIXJkxFb1vWvogj5MGQC0tI4OVE79dWp2GQ=;
        b=Ewl2Wc/C41fkmjeV/OtLC9oNkv6fO1zH4Ydobt6ihVN2y+rFBGlDO07z8SdLMVOyDj
         w6dUS6nObkWUGOwj8SpO690mZKnl+Eh3z5IO16gjiRvkPMrb3x3HmmSShel0ceojev1b
         CkY/M221qWFxdbhoD0HiBn8vZdZnZb4PreExCmrCTDCPEKYcrfGM075j1p6IUpgKk++k
         vEg4GMeVuccr8lGulwm/MMeyZc/KHNmB8LFE0dhDoE6Th8UaQ7iJhDwm97zmNnYz+pNX
         K38voNqky/+Havaw43VH0CuJ2W4mYS/TP9UVoRH/1ZgeZo/SK57QNnGQAbO2phxQO6nT
         YGdA==
X-Forwarded-Encrypted: i=1; AHgh+RqFIIe98WXK+2dufr5c4X1QwrPLBAqOfSF0WkJdLx5pFCfKM2qmiVEcJkeilNpoxxX5Cf54Gi0Z32Ui8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dhdUuyRhBSVVrUaKCuK8PgRiMY84eOVmpEqmzMyrbOsPCZU9
	8utkDzeFYlG2p9+CDOBaNDXR1T1nCMYh93+6UE2SuSu5YORV8HmI1dki2YDASM8wVgMYQkzK5pa
	6YRfjFPNHsuqPjG2ix9LFtvlBDzPnxgo=
X-Gm-Gg: AR+sD13zAXzKmcj1bLYMJXMq5hu2kGdInv4T9L8iDzDYJP4i51E15BXBOkyG7+HJ1Vh
	AZogQUAbZaaIlRFcH749+Rf5eqt8j+RQq+7uGPHXyVtaqe8nphyq/dZ0FtLQUvWTlL5qUHtuak8
	oF8B9la8LMKXpL7MiU7XBom1yJImoBQoR9X1oTfTtBaZBeTEP7L/cMaAmgNitsZbF8kMpaVlm9z
	daxufGl8bLu49B3E1UeClV6I9Y5+7IVQjuD5sBfDdayEI8sR0fUzCgwD4LY33yn6DAicFolvdD4
	rGIpWSXbAGQ5e2G4I6EXH+ci15NqMHtz9OVsb5wbuybw
X-Received: by 2002:a05:6402:2353:b0:6a0:fa22:c1b1 with SMTP id
 4fb4d7f45d1cf-6a14f14def6mr6034923a12.19.1785972017604; Wed, 05 Aug 2026
 16:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804225617.264861-1-maximpedraza@gmail.com>
 <20260804225617.264861-2-maximpedraza@gmail.com> <178589017450.2494424.9339926059212534643.robh@kernel.org>
In-Reply-To: <178589017450.2494424.9339926059212534643.robh@kernel.org>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Thu, 6 Aug 2026 03:20:03 +0200
X-Gm-Features: AUfX_mzOCZNsmfcLq2dg0NuiT9kjwjgP0rCcSAmpyZFQYuYenYCm_iNS5xusMIQ
Message-ID: <CAEUXW=GWjTSoa6iRcA=AsP1xkKdud_rwYvgqXahmzHBYZDPYyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: display: add a device tree supplied
 boot logo
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-fbdev@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	dri-devel@lists.freedesktop.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	devicetree@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
	Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"

> Documentation/.../linux,boot-logo-clut224.example.dtb: /: 'compatible'
> is a required property
> Documentation/.../linux,boot-logo-clut224.example.dtb: /: 'model' is a
> required property

Fixed in v3: the example now declares compatible and model on the root
node, the way the simple-framebuffer example does.

> Documentation/.../linux,boot-logo-clut224.example.dtb: chosen: 'logo'
> does not match any of the regexes: '^framebuffer', '^pinctrl-[0-9]+$'

This one cannot be fixed in the binding: chosen.yaml allows only
^framebuffer under /chosen, so any node this binding describes is
rejected wherever it appears. I have opened a pull request against
dt-schema adding '^logo$' alongside it:

  https://github.com/devicetree-org/dt-schema/pull/204

It mirrors how framebuffer is handled: the entry is just "true", with the
contents validated by this binding through the compatible string. The
pattern is anchored because the node carries no reg and so has no unit
address, and the binding pins the name with $nodename: const: logo. If the
naming changes as a result of your other question, the pull request follows
it; it is one line.

With that applied, a full 'make dt_binding_check' is clean for this
schema. Without it, the third error above stands, so this series depends
on that pull request.

I did not see any of the three locally because I had been running with
DT_SCHEMA_FILES set, which leaves root-node.yaml and chosen.yaml out of
the processed schema entirely. Your message says exactly that; I should
have read it before rather than after. Running it unset now.

> The base for the series is generally the latest rc1. A different
> dependency should be noted in *this* patch.

Noted. The base is Linus' master, currently v7.2-rc6, at Helge's request:
v1 went out based on a stable release and did not apply to any tree he
uses, so he asked for git head. v3 carries a base-commit: trailer from
git format-patch --base= so the exact commit is recorded in the series.
Happy to rebase onto rc1 if you would rather have that.

Max

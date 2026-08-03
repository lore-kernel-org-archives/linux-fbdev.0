Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73182264C7
	for <linux-fbdev@vger.kernel.org>; Mon,  3 Aug 2026 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794678; cv=pass; b=oEae2UiCjQdaql4a7bLKn6Vy3CDihCp9aEu/t/5Rk1xoeVKqj4t3q8YOfmOhsutNQp4Z7lKimIlSQhn7apOl5bKeNz0C3sn3r+HFUWLbbl59mJomSSYk5gOX43mWurV5q8/zwlRMfC8JO5o0aTjaJK4kUT3oqvPmFbRe1rwjHwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794678; c=relaxed/simple;
	bh=7WoJ364o71w8b02TDFU0Hi19/xzHT2Re2qR96++mBVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEOnnjWR2WygBIlYgW/j0GuNyuAbss0aNDS0z6rzdIkMK7BfN/OBFSbDmC/xW1kTiRob3OYoJ7dcDYG0kYh5zIepRsg4DHEtvpmzPE734WVZL/daPJPyvXkcysBZj7LB4Sq49LeZoH1KAdapWA/3as5XQ5VzoEiL/wjGY4ZNpPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRLf1n1B; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRLf1n1B"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a18180so4770863a12.0
        for <linux-fbdev@vger.kernel.org>; Mon, 03 Aug 2026 15:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785794675; cv=none;
        d=google.com; s=arc-20260327;
        b=DMw63kBS0apRyks/wHmsUJAQECe7MmU5bXym+2LCAGdR0cJO7acVdhKGPDd2gl2VHz
         zaobbmT3N/k/HgOg2xmP7B/4EotrApDpeJlGN+xjjFwkzcu4XFFq29eFvsAbS6sVIuW+
         AowUZrOUS972oUbXGWTvRWng2z04Xxsh8Eo6CudWs4t8ulvwqk1SGU5TSqgEhgdcZy54
         Tctzl+U3UtSXCSl474346iFdBzUU1qneuYvxEUn8SpwP+wFSDEijjHWJNhC225YNBdLj
         lB6S6dsDSPDC6loCIwWJiNgx7EOSM5VumTKP+VLkxzHCba/1w3bqwdWAl0Z8BjBSIqpA
         qZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7WoJ364o71w8b02TDFU0Hi19/xzHT2Re2qR96++mBVE=;
        fh=CBhwl+bis71qDBMaly4vv1AunKLsJ2FM/XpAusp4S9g=;
        b=VchawaOguBG45+xdcufHRY5GiK07VFJexn9cu7NJmvuW6jM5UD+JgS9YeMxmby5Jrw
         YPXxCM1uUfnV00LABnFznCzyPwJtRDI7uWQQtIg5hvbhVU6OKvKpMhXCpxoQNYj3bldW
         KKXEp0q3vVAb/p7A1JWDkwK9tq6aKIvEaR5w1EEBRu8hPQFwPpsLr1fErDwFtTz+zkRl
         lpCVcwpWt+o0qJR3xky7TVE4p7qiHJsxG9R2NdlcS1U/csun+eLJzhLsihURdX3h5Wii
         3Ylyv38aluSkFPQHYH1yOj91Wr+QMbyQXqcGlwH971HS1eZWeogvGDkKm3lZfp36YP0k
         9PKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785794675; x=1786399475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7WoJ364o71w8b02TDFU0Hi19/xzHT2Re2qR96++mBVE=;
        b=KRLf1n1Byd3j9CtJ5fG7KJgYszv40Ow0Kg2e+9XEw5aUq1y7WBjUo35fBSP1E0E50N
         F2yFxg5NudPlxNiNkFrFJ5H9ymX5IZkKryPj7YC0TJ89AlnL8FsS4RKbnkvqqMlMu9uG
         b2HpdUlgY/p86Km0/h/W/WZjo7yfb5tY4PoZbo2iiNIHwrsPk2fFco3tK9YeV9nAXvy1
         gqPAe+I7mYSTleUGYoCPAKppcxa4GrVQq+x+2t3V2uVf2LP3VZ27rbMZzUXVXyn2HrWj
         y7yUMWQhifMnKhfqnmYvaKIVXkG6ryxDuS/CsEcK3icQVnYv70Acxb7vGXC3qoPhRxU7
         Pn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785794675; x=1786399475;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7WoJ364o71w8b02TDFU0Hi19/xzHT2Re2qR96++mBVE=;
        b=VkFa85gRrbJt6UMkZ21AYRTbUJI2dIVv+MPfUpXaIlzIFyGot+d1CrIfYSSR/te8PG
         8uu3O/bquS6YYjkxwQvtoky2sItHT2BNnn8f+zS+or6QoVQ/xcgGeEb1pXWWCsNDQ6VC
         iplHXVfLZZnT6Z6k9Rqt5tvRPfH3re7ZjBVB0uNmGveGvoVRYtrDXKasUXftod0KqTRi
         3+iFFLdZi7ybhDvfqEvWNEikixfxCedbXVI0BcxTl+M6hB/KLL2LVcRE78CbhQovOv+O
         sHLiVwWsOErvih4EvVVc4aG0+7XAPur6qTPz+eziQheFUyzOxF5lGjz0zLMOF3S3guaC
         AgQQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUDflHnKfCOjbstbt0mBuLEgPGh41JC3Uyxyy4P1pW1ane9+CVHlb8/r+F9qKOCaE9WYckQNXIA46zMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMIOLNTB0rnBSmKIvQ8kTdXUnQl22/6Ykz8z2l4l9D//3ATZ/u
	vcY3cEjp8T0ZMkKmeuUfaHnl/bSrwEDgj9l9ddKi7VEWDl1SKaMALUjD0qcrSCNgozjuXRC/SPB
	9p9WfozCqFt1nJcN+jvB7J6XVSvpLFEs=
X-Gm-Gg: AR+sD122GBC5m2UmzKLM2muLvaIp/E5H7/yw0r7wyV3wDRgyoWG1uIBrgeoh/6XCzrF
	Ft0zpAP4nkP6lxd4ct9iDHuU9+Ake5CjtF/4UUUSBE7qcQuXy51NtD4Venqu/9dSby+8DwTgIxw
	nBHMdCczuBCIEImunCyEdvG+uF+qUT+xYmujJd2rni5a84hAMLbXpTigjfu6aiqmGZEyNIOCUcr
	cxnJ8co9v6n2Vq14QE6RsHltfDQRJOXp3+6NE2X1aYSZCgKE9rmKtXxfZvh+2cgM3C6Ev35/58n
	U0ejb6vLWwVQ6Xn7zZp/wuFAuQEm7YZxK8T1JvjxHNQ=
X-Received: by 2002:a05:6402:a0c2:b0:699:728e:48c3 with SMTP id
 4fb4d7f45d1cf-6a0a7c60706mr9085678a12.9.1785794674539; Mon, 03 Aug 2026
 15:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <6rbjbj74zh.fsf@pengutronix.de>
In-Reply-To: <6rbjbj74zh.fsf@pengutronix.de>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Tue, 4 Aug 2026 00:04:23 +0200
X-Gm-Features: AUfX_mwLFzASRisUw0SGYbdrUbrTEEZl2WcpJHPwHspkAa-eHL0jaqDpB83YDME
Message-ID: <CAEUXW=EHD1Y1zHQWE=jFhONM5Hg6TTc_uPYHgp-GS-4YWYJN3A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: =?UTF-8?Q?Ulrich_=C3=96lmann?= <u.oelmann@pengutronix.de>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de, 
	devicetree@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 3 ago 2026 a las 14:39, Ulrich =C3=96lmann
(<u.oelmann@pengutronix.de>) escribi=C3=B3:
> independently of the specific implementation, please keep in mind that
> the kernel is distributed under the GPLv2, which may have implications
> for a proprietary image embedded in the device tree. That doesn't
> necessarily have to be a deal-breaker, but it's probably something that
> should be considered carefully.

Good point, I had not considered it.

A warning could be added to the binding documentation about the licensing
implications of a proprietary logo, aimed at anyone thinking of
submitting a device tree carrying one to the kernel tree. I am happy to
add that in v2 if it is considered useful.

Patches 4 and 5 also avoid the question by construction: there the image
is a separate binary the bootloader loads, and the device tree carries
only a phandle to the reserved region.

In any case, whether such device trees are accepted is ultimately for the
device tree maintainers to decide.

Best regards,
Max

Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3D34F497
	for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035723; cv=pass; b=iyrjyL0DK1+IjheWlyV1DZlxOKA2PQRWmBLnL94wyAZMJ/Q1bI7gjjk+atSPIx7G0fIGd3Q7yCK+yhRaPYFte5DtWeMsyls6ygauK8J2hIlJRpn6/6nbpM0n89sNdQGF4D1ZPSkUc4Qhy+ZsLcgDs8FdEOvgVq41vH7ok1OfjEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035723; c=relaxed/simple;
	bh=ue6jFvPPvjqPgIpHsXNu6T7RM+b3RNh8Y6zW7p+85hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJxGrYEeAhUhYLAZ5YTfvyWO+iyOttk/TWgpr56M54fMo5jTyKrwF7YGF5wdNxyyaQNSWwiuJZJh3CAapI6Z7Ej9xhM5aL+ZZKzAn9bdfPku25EvpIC4JnFIfgofwLeqkSTZ/D5B9qksJwn/6P+7htFhXSvKwa+6d/0/Kgc9Sy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAMoLggN; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAMoLggN"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caed617615so47266465ad.3
        for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 06:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035717; cv=none;
        d=google.com; s=arc-20260327;
        b=Xve7tVih7fXVIw+4xdNLN7npNPiH8s19IZfTc5tjTh+hLvXLAnBEmhKZtKAkuCSFBz
         2gAuiPVxsgu8Ft+sTAI2N1r6HxZMtz/76wr74lHyuko59ot1I0xDkOJ19o9/W0xirBuc
         BU+4FQkA6jCfoc9qh5XQryWVJki/QLQ/qfYaQzXzfyhBdZ1GbhGZgnRQI3pRfzEcQO4h
         bzcmD3tadyY9ufzGc7M0VcFkxdRUlTjScrIAJP7XqysEhq2H2GH2FDekRU3Nog9IdpGS
         SZ/3lFgEa0x8oUI58P8i2vTuvT3KXtq44KRB7hW+lqtQuFEWvbnp0Ik6FtuYx3a1gvF5
         cKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ue6jFvPPvjqPgIpHsXNu6T7RM+b3RNh8Y6zW7p+85hQ=;
        fh=JtqS+liBoOBtvLp4NfiFvkq/HoO9gj1E0wMLOeFhgV8=;
        b=Gvip5a+3/rNjszCZPj343kQAMeq8E7F4xdN9jcJ7CnwIAy65S2dhGopzMewV5mfi87
         RTsnPT/2IHjcsD4sbrw0QgBSjo+zwUMAY6wU1RSM8A9Ul6Ou+Lnnzpf3LUKbGo5PoQo4
         ssCTTL32kM69hPdJo/qrbD9vDkj0v0dk/DAG7llumGiwXsIn5SpljFM5PRW1qLug1Yl2
         Q96AOIgKl5geYiKWpwwJoSjyRtoSG6hLM12o2va8puPhkvI6LRy9/L01YL5tef6CTTJn
         ZjpNQQ1VwP4ST9SbemsDdXeiyHjW6CFfmrZ4fDjJmMBylHFzrfrqZ3QWVQb1Xz592xzV
         JD2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035717; x=1784640517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ue6jFvPPvjqPgIpHsXNu6T7RM+b3RNh8Y6zW7p+85hQ=;
        b=HAMoLggNikNfjMaUSjRVs0LKsdZLYv3PPjXr/y1n/bgfeuEWuMbtBEeSeu3Mo4dpnb
         xBWJuI9zz+8g/MpuGUW6WoFposV5HBQV4iEtgMSAkhvsuNGWlsSPZJ+Fq4weUHTdF1ht
         XldyK/rSwsiVV3E4u9TlNCjlt3Ou2fkoLA8RZMEXYqBzcpAXQghG1Qs88zaAroZ2yqX1
         KfYl0+I7ARIkLrHU0obMlW/vLijtNhknmn+ZjZif4tfwcvWHHaYWf5/HzYpfEvh+Ad63
         +uKJ5fbN33gdlEzUd3aolfkrLr4UALNV4xPZv1zsgyrd7pe6vjxEn/lPRxc7yPMrnTkh
         cEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035717; x=1784640517;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ue6jFvPPvjqPgIpHsXNu6T7RM+b3RNh8Y6zW7p+85hQ=;
        b=LT49Tt2QjlAV7tYGIBQp2HOJJfLLn72B1z9qFFRtRpjsb4cV3Ga0Y96pHhACYq62Ig
         Pbqtn1CZ/+YX/4cVw3iAqAggdHGerYoDr04jX5p85TURWDkhO/uozYkuqnOpkT0A7Vjy
         tpPEtjFy3iNcVjrCprpZCyIouB+qPt0oQz8/OX2ROUV4shjuq341kIP7roJPzU9uDTSz
         VO0j/IAva3WS38P4bEt4NMr2KeddduSje2dMBGLZ4Z78Dsnrn+mOjEkpU3I/2RYeN8Mc
         Dhm58OsOWWtup6vOwGB988n8FXB/gThJLAZWNjTjuI6HNuawpT5vZ4P5GhmTGGNb9jnc
         e2eQ==
X-Forwarded-Encrypted: i=1; AHgh+RoGlOFT1TSDgy64ru/orjikx7E6TUXuOE3gdmKNPiwhkTZFuAS/I3QaTEocMkJHlmyGvqWQq181gf7Wvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6KkFXnikxrSa6Y5MHfq5IsXCF4n4s+1F9zC29Wb4Z59qkepJf
	pU7XZy5MTO9h0YnGrrPPw4ewbDEizO2bnDD1uftsHV00foCQ+fei7f7fMRahkjAOU41AO/yDclV
	yhQ38IkacYKi7S9oPFsnMkcrGs+vSgEI=
X-Gm-Gg: AfdE7clZAMwnop5UGv6wQhfERjGWcdyqD7m8GVAtBrA81hGdtS+/xFXc68iqLbFCRDy
	WZAIN8S3DiJRamrtL+rB9I1JpYfYCSUOXc8xu/BhrL5ahF9Wb1r31041T7qCuV3nZiO1DjtSeSP
	CTehO/1JcA+w4/SW3i5bLWkAwqSnoQ6sOnhoaua2wnf1TKPYOd48+B5vv8Mb0wqrsBtaGG4Dbbn
	lBp5di33UPESik9KkqA9gRhZM7MibmGZClXaPtJ0Rnl38l35WQPeibK4kPoPKxobRv/mPG4JEB+
	7tLlkWYj11fnikcmZTgrQFIdTqu+Tw==
X-Received: by 2002:a05:6a21:7486:b0:3b4:b6d7:a992 with SMTP id
 adf61e73a8af0-3c11062f70cmr15032381637.8.1784035717203; Tue, 14 Jul 2026
 06:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260617080031.99156-5-clamor95@gmail.com>
 <akeF_VrijPbebz3I@hovoldconsulting.com>
In-Reply-To: <akeF_VrijPbebz3I@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:28:24 +0300
X-Gm-Features: AUfX_mzREZozvqJIpCZw-bv1kiFlmVezGQdepbPdfuQMwUIt-LOogON_yq372Iw
Message-ID: <CAPVz0n1+wrq+g3p3UTc3hzHcsz8k02=QsvmseBD45d+SoSFsBw@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] mfd: lm3533: Pass only regmap and light sensor
 presence to child devices
To: Johan Hovold <johan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:50 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:21AM +0300, Svyatoslav Ryhel wrote:
> > Instead of passing the entire lm3533 core data structure, only pass the
> > regmap and the light sensor presence flag to child devices.
>
> Again, why?
>

Because none of the child cells needs entire parents private
structure, regmap is all that is used.

> Johan

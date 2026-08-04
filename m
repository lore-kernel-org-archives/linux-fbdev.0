Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E93469824
	for <linux-fbdev@vger.kernel.org>; Tue,  4 Aug 2026 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851971; cv=pass; b=pFg4GlQn70ovgqdX5CGf2w+6CRGX2ljYgKrJCgmfTy8KNRDp5XbeALLlwtRd3C/dsTtTZO7f6iPs5d2zc21ZOuLBkER84F4ljOYU0Fs+3VFD60o3NLek0znYKuE1kT+qatFZS1zo0/lNXabuPoDWZ36n58NK/e34GmRGjPGSXzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851971; c=relaxed/simple;
	bh=89EaKRTuttPUHq+sVPSA7Zb6zcbSC6P4w6uUi6dNSdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPevoCkeuLO9S/NYg9q/GbJm3lC04p2Di5uo0HbckFOhARhI/+f/O8Cw0kfZeORMzVXuZqQId64ckri2/hccKEpKXhas/cu1ZutaHcVEQjy4u7dF9qgmQDyQQ8kO/Jopephw5X2hSGD6cImvLbt/Xu6c6lMu+5JgX1ibQEjRBvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNmMWIa3; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNmMWIa3"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso6972957a12.0
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Aug 2026 06:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785851968; cv=none;
        d=google.com; s=arc-20260327;
        b=MH6A4SVSU4I0srEz+U81KBMnAFy3A+YUVTxEedSYCLK8o2x/O3SeN4Qe1GjHzcw4cd
         G8JLEL1a58eJbEXG8D2SdG+RhSK2UIIrTBJdvtOBXruWawH9ZhDGhvftAelA/98yo0N2
         WHGBdiw28ekBUOGdCfv9FEQ7c0oqr9f0SCY34Etq74jUP9lLvOIw4Qaw/DJ+philF1yG
         ciR2MkCR/hsEzzTro16f7ZBRfE2O/V1xSoyQLAdvNW2Hvr595eG7uojRbl+IChT2d5oE
         dhELuprjQc8gNp1P4bPXjZXRzQzIIrviVIpUWCNFpwR7Lr862GffwL+eRNwWwc9OQB91
         2Zbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=89EaKRTuttPUHq+sVPSA7Zb6zcbSC6P4w6uUi6dNSdA=;
        fh=YBo+TDeVNVzFE29aqTrsHSOXeBchpoqtTWdr6mGlGQE=;
        b=kFQPD2mf3GBVv3dclTo/PDDwEpaYxvErYmVHQflu8/rii26QtRhX3xJwxetoOS11W2
         N6UyGKbC0e4Uh5GMUeVNctru78KaXt8SFOh23JJh7bW2oewjG7z2W0BTSMMotcOYcROO
         h+OF3Lwpfisli9u0Qo5+YbkXVvKPUJAC7UPezswR1dqhxcM+liV6j4z669nHdIC20h5j
         E66gGVWb7Yk+8UuKISt/ro6r+ANxd/tyoWDP0D/h6HlOhZIQrw/XOjahH+MBzp0hLnOp
         YpZr7N2hsqzzSKmSRTtZXFqgxNtMjMCjeUn5dxEoajiW4T3lrgXHdp08W2gpY/6HFuyr
         riJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785851968; x=1786456768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=89EaKRTuttPUHq+sVPSA7Zb6zcbSC6P4w6uUi6dNSdA=;
        b=RNmMWIa3L6sneRH94TfPlrX2UC7x8/2gIqDI5sO06LWhB12FcRtrMNryDnPdHEmg4L
         oDmnPwyyd2IyHI3CeAM7OIDzL+a9PSObzNpN0LrVkRzvUAO3hCyc1vArBQVFVrDm9nZL
         gWU300NVvjlpuvF+nyY4sY0qR2BpUW4438JIpvk9i5ZDSUC6EaM7ffLQHL6B10Qpsl0A
         2/P8RtCQ5Fl0MYKw2b8EZUif0bIwpIsCGwxunpxOVL+f/BXhHXeHtdQmCf6nLtGIXbiR
         Qd7FYh2PnPE2Nl5G+ADYIMYBTNKBci1NT8A8miUQJB88ffgYi5ND00swQ+KBOgdYOeov
         CQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851968; x=1786456768;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=89EaKRTuttPUHq+sVPSA7Zb6zcbSC6P4w6uUi6dNSdA=;
        b=pMLp8bi83clrHswSIwj1k7d14QKLMndrgma4nJLpbpbKgmAGFmu/2/h7cAn+xvW3HZ
         YAY5mVqJJ12WJAVCJ7Du50kg0ip7PU7yh9x7kfqsNYm4upNPukjrdttpV9l7R5FI5QvW
         GaW/7Z7lz/c4F13AyCeXggfYbV/h5KkwIboq8xhGrWRUr7DAynAAG0ulhMIroHLV97FP
         O8EXcC9LFg9TRb26C5nkzPfHdB4zm8epFsGrdfNYS1ssHhaMSDhkn2CytqlBLMjvab5B
         UFQ742802e7MqVH92dhMShmoKb1u8mTo5q6BhzJ+qUWSadleYRxaq/Hh5swwazwYqDH9
         Y/VA==
X-Forwarded-Encrypted: i=1; AHgh+RqSkAqYW3cPtVbc5YKpmDQcxyGCaKQbNHiCUCHRBpRnEjrnpwwy0xMOK3DS9i7Nz3wwy6ygZBPHUKVR3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61GxGph7R7snDkm8gF2P/PEunh+GAvEk5fOVPZGQMzc81TwUB
	Xdwz2LCw8QcOzvANrzOC3va3jK5c4zR26Si53baHCFBMLiym5wmG4KPU5ioAZBd2X958612GUFv
	RmddhLsJWdSkaslGtEjuDj1DdN9tE7m8=
X-Gm-Gg: AR+sD10OtM0mC08XV6CDVZqZzvrvNJpBFycRjqk6DCIugo/tjBFawr1aZFjSH+iNtDy
	z52NZbWgi6zUDLVUixxInDNbBjbrDG1hiJp0YSiQHUFr+RmCjUw6bhD9sIOzoJ7q1DPEveIwNH6
	NEEgp969U7ym9QYVqLQ4pPjZwR4sNB2Z2p/yAhRwtCt0Zu4GhAKvPHJ+jF6OR1Qv1RGTowp9+J1
	eiGPDuAdymLOOO5JvFifbQvZkJg+/DZZ5eSVNw8FUkjmMGMK6aCJwVXh0pqeItqLdTiA0WlJA73
	MugRca3L6jaXV2i1n8Y2d47WUudkJl8LC/Jv6w8FHGEy
X-Received: by 2002:a05:6402:3209:b0:69f:fa13:ed3 with SMTP id
 4fb4d7f45d1cf-6a0a7cbcff7mr13543404a12.16.1785851967781; Tue, 04 Aug 2026
 06:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <6rbjbj74zh.fsf@pengutronix.de>
 <CAEUXW=EHD1Y1zHQWE=jFhONM5Hg6TTc_uPYHgp-GS-4YWYJN3A@mail.gmail.com> <6r5x1q78yz.fsf@pengutronix.de>
In-Reply-To: <6r5x1q78yz.fsf@pengutronix.de>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Tue, 4 Aug 2026 17:59:15 +0200
X-Gm-Features: AUfX_mz3aSa6-cw2PyoYrLLjsrQMGpXNCxHpupxxxAIGNK-kmxelTU9OoI4pMZ8
Message-ID: <CAEUXW=FxgN9Zj-1eR2MdxMTyyKTMTUSYHpkcCpuvZKnGYJ-zTA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: =?UTF-8?Q?Ulrich_=C3=96lmann?= <u.oelmann@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	dri-devel@lists.freedesktop.org, kernel@pengutronix.de, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 4 ago 2026 a las 7:25, Ulrich =C3=96lmann
(<u.oelmann@pengutronix.de>) escribi=C3=B3:
> I think the issue is broader than upstream submissions. Once such a
> device tree is shipped as part of a GPL kernel in a product, the GPL
> obligations already apply to that distribution. Therefore, the licensing
> implications of embedding a proprietary logo are not limited to upstream
> acceptance, they also affect downstream product distributions.

Point taken, thanks for spelling it out. I am not qualified to argue the
legal side and will not try to, but I follow the reasoning.

In practice it reinforces the reserved memory path, which is the one we
ship: there the device tree carries only a phandle and the placement,
and the image stays a separate file with its own licensing, handled like
any other asset in the product.

Max

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793652318;
	b=qo0aMBgBubHsxipuhqwvW1wf5hICZ+nbSpJN60QG9nfwi7OI1UvS6z7V1T5wULZdle4X
	 r74PaCdf8Pte0eo35x53eT52T13FQUW1kTtKHMjudVR6lOu1iH2RaeFkJx+A65BS2UivR
	 TOFsdCaMQMwlA8cfi528YfnpOb9l2qOsvl/a0zEDEft/KBdAZRjfCLMoWt+zif+WTjv8C
	 dlwQ6rAEw2GjZBO7A/Gx+Qcj6ojQe0nSkxdOGVBTEbHg11y+5grB9ptsDDjj+HUkqyfP3
	 naX1oqHjZTuta3qU4SPav6jTSB5zNuZYvHzOEMK/IzMJtMgZIZwUh0iVXFsoIqTq6HQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9+4MG/RP98VFJErdCyXbOsA7c3c0RHEevq093WDWxVA=;
	b=FJwTBV5ZYOLPw71IXPy3Fo01dDY5pgXS1wFgbflhAprcp6o261xvDfqAjmyLlvFCTLIL
	 5DXA1EWoklPpDeoOLLxrr8H2pAvvLCWbUtTlVjdphCbSFzex2O0pa03TTMzpiF82Z4o2j
	 CQjocBPmCO/lL4j3KUvu9jo+Y8iPuQkqFB4hfO1mJnlJk7/e3K9hX5Ee1sdxVfWCrOhat
	 mVMxigNLrJdXwo2v+a1waHwoYsk+FX8y74+XdBS5G8HSR3BWwrqFd2Kuid0T0D065suVt
	 n06EsgpwkNb6dhQyeRfa07s++r2QoJ2sWPUZciHmfVI1ESW08Wy46ooHJTQviABOP+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BWgtXpBP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7CA606A329
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Nov 2026 20:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E7CA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BWgtXpBP
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4395d31228so532420066b.1
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Nov 2026 12:45:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793652317; cv=none;
        d=google.com; s=arc-20260327;
        b=gpU/HXeqzrMBzEejQTJrlQG4iEAx1OfpSZ+1+fusfg6U0yy9OBnbAblLAvwwFwSfd8
         +02yrykE/Zioa3vTvDI5jxXcNnlsQxQmU/O5/fdPZM20xYmRXPo3k2HiOXVtKFl5aClI
         evHfyo3llpsZeZaeodWix45oNeeN8jI417kHml5BqRLCHKIp3bfzcbFlZJXzVOLZz5oK
         lO9t0Yxm0RIGyt8+DKx25owsGlCj1O2/40XgubgHFscLR9NahXwpxZnP2Zwz5SeePxXv
         +gJNikEIeb+FLRqyvJQo2/rx/pnni3+RKQRMpRHSRO2TLd4NZRsS8EIZKXMBg23mIV4b
         VLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9+4MG/RP98VFJErdCyXbOsA7c3c0RHEevq093WDWxVA=;
        fh=mi2LqjMCrtTRcumzIL+NitE6SHyi4ZweYjMBC+9eQV4=;
        b=Fxt3Uujer3i8nkePP+E1Bn/OF0e94Yic3AR7ooCzwi3/IU+lqN1ajLAK+ThC2B+hG8
         1ON3qEV4wJuRAZkm3cvhSe2My8BQSUqI2+/BK8oGhEh8xelSytFXoicPpP6g7862aHpn
         oU33x9cvxSncWAI7FxCFon5bEy7UlYoNfC4xrO+L9i+H2+rOsBz9BEN9dRc+k6ssapre
         29F9bP65voCIaiIabREhH5O2p2zju9NWIqL7R6JbXO08mlo2oKWzpIxbbYIzjgJU5AUb
         qzhBirDtOOO/uqsaN0Yqcw32Zx1S/6JNCKml/jOYO8dIH7c5R11pQxzaFVp5IJvLp7Uk
         m0dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793652317; x=1794257117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9+4MG/RP98VFJErdCyXbOsA7c3c0RHEevq093WDWxVA=;
        b=BWgtXpBP21kxrMgl3/xj7tNTB1/QJCyMEsTFYk16Eb5nUSHOQB6Ifb6Zx7CFQ9sDcB
         AQWxb6G+5RU0dGvHWLa96kF8bDQXNTtnb8mjSujwe4rv0ZYG2Y97XsMVjGnl8mG/H7UQ
         He/wp6v/h28VaWEzLVTdlyiL1PvPiMKl77IXxNnstqsoiflP+CRCFOmxvPS2b85Ps0CM
         O0VP+iv/rbJ2JRbYF8rSkhrzx7tRerx/zkTeCF6e0TCcy5HqYayZIsaA8nwgkg0Q07U9
         exjH6cOmfWLvNSNKQ1cYXo+js934AEkJa78V5DAjQzHETqB2JYCNapJjht7EfkG+v949
         zzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652317; x=1794257117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9+4MG/RP98VFJErdCyXbOsA7c3c0RHEevq093WDWxVA=;
        b=2RRx7AZtmGudyAIFemC9ux3SPfsauzWoaFTYePkucNgBvvkMVhGmAsL36kJ0ldQOvj
         7k4Wucji1wX4o0GS4CFhBlX3WaYUr+4e7CG6fJGlcAiUTe+UwNc5eQbOCMRPoF7+RCj6
         J+BggLVoU6jDY+HXnssBAAyjmon//Y7BIuNOXt+RDlysKuuMkWQsmIMvcMFV7L5PCgbU
         7H8wb3y7pChhnhxpGqxLWZwClY6HchtpX5lqPCx8a1bVeBpwfpy9PiTKeFhRu6E5LPuJ
         sJDHZJjsizyfeUnrT4Dvzx1yuPoVN+qglzMUbQidoytHh36YKmUZPk3mKQtbtRs15jCB
         H8VQ==
X-Forwarded-Encrypted: i=1; AKwUvBybJwfjWzyy0n6JtOJ28ep8U347STW2XKcN2jOM3Wn+DsfltFwKb3sy7Agiv29z0aybpFsBFK0w0mlOag==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ViEfWIScXv5IJ44zPWaCxbwpzSvwIMW6bqw/rZDQNcj++c68E
	s6cUrFO5NXqRucBEBPnlcffRm6yeKKJ5ZTdra5l56onyQrWHiiCBeh216ndVGV3oIx2Vg5ULGjl
	4biA7bnjH3ec/HSisq3PtF+owlJOTp1k=
X-Gm-Gg: AYBFou2HcI9F981+sIoaR95//BLK3EIO9Gy6OpoGdS3ky274JDDV8J/+tpgoofyi/tp
	kuqhclfIVCr2babfWRmHtAcRIJ8+N5Hupj6Js58lWeh9GCTZct0Lpx60GwnE6/w240ANkZjeSNd
	H78LOZDmtRXMyigyft+0xPu4BKaHwi1DxJYVF+PBhB0jJMFTqpZNUZ3SPmK46PTIFFEX+C21meO
	0Cq9XMdoCZnVvZiHDW1Ykawfn3X023VHnlNW2gwsd8ZpWrjaIY2Mkxm1vy+91TaIcr3qW/bzByC
	svTPfcx6yGc8YFSlSeWDK+XC4jvcktnUPQfgVRocs027EC6a9IzYV206s/s0v7Uj4VwVeVQaZQw
	g0OIvaG34+1i556hVAcxtd5blGU93MPO1GivY19T5SOJ3BL/iiWyzpI7M3MCyKDE2EoE58jlgPL
	kuGbtao1IYRUAH08ZlkCgijrkEilnmgO6dgXNEZ9K3iVq2+mKYMJoKSjHnPGQD50J9S6hmLobpY
	Lc/fcmthIYo8x+sFsTtVbCsLQ==
X-Received: by 2002:a17:907:7291:b0:c36:a4b4:b1ed with SMTP id
 a640c23a62f3a-c4ca7a18e9emr1040945766b.11.1793652316563; Mon, 02 Nov 2026
 12:45:16 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031042315.1122699-1-eric.lee0305@gmail.com>
In-Reply-To: <20261031042315.1122699-1-eric.lee0305@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 2 Nov 2026 22:44:40 +0200
X-Gm-Features: AclHuK9vd6HXpTj_GoBsuPuHc9gsfqa_KIPnkW7tQj01sWOMQhU3GUHBUvE2PZg
Message-ID: <CAHp75VcvKkOmFTtJDHuKCNVUMXgjZLiNqmGcHFKT__dtTt_QJg@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix space prohibited before that close parenthesis
To: Eric LI <eric.lee0305@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 6:23=E2=80=AFAM Eric LI <eric.lee0305@gmail.com> wr=
ote:
>
> Clean up the following checkpatch error and warning in fbtft-bus.c.
> drivers/staging/fbtft/fbtft-bus.c:14: WARNING: macros should not use a tr=
ailing semicolon
> drivers/staging/fbtft/fbtft-bus.c:65: ERROR: space prohibited before that=
 close parenthesis ')'
> drivers/staging/fbtft/fbtft-bus.c:67: ERROR: space prohibited before that=
 close parenthesis ')'
>
> The reason of that error is the modifier argument is optional to the
> macro define_fbtft_write_reg. So, even if removing the space before close
> parenthesis, another error "space required after that ','" occurs.
>
> In this fix, I change that modifier argument as optional, so that
> it is both ok to use that macro with or without modifier argument.

It's not a fix, it does not fix anything.
Also study the mailing list archive (lore.kernel.org) to see what
happened to the similar patches in the past.

--=20
With Best Regards,
Andy Shevchenko

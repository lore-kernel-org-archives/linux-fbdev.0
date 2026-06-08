Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2543859CE
	for <linux-fbdev@vger.kernel.org>; Mon,  8 Jun 2026 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898946; cv=pass; b=XmH1ld/Y2SiLLsXIjzK8LXdc+n8Kil6RM2AVpOJ/WiL33Alo/Y7T6HPDZ1uREDYg7a1UgnBCAa8UnxTHVYFzISktoh9RAR0n1ZGFiuyXUdZupeKY+yfyEPzoKHSBHCr729cWsvz00R0TfFzeHffrOt55b6nMUMApyV5oN2y0d0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898946; c=relaxed/simple;
	bh=8gi/wE5hjAq/hZ0xe+B37Cet1OR9dugn2vSBBancYOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBCaOtnYs8fRxfJxEhwmDKgxV/xE/4cBg5MnrCWiU6TFw3zs5h8Rku59XjinVPku1XwhkrZ1Q22Abc/xXSvFshTkv8CjQgg7nCf5S7F80Up442QT+R6nWoWIQTzv5Mh/4KSGlMgbxpPrEJ8t4P95nMndeNhC0MGaltTw8bNr/7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6nG+hpB; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6nG+hpB"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-beb7f26ed62so444969066b.0
        for <linux-fbdev@vger.kernel.org>; Sun, 07 Jun 2026 23:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780898943; cv=none;
        d=google.com; s=arc-20240605;
        b=I3y6Cx6Zyr5lmREeUdad+eX+0nc/pWZRPdwTwnv4kgSiBvFeZq6f4gdPGRrYvEvKqj
         mrSugyZfShJYtRuaV3iuFCHu+o9pkDelYX8GMOm/a3wNEqalYse5/0ZYrixkUo2X/B+9
         F+MWmvJRtlsZIS6KRS9TdKOhbVIhcOXv1jIqAkKLsl07N9mPr4MolwNnCoJICFu2u0uy
         AnByBypoZJVC71YcDK1aIuz9Ox/NKpHvRgzU0FywpeedM28fAM6inLDBN84ukmNjHrS4
         Vwh/IpynQBlciOpIHIffBrHRbdXEqKVOsMLvMpbAXVAenEfaWoBxujhbkwtYpx1dcbmT
         2G/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8gi/wE5hjAq/hZ0xe+B37Cet1OR9dugn2vSBBancYOQ=;
        fh=k6EH8D2HpzHmv1C6RCdZKSQtcTnxp3pF+FJQem+511M=;
        b=C9vuqQtvtkStsI9in0TF2GL4VtAsPsvm4cNHFZnZs3OrbE/KaraPMmwGgW2ruAVWqP
         20iCUjauh4J5LoEH2MmYfN7y0Vm4ByuONL5za149WQ6Gb3u0X9Dhz1s6AUYdXZZA6Sdq
         EuMexG5IV4KTBuSiDvSATq+zPtBXb32dGjIiMfM7omFYoIy05dj7xLzXXk/uee+yOPQo
         wz8BuyeJlPRkh2OjLGreylXf2O9uHTyQzjoGo97O+kQ1MAMH/+Wfe4otrRfEsZYslVNd
         gNbLvPFBGMPYsod4qw0xwGLKwumKqssrqQoa+dbEDDiFRMPNAV+hwldhMtikWS0pNiUB
         Bt+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780898943; x=1781503743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gi/wE5hjAq/hZ0xe+B37Cet1OR9dugn2vSBBancYOQ=;
        b=Z6nG+hpBSF2Za/lsuP3bJ/PFfsqb7jl9j7Y5OfQztC6IyQWn0sFobx3cgW6AuTE2uX
         Jrqf8VUCd9XpjfqlQsAukM7Alvil/PbIpfbczBoWdEx/T8R/ML9nZQ7z2Ak+/gvkWx1P
         bwoXttlmtj2QOK3X0SOumVQYogx1JwUk7coWH4/wO0teH9cN0nuAnnHc8GrTC1dznUq0
         /BCrRCJ5mBsuR39MFFudwUG2UhSOnsm8b3DIjiwQeBRV9WV3tEX8HwH84oWGj2TN+94n
         8RR8cTOtb+/fUGuucHJ+FYQshDM8WS5fX9lH+fmpImGXAd8VgkVsR49fie2WcBObsP0h
         fsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780898943; x=1781503743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8gi/wE5hjAq/hZ0xe+B37Cet1OR9dugn2vSBBancYOQ=;
        b=bKfpmenLdLGq/x069tY8uW8pMXeCM6JEJK07x4yTG14KfeErfRHrD0vhBRQZnyoqzT
         FgEhJWCLdLSCbv98yvGrn5Q1l+Pjf3cElFGBKXFupQALB6BoWW1XyudqgIt76CgONpxF
         CF1jyBfEEwMwX18hRNAh2nwi+9KSpkTluk1a/AqcByVoG4GE4sm+SCESnI8pssMubxyh
         t692/BgS8x0mKpJYCSN8wYl3hQuVt+iLI5+wpRY2YjN+HDvmHI4qUAawvGsNnmaYpivA
         CkGGWvHR3rHCkhpNtIrEyYyp0RIcnsb7spaRZ2i6CAHExBkDXDyNjFbVtb5SjRzuYiMT
         vpTw==
X-Forwarded-Encrypted: i=1; AFNElJ/uCKVl7v+MJDCFVdOBrZ+Gw1a/U0mxCxXvT5mFrJUGkQ74NDLYMfmqw226Pe5piTFGCNcEyBpVCZrCUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDUUb6k1dqNEqTiS4J4hzLc1OnvIxzKxSUSaT5JMAAdvArJ9/+
	naAKQgADI9KCk5+Q7oUAuxfLyO47+DHVygWQ3mzjIZ8sSsRVAoaiY2ipUFRV3JVD59RmXF6Tqlt
	z7RCdTYu/PmvnfGm2xnix38dMrktIgNY=
X-Gm-Gg: Acq92OGqAhzADZYM55EsRQ0FMJkOfDLtAgUFRvRW3EEFY5ks+66u5WtcqUhzki6jvZd
	2HWPRI0nxJrr2gG78bbQTvqg6gmHZ1exTkf2RX5Wv6kYb0jqAsXmjl7j4cM89l/e3CyhzeL1C6s
	NvrHdN7efFdyjg1dhhXpT23S61/hG5is7yQ4+avzCGZPD0X9jkWTQW3tgQInu5TlzlZGT4aB5EY
	T1phR3TdMjGPfGH5kWCmouN6xcVvehwZaf8Jh0VRgCyL4Bi7N3rSbqnq55wufwAABGH0n+K8H8b
	ETp6zS5R2UrLfqT86UFCi2EwWHqrA439i1A20eKrQyWTJFaXXRXSzYK/4Wv/0UjNN8X6zE/UQic
	St35O2Vwkkx59wDpYFAkBdLr8sIM/EayvF+OGXoo65mJPPLRF2q5SMScGtSc1hwOI/40JJbvpnj
	o0fzI=
X-Received: by 2002:a17:907:6e93:b0:be8:93c2:cbae with SMTP id
 a640c23a62f3a-bf3709666a1mr614698166b.19.1780898942969; Sun, 07 Jun 2026
 23:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607201708.88644-1-ilovelinuxgames@gmail.com> <20260607201708.88644-2-ilovelinuxgames@gmail.com>
In-Reply-To: <20260607201708.88644-2-ilovelinuxgames@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 8 Jun 2026 09:08:26 +0300
X-Gm-Features: AVVi8Cca4h6JLxFlP6kdGJ4g6L7zlZmMpERaiqBbVX1YCnn0IeyLuZTJiZG6xIU
Message-ID: <CAHp75VeNHCbiP5+YwLvWifzSF5FBD8aKBdz7rd4GAr=Y_i6fjA@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: fbtft: fbtft-bus: remove prohibited space
 before close parenthesis
To: Georgii Druzhinin <ilovelinuxgames@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 11:17=E2=80=AFPM Georgii Druzhinin
<ilovelinuxgames@gmail.com> wrote:
>
> Fix checkpatch.pl error: "space prohibited before that close
> parenthesis ')'" by removing the empty argument and comma
> in define_fbtft_write_reg macro calls.

Please, learn C preprocessor and compile your stuff before submitting.
Also since you have a series of the patches it should have had a cover lett=
er.

--=20
With Best Regards,
Andy Shevchenko

Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9154F39A04F
	for <linux-fbdev@vger.kernel.org>; Mon, 10 Aug 2026 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345658; cv=pass; b=XeXyhrRrVMrkh7nqrVH4SXEf77wqDu8ohO7i6Bp8xydb3tl2bd0hAYd64kQ0qoLbKmfWowa0BzMMrLnj8CJrdVAW0B4miYedHAoxtfQNtuTHQWbgU04IF5lbUQ1YKI27C+41PcVcr4Kh/g3+ySMlXZ4Ipe52l05tN824l/HFBA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345658; c=relaxed/simple;
	bh=t0itK36weHoU2jtoEAt96DrFUj7FEsHjlM30gbeY12U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPjKPR3WcjwXkQ5KxRsdDe5WeXsWNCdkI5yRgOi7HJHcJLqB6Xa0mLQklxOz7bX1f0q6ilBh2nxViWrA7ZqQxareixlzGI2IgZuTTOMWQg1KHCT+IOb5X5BhqCdSxBEFUfs0FcHGdZ6nGxFs6RQposXpMIB7OI2+nQG52V+WJwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpNlbQyi; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpNlbQyi"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39f20d19895so10305651fa.2
        for <linux-fbdev@vger.kernel.org>; Mon, 10 Aug 2026 00:07:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786345655; cv=none;
        d=google.com; s=arc-20260327;
        b=Z7IKRDyXYte5PJKYQ8sWzrLV3FNGeZBoB3zhXnB+V75Z6tU7gf7onsOzytwWd3nxXd
         f3oukLwOKrTY1TmqyUDoVhLouU9pQ+ju8AnDx2hPCM5GoL/NqVAL0EKj+rYKRZiMYBDO
         obTwYTRgSOvChY8zgL0yA8929PoiZzGvru+4oWbNyUjoM1AqlAHBxM20tQfYErZLvXVJ
         bl459EPd9TXUDQsIbv9eQDunPUfn4n55AnMeUINsYuKfopu1Io42dByChFZOSq97Gn7N
         VCH00k0yiZ+X/bSVzX7cXAFk5mwbkE7VvU+UxsVzee0ItvfcBnrguOZl5G4gi09Ja7M3
         T0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t0itK36weHoU2jtoEAt96DrFUj7FEsHjlM30gbeY12U=;
        fh=qOSZtA2xa/1FtK/lDK8lCJuRaTiQfZz9orF6ei/292Q=;
        b=Je5FX5aEe3BDQmGE2f0WYN+gXsgG/Vy2plvTAdBlLEVFlSmK/paMGthzA7FggQeWTB
         5RnBEvkTUPjntelrfgh+tUhmeK01kGTsbbVyGJrhW31D05W4xFPSSrKEzZ9POnExuzOk
         RFTvmdB2TmBVjudLL6lDxrCzQ4yw75lA9IS1K/4ouHqgEUt1Z4vK7DqJAQSolTXi+mzC
         cmoATMVJemuKLjU/3yYeUyYVlmLQ9SkewFTPoCUbGgHDJ2jH+Y7ZSNBQ+OA4o7Ov2G7h
         RoXAs5LVm3aOeDjFrZgtaHQqpm+Si4/z1EFl2a7uBaSju0KnoYrS8r1wkGD8HJ7GqlO3
         bn2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786345655; x=1786950455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t0itK36weHoU2jtoEAt96DrFUj7FEsHjlM30gbeY12U=;
        b=JpNlbQyiGFiGH5kUMXjQ3txd0p2d2psgYv4yIMOJPjKrDdgoLV5T0uGdN9gfAsgSSi
         K/1iaHy27aH7erW4+FwPdVhygyrQuxmS2z4GUGALvkGPrRjDRBOaChlkDoM320LVtaB+
         vkAyg0VfYcPkJk1HtYy+7XZ37FQaxyQeXOUsKa7NEeilX3Khpsy7gexZw3NCexIJ9CRf
         wDn8pPPSDyzc/Yp/Nm+X2j1ee8dbe2Bw0fx6F7oS70nVjelMuCVxkCNZfgdsqueseHfq
         otnHiKmbraycF2Rx964y9vQTdsVCPSX51XaxGbhvTEuaZQAdrxCQki1IGStxjNE/91p3
         5SGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786345655; x=1786950455;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t0itK36weHoU2jtoEAt96DrFUj7FEsHjlM30gbeY12U=;
        b=mxcWGVQQcRetMXf5eSwcRqpOQ9Q9St9AJTO8gqC4a7QxseaoV+j8L0Xt/+r2OqiNHJ
         T1v8vrryturh3j22hci42gl1xBsRXP6LnRIP7gvNdH3hmR8rqrSzf/OhCg/7Je6+BNSq
         LxkSujKmodn7AXzNzKSivTk+YzKwtidWo2P9pbSW6KQAo0qHCp1YA8Jp2PYum1QMVO/C
         pmyoOw8jP3E5HYA6/2CwHvPKFgNS58xbNCT7aAiBxQrVC7VWWO9wo8S44tj7H+0aqskC
         ZIpjkZU0ZrDommnMSrJl0541txjTwEHSkJowuB70UANlgCUUoAiy1tiboaymQzlCf3xR
         yWAQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmW8ve6fsVDUVh10iDYkp7Zxaz5qbL15gN83+XG7K43coHM/OckcgXlWHu89r3dKAr81Yt+ihKF0unSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDb2wuqG8ZoYkwnH2Tea+UG1plepX9xKE1vk85xgrBFVXoFwp
	CQPn0boR+AJZQXutebGtb0lUoqriy+dF2j1AymxS0yD8nvsUBjRYoH7pn4zqyEGYAzfnblYp2Qg
	WFvUz9Z5tJr8WeJuuKis29YzxXlJFlPQ=
X-Gm-Gg: AR+sD13Hi8R4O+qkvhE2XFZ8Irb8f9IYNDJB1T/HW9XEYsCHbHklLomTYLB3Ur/A6V2
	ClQYc3jDn8Sst1VmZrOZT7iomgRXJY7m6Hr79kZt6OPRpc55mSfCfDJept/Q6QVAv0Tgw8Ug99J
	rog1BzOkq4nE2PMsKx3DJt0+LSx4A3EcspT/kXPr/IaFgJxNDK3esEYmWFkoT/0XlxvZQld4jLo
	sPeT6g5nik/ekHomPtSqe9sBSckiXgiEXU4kIVwmWB0/MNcMDm26IPC1BoBknMstOR1Lg/ljZqu
	0RUaXceru9jcPpk5YBoZl1LX7wpJprGGp25+VFIDvM/hSYymIulwr1T7bkt7GOuEEiKM/X4vrhm
	Afllu0do3Hd6t4zbfoQtw3jruGbgKmEfWOyfYiTZno6EoIlaGECo0XwxwwA+X+nmbvjaysB9XKH
	OEnxqrRhAs4my4R3OEq6wZ7PfbhwsziqKdrNbrBO87kg==
X-Received: by 2002:a05:651c:c8d:b0:39a:cfe9:247f with SMTP id
 38308e7fff4ca-39fbb301b83mr46526421fa.31.1786345654462; Mon, 10 Aug 2026
 00:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809053253.14537-1-amballip@gmail.com>
In-Reply-To: <20260809053253.14537-1-amballip@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 10 Aug 2026 10:06:58 +0300
X-Gm-Features: AUfX_mwVA-ExyPEAQSrd3nXoSIktRzqRF1T8EbwlfOAr0G0N12s_EaUlhji3NvU
Message-ID: <CAHp75VcFkgrcBKJcvm8Br164MA8jM1xRKahBuZ-WPgEBwfi5Fg@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: Fix wrong controller name in fb_bd663474
To: Preetish Amballi <amballip@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 8:33=E2=80=AFAM Preetish Amballi <amballip@gmail.com=
> wrote:
>
> The file fb_bd663474.c is a driver for the BD663474 LCD controller,
> but the comment header and MODULE_DESCRIPTION incorrectly reference
> 'uPD161704' =E2=80=94 a copy-paste error from fb_upd161704.c.
>
> Fix the comment and MODULE_DESCRIPTION to say 'BD663474' instead of
> 'uPD161704'.

LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

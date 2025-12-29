Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F2423D2B4
	for <linux-fbdev@vger.kernel.org>; Mon, 29 Dec 2025 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766994100; cv=none; b=QKN9mw6n9qunH7elP0xyDuC+6zf6PoHAngGLY9NgEkBk8sGYSq4iAX66S5JW1YdTRKXPVlpU623J9a+dhlPLvxF7w95ikDrg0xWaoguZ/voPfBfWfEe4N3qtegA7GmosVFtT/+dGHbsIwWLon/xzS3Ebwt6Azpi92H4hBSMpqGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766994100; c=relaxed/simple;
	bh=eOkQciggp/BXsj7NQj5bVAYGclg96Z8dCMeXzgcsVS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5X8I4+a+2e7dKEPOxMtSJIVR5hI6uIcdIbphreWouWEQjDie71XvetR4DzaX0b4fDBhTWDf2hm7cHOilLYx1KfPD6JRu5FTWQX1OEIt2ct+mJFkCIGhXJqmiLWH92j49/NWebSAzeWX2Q5qB2G1eqKRUf+poqZsHsIkqbTyfhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzUWKhPy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzUWKhPy"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b83949fdaso11741948a12.2
        for <linux-fbdev@vger.kernel.org>; Sun, 28 Dec 2025 23:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766994097; x=1767598897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CA0M70EsX+ac4/joS2XDMeJK6N5Tfgg4wZNTxTHbv4=;
        b=EzUWKhPyYt6jLHLqw2LJrYmGVl1/XSXSLOLIC9vwEUPxxE6wzWU2BzWxj42OZM+fn5
         lbAiGlgI1/fBuXPv5a7U928J2b1yohKalkIcmlslFa9VPOC+f7yUE3ue4xhlnBLo2SMc
         9M9QVOgOcFkjNXOHFXovGDhXIKMmq7mAqesCOvmZsmtI8izMPyfrBxInKB804ZeCKREt
         DTq9z6odCe08/7Ejy9WETnZQCf8SBRN+AHC9hbV+2s+noHViVgTO/MaMPyIjXzsOYLpG
         5QUvAu/y10bVFOhEmGK0hT3w2vYYRS4LaVjTBBpizCqzcBPsetz8u1vwR90j/sEolHuR
         BR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766994097; x=1767598897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7CA0M70EsX+ac4/joS2XDMeJK6N5Tfgg4wZNTxTHbv4=;
        b=weM7STrLIz3oG6HpSIH/vKn2TVw5rrJtyAz+Ys6wn19QFaGdWT6hYeD81T6uhFgIMf
         gBcl55CjO3Y8PoGVqkENvbbi+Gn8L3jJP7faRIkR+D9pE1aYu75qVXQF62SsTowR5Ofq
         fms8aqGCjaHesqqWMo+050nLETgpE22r9XNCRiVHAekEjKfzZ1vpyytFVKGg+UHD6XPt
         eh3NWrHVFK+FrJ8xaGqmVT1FXkOnSVUssGS0kHizQK4I5XHRFScqj1shS4MsEie4pAnf
         yb+X0yiZDxo6VaVP4r5D8AyOBkxOy1ag54QsEWA8zc7snmt52woIrBz2Cbh59pdm7TaA
         SWwg==
X-Forwarded-Encrypted: i=1; AJvYcCXuqD5bp2smSz3kh+VivjS7MpRF6vxunSBoyIiHN4Peb3k7EVAPiTWuI5VO3G2cqaOK0U8VcgnLoB6jEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzA3IOyLzAJmAr8q3rodhLqqezMglmZv4c5wACMIN6/MxLI6FeY
	glkV5A8pV0GH2V15b+yNEnQbWp3xq6/gYxst2jx1J25biJgePhPzFm07hFcfYGmjyngo/qYZGby
	3j3Pb8205WTBfmVr1RnAsoHP3wdErVi4=
X-Gm-Gg: AY/fxX5BS1PcoIStHD2UwkSyfLvA1uOBWb9PP0giu1XHe/7WVFACPWb18kK3bCgSpoU
	W98vuETMZy+XlYw4KotR/9rtA5Baz6wcJTi4CDPZqTXntfp3ZxA9UeXuPdXPf4RKACly8JDpFs4
	J57C6xkWPwLA/zZ8eAjU0XhEYuTqIfy9RWCEK0lStHimGoWyod9zxv3copIfceyHyO6BuzyhPrC
	AOenFT+AVId3zi+mfWu/QLxu2XbBaj78fZpxIEUc/ILK4v0gJ6BS2RK6/AaqmFpfzwrMh8Vk4dP
	1GaoBAFs7+De1a1/xuPr2jTIquj/gQg5JqWHiiyEz4swrf3zRw1Zj3m1ltFcIfwBVh8m3kHBnyc
	9uFomR6U=
X-Google-Smtp-Source: AGHT+IFsiw3jWtdQEDQH/mXP+tcbghOYcPeWqAbdVDVv7o7/abPtivB78goQWZ0idTFYi+CcJ/7gCrJl+TRRu/MiPwo=
X-Received: by 2002:a17:907:9809:b0:b71:ea7c:e4ff with SMTP id
 a640c23a62f3a-b8036ec9e3emr2773470266b.6.1766994096979; Sun, 28 Dec 2025
 23:41:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229010814.94255-1-spxxky.dev@gmail.com>
In-Reply-To: <20251229010814.94255-1-spxxky.dev@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 29 Dec 2025 09:41:00 +0200
X-Gm-Features: AQt7F2r1dDWzOTpFWamMt3UW53SPeTfq7dsNRjTugzb_U_DAnDoUbownyn-BlB8
Message-ID: <CAHp75Vc9fnuMb3s-KtX5r+nmOH5BztP=d+h9FXpn2i34sCv2-Q@mail.gmail.com>
Subject: Re: [PATCH] Replace udelay() with usleep_range() in PLL
 initialization code. According to Documentation/timers/timers-howto.rst,
 usleep_range() is preferred for delays "10us - 20ms"
To: Alexandru Costin <spxxky.dev@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 3:09=E2=80=AFAM Alexandru Costin <spxxky.dev@gmail.=
com> wrote:
>
> Resolves checkpatch warnings:
>   WARNING: usleep_range is preferred over udelay

First of all, fix checkpatch to point to a newer API, i.e. fsleep().

...

> @@ -210,7 +210,8 @@ static void write_reg8_bus8(struct fbtft_par *par, in=
t len, ...)

> -       udelay(100);
> +       usleep_range(100, 120);

> @@ -231,7 +232,7 @@ static void write_reg8_bus8(struct fbtft_par *par, in=
t len, ...)

> -       udelay(100);
> +       usleep_range(100, 120);

This is an IO function for the hardware in question. Have you tested
it? How do you know that this is a non-atomic context?

--=20
With Best Regards,
Andy Shevchenko

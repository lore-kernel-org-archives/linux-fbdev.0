Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50756331A4C
	for <linux-fbdev@vger.kernel.org>; Tue,  4 Aug 2026 22:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785881732; cv=pass; b=PBGghfccQGvMtMKK4rHN9KwkbJz3oGMRU3Y9NAbunClg7T0GHUr5+v/ljb2166GeHqX78bnjIxXVt/jesbP91hK8R3cB/6M4+zjKyJH87uiSERfBcZrhKOiHeNjFBY5x8hpJSP9CLNw1qUha7d9ehPU626JsgRGJ4nRcDW+ypMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785881732; c=relaxed/simple;
	bh=ef3eP2ZfvS4QgihgygcbC4UqPqMKPMjYnWKL4nfyJxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqdCrbjy4UiKS2bPFdwNwduEBQwHNzEEzCxYBYLA+5hIVqbUG/wqo4RF8VkaCDuU8y17ALxw3u7G16uCSQLJDfHbTtJGdNJPb7zYramc2eaTPaP0HHNAA5JHiZP30bz7ExZrf4DU2kCX6P6DX/b4rYvYUR/d8Jz3gIVkM82rT/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/PJL+1o; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/PJL+1o"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so142509a12.2
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Aug 2026 15:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785881728; cv=none;
        d=google.com; s=arc-20260327;
        b=f1xZz4zCVV5PlqyZPdHtjHHtqTlEf2Uur2mk3MVdlcWgOeE2WT2dHkla3gSyOnMNXw
         sKi28D7xYOo1SHkWQJCcyFTa3xKlIYcZ+gByXhlyl9vOzjMLJKdcoMhWj6bdCjnZdmJC
         /HRObDCWMOWS+Ry6oWfuZafkxL/Dneyv7zFWaWqnIaO4cr2stg6juiM0z4B+AVmGn0bg
         +5sSq9V1+DVQ9VFYfzJLK+wHCq5bhPHaeca4ucdQ5vFgh1gX2rXwz0B7TQaiSkHyhmiB
         +HR0RmrcFBi43d+CAzqXkfJKwec25gveKAUGTMwEDA5SYZII1la9lU7YSRx6SqMfmiVp
         K5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ef3eP2ZfvS4QgihgygcbC4UqPqMKPMjYnWKL4nfyJxQ=;
        fh=S/aGKMX8PjglOwcU3hiwbtvKASiQ8/6yhUJl4/abKhU=;
        b=XmifnSUsH0YZ5OekrCwKBCeD1nt8blj7V5rsCi8cMpKf/bNvyB8xpFSxswB8F3+zZy
         Dca69vvNQ6k7oXVC13eGdq0QkCU6K0NnOFTceX4Nq2XKw16Lt64r6WXjOaaCV0UCHdRo
         QR7OV6gausNytKchNi5W2jbaR0Bc7q7MIhodEDR/cskOHQbFbU1unj6a/ZVz1iCFYj/5
         s4hAb3Z1314v7EXwhTTt8wrB9xtPJK/S6uJneBUgowaZwO7uAD1lr0C2CXBG2bRhkRw0
         BLVTQkaF6GaAD/TUZ+hWn33XxQCBN0NgMcgLudYpkM2vpYm06OpSz4gd4XByLC138TtC
         fEJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785881728; x=1786486528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ef3eP2ZfvS4QgihgygcbC4UqPqMKPMjYnWKL4nfyJxQ=;
        b=U/PJL+1oE0dcUkU8sgWS74BBDvtTojCsLYFO4TYVNL+SO96zN5q2w0E07Iokg70kn0
         jo70X3nttFJudn1F8kOj/oiaAlWaf3tXtvxGeQx8KcmFr8vEu5tMwubfyEbMs8HKmXjL
         4aHdN+aAlE8eEb6BDNUIjtVbUCY/NxaK9gJJHRFLh5qOs8gnBjWThy+5yjNptkrPydwP
         1/Cfvt27gyRDIIZ1ZPbH3mL15Cg76jzb7Qd1t32nUPjS2kvtTpNAyFM2lBGK8DCZLmMI
         wQYpFP3l/0Ue1eawz/tMV0vHpt8CivT4CBD3bn281qi3mueSvrPwxTyaG4vw6Mmp7tGY
         DJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785881728; x=1786486528;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ef3eP2ZfvS4QgihgygcbC4UqPqMKPMjYnWKL4nfyJxQ=;
        b=k+DXZhzYOdalBycmtehd72vI1zUhikqBh3QRExzHYfEH/01NSorDV11a8ZIphbBvRT
         6uAuyIWwTiYQ/3P0iUloFE7QMyJniNz2e+Xul/PDMOQWEcMcmkB6WE1fcXKhXm+4R8zh
         Kcelf+sXT3F7AQMhWb5Otq2n5CmkDim0a0XgaJGW/oz+07+LANoXEhLxyrG07o6QX8wz
         Rc5IJPAO9Mb+rFPi4xFJLbEhVcUTASM08JbEk8Kkh/3rhq+1bx/mVEC4505XTnB4AKNc
         9pDIEmqgmM2oR/5e0BO5jfwTR8wGMueEzWoxBwz+l9oPwIeK8CTFC5VAfCgyIN+EAqhj
         8q5g==
X-Forwarded-Encrypted: i=1; AHgh+Rq7gT1DfjFJFsSQYZ/cifBthENRcdA9SKBf3PMi2+9NsKjbH6lPazB0Qw2NSTvPoYkZH0DNa583nTuYuw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfemduuvw69mGuMckVKM0oDGsHLKY6RUFVfowT/ILFirT9mcDU
	oOl/wh9FDN8Thb89ikFYK+ZShXQ4HFTYOqcEpvz0YiTWzcPbJK8p0J6tcG2p8NNxxHCxj2BZRHn
	KZjQ9byR6BUbabFRLooua4YwLBMMcgjo=
X-Gm-Gg: AR+sD13vHyZaOvoT3BCOxU7tjptMv1I72qV2FCBGnyGZIcN89teDNCJb1aveGhuEE0H
	VBM3d+FMWqPdMG+xe6IekNUEXi6bTLSbuKwOrW6d+4JEfubmzWZokFg49FwCYy1lwtJqOl7UhD+
	pzigEOBj7G9NX3Nj8u+TyY0CF77kqPLdlzFCMdnqNrRjx0saOJpFYT0AedFYNSKhChbyp7wMwKs
	eQObVEs9a6//Nn6G8jvZewSRZdXtbYtHJokOrwLyDXFMi6GTRTjrWKXPg7DKaLWgh9oOtH22evy
	5aykPKntI/OGYDdNtXUHeoGmaa5/Zn/NE1GC+7uJkW4M
X-Received: by 2002:a05:6402:448a:b0:69f:b52e:7484 with SMTP id
 4fb4d7f45d1cf-6a14f254d4bmr1202877a12.19.1785881728391; Tue, 04 Aug 2026
 15:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804225617.264861-1-maximpedraza@gmail.com>
 <20260804225617.264861-2-maximpedraza@gmail.com> <204c2805-346d-4935-8e2e-1538b79ea995@gmx.de>
In-Reply-To: <204c2805-346d-4935-8e2e-1538b79ea995@gmx.de>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Wed, 5 Aug 2026 02:15:15 +0200
X-Gm-Features: AUfX_mxQbUNLor7Pu65Fya-T6kupsatV09gVQoaRffyeGIYc9D-fDFpjiNF7eXo
Message-ID: <CAEUXW=E+fcewEHoOan49f9TS4EHq8u3j1+ac0rSYXv+7TiP8ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: display: add a device tree supplied
 boot logo
To: Helge Deller <deller@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 4 ago 2026 a las 23:18, Helge Deller (<deller@gmx.de>) escribi=C3=
=B3:
> Instead of adding logo-centered, couldn't use a value of -1 into
> logo-position.x to mark the logo centered in X-Axis (and .y=3D-1 for
> y-axis)?
>
> I don't know if this is better or not though....

It is better, and for one more reason than you give.

The binding as posted says logo-centered centres the logo "overriding
logo-position". That is two properties where one silently wins over the
other, which the schema cannot express and which leaves a device tree
setting both with no defined meaning. Folding it into logo-position
removes the contradiction rather than documenting it.

The per-axis part is not just a tidier spelling either. A boolean can
only centre both axes or neither, so "centred horizontally, at the top"
currently has to be written as logo-centered plus a logo-offset computed
from the logo height. That is impossible for the reserved memory form,
where the height lives in the blob and the device tree does not know it.
With -1 per axis it is just <(-1) 0>.

So v3 drops logo-centered and logo-position becomes an int32-array with
a minimum of -1, where -1 on an axis means centre on that axis and any
other negative value is rejected by the schema.

logo-offset stays, for the same reason the per-axis case needs it: our
own panel is 800x480 with only the bottom 320 rows visible, so the logo
is centred and then displaced, and that displacement cannot be folded
into an absolute position when the logo size comes from the blob.

Thanks, this is a clear simplification.

Max

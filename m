Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6772638B7BC
	for <linux-fbdev@vger.kernel.org>; Thu,  1 Oct 2026 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863381; cv=pass; b=KM/zFqk2OGRcgdJWxFG3IUpf6zx/Df3m+8nRasU5P+0HLwslPPyOv1zs/Wpcs6zP/j9Jd4ey7J96iWHBd/d9lu9xYBtEhabxdSIlNcKfmEvixfSjaA3HpWptuKJZdPYwGQbTPOsQiMik2vbhT7H3rMKTPrizDoatlCt9DlMK9D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863381; c=relaxed/simple;
	bh=d6FEHjro//70G/l/gSUyI1rn/GjbHT4yliKB3BRSvoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrTyrhZRMZSic7enI5dMiSptmw/EXTrUy/lRxu4iOxU6ejedsHEtHP8Y4mk45hPUHhPy0grTybxoaHRaDBigLu14ya36I7Cwttto+qGNkDNMZlOr1PSvl65s2hwuIo9GqTGEUVOXQTXZsBPDxUTM/alOpW7rZHk3is+De4/G/tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzTgf67u; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzTgf67u"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c20ce3c118aso441666166b.0
        for <linux-fbdev@vger.kernel.org>; Thu, 01 Oct 2026 07:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790863377; cv=none;
        d=google.com; s=arc-20260327;
        b=MXujPjoxl+QlB12wd9OvJOpX8eLIzpfofK30t57C+NH2fV7NCEql9xMpKHZ1W6knop
         /1KZzN8cqtBxyJRDBMGXrR3U/l226vcTlhK6i0R+Ygz7X3fqbD0+cMnh1ZQy5d7OWN40
         Gg63r+JjH0Ihhras+ZqnYK4Mu9ma9qTHTAWp7Jyws2AwWi4VgosIC3eGF1e9A/vUaMyK
         dCr5Tyae/0KspjolSy4zqwG5dWY+vUq4iQwvS4nb54Y3jgdMxJ7bAD+oZwK5HsdHf8SZ
         lGswAl2Gl112TFy0O27+1FrCoHnjeEb3sz0u8mSWVQ9VX6c7SHgWd5DyX5dih04eE2D5
         bi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8/7CE4ZuKqaD2pkivrDjqtKal/kq71Tiz2qeo/N8RI=;
        fh=TmUi2DYLVW93x6j7EftztvQa2wQbBpAWfmWQVY/f0sQ=;
        b=TBPYUl++DXRaj96AEqvYoSGmpE9KCu2EvPWCzGNtxWyZ1pwo9hkMzXkbrHRXrJpHBY
         AiS/xT5RfHK2Q7V6ShaATJEkq+8dp1xqQcJ38ubU/yqvDTh2WjZQc6fh4bfOmBqXNmzi
         DRkvShg+GafyV5bYgos/5k6A+RTdVzV6rel1aDU5qN8DeUJuI4ApYsveomoCP3l+BJEQ
         9JN9qxxOhZPfhzIrgfFLhTYTeYG22i1jjgG/dMlw+swKY1W9aKa+X4w53i2Jzf0xU1bP
         5fhZiINusQj5d+00xJDFvFl+FWlyDgmTFncJEb3KchrOmSDKTYfTvimyhVT6710LNFQh
         RY9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790863377; x=1791468177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N8/7CE4ZuKqaD2pkivrDjqtKal/kq71Tiz2qeo/N8RI=;
        b=gzTgf67uUXHp7cQaKpcKZrOXOVOjCsA26wj6VM0QhdIYK2kg+pCabc9M6hgUqcz7hI
         M7BD5A27ynEu7jcN6wqK7jd9lEuUXDRBZE6TTNT8OlabQ6ht/xvz7+AvfmfkRdG/ioK0
         LgSr+BTY/5/A6ZekfTFBztWjCGz5DcmUksKpTzHE39OZjzwXbPkMcQDzf7/q/oOAiTAJ
         92WeOqByXw1eLscnUf76ioGuRH0S/isKr6MfSPo+71sa4zT9clyoKWS85xlqeJr3tlUe
         9ubpgCaCqn4O6zTvEDh1ZcwOpUidWXecwXPsxTiSSMvzAKDCQv/E0ZQUVNZLLSF2o5ah
         KLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790863377; x=1791468177;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N8/7CE4ZuKqaD2pkivrDjqtKal/kq71Tiz2qeo/N8RI=;
        b=WLuhl2/UfNHPnWEJSFM99ZAYTf/O9t+8GiOFHYxdZ3KAdZZ3c9XNx0F1RMksDWxGmr
         aXXsPebnGlIfwf1IcSoAFoxXOyTOIETy8I/1o8Iy/HqpgFEIQWbBJIluyvYwTbuQr50b
         zFScEuMFLf2Djrw2cYyWKmHJEXbQ8zquehCMltjs/ZNUIA2V2kCNYXrs9Hu7E+jI91Ro
         FuCSyjZw4XS7oqtaHu73796tyvCkylfgDjIux5gZLu+kdnwWMVGQXw2gwKnv/pzEmzIM
         g9aA4FcNm28ldv/0gMDEoZV49PJy6KTyft5KHXEAaNXr9la7epYcqtBV6zttEkX8r5Ci
         A42A==
X-Forwarded-Encrypted: i=1; AKwUvBzRQGqgShRTOKjTnX7RL27xaRM+xE8rgrd5IXqnlziDRVpKXYMd984jtgkeuATwFEwAokSprzSADhDZng==@vger.kernel.org
X-Gm-Message-State: AFuF++mHRm0W3kws3cd/iVwDDfqwbI7NrH/OdPyG73LLn3cuWDT2RA0F
	WtDOgUJHEtDkookvd47GBPoTpDTH/vw6ctdo2dMzxbSj3aLepFp84rC/YWMKvLyLvLkFiAtvjyT
	c5KAm/ObMCFHzfBH82bDgsAvi3kYuHEM=
X-Gm-Gg: AYBFou3kh5+mYICCY7M1UBEpP67DyT0+3gfXH87uU5Waz6wmAQl6xM+wKzEWrmatsM3
	8itWfHuUNjWxr59pyxPxhv8+WrDs2Aj8w+z6tz3+PG7sNV+HmlTEd8rSBScH3f9QVVGK+FuhPc+
	9wFPgj2996r3OcFVbXT3xA1WL6VjS3OHDRxR+4TuL4pjXSlL2nTTyfetiRjrRAKYeSu9t49YyY5
	38TBtguxCn5ZifNXUXZNLYO7FFqllt1JlYqwMvTLlaNCR27/OtaaoBoqSjwMQS/z6zYYxSeRmCC
	PcANc3YlIJ6VFV6hm6FeCbLizPHqsDWQos4vlKhIB/pTJdGdsbx+46vDyf4z/OewyxrZ1+Z2kmI
	0XpNz99q/wMS4jB31GdDccO3oRlBPxVdfgY8CeAecF5A2ZFcKtbNHcLl8qlXBptw+FVQMGaRkta
	yU//IUtEjPyJ20eyBjCTGGD/XyvfWsujXBmbiAYXmZ
X-Received: by 2002:a17:907:9625:b0:c2e:2275:1168 with SMTP id
 a640c23a62f3a-c2e33fa28d3mr242508666b.19.1790863377337; Thu, 01 Oct 2026
 07:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001133736.802604-1-tzimmermann@suse.de> <20261001133736.802604-3-tzimmermann@suse.de>
In-Reply-To: <20261001133736.802604-3-tzimmermann@suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Oct 2026 17:02:20 +0300
X-Gm-Features: AclHuK-Ck5Qo38vd623LvGwdR2qBOOVXPJ98wewQWMKyHiuuGCBfZRXpFz9rHO4
Message-ID: <CAHp75Ve1-LhMaLczyOyLYhXaHzhRVOTsG4Wi6c-KPT1VQJ-nKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/kms-helper: Remove struct drm_simple_display_pipe
 and helpers
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
	simona@ffwll.ch, decui@microsoft.com, longli@microsoft.com, 
	ssengar@linux.microsoft.com, andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 4:38=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
> There are no drivers using struct drm_simple_display_pipe. Remove
> the data type and all related helpers.
>
> The idea behind struct drm_simple_display_pipe was to provide an
> easier way for writing DRM drivers besides regular atomic helpers.
> It turned out to be more complicated. With all drivers being updated
> to use atomic helpers, it's time to remove simple-pipe. Also clean
> up the related TODO items.

...

> +++ b/drivers/staging/fbtft/TODO
> @@ -1,3 +1,3 @@
> -* convert all these over to drm_simple_display_pipe and submit for inclu=
sion
> -  into the DRM subsystem under drivers/gpu/drm - fbdev doesn't take any =
new
> -  drivers anymore.
> +* convert all these over to DRM and submit thme for inclusion into

them

(spell checking?)

> +  the DRM subsystem under drivers/gpu/drm - fbdev doesn't take any
> +  new drivers anymore.

--=20
With Best Regards,
Andy Shevchenko

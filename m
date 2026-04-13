Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552BE3845C8
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Apr 2026 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776059972; cv=pass; b=BKrDIGNaN5DHK+QdDGUrbUeyYEGxpl6Cn4qP8obJoolfTZx+fxj2xjqyGW2Om9p6Z9YSC1R96BITBHYVlmj1FRlqr1p2LyJGpDGheynrDHEK3vzFKUAn4piOoGqOqXrzm81v+IDW1Y8jMoHLzl1u+lxXtD1z0ohDIS6W0L9s6II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776059972; c=relaxed/simple;
	bh=qNEpgoGKCBmpBW7B8Pk3rg81p9M1LG8cQpxkmfpgVi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlzM8ahw2I7uE3oTNNLCj9oaV5sQz3fcIHqUhL8rmA9hn9cyT8queAn7vBI2mr7Yk1izeZm9/lmN97HLb0ebHw5vbagIqT+w0dbULWc/4+8FTVT2wPW0R8pUbJLGg51J4NScPMykpSWMYtJcJJF+zcAMcZ14byYHdZfYyj//H8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjpf+lje; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjpf+lje"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso514260966b.1
        for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 22:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776059969; cv=none;
        d=google.com; s=arc-20240605;
        b=QqUcVCRVe1JQ012/ng5wuhrMVDQ9arLFTiHqhwKb8mMIZ/9fFdXpMbDzia2KWr4IeN
         c0hJJfrGsrKis8+nDhlMVd2WCDK/lxeTDrVRVtEWnyU7iI/oCwhsA+22HhqBwio0Ern6
         3f+1bXuNe2fJTT3Ve1BYIg/UIE3JPP1nqSOpuqRe3WD6h3pYQYLuL9goCcfgyQABOjzw
         TLJZ5xk897b5Om+rVsXj5ukYCkqul+9FytUAlRQVWzGqYsdl2UVLxKqyzPp2e68riq55
         M2AiPaC9IZJ+y3ggjlVFSEqkW/g9moIbunud670SZanmKzVV0xiL88U+utmgnlXN6eY/
         ojRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qNEpgoGKCBmpBW7B8Pk3rg81p9M1LG8cQpxkmfpgVi0=;
        fh=+pWBIn/CHB9DLGOGxzYGfwJ/hwznpDLB8NTFbZ/1UY8=;
        b=RCcw7+9+4KAwAHP2iTdDgXOh/cRWJwjwqbXYJpGqA+Mj83poB7/+1qSK7YC1UlGjML
         44sjYRasciXkKmWNI2absVZZTk+6l6WqQIQW404xyRZ+A0PFUDADck4hBRw2XQuEwY5O
         uuvp1mOaT2qfBW+37qcz2ckq72lgIkFmesyKS0afnQMmWaq6j9jbn+IAb37PQ5fqSUf8
         YMG51WLoLcdgPeZ/ijmU0m5acgExTKeu3gnAccXI9+1I/z3GUe6SqAbEQkkHcziwwiv/
         9eNVWvegFf/zHoEmkuyemAkksQOp61YYT7IE+IYu5QkJ5xCrb4lyXryVGYcbSx2Wn2VV
         IGxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776059969; x=1776664769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNEpgoGKCBmpBW7B8Pk3rg81p9M1LG8cQpxkmfpgVi0=;
        b=bjpf+ljeEW0BS0bIrVXVkrzLczfkpDebvm6yn+2hXPw2GcTWwVgtxE0x2NrYo6/hTf
         CZX5GmjxR1FLDnSK1hFOBjJQRc6mclgytbUFe6z9qUKDnii470q4s0rPdf+xLZfDg3/C
         UKdXR7K8VMJbRkAuKjW9ssQbjXPIZPRURsTT2vjxNr3z/DIT437tpAYMA+o1NV9atDTa
         z0wurSSX0yNZu0psFHzvCWd5rwyWlKLwqEW938ywx8sO7eLQkkH2NfldHkMUog2+LB+9
         fsvTkDgVpIujSBjknARbBgy5tao7aBBbVNhUlZHpdU1kKpxY10DGOpWbSo9Ou9rn/DNh
         ALOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776059969; x=1776664769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qNEpgoGKCBmpBW7B8Pk3rg81p9M1LG8cQpxkmfpgVi0=;
        b=kAUiDXtVkF//nCK6GtziMEEg+N3acpQ41pkjagz0Nvmj9pYoEuoamqLcYUr+pVKE/o
         8HAY1a4pIsH3nBj1qU8gQxN1zCYY1ddYSnMrH0wNSTwB6XOorfZrYkvHCL5KEgp3nWRY
         iK0P5USFbqq+FsJAzGBN9/RBoUXzhUf28wG9/CY0x/x64J2SygTIpogAB0esB2JzqrKl
         p2sqGcU4JTSh22xtQLVkJKy6dz0ypuR/HTsoOgnFoICkLIA2LtodbD6EdoxyPBj/TzHG
         rjFBwNbkhCcAEDbLTOSZHSIry7BBxz7jj3sUqvlM08OXdxa1URbZ+kBfP4bRJEaFOaJW
         W4tA==
X-Forwarded-Encrypted: i=1; AFNElJ9J9GmkaHU8EAmHth5UXmovWJwGSbVEH/iGAmbLrceZasQ9dDDeWRrwGQ2zOz/zS8vaSA5VtfpQtPh4eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzY1jhDCx1EiAP4Xt1i9W9twq14J47h+NfwE4qpp9OyOMbmAwcc
	W+V2izrfOI9+J7cfp8N5t/99TMxPd7eLrBu+nMvLWEeY656K9AQZFhn2f5mnWvITbN+siQZgcO6
	RJLvNuHDYibYa/vKm8aLJNmI7U/sXYxs=
X-Gm-Gg: AeBDieubpYGkei8gpGOYTtJFvQHyHgAkZ1zZ8EBTCDkd7o80mNNTzoYRq5u31DeOdBB
	xUYQAigJSIfUWdPZNrxU0AbEYJg6PgEX4E9hLfwqBBWr+nSvABx/0Z5R/mvQ2TP/nmNU7Bg0PPV
	h7mKB3bdsOHxWWCLRCYeRF3FJazexHSqvH1xXHnXxDjNXR4tYqM6yQS/t5vr+MzoyndiAqrgoX2
	VJNrSd3K7zdffeYVOtxpbt9qAIbeCJZbHZYX77kxVNq/OvXxetUCI7LkwYdV4KF5recCFBiWCRs
	QZzRFCJOW7f/XdQUe+9DiRsbfMFIyODSmfoFfGxoQ8XfsOqPO2F2py09MyudXP0Ydig29yaTeoE
	BIpiYcHQ=
X-Received: by 2002:a17:907:788:b0:b9d:3af6:bd6c with SMTP id
 a640c23a62f3a-b9d729694cemr651556866b.25.1776059968313; Sun, 12 Apr 2026
 22:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412173317.3329-1-mzndmzn@gmail.com> <20260412173317.3329-2-mzndmzn@gmail.com>
In-Reply-To: <20260412173317.3329-2-mzndmzn@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Apr 2026 08:58:50 +0300
X-Gm-Features: AQROBzA8j3VszXwFcoXm3tMq33VS0vxR7xxrNxJqDXOQmJwlb3mUiGiFtaQEOGM
Message-ID: <CAHp75VcdWMvvM-oKTqRACSXSUiVsEh1Ep_82MsJxfbrG4thUdA@mail.gmail.com>
Subject: Re: [PATCH v3] staging: fbtft: replace empty macro args with identity converter
To: Baker <mzndmzn@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 8:33=E2=80=AFPM Baker <mzndmzn@gmail.com> wrote:
>
> The define_fbtft_write_reg macro calls 'modifier' as a function.
> Passing an empty token as modifier is undefined behavior in C for
> fixed-arity macros. Introduce fbtft_no_conv() as an identity
> function to replace the empty args in the no-conversion cases.

This trick is used in the kernel (usually for u8). If you really want
to improve, use _Generic() instead.

--=20
With Best Regards,
Andy Shevchenko

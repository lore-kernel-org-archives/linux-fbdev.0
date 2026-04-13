Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE636308B
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Apr 2026 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776063614; cv=pass; b=BqpAaRIqr9dmX0zwIwfIc4dSlTpnwKEd7IiS+pdw2ARga9oZ5mbdr6ZqR6M4NlpX+9Od4fD6/8kKCsi+3z+tCWAconC6+WBLhov1c2pTlVb3AXAa/JkDb944jgAUDwot3+whXkYf+DJfx71+R7n7Wp6ZYoHTHxXj9ghsurIiIII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776063614; c=relaxed/simple;
	bh=DNxWK0L5MVbngPTtX4ZuKM7+uvDs78OElrIwXLEPfAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1xawWXgTYHJRTOnXDKjgsE3tv5gsEkuaBzita4xQIdAJXsQkmtgK6BLUw1uab1Z4452pyG0ztRzTbZrig6EdPJ+dpsqeRyBgD3O59weU3anDrC+3ACXFjcMOv8OLeAYP5n6B4fN/Eh32Oxjp/vAffouXy4nlWe37aLSkXJ21dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDZdH7ya; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDZdH7ya"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9c62fc8debso616509866b.0
        for <linux-fbdev@vger.kernel.org>; Mon, 13 Apr 2026 00:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776063611; cv=none;
        d=google.com; s=arc-20240605;
        b=JCQdE28v99aAOMQGjxpG0Gp1kyHh2/PuKhVlBweKasPejiqgHf2FzQKMbG+c+iFGkN
         HbO7FqExIGYe/fjDaEo+l0jUpDHchIvxEvMHcRUgN5lrEtLN69ZgUdhsJ2L5LwRZm6n8
         XiSgAG8HBUzkCfblv9bx+p8w8xcDhXY0e5pRT3hXhy7HRKAG3AFzxTXjq1edU9peApx7
         0ctf4FWR/9v4UUB+rRwZRtjaiI6e1lB+LyTZXrs+BVIPfkkC9QcMVDxrnJsjAhBJQJ5l
         PS1GGdSOHslhU6foRDKV6DeohwD1+xXtig4P5xGPtOWMqwV9yE1d3JAyDWsbYxgATJCw
         MI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X6pSeBoMwbk97qHNLEiiR0g4dw8qT9zFAczkuZLFIic=;
        fh=vVDoicU+9xcNUT6k91pAEyPfln9oIKOivppXcyYsI4I=;
        b=Hec+GAgSXNJRIwWxDDusygjckp+SqDgbOgYaMI+kiRotZmIDwBPx8tbLw245pvFZ5S
         WBBdaleMsw/MerSgLaoED3a3lfFuOONHgyTKRa4/E2ZLDZfkuqXC1SoZwlMwe/LCT/rc
         IICQe40kEMFZXwHMffB+73wpnh8S7zzvAAKZpgGJ+SRpX2QXdsLfsgnQsCgkZqF8CWKB
         8jmygyNtD3HIAXnVgM4rzfeVAAAUNgOcAdl5fzB1x5aI1tVIHKDtmAdbSugdWttX3dOU
         gy6YKMr4N3vbrxB6+5GfN7luhlva6+FKveLzChWtpclMqEqezoXAyTiLNP5ikg9CLpfN
         cAbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776063611; x=1776668411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6pSeBoMwbk97qHNLEiiR0g4dw8qT9zFAczkuZLFIic=;
        b=bDZdH7yatRSoLspqXcY1lKPqaT3jQ3ba9ZYRuhG+2ws2EvJwd0HldLOTEYd6+9XqTz
         Ee5wa+oXZNrIXG/WOvAEMOlyjlwYRn807VS0FeN+rLlvLFfuy1GziUMv5uAfeALlKWQi
         cX3Tt3AQgyBqetvEtYVGk5iLChtFEK8rb9u8V/5ldLEgBRB4YLcwCZzoOGf+Vp2Z49TX
         NFm8j2GfycEG5blZpOShroWbLEjx15HDpB9AdtLb0EdXKoZ0BwRq2Kpp0XYXP8SLA9j/
         5sQvtyx5MsCbBXrt6TxVVXZ2Vo8bOL1EHUi1DpT4+A+XpYyExj5kv7BaKzKftvkgzO3Q
         rg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776063611; x=1776668411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X6pSeBoMwbk97qHNLEiiR0g4dw8qT9zFAczkuZLFIic=;
        b=D8JAAgAVrHuJSIoHJXdsdYBAgFMJ2RIox9YuamgvoIMFQ/MTCa3hkAoiYKUnm/Ptft
         QhBclAOMmp64pqN70+6R4cOsoyzv/N4aY6qBa7GI4Ij0E97Tzfeqf6LeJi7EqzxOh4M+
         ZVE6jD/j9ThJ+fnoNS9KHkvfqW8/nWq2jfx5ooX2FHeHFwpWd1VVnKtwlG46LVir6/xB
         6HXWinj1jXF35XsGoH9MlUdqu71Kitu8T9XHPI+JMoY44PppO9by79XDLvQkSyp7ermZ
         Vg26nufJ8dDGb6tDqo8ow+RtVtHXaz2KmlZp5ZIe/n/mEuBkdbfhDTWts19eLggQE1mD
         4K3w==
X-Forwarded-Encrypted: i=1; AJvYcCXi+I8TL4kbVFSB7eAheKzYuOQY3fzbuMTKbPH6oWxXGQG9xZ7UxqImSRpa+nQg2XEDJF4m1tzn9egCqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNAKhU1kz7JVCHgUTSexmVmtJOAEzOkeC5phi8rDu8kkmKOKLR
	pL/l5VRhrf8oIRnsPQhlQtcjbRRYEIOcULjPG9BVHzqu+odbgTSPuh6KEVoT0AYT58rZsHltTwm
	oSyPFmfFYYqXVYFZhre6KXyYstRvmsOI=
X-Gm-Gg: AeBDietBieJVXW7gCuN2J5CwsJspD78NfZW93B/ZVdM39KMIKoShuhIApx+iCmdaMhB
	5g220iUpRl9TAdt5EdxgzOAhFGuuvYFPRpovv1gwW+mvX0xvwnXuQefSZ0Is1Jywg8cZ/N2+k2y
	Uhnd7T24CSe62cWyR7iViMIvKRQIaCLSjHCiZYFSeFzvK6zMOR6zA004ZHUUxwV2DP/DZFi1SwK
	O91r7uq0uD3z7WXhSQ3oetuyO1hAMC49XkqVIf2BD2Ak1gN1T3X4oXDSDtuTsN8ht0p8dOXv1WO
	2N0qJoYZx1KG5MZUrJMOBhZ9ia+0GtBCjjHoTfl/YkFKM8mE4f3O4QW512sMv9Dm6eAjM4LQYZq
	Tz9pSuYk=
X-Received: by 2002:a17:906:eec7:b0:b9c:69df:4d99 with SMTP id
 a640c23a62f3a-b9d72ad8da9mr652948566b.46.1776063610650; Mon, 13 Apr 2026
 00:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218061406.8043-1-arjunchangla7@gmail.com>
 <2025121827-lubricant-salad-860c@gregkh> <CALO5-psPGGxo9bu4Yjs54Sj=Hpq4x4Zgvp6tEY2MzV+utUfGpA@mail.gmail.com>
In-Reply-To: <CALO5-psPGGxo9bu4Yjs54Sj=Hpq4x4Zgvp6tEY2MzV+utUfGpA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Apr 2026 09:59:33 +0300
X-Gm-Features: AQROBzC-kH1OmWCu3fYOKS8_sAHANFaz5pop-O-JWmBJ0plqPTqCm4ToMsiAjdg
Message-ID: <CAHp75VeZyn+55A3T2_VCGUrvsRwODp2hJpL21Z46UeyOeYyQbg@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix spacing before close parenthesis
To: Arjun Changla <arjunchangla7@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, andy@kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 9:58=E2=80=AFAM Arjun Changla <arjunchangla7@gmail.=
com> wrote:
>
>
>
> On Thu, 18 Dec 2025 at 11:50, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Dec 18, 2025 at 06:14:06AM +0000, Arjun Changla wrote:
>> > Fix checkpatch error "space prohibited before that close parenthesis"
>> > on line 65 by removing the extra space.
>> >
>> > Signed-off-by: Arjun Changla <arjunchangla7@gmail.com>
>> > ---
>> >  drivers/staging/fbtft/fbtft-bus.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft=
/fbtft-bus.c
>> > index 30e436ff19e4..2f7c891177fb 100644
>> > --- a/drivers/staging/fbtft/fbtft-bus.c
>> > +++ b/drivers/staging/fbtft/fbtft-bus.c
>> > @@ -62,7 +62,7 @@ out:                                                =
                              \
>> >  }                                                                    =
         \
>> >  EXPORT_SYMBOL(func);
>> >
>> > -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
>> > +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
>>
>> But you just changed the function definition, does this still work now?
>> If so, how?
>>
>> confused,
>>
>> greg k-h
>
>
> Hi Greg,
>
> Thank you for the review. The change only removes extra spacing in
> the function parameter - no functional changes were made.
>
> Before:
>     const struct ia_css_output1_configuration *from ,
>
> After:
>     const struct ia_css_output1_configuration *from,
>
> I verified the module builds successfully with no errors:
>     make M=3Ddrivers/staging/fbtft

What are you talking about?
The original patch we are discussing is totally wrong. Please, compile
the code before submitting.

--=20
With Best Regards,
Andy Shevchenko

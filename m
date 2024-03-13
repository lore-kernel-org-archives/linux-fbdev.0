Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEA47A40
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710346101; cv=none; b=sACoUc32s+YMnt21aS+OGoLmrO7Ob3B3E1c8j0YyjK4YJtmXfgW+yGsjZP909yCy1XGXeHv6U9zcy8tfKWKgChDhYeLvYTacePKaez555ait7SqikWm89W4Aoy0JiHnrf/Pi+jU5SokwO/JmkZ9xxRzZ6LC8+NIGQGrap6Ricro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710346101; c=relaxed/simple;
	bh=CovmuhB1AdolpKpkG/Fj3Mesft/l/SlOhQMcpkg7uZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBMymT5WeT72BcneSXf+bSZ6hm/QtZDQTYVIhgaqSeI8/q/JvD9DBCtUKaNrqZLYdQ3ecLE0D6zlCtMQV/xYiQaLW0w9FIJf4NJqBRRPRloSs4nfbCNEnXa4NfRTEsQ06jzbvx3GyDT80wAAgpxQgkTn8lTMi6YJWC9+4U9PbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nw7qr+eS; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nw7qr+eS"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso3600242a12.2
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710346100; x=1710950900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6ULIWkqwYtQwHi0nH3X4LEjPNLviw6dhHiCy7dWpr8=;
        b=Nw7qr+eSWuP1XJxMU8zgIWlLcCRI3KYmnQJwD+d/nzM4pa8OkaEWZ08gYaCFuYpSVH
         afLHt+hEz3rukrscHX5LZjvOT4xDzGja8B8eAwV1KxvzHRiRhbUh/7QhbSQVQamUcXo8
         tsAOD91F1KVIeYyOS3kaJ3qsOqOh2P+z9jI0vS3J7scgxtGePIbc4EM7sVW7fEXOFBaU
         iGpdqbxXodg+3ojU4sCngKRQ2BGyhuqUWG4e98LLQlUV/2UJNY0ja2c+1pBEurMynvxm
         Ye+mrt8V+tIKvhrW6taVh6mKW6gvnWNJ4+dI8Kbp4CMF4Dtg6HXLErnu/oJ3iyBsQZrM
         xBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710346100; x=1710950900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6ULIWkqwYtQwHi0nH3X4LEjPNLviw6dhHiCy7dWpr8=;
        b=q/i25cUqPzIdHdb3ImMLMhXn/I3CD+fRUvYkSIVo4M7mDw9vVYWdgQwpsOUXq/nIaf
         XOH+3cFHpwdHfBytX8jjIYwnoaoAghYIZKqn5G1ywG8bnnC08cFQTlcHaCbvgkyLA79E
         96cQw83mvbv54fiK+5Wka/U0xQgA/fyAcl0TSLRwhKXEOWm6mdB2/SGp3M6cFza9C6Kp
         5sxVDxJXc3/D90N77cufZWzWdmch2PiOCSP4cRznLiXNhfkYKHchkF3GpXRvSpp18e8a
         haUtvvs/GaYuxi8Qs93X+zcAAEn8OFzW4gg3H5yQ1ys91617MAZ0aL+I93TKvJDy0IU/
         cxpg==
X-Forwarded-Encrypted: i=1; AJvYcCWhYfMBVjHoLMZ59VZbAAyzjlvQ8I8CljrVTvPQar7nUCkEY/65MIwYzUDQLPQyWthho19gjSs76Q4iKDbQLp/yuaO4VeyzveHIudY=
X-Gm-Message-State: AOJu0YymZtmjB6prwJTFyaPxOjz7iD+XWL3fUcq2eV6qSnlUlMvDNumy
	tdmFdEXdckejqzHAMhZQNK78aAK6luD2Uz+h0ULkvgZMPWcCd5jPo0ZiD7wA7IoApdyJ75AUam6
	GiNKcM2eqlykKUBPHec5SrcV3qXcZHK5RK+Cg3Q==
X-Google-Smtp-Source: AGHT+IFw4NlwXdq8k5AaP0t6MV8Oqx6Tr91pjx5TGQukQAekNWRrB6XIh8BPrzA3MuN0QBTfxmlK7KxNwQu9LllcLBE=
X-Received: by 2002:a17:90a:a008:b0:29b:bbde:8f19 with SMTP id
 q8-20020a17090aa00800b0029bbbde8f19mr3568139pjp.33.1710346099732; Wed, 13 Mar
 2024 09:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313154857.12949-1-tzimmermann@suse.de> <20240313154857.12949-2-tzimmermann@suse.de>
In-Reply-To: <20240313154857.12949-2-tzimmermann@suse.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 13 Mar 2024 17:08:08 +0100
Message-ID: <CANiq72=5V_XChzDhaaWNC+B4LP7gqivPZj5Y10qqS4SkQTGB_A@mail.gmail.com>
Subject: Re: [PATCH 1/6] auxdisplay/ht16k33: Replace use of fb_blank with
 backlight helper
To: Thomas Zimmermann <tzimmermann@suse.de>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, 
	deller@gmx.de, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, Robin van der Gracht <robin@protonic.nl>, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

Thanks for this!

Cc'ing Andy and Geert -- the new maintainer and reviewer.

Also, a couple quick notes below since I am here...

On Wed, Mar 13, 2024 at 4:49=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Replace the use of struct backlight_properties.fb_blank with a
> call to backlight_get_brightness(). The helper implement the same
> logic as the driver's function.

It is not exactly the same logic since `backlight_is_blank` accounts
for `BL_CORE_SUSPENDED`.

> -       int brightness =3D bl->props.brightness;
> +       int brightness =3D backlight_get_brightness(bl);

This can be `const` now (or even removed and have the call embedded below).

Cheers,
Miguel

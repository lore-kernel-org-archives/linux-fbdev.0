Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C12628C
	for <linux-fbdev@vger.kernel.org>; Sun, 21 Jan 2024 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847761; cv=none; b=ezzH4m77sfA0HQWEyVw4Tfn3onEY/0FoNisnWsCiSTZ29zmkk7K7rg/DWYDgD5oeoAxuSGN/Ke09PH06zJ/7c1TjBZU0cEMwz4vvW2ddPrEL2qqask4cOWYCKQ4oay1w+twdJiIKgZnMnMlrX7U5SZi0NDwt1LyC2j87OAJkWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847761; c=relaxed/simple;
	bh=872rfjy39rwVRPIkk3ndSS0WStZElYm0Qg/+47Tr7M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESei2Kj/Xd6fs6E2+oi3Iilf9BcpEsQhKHNkmDadPJ/7JzA0cXW+pjbBTvtgMKRUiryxhWBh6xeh8swKe/Ui+ccBsXEnB8saq9LAOzjgGPfkfEHdjlPsQWKV62FyNX07MSi+TSIQBE9Qefp+5JmEmk2nPXENqTgDThxHr09Rdz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tZXCaw6p; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZXCaw6p"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ffb07bdce2so8406267b3.2
        for <linux-fbdev@vger.kernel.org>; Sun, 21 Jan 2024 06:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705847757; x=1706452557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=872rfjy39rwVRPIkk3ndSS0WStZElYm0Qg/+47Tr7M4=;
        b=tZXCaw6pMVa+X8oQTbA5GeBwbEEniZAqVwpANtGp2WRTt4H1BmEHGPW9h8XI8fVaj2
         QPkS7gx7yqMPVzupWMlfUTaSFiHeOKZjh5aK9HzyB/LdcghER1Z0ibSnzC4x5JQAJipg
         Fg/DaoywD/98zdtutlIXAiBMcXYq65Hvzi8XE7/jZrm+hZM/Gdckl9czCxf8pOXZtjk4
         RbF6bEksWScllJR8VcUVrohzLBdcZbJaVRxVUKXlLd9WVagSUE+IowLH4ye+eHolTfYT
         TlUd5HrcW/FUPirKZ2wljOI/LiFt1SQfLgh0ccFhZD9rFaPU7ftGM5xZugw27Qnpv0+5
         faqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705847757; x=1706452557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=872rfjy39rwVRPIkk3ndSS0WStZElYm0Qg/+47Tr7M4=;
        b=F4aDxWT5OA+V0M8JdEbWDobddwu1bYKyi7ERIrl4wCTR+ZrC65SFerBAnetf9trUHz
         9n7aJKKVBV46JY1Bn4m8eMRObeCl4NljK/gbf2Vqes2Wd8deCx+djz444VeHBoX1WR+f
         y98bZhuz/fp7mIfvmRjzh2jRbj2mNc+8NP4BDooKwZqinwTVl/2SJwPMQdO/Gilod2r/
         ChV3vasm8mFzNMHwRm/k48dcHQ2kBFTe0dLIYaMHlMzPJ/C983z6vvq+ogdTmdmzCHc6
         x5nBBaTnJ+rLqZUAdtL1vbFXDFFJ7yeQBGN6km37eDMu3lG7WNGH1uN7lMP6ip5HnloJ
         P0Fg==
X-Gm-Message-State: AOJu0Yy/nZBYrXJEsgKp04SbYpCzNZmT0rH4NumPr2GE/1pxGsrt60Dr
	sZBIRi8lUM9QLXD+G65SbI0VEw/0CEvhPfOFxhED2VtAefX+aekLA9oQJ/JhHZWv3JPc5MAUVSv
	F0Iz6mACmvOKEAzr3f/R11y9CTlpqTVyFrpkDbg==
X-Google-Smtp-Source: AGHT+IGJ2DYegRgTTs8ZHsk79g8rkAhLXrTgdRS3BTZclQzp+PaNFA6RmnfZAQEkPgtQz0pMrsua29Q2IC4VA5JrGXc=
X-Received: by 2002:a81:9c52:0:b0:5ff:96b8:f0b9 with SMTP id
 n18-20020a819c52000000b005ff96b8f0b9mr2720698ywa.90.1705847757431; Sun, 21
 Jan 2024 06:35:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120-ktd2801-v3-0-fe2cbafffb21@skole.hr> <20240120-ktd2801-v3-1-fe2cbafffb21@skole.hr>
In-Reply-To: <20240120-ktd2801-v3-1-fe2cbafffb21@skole.hr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 21 Jan 2024 15:35:46 +0100
Message-ID: <CACRpkdZJyY9oYMt3TvDEGthN-Wvz3t_40t9P-VsgTKCJQaD=pw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] leds: ktd2692: move ExpressWire code to library
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Helge Deller <deller@gmx.de>, Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 10:27=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovi=
c@skole.hr> wrote:

> The ExpressWire protocol is shared between at least KTD2692 and KTD2801
> with slight differences such as timings and the former not having a
> defined set of pulses for enabling the protocol (possibly because it
> does not support PWM unlike KTD2801). Despite these differences the
> ExpressWire handling code can be shared between the two, so move it into
> a library in preparation for adding KTD2801 support.
>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

This is great stuff.
I looked at my KTD253 driver but AFAICT it uses a different method:
instead of transferring a numeral, it increases/decreases a counter, so
it can't use the library.

> +extern void expresswire_power_off(struct expresswire_common_props *props=
);
> +extern void expresswire_enable(struct expresswire_common_props *props);
> +extern void expresswire_start(struct expresswire_common_props *props);
> +extern void expresswire_end(struct expresswire_common_props *props);
> +extern void expresswire_set_bit(struct expresswire_common_props *props, =
bool bit);

I would skip the keyword "extern" since it is default I think even
checkpatch complains about it these days?

Anyway, no big deal:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

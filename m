Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794051665;
	b=X//NED/6kGb0nIsPhiNGZI3aHI6Q/jpK91kR3/+/Uv4FgLG/BPgcP2yf6zT9cDv/vYqR
	 rgsuvdCZAG8bCcXPqHhcf2m70WPz9P0C8MhsSJyKb6U3cW6QwIwRUjZpk5NbmzkZCCZHr
	 JUhIYlh6U7RIIPHWpIcedyOI33IHkcZry4IcNws2J4nVL6o0GAXIPKpXltFmMk3S2Sp0f
	 fDZQ7JVN/noKp9pKwICdy1HBySSqtRnkAX9gj7xAg1p9PkiTFys19ITNyR479QOmWqE/N
	 hq6zyVu9BXhToFwAU9g4Q6LjGXFaRw/MTzNB/lldaZO6627bY2YfApdOLFhCueV/8gA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6fTH6XXWW1XsqnJehduXCj5gyuC0EEdV5T9p2wxK7S4=;
	b=fVIKYrXzzt+Gq+FDSV/RbraqcbfxMZ0+DkmyGNyrbNWTDOjTUfDwKRvwiiuiEf7HJS8C
	 3EkaTwpIB8U0LLYjz7UhZSzQB+k8G1y1mNfvZVqd+CgmZw+WhNEj8AMJ/wFP6jon+nDZh
	 1TmK8pYXJBx9u5i8gECXm5D0y2KtUoB6gMjG7hZCnKkHWyQ7TNW0fgiVC5RA3l+IuHDDx
	 7T0mkMJMzyBEW+PBh6evIjvGdeu5lKEMPlhBYlDZGfe2TT8v7kp75R/8B48nivireYaFg
	 ZOFAZdfaboM3F64JNgd9ZGhPAvAIF3bjkd079tMtpktaZ6ljxKiuqB6F+iGZ8pjKusQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Uv/MnhPY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44156606A326
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Nov 2026 11:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44156606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uv/MnhPY
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso18293537b3.2
        for <linux-fbdev@vger.kernel.org>; Sat, 07 Nov 2026 03:41:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794051664; cv=none;
        d=google.com; s=arc-20260327;
        b=poArf4XklIi/KEkJ3LnmFDeUJp/WwOrus7fwGGkL3cNntEaqQdegoQMuyPg64C1fFr
         q/YIUDjIrbz1krP1v1TOnd5Hq1kVi6M6+47vXZTv3LXSkt8jeQoriAqAPwjje2IUQbj1
         MERWxc+C5Z2fi4H13vIE6M9bhuRzQoEQnrQKEsRfgQSm2WFROh3zF7nFLGuaRcN84nel
         EViomm5YWNmSBasqt67gxVYtmxEj4Voq98H8DqHTaSWvFomlmklxDXAmcXb+lJU7AVUl
         wKqe0TSZI+R9szfdLKkDl8Y62O/L50igGXgf93u5jeQe+x4ObiiUUsEwSbKbU+Lj2RsU
         bVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6fTH6XXWW1XsqnJehduXCj5gyuC0EEdV5T9p2wxK7S4=;
        fh=TFllr/+FWBl0AUmslPbur76mXBO/k4heQ9rgq2UDoWI=;
        b=eUDqs8Mq3Vc46bsvznTM6CL7Ai8Z9qCuNHfn40PwOVrLeOYiWItW/Caez0etFQdibR
         Sun5V2X+9nAxtcwGHAvbuQ4GimytqEqRd36j6q4qQdXQtRt+g9FQenRO4Rzk8MzGc+jj
         wAdDu3HHYgyXABU3g3LWAFubIAjEn0YVDAsUtqEmX5tTquglYWDSyegwrfFB8jCeDC1z
         MErmq8UEKjEpk0gIswQLNfOX6U/c6u7U7FjZAJpZZEIqlsDoJfFBesgtBq5Rc/BDH0ax
         vrWGndUByIntRNfaUdyF7cr11rT9QxhDApZ+46Ktqr2jtbII8jDWapkUAlks7NZg/IWV
         djGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794051664; x=1794656464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6fTH6XXWW1XsqnJehduXCj5gyuC0EEdV5T9p2wxK7S4=;
        b=Uv/MnhPYUlJ/ZX3RqlHb/a6i0gp4cIGYXj+kYDIio6V/YvCxjxJA1aNGJgeNRUxdZK
         B/NFrxW9NBs500iOBSmcRTVBEasxYtHEFcd1egHm20Ej7uyJJ0Rp80nGbvp1/+e7tMUh
         wC4e8gHwYM8o8Vt+rPhlrdBEvOkGrJMCV7IXeSzzC3VlhId/fBBldvUud2QPRdiinNFg
         3BXu0ujHM/Sv5SgFKJsM0tDit0cL0SbhnobaRGmwzHbAhwWAWD0tA+ZwfGoHuknR0K4D
         CUIcEppiZGj832l0z4Crge1NX60zE+2QUS9g+zF6snRUzL0NiCH5VfG62J/ktBwChjUT
         cD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794051664; x=1794656464;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6fTH6XXWW1XsqnJehduXCj5gyuC0EEdV5T9p2wxK7S4=;
        b=Pnge9AssyThivmHi7nsZ1dbl+AbnbBxsqZ6uPZMH2CtyanRHSwsC9DfCxDyym5QKBY
         HazuGsuggZao5As/1njzBjRqwNnpuCV8xF55yAghDyWiqAzz/Igs5YM7Zi0XZqZFGHxr
         M0GRG7/6T56GVFQAaE60dwoKxR/nJ47TzlP1WexptgUI4FCq9UsFtMNN5mkJXCj4QVzJ
         so8LH0j3ro2pI7JspZ2gFVW3Cf5JbtzBLxOIx/7clFa9adbNfeo8w2LGCwwV8XHQmOoY
         rw89J1rbTqsRX232lsIbMHyjRsMCn4c9qMz6MkSCP1XjChOVNvrZJV9vCaUvjImLn+O1
         ZNjw==
X-Forwarded-Encrypted: i=1; AL+hErGEoXWdF83CuIszFeoh6vfj3SmwAeo4OeENyBjnH21hu5Vi3kyHZa9hGaUQY416jlWOBwPb36OjWICEFg==@vger.kernel.org
X-Gm-Message-State: APuU4Z82qYjQ9KSliLWSeQSSqfSRUBVbxl6sLa7mc8d9tFmfjmasTWvR
	e19bZqaCNcFEk9CSSIwjblj4BrPbp4Zc1+YbvPFL7QFaVLHHgNi7Svdmb3d2VWdaBuGCGPCu+4b
	EuMJ9HlfDPYXIdOHvYcnXAqG93ecBgEU=
X-Gm-Gg: AYBFou1y/gKC5lpz0lucpEPPCKa8lQFIFInOL4+XZVc9ST8xvLvjjxOWRBpk0qhH5Pp
	EU/huVb+yT8F5KKfvUovzdsBQPnXuQn58w2NJGTYtr2Fxsi155CS52Sh+K8MFPp9wor3kNCOGQx
	injW0wDnyviXFuHMsPAEEdW0Rq4THv9vK9c4zWuyfzL5EnHDHy4Zz1heIscWBDV9wW1r3GD130e
	CWRq4rKIOTM6Dc5tN8BRc9aZDBFUyqJGYfo6hbZ4BgzNi2Iyms9+k19aFUf9PrIMtK/ilc/AUe/
	Hvglzgqytkieobu9AjU2pn5W28PoDC4HKeQGHMZX0f6KkqsfRSkbhpIIeTmiJPIdsRLRdauI/23
	W90NK8+zMPvPQxFHZjIKu+sCyk92l9D5OJaNFhP1/ZkzsHnLaZxr9nWoL0AzsnkVb5VNMcL1Vhl
	FPUJxvVlsLPHZRddtefIeyORyWvuAja3IcZh+fzKwt6LAGFsg2ECGVTPAMzVz3E5/d959y2R4CL
	wRc0sfaj22+g8sz8N9itBWtYlIbWvKiz/fRLRhNdKLdyVvemyZJL6w4MfHaWw==
X-Received: by 2002:a53:c056:0:20b0:677:c18f:7257 with SMTP id
 956f58d0204a3-67c141e4301mr2310364d50.23.1794051664343; Sat, 07 Nov 2026
 03:41:04 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105201154.37294-2-matyasdaniel006@gmail.com>
 <874idv2bol.fsf@yellow.woof> <au4J-0GOUuueHLZe@rabbit>
In-Reply-To: <au4J-0GOUuueHLZe@rabbit>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 7 Nov 2026 13:40:28 +0200
X-Gm-Features: AclHuK9O7PUmgPlP4zevfIOy9d0EnpN6X7geLvTsMFUAaD8AWKettmZPb3yRw48
Message-ID: <CAHp75VedGBBd8qk5fO9-DkGwmuLQk77_igefAwTbrfcPCMW8Fg@mail.gmail.com>
Subject: Re: [RFC] staging: fbtft: Moving fb_ili9341 (and others) to DRM
To: Daniel Matyas <matyasdaniel006@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, dri-devel@lists.freedesktop.org, 
	linux-staging@lists.linux.dev, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Lanzano <lanzano.alex@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:10=E2=80=AFPM Daniel Matyas <matyasdaniel006@gmail=
.com> wrote:
>
> On Thu, Nov 05, 2026 at 10:47:06PM +0100, Nam Cao wrote:
> > Daniel Matyas <matyasdaniel006@gmail.com> writes:
> > > Questions:
> > >  a) Is removing fb_ili9341 acceptable, pointing users of other ILI934=
1
> > >     modules to panel-mipi-dbi? The KD233 node would then have no driv=
er.
> > >  b) Or should KD233 panel support go into a DRM driver first? I don't=
 have
> > >     its init sequence or physical size, or the board...
> > >  c) Is removal of all of fbtft already planned?
> > >  d) Several other fbtft drivers have drm counterparts. Should I inspe=
ct those
> > >  to see if removal is needed?
> >
> > IIRC the main reason fbtft needs to stay is because it supports paralle=
l
> > interface which is missing in the DRM drivers.
> >
> > Nam
>
> Thank you for clarifying. However, the fb_ili9341 driver uses only the
> SPI interface.

Only two drivers use that macro, indeed:
drivers/staging/fbtft/fb_ili9341.c, line 136
drivers/staging/fbtft/fb_sh1106.c, line 173

> Is it alright then to move (or remove) those drivers that only use
> SPI interface and have DRM counterparts?

You can suggest removing it, but it might break some users (yes, I
understand that FBTFT is a staging driver), but doing such only for
two out of dozens drivers seems to me a bit inconsistent approach.

> Furthermore, would there be a need to enable parallel interface support
> in the DRM subsystem?

If you can do it, I will agree on retiring the FBTFT drivers that will
gain such a support. I can test 8347d (IIRC I have that panel at
hand).

--=20
With Best Regards,
Andy Shevchenko

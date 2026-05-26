Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A4740315A
	for <linux-fbdev@vger.kernel.org>; Tue, 26 May 2026 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808152; cv=none; b=bkksjnb0PIGdWfFIoR07RqaAUL4D6ZD/OWnuaQBRewdjR01pdI0g3LrW4mcORX/HwXelz00aASO7bvEwDgepGVphjogvd5urYHNEq3DpC0rrdOC4Whaz/wDaziMWnOeejF2f+sKdn/hwAowY448g7DcT7Kyigqjzia13BsMTf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808152; c=relaxed/simple;
	bh=yb+0omux6d1zyLgvLzeZABk2GNuWtKQ1yrpCoQCsmR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtj2XobihtkXU1Egu1AKMcfrw2S7BCdq4iKeObF8vxlVUByVMOf4o2P45iDtAzv2HvacgE4/OTllB8d2hK94nOAyHPMA5nzL1uJBFmGqwpH0n9612W90ZVbvfV0pd+sCDfBd8kgcevi7BSQ6xXW8F8SY8hzNoC8U2r1fDFzjJm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bdbcc6c4500so860789966b.1
        for <linux-fbdev@vger.kernel.org>; Tue, 26 May 2026 08:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808149; x=1780412949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MLTPgXz6PTE+WNmbiors/d1TQS2Sqmrm+U6hNBea8hs=;
        b=enGLBODRQ/xj/7FKob+VRhCRCmmx6xykbm9JqI8yVzaUEoJG/74Z3+BrQwUMQadN3H
         Kg0wKmt3wx0h4GmLx1MTm13SCGzBGxpVnnTEoAF0cEusNqzse60NdeembWgoQdWNaZCS
         GvINk70iy6KbJU7YU+q9bnCjDdaV2DxigAAz5xxIEO9BpAZWUld37GPcOJFpCUPJC3se
         /I7eh6ghpZIJqxzc80Dv9HtX0FGMlhaJdHSNV28H8ZV/5v0ewnU8c33VvOtz9Psf1FQ7
         gioqA6tB4Fa9mUsjb0eb+oTDqsBhofedHoI8eWXxzvhIE4QIPbu4LU28Qzh/0lwu349U
         jerQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CakKihKFueKCKDAWZSTAlktIcRDOwQsjPPaDlmJSP0HtIDci1fwPUvYVu5s51oS6M84qF1Tf+rf4fZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4LWlpGA9Xyyiya588wMFgJMXXcBPzyRGxTMuRT3MeYUN4I8um
	N/Pq5EFRgTMFH2txa3cUPDOLQDqv2U9o6OH5zO4PeS/55XSZUaaOjUnUw96wz9nS+Vg=
X-Gm-Gg: Acq92OG3wo3twPgQ9P3qZ3chS/GseY8RCXwT0mVHDkm4eLNnTApFp9znFP842rqacne
	p08zvcNaRY2wTD5qEKalbqHpccntCFBS4Qj269xwJrjvbMMp4b4pi0pa2+gFYAS1gD5PXo6mqio
	dmM4KbGVaH7zg50QcehVdrwGSC1dSp2g3fjX+P0fjyQTAp7w3S/difie/sPFrfakh1zkkDU0/ei
	A3OEwYTXAoYgxGLnNflzCzvqKVCq1UrX+oE+QfbS0K50KLkdmnZpv4YiVXz0grkF1KB18fju18m
	3eXSx14OacmktZXhCGx4Up9Cwer9DoUlUewtUVgG9CNSEZT4cS0izDRAJmOhJQE7AMslPI9zOlk
	PLMDrI9t56cXadD8sqe9iUFfx+CD+jRsg306ekggtXdOzmyTsOKwf8AJBqXh7pzNixziN8eEK0h
	ufb4SpHCAee3BIioqwlFkog/96enB2qfzvs/mMy49Yw92ZKSF+qA/nTVEy3G4/
X-Received: by 2002:a17:906:9918:b0:bdd:52ef:73e3 with SMTP id a640c23a62f3a-bdd52ef77c4mr875895966b.12.1779808148914;
        Tue, 26 May 2026 08:09:08 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc5ece286sm504648266b.40.2026.05.26.08.09.08
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 08:09:08 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd4d7f4fa02so1800922066b.3
        for <linux-fbdev@vger.kernel.org>; Tue, 26 May 2026 08:09:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9+IKRcx9Xyr8r71PEaf5nvnJCCUnBI5O9rDeUzeEAPTt88MT5OMtBI49ORT2d4HzXJutzXq+oTULsDVw==@vger.kernel.org
X-Received: by 2002:a05:6402:360a:b0:674:40c3:f047 with SMTP id
 4fb4d7f45d1cf-6889ca4520cmr9385916a12.12.1779807721391; Tue, 26 May 2026
 08:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 May 2026 17:01:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>
X-Gm-Features: AVHnY4KG1TJnpMipnk7rqdd9LGhhF-uK_MvXjYFynbh1jLKZ-eyBikYr9yO02y4
Message-ID: <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in zorro_device_id::driver_data
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Max Staudt <max@enpas.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Helge Deller <deller@gmx.de>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	netdev@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Tue, 26 May 2026 at 16:17, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> this series is about improving the handling of pointers in struct
> zorro_device_id's driver_data.
>
> While it's ok on all current Linux platforms to store a pointer in an
> unsigned long variable, it involves casting that loses type information.
> This can be nicely seen in patch #7 where after profiting from patch #6
> the compiler notices a missing const.
>
> Preparing for that change, all zorro_device_ids are converted to use
> named initializers, which is also a nice cleanup that could stand for
> itself, as it improves readability for humans. (That is necessary
> because an anonymous union can be initialized by name, but not using a
> list initializer.)
>
> My motivation for this series is the CHERI hardware extension. With that
> pointers are bigger than longs and thus you cannot store pointers in
> zorro_device_id::driver_data. So this series is also about getting
> support for CHERI into the mainline, but I hope the clean up effects
> mentioned above are justification enough to accept this series.

Thanks for your series!

> The dependencies in this series are as follows:
>
>  - Patch #5 depends on #1, #2

s/5/6/?

>  - Patches #7 and #8 depend on patch #6.
>
> So if the ata maintainers agreed to merge their patch #1 via scsi, and
> Geert agrees to patch #5 and that it's also merged via scsi, patches #1,

s/5/6/?

> #2, #6 and #7 can go in without further coordination.
>
> Patches #3, #4 and #5 are only about using the same initialization style
> for all zorro_device_id and can go in without coordination.
>
> Best regards
> Uwe
>
> Uwe Kleine-K=C3=B6nig (The Capable Hub) (8):
>   ata: pata_budda: Use named initializer for zorro_device_id
>   scsi: Use named initializer for zorro_device_id
>   net: Use named initializer for zorro_device_id arrays
>   i2c: icy: Use named initializer for zorro_device_id arrays
>   video: fm2fb: Use named initializer for zorro_device_id array
>   zorro: Simplify storing pointers in device id struct
>   scsi: zorro7xx: Make use of struct zorro_device_id::driver_data_ptr
>   video: cirrusfb: Make use of struct zorro_device_id::driver_data_ptr

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

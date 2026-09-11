Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFEA453A5E
	for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112213; cv=none; b=XgzCRgTRArv9SMDHbH8+IvXo2OXH+Sbf30TOSjpJtTDQTbX2UJpq0azKzK660lNgKmylPRxdRziTvDPrsHgl9mBkkvJtWF+vHWPsUbnydYFE9nMnj5ud8nOcXJWjNihpSY403J4sCxjSF4OHEIJpxS3UHT3vny8wZ3GZ72tH+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112213; c=relaxed/simple;
	bh=gbmyJ64L6uNWZRacKLU2Vghqz/zZpdA4Wk9MoWvK9Nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAQjyVuEu14OdQEDz1gA5PRPXRLEEuxIzZuE0u/Ote08RM4O7FIrN866ZDH6Y8Sx89xoiC1rng58a7dYMdcNvbWc98MOvHIavkvmmh08BC7nTh/obXx5Nr7HiomzB1qU3FolFLHbekXeuLJAgovSrNO0J6k7Ch4t30StQ8aR5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-779d18ef706so404557137.2
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 00:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789112211; x=1789717011;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fbsARpw/dJVoneGGfEjuF+GfyjF53s/yH8EH4RLlPOA=;
        b=Hkhe5j6oGq5gK8qBqElyvcmuiFoag2COIrTOvjaV5xoELNaz9OXIrBQJX7RHzVwSpV
         W9Srb/fdCUE39Ylgi47QjbYI+Pd8nP+htaB4oshyasbxKQbZr78fQzlLNUm6oO75c+bi
         4gWQM9/STqHANXLfvCozn7B6TYGsZRP3ZpQmuM7FXIvCuPCSVdk2ffXs1fZvxl651xuu
         hmLDooUWElQcaCUqf47SlA+n7inrAVUO/ZdOYs34cmACEn7retvQDEEVwYw+y/H+oqQw
         lNNfbmPg0Kv4HYP2PhDY0oMTHS7naeS/K69RnI9RgUFQiYcJ28MRox7ca499UkVYsdDp
         fcjQ==
X-Forwarded-Encrypted: i=1; AKwUvBylL3yXSxRiBneFVmGRtDxdq5GrOjanyuud4K7UsGvGpyyA2Mnr7xq2BgVJe1KhfbYVsi449gNoaJR4zQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ljqYJo8pXIyR8SR3ZYf/rKiaDZ9lZngafmdKkmhSdxknFeIbz1
	2jsnhrXTurNi7DONDt/kBG+e5HAEqObMN7lI1/AGEsVK8CHS+GRBLMSeS+eGnoes
X-Gm-Gg: AYBFou3lAkNgr1UmdXPFNv23CZUBG+I/ipRp8MYyGdSkLjy+fIUIcRNRuheMwNUDdHV
	ZZ1ceCNObWiS9L2q6yAh9r2J3c2B4c4w1qSHvs5CsaI3pWOci4E6muw0bcfdpm40ykFunyG5N3d
	563XDA3kBF1C8csPOdYR1xmVFcz9TGaxgqdyzHmFZLnBoyP9Oc78sA7cd3oYZZDBWLsbEa8Nwye
	5BWSIh/f4xzDXyvD9dWhjujzspb6FsoqoARD6nnVEfokCR6mW+cvMqMXdx5FK2Z6iMy4dsi7XXo
	cGwXQHXy9UGDmIHJtlWmheLoV3fm82I669GvPbJLhUz68lxDm87qVsAe9f0TW/vlLMgMxR0WxCj
	RjN+k+4bCK1mau56ncHP4iE1FirD5TqQd7lzcGiaCqBL8mBZjvo9IKKOKLHsLrmhp5P3cOpj5Wa
	s30ghQVHqQi2p+qI3lcXpiIoq8ixWCxtUR/slz2oa86FLeC0KiQgwbLwQeeHg0nea4r4nSsZKyB
	c64OS5LCKQbGsOe07dnIN32JO6EV63kgOPj
X-Received: by 2002:a05:6102:5493:b0:784:b9ec:9144 with SMTP id ada2fe7eead31-792abb23c2cmr2601478137.8.1789112207758;
        Fri, 11 Sep 2026 00:36:47 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-982ba0c3679sm1868591241.10.2026.09.11.00.36.47
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 00:36:47 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-78fe51a2dbeso533024137.1
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 00:36:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy8+pKpLMwBnckN4LEbqWeawz5ioB5Cb7bp5Cbesi0jS3I3WNWSkd73U8EyUNwUFI43dwRUneAZ8nxQ5Q==@vger.kernel.org
X-Received: by 2002:a05:6102:148a:b0:77f:fb50:8820 with SMTP id
 ada2fe7eead31-792acdd6139mr3532430137.11.1789112207336; Fri, 11 Sep 2026
 00:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827093948.2825531-1-lilinmao@kylinos.cn> <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
 <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
 <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com> <CAMuHMdWoZBGyH=WeiTG4QCNC4hr_+pC4QQb-wjK0afZgMUy1Fw@mail.gmail.com>
 <f2656a6f-0bc4-2afe-1a1a-f8ce1167e090@gmail.com>
In-Reply-To: <f2656a6f-0bc4-2afe-1a1a-f8ce1167e090@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Sep 2026 09:36:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUBn5yjXA25zOjUbtOjeY105AwJnP+tvJjRH5Y-qzfjVA@mail.gmail.com>
X-Gm-Features: AcwNN1VMa2RNewNSKr2wzj3QZMXOaBYMFGdqezh5M0Od6lwZNKFjHs8IMjeEn6M
Message-ID: <CAMuHMdUBn5yjXA25zOjUbtOjeY105AwJnP+tvJjRH5Y-qzfjVA@mail.gmail.com>
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>, 
	Linmao Li <lilinmao@kylinos.cn>, deller@gmx.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Michael,

On Fri, 11 Sept 2026 at 06:53, Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 08.09.2026 um 19:18 schrieb Geert Uytterhoeven:
> >>> Unless I overlooked something, the fill also looks wrong on paper: the
> >>> first line is filled with a repeated byte and then with repeated
> >>> 32-bit words of the same value, which cannot reproduce a 3-byte pixel
> >>> pattern unless all three bytes are equal.
> >>
> >> You're correct - we'd need a memset24() to account for that. Without
> >
> > Unless the frame buffer would be using a DIRECT_COLOR visual (which
> > is not the case), then you could draw pixels in the 16 console colors
> > by replicating the color index in all 3 bytes ;-)
>
> Sorry, I don't get that - are the console colors chosen judiciously to
> allow for that?

Sorry, I don't remember if we still do that.

> >> hardware support this is an academic exercise that I don't have time for :-)
> >
> > True. And as this code is used only to fill the first line (the blitter
> > replicates it into the other lines), the performance difference between
> > a simple byte loop and a true memset24() won't be that large.
>
> I wasn't worried about performance as the blitter takes care of most of
> the work (though we may schedule away from svblit_fillrect() while the
> blitter is active). Getting the 'simple byte loop' right is more
> important. My sample code got everything wrong in fact.
>
> There's a reason why we don't work with 24 bit sized objects usually,
> and probably a reason why 24 bpp was never implemented for the
> SuperVidel :-)

Yeah, 24bpp is tricky.  And in this case we don't even have to deal with a
different endianness ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

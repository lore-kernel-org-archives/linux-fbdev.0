Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383137F30A
	for <linux-fbdev@vger.kernel.org>; Tue,  8 Sep 2026 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851933; cv=none; b=Olt3oOysWGZjuJVIwQqru++5jE5748zLsSytbv9Tr0JSdEeOeQ/wI+wGh4D/01SIcHLzlfqF64S0TTm9u3zKUtgXuf1HtUBHx7HldbQ+8i6Z1GcF3Z2Brcv1Jurmuwvot92jizSw5UdYQlzIXLEqohS29mkQPtOSntZsylvJz6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851933; c=relaxed/simple;
	bh=atHJUSU8jh/rAd34gcMPQ5DnJpjMvR7FLz3fOgQccno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REjUbeYRT1BGoSw8ZDoxq2rc4RrPhDfgYxQb6AGOm2+PeiYLnoSMxRlUN1ycGwgB0KZGjqqxRv2HpwTZmnow39P7ieSqphATv3MCJdOfyBgcGBr+TAjBzf0md/CZmGaR8PtMi9nqpizRWLcnc04/YsYZlpsDA4x9XaY3hRtDjRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-754ac74c495so1344425137.0
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Sep 2026 00:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788851931; x=1789456731;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ASzOob7GnYKJXcWv8xLMRXcs4durQAzV6NwhNCTQzS0=;
        b=DsDLzVSyVWL02ETzMcRb/ybMkFe7B/E10LFTBHatWCSYtDJUxXkQGeWcAZeRoiHfjE
         PfwAgHGcLqsA+hdLsla/KqsarCVPLA/ySoUwFP5vHTBhBuxoSFN8WWD4row8M577kNEr
         CGFTnH6zGM6lG4YxUoi8M2NpOzalp4CFFDhHNp/RhCZvUrsk+j/vdZ/zh43uXt+pWP7f
         nxh0iJsIp+Cd5ot8H9OVdaU18bHiqKsqo17gxHqYoQivcfRsv4B6amhSoTfWPQnsRQ3w
         uwqpLU9esySMD3V8uXm8OYwAQ+QQW38aTxy8gtad6phLJ7JDoAGKJCO2Dhn12QULkvnr
         1y6A==
X-Forwarded-Encrypted: i=1; AKwUvBxTagc37XP0dWKO3oUp+mx47zStUxiCKL6OmbUfivuoViDZZpvekjN//SDfKaGwh6qX8KdrlJuPSzXd7g==@vger.kernel.org
X-Gm-Message-State: AFuF++k/1Gy5i2BQ7QiZI/Y/dVMFZGnszMSGyuzvMOBmmje2y1BTP4o3
	nRAptnETEjuOk/hSUxESnPkbnFsbGun4+JzOS/J3KNj+N2RnYuQPISxk/EtuGGcp
X-Gm-Gg: AYBFou1BQ/s/CmlfkfihcX7voTOA1kIwMY5QOyZW+phyYQGn9esAAG3z3ebR13f4mf1
	aZJzgp9YC27LBqYh57djvrxzrDaoDmXkt2xi0h/ervfrprosTzaqySeuJwxG7AetRQYTcw2Zs01
	efRZi+yF9c8Vprs5vcRpOiNCS3KpZ6bARwc0nSua9rHQv9fZ4QsNHOj7yP9cWjDEtJrIT+y7EGZ
	D9SZ0OXyF7p4939ttyeAeSYnln3BLgGevShB1tZsHbUostq0KDw3pc73SlD1MClibUgsgTzmiQN
	VHCdrnib73+6hoSU/FYQj77+Y8lq8DqaW+gZx1lZ6HGfT+EwgIQGDkEVjdOL/FOOc/84ZWGcfl7
	Tfk4/6cctu/pWUfkzrE6JtoJn6VPYd5gB28fValkFcsxLppitadwEIGLxBaj1DKU5coOoAPwfdu
	eBxSU5FP+UulAvES5Uz7pCBEKlcDY1JxarB3iGjkXmrgCVztPAmU2ABLdJNRUa8u7OjI7WPq1J5
	YBl1DlUULRM5x62/R8tSBDrQg==
X-Received: by 2002:a05:6102:292b:b0:782:e19d:6f39 with SMTP id ada2fe7eead31-78a4a483c93mr8220918137.0.1788851930723;
        Tue, 08 Sep 2026 00:18:50 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a47ae8dd2sm8404364137.8.2026.09.08.00.18.49
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 00:18:49 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-966eabad303so960411241.1
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Sep 2026 00:18:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByqIdHpAJ+4X+2ETRGTpUwWB5OiVOMspCtFP4v0R/YK8oovDx4sbIJor4TyC1T/rEd4l3TMmBMHVEIemg==@vger.kernel.org
X-Received: by 2002:a05:6102:5493:b0:789:5f54:2367 with SMTP id
 ada2fe7eead31-78a4a718223mr9320013137.4.1788851928902; Tue, 08 Sep 2026
 00:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827093948.2825531-1-lilinmao@kylinos.cn> <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
 <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com> <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com>
In-Reply-To: <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Sep 2026 09:18:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWoZBGyH=WeiTG4QCNC4hr_+pC4QQb-wjK0afZgMUy1Fw@mail.gmail.com>
X-Gm-Features: AcwNN1XmAqsgmY9dglWOajpNmnnts6xxj9nL1ZG-ZrxbM9jWTj4q9h8M9EtZsAE
Message-ID: <CAMuHMdWoZBGyH=WeiTG4QCNC4hr_+pC4QQb-wjK0afZgMUy1Fw@mail.gmail.com>
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>, 
	Linmao Li <lilinmao@kylinos.cn>, deller@gmx.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Mon, 7 Sept 2026 at 22:14, Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 7/09/26 23:14, Miro Krop=C3=A1=C4=8Dek wrote:
> > On Sun, 6 Sept 2026 at 11:49, Michael Schmitz <schmitzmic@gmail.com> wr=
ote:
> >> Hi Linmao,
> >>
> >> thanks for your patch!
> >>
> >> Am 27.08.2026 um 21:39 schrieb Linmao Li:
> >>> The SuperBlitter operations derive an integer byte count per pixel.  =
The
> >>> accelerated fill path handles only one-, two- and four-byte pixels.
> >>> However, the operations are currently installed for every external
> >>> framebuffer in SuperVidel RAM, including planar 1/2/4/8-bpp and 24-bp=
p
> >>> truecolor modes accepted by the external video parser.
> >>>
> >>> For 1/2/4-bpp modes, the byte count becomes zero, so accelerated copi=
es do
> >>> nothing and fills fall through to 32-bit stores.  Planar 8-bpp uses a=
n
> >>> incompatible memory layout.  For 24-bpp modes, fills also use 32-bit =
stores
> >>> despite advancing addresses by three bytes per pixel.  These cases ca=
n
> >>> corrupt the framebuffer beyond the requested rectangle.
> >> I believe 24 bpp mode can be rescued using something like this (entire=
ly
> >> untested):
> >>
> >> --- a/drivers/video/fbdev/atafb.c
> >> +++ b/drivers/video/fbdev/atafb.c
> >> @@ -2463,6 +2463,11 @@ static void svblit_fillrect(struct fb_info *inf=
o,
> >>           case 2:
> >>                   memset16((u16 *)line, pix, rect->width);
> >>                   break;
> >> +       case 3:
> >> +               memset(line, pix, ((rect->width * bytespp) % 4));
> >> +               line +=3D ((rect->width * bytespp) % 4);
> >> +               memset32((u32 *)line, pix, (rect->width * bytespp) / 4=
);
> >> +               break;
> >>           default:
> >>                   memset32((u32 *)line, pix, rect->width);
> >>                   break;
> >>
> >> Can't test this on hardware, and would need Miro to confirm it works a=
s
> >> intended.
> > Linmao's patch: I ran it on a Falcon with SuperVidel at
> > 1920x1080x32bpp, all good.
> >
> > Michael's 24bpp fill: I cannot test it because the SuperVidel has no
> > 24bpp video mode. It was planned but never implemented. Its mode
> > register offers 1/2/4/8-bit bitplane, 8-bit chunky, 16-bit highcolor
> > and 32-bit truecolor (24-bit RGB plus an alpha byte), with the
> > remaining code reserved - and TOS offers no 24bpp mode to set.
> Without a 24 bpp mode, the 24 bpp fill is pointless, so no point trying
> to keep that mode alive.
> > Unless I overlooked something, the fill also looks wrong on paper: the
> > first line is filled with a repeated byte and then with repeated
> > 32-bit words of the same value, which cannot reproduce a 3-byte pixel
> > pattern unless all three bytes are equal.
>
> You're correct - we'd need a memset24() to account for that. Without

Unless the frame buffer would be using a DIRECT_COLOR visual (which
is not the case), then you could draw pixels in the 16 console colors
by replicating the color index in all 3 bytes ;-)

> hardware support this is an academic exercise that I don't have time for =
:-)

True. And as this code is used only to fill the first line (the blitter
replicates it into the other lines), the performance difference between
a simple byte loop and a true memset24() won't be that large.


Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

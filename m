Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736F36B01
	for <linux-fbdev@vger.kernel.org>; Wed, 20 Mar 2024 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710974143; cv=none; b=lwU5XXeapsjWkCeKFQ+AhuUCs8qCDm2W1yhQU7ti+4LB6V1zU+Sstz956CChPH9C2b1XgzExjY2iafi0rAkTmOIFuLY9KJyVCrAFOcyYOcv2HrwbBNnp8ymOTLEoz9b/9a/pZEYHKGU1gwCpvtHuMOc1ugHDf7G7aXYZ7BNkBbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710974143; c=relaxed/simple;
	bh=NMlbaJEt7YuPuHyd8puVAOBb7ZGjFfwrKm2bJ1oJU84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFwMoc6W5YdKIbVRnyVYgs2KMV02h7a0pB7M+hULu9b3U0okE5h024hS+Czf4PW5bdrbmeQ34uFFKldBXowGZjGZ2kZwVWsrXr4mDaMdjKMrp9QWWUP82J7cets5NS+UU55DJFWizk4K1oYc7zccXFEz649DVeT1a/CtF1a7JTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eV/obVnn; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eV/obVnn"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d687da75c4so4839071fa.0
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Mar 2024 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710974139; x=1711578939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/Eqc8JOcHZY7IXZvTiJ/8bJTfQGWaXx+KUSs3MCDdw=;
        b=eV/obVnn+pkRFC3DIHtOu5DiaFg9XNthy/K/L8aCgvXkkVDNtcfuWph3MLxuKV98UX
         M0JYxVfXuG+JJokGK4wic7VpBuTRAZOWTbXrsPtAKPSUtBcw8TBRijyUyponujSD3QS2
         +Z2nqUTZmEvsKLFJyNZoig9Vr/F5mxjH3UqxHkK+w0MUE5HqWbGoWGmVjZWB8gyKoLCi
         lTXr6JXgp1RRCl7og/nEiCyZXQbkHWWGQvvUavvB5FvqthlhPN7NcPPCIL0oLeCvqx81
         VsqJtBQXQE0v88j4tshpdM8NspKjyTVDY7oIIRJHurS42m2GpMGgXR8mx/Ry+Y+TpaZ/
         XoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710974139; x=1711578939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/Eqc8JOcHZY7IXZvTiJ/8bJTfQGWaXx+KUSs3MCDdw=;
        b=Wyvp4tb4sSjB+BHPsh5lBuHttJlYq8PhVYtWhJeDYwPw16B8OpcGBKBLsjK/RyNo77
         xuCGXK/Zoh8ktE+nO3P1Gp638gTFUGykw6wpzMa1p49sHehmv2BpbocT0icKfpufdib7
         NkgfaIh5STGM3U+EfUN9TxPfjqTEtt2h3lC/Nb3gdwn6qQtg7t3b7J4BjKsP5MaDTvbd
         o73o2aHC9KCIddCECQSIJAZkDc0xDoE7VgiJch0f+lrOpvdfiJZAfn+fPj1OFdc40sN6
         qGocW1PQJLwf7EUUCF/IJCRHl5vjoqLJczXp3A70blgxlNjAlm+5cAzAv3WgGOqIDhc2
         obbg==
X-Gm-Message-State: AOJu0YynQ5S3rZNgC4y0VFFL4JGPJLl9mW4D2ZAR94vwEN1SP//AgbZt
	iOTgyXbB+RdHbR2ZEMOj8B8x3PN3SqTDVaAgLRoDcE2L/ERM6C3Xc3k4ZRNPOfiLEY6REJNzdhO
	MWdkCr5Yf/7+pZx6vk57qRl5ZINUPuCpHH6PU
X-Google-Smtp-Source: AGHT+IEn5Owi2sPtfaUxycTRYFwNeKA+Pm2rq41oCVa8/UT2ciC5oEejXaO971X27DHZCT9SSJ+kpz2ClHcFLTEpRno=
X-Received: by 2002:a19:431c:0:b0:513:e17d:cf3c with SMTP id
 q28-20020a19431c000000b00513e17dcf3cmr8896729lfa.1.1710974138867; Wed, 20 Mar
 2024 15:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-strncpy-drivers-video-fbdev-au1200fb-c-v1-1-680802a9f10a@google.com>
 <53670007-edbc-4762-9e57-0b3c29220d9e@gmx.de>
In-Reply-To: <53670007-edbc-4762-9e57-0b3c29220d9e@gmx.de>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 20 Mar 2024 15:35:26 -0700
Message-ID: <CAFhGd8ppVq9aGbfFLeL30jQ15KHS=FoLh0c1udXo=Z+pCfXL1g@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: au1200fb: replace deprecated strncpy with strscpy
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 20, 2024 at 12:56=E2=80=AFAM Helge Deller <deller@gmx.de> wrote=
:
>
> On 3/19/24 00:46, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > Let's use the new 2-argument strscpy() which guarantees NUL-termination
> > on the destination buffer while also simplifying the syntax. Note that
> > strscpy() will not NUL-pad the destination buffer like strncpy() does.
> >
> > However, the NUL-padding behavior of strncpy() is not required since
> > fbdev is already NUL-allocated from au1200fb_drv_probe() ->
> > frameuffer_alloc(), rendering any additional NUL-padding redundant.
> > |     p =3D kzalloc(fb_info_size + size, GFP_KERNEL);
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> >
> > Found with: $ rg "strncpy\("
> > ---
> >   drivers/video/fbdev/au1200fb.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au120=
0fb.c
> > index 6f20efc663d7..e718fea63662 100644
> > --- a/drivers/video/fbdev/au1200fb.c
> > +++ b/drivers/video/fbdev/au1200fb.c
> > @@ -1557,7 +1557,7 @@ static int au1200fb_init_fbinfo(struct au1200fb_d=
evice *fbdev)
> >               return ret;
> >       }
> >
> > -     strncpy(fbi->fix.id, "AU1200", sizeof(fbi->fix.id));
> > +     strscpy(fbi->fix.id, "AU1200");
>
> I wonder if you really build-tested this, as this driver is for the mips =
architecture...
> And I don't see a strscpy() function which takes just 2 arguments.
> But I might be wrong....

I did build successfully :thumbs_up:

Commit e6584c3964f2f ("string: Allow 2-argument strscpy()") introduced
this new strscpy() form; it is present in string.h on Linus' tree.

>
> Helge

Thanks
Justin

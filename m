Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CF719AD5C;
	Mon, 28 Apr 2025 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745822220; cv=none; b=Cpm5s+a/2zNu9RXPcdOWI9V3lNvvwY7BiESbwgIw3AZt1+B01iGohP+H0WubXufHRtklcKtchCB5YUGIAb+erhOaEy9zRG3dWkgbcFgyVfGBpwWIwVQVCoo0XzXAuvT1HmZ/T9X6ahiPVwxOcZNfy6DAtkH4GDz3Lo+4CS/gNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745822220; c=relaxed/simple;
	bh=Am3ATgqCXM7Z1F6TVuGcXo9TdrT/FcOarhjRMiPCh3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUXCXEvcMf0tA7AltVVfjI5cdcOd72BuMVTYEDO8nOKR5TTKnjVx7uPEfdrI8+zseec+frQ2XFECV92WpuNoX3aL+R51aK4tY09ix4ocv44hEZh2uRg8wrRqjTASslbr/Wp9lRXtJe0PRpwe/of1T0J23cyWSSMoXyr7BlkXMBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86fab198f8eso1744651241.1;
        Sun, 27 Apr 2025 23:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745822213; x=1746427013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HxYx13nksu5xy2CnHaN8inhIAqufNq0pgtm+B7CBB0=;
        b=toGcj6SMoqNISv51bLdmL5FzIFUuIhNx4htUeYUUpk9ietwH62Yly77/aiHzCCNnDC
         8FYuKRXG2kPKhyrXXZ9uK469B4KwIvAXYy6mSGu4bTwEFQ2G7A2MKGgqLfvVhGIyllTA
         i7h1AscXv40PJEzeRE6sNAYLjI7+bpM1oMHUR7MSJkuaZM64daESpnDmIFQV39UZGfGZ
         E4ge2/WiwUQuVkgmD7CNvq0QPrPYM++eN6nIg2rueL1v9J/9GlKOLD2dV9zzk+NlOK2y
         2ioZki1QwW6cSFBAuGManQ1P4g5qmj1hl3K2ngZ/z5rVkpNc2+UOowpXYADzLPREKYd0
         chuw==
X-Forwarded-Encrypted: i=1; AJvYcCV84LG14XLYXfmGzvPpxA6j20p1kNjSxBts7rs+JsfHlorWcO21cdFMjBYWcIf0NHPkvrRGczeMk4JCYFy8@vger.kernel.org, AJvYcCXsFp3bLRsmrJfAXk2koMbceq5HHUq0KRZSGTtTotlshQinleWxhUzRfJKfelC5lmDQ2Cwwk71w5LGbrw==@vger.kernel.org, AJvYcCXyu0ta7+ZAh1rdMVZZeDh4xUcbB23jK4bfGBfL3afD7HAdjqlT3T4Qu41XLphm53B9Ci5JKzdzx+NuqS+etqgv@vger.kernel.org
X-Gm-Message-State: AOJu0YyBM0/6TVfrPbdB8EUKbZXL1pZvDEk8znUZWnOGoeaZWN5Qr1Kh
	qzKN+iUPSvEKp2e2FR8affuQ5YexPEST2FvyS5LL6eguVy3iDPhCawtdz0Fa
X-Gm-Gg: ASbGnctTqvcNPREmo7rQbIwD9lxKI5XubIXbeufhNsrBjexz8vcXjlTM/BTmwcLbNR1
	oO4yKAZGb6zwi2C9+JJYVhh82x1Zuf8aVOoWZREjHzCtVTZBOe0Vyh+LrEwON6LPYWU5Bylzldy
	6TQMclpsEQLZbHqo2CryxLE8Pq5ySJCUhyghsqGw5mPkyywaJTOkzuqp31mE/LJiIup+Lazh1ct
	uz+Vq72anxcPBeDCvAoacArwCbtquh6fTncyONrd1cfIQ7H6dLXDmKb6CgNldX73kLqb+E4D7zN
	Brei/1XhDG5NnBaJVEdywVqqc8ch4xAJujKkgNhpGl2SmCRIVquoCNYFlzDcrOWUnXe+X9TfKp2
	Dmdg=
X-Google-Smtp-Source: AGHT+IEPTqWYz3bezSuvlBSjtra/w8wLuQXmDuFE8sHZ2XmylGgU1c3DARkidytYE/KTDopn4TLc8Q==
X-Received: by 2002:a05:6102:15ab:b0:4c4:fdb9:2ea with SMTP id ada2fe7eead31-4d640698094mr5235709137.7.1745822213301;
        Sun, 27 Apr 2025 23:36:53 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4d3d5662e5dsm1756433137.18.2025.04.27.23.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Apr 2025 23:36:52 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86fab198f8eso1744645241.1;
        Sun, 27 Apr 2025 23:36:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgl8XbjL7+wtgktsxTSj8Em/3o62Z8ioj7meeZKbIIkyXEhrR2mxLwZBk57FNX1riXfrc9TiCoA6b/9Q==@vger.kernel.org, AJvYcCW6PaKSbYhPAhl+bNXZlp+tDIdOILARxjUTC8Y8FzkbVTM8nnaUj2d1A8nm1REipRpz3isgsNFvQ2uieFAE@vger.kernel.org, AJvYcCWdG/6wtAXmi+s0fI5+yKt5vJplncF77BQabwLa3rYtcjAJOT2NtQutoN6q0aercSuQz+3/5s6IEo3I0jiUgRdz@vger.kernel.org
X-Received: by 2002:a05:6102:32d4:b0:4c4:e414:b4eb with SMTP id
 ada2fe7eead31-4d640d802fcmr4616539137.12.1745822212499; Sun, 27 Apr 2025
 23:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426062305.work.819-kees@kernel.org> <b982d4f1-6ed8-490b-8d47-6dc5231913e7@gmx.de>
In-Reply-To: <b982d4f1-6ed8-490b-8d47-6dc5231913e7@gmx.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Apr 2025 08:36:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVY1_gEqULGD0BzdTd05OAkodhk+RXKRAy-T-0+RJt7yQ@mail.gmail.com>
X-Gm-Features: ATxdqUETGiqKKLP9sekTsuKQhnr5eXZt4XYi72gcVaTSzgLI84_ILYIl_9rFvl8
Message-ID: <CAMuHMdVY1_gEqULGD0BzdTd05OAkodhk+RXKRAy-T-0+RJt7yQ@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: arkfb: Cast ics5342_init() allocation type
To: Kees Cook <kees@kernel.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Zheyu Ma <zheyuma97@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"

Hi Kees,

On Sat, 26 Apr 2025 at 13:33, Helge Deller <deller@gmx.de> wrote:
> On 4/26/25 08:23, Kees Cook wrote:
> > In preparation for making the kmalloc family of allocators type aware,
> > we need to make sure that the returned type from the allocation matches
> > the type of the variable being assigned. (Before, the allocator would
> > always return "void *", which can be implicitly cast to any pointer type.)
> >
> > The assigned type is "struct dac_info *" but the returned type will be
> > "struct ics5342_info *", which has a larger allocation size. This is
> > by design, as struct ics5342_info contains struct dac_info as its first
> > member. Cast the allocation type to match the assignment.
> >
> > Signed-off-by: Kees Cook <kees@kernel.org>

Thanks for your patch, which is now commit 8d2f0f5bbac87b9d ("fbdev:
arkfb: Cast ics5342_init() allocation type") in fbdev/for-next.

> I applied your patch, but wouldn't this untested patch be cleaner and fulfill the
> same purpose to match a kzalloc return type?
>
> diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
> index 7d131e3d159a..a57c8a992e11 100644
> --- a/drivers/video/fbdev/arkfb.c
> +++ b/drivers/video/fbdev/arkfb.c
> @@ -431,7 +431,8 @@ static struct dac_ops ics5342_ops = {
>
>   static struct dac_info * ics5342_init(dac_read_regs_t drr, dac_write_regs_t dwr, void *data)
>   {
> -       struct dac_info *info = (struct dac_info *)kzalloc(sizeof(struct ics5342_info), GFP_KERNEL);
> +       struct ics5342_info *ics_info = kzalloc(sizeof(struct ics5342_info), GFP_KERNEL);

sizeof(*ics_info)?

> +       struct dac_info *info = &ics_info->dac;

Exactly my thought when I noticed this commit.  Adding casts makes
it harder to notice any future discrepancies.

> > --- a/drivers/video/fbdev/arkfb.c
> > +++ b/drivers/video/fbdev/arkfb.c
> > @@ -431,7 +431,7 @@ static struct dac_ops ics5342_ops = {
> >
> >   static struct dac_info * ics5342_init(dac_read_regs_t drr, dac_write_regs_t dwr, void *data)
> >   {
> > -     struct dac_info *info = kzalloc(sizeof(struct ics5342_info), GFP_KERNEL);
> > +     struct dac_info *info = (struct dac_info *)kzalloc(sizeof(struct ics5342_info), GFP_KERNEL);
> >
> >       if (! info)
> >               return NULL;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

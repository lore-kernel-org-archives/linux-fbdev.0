Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0BB27FB21;
	Sun, 15 Jun 2025 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750021061; cv=none; b=AqXmpBM55Ol1MmK/Haiagcq/cq9lssMFJhg4KLc7bXqeB8bkwibosExO3ZsbDwPbeNWr3E/DSEZe+9mEQQiJNT/bEFqdFdks2drPeF9yQ3qHDzchzX5+aI6oPuHDuPedZpe+lCsHEefSNO3HC2LTDcaM5xpGCY2KPaPjfE8pKo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750021061; c=relaxed/simple;
	bh=O8POEp/LtlBaaYjyW9tq2nW6g3dK6HqPKBVeDTfcM0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSeDSiJ5rJgdl0+FTh+KMIpQKFVgsDP0ih3lBPXoyCFLY6YQGH11mbxdb6VNwn/5Al4ldTeOCyg6OcspYZU3smoEspLRa7NQfWuWUOR21RmvXgMNV4l5bligF0Sys0Ays7owo8MnJukqLbC6FDOjbv2ThuvY0zElxhd531c2qGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2hKtFPt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2hKtFPt"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso494250f8f.1;
        Sun, 15 Jun 2025 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750021058; x=1750625858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2aI5ojTa0fVOmRjpVaA+YiywY9TgSfTBgCLyg00I5Q=;
        b=I2hKtFPt044nhzi9tlnCrvfLa7oZFq/+xieDJRpOd+PHejte0kZtFoJHc8bljodwlG
         VktNOLy2A20IPIw+5T1aU9193zGtfxrI5Q2bdg7LfcKMV0J+LQIgAjkeg5Km1ZRH1ZjI
         Yk1ezDv5XzUywMsiSJH37XvOptjm6E0J4/BTdw3YgWORVCkZ2ML9Se6CSjIlnDbp3c+Z
         gD/fNtzqmFEoNsGtP/P3WZip9HdXwZpzG3YjRIvF7ZgRt8nX6hPq+oem9F5rrBUUpzwc
         oDvwlBKRkRBOD+nUhI9mhD8k+7Ob8fZtJdx/G86s8Bh4/+1DQv/t0uLAj705fy9g06wY
         2GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750021058; x=1750625858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2aI5ojTa0fVOmRjpVaA+YiywY9TgSfTBgCLyg00I5Q=;
        b=tSlTapeH/AOXfNpoqRCpONWkQXlUvlqeiWKLKWLWNbvrpl+30F3J6ts55bJ1viFLbj
         ojdxTRqB870vjUKK++UY8uNlmr9ZaE/DTnyJrUhjyp/wa0YZxDOhsS1IpPViB4V7+BKQ
         woFdvvirCX5ztu7YuleThT1eeXHFp7bUHVdlbPm0WT+IatffugmZRbdjeezrUfkkwjMn
         nRq2IPmfzy/9RPOl594RpAuywdw+QQM0Or6aNONWBDfU9cQVo0+mHfiPt7CYIfLYsFuV
         1S4CRpF6c3SzLaMUHsT46cvBdWBAidwO19LsWDQYI8hM8JMILqzn+D69Hkrze/DpGBQg
         /14w==
X-Forwarded-Encrypted: i=1; AJvYcCV7y7RqsxH8akcC6K45hGPsBa1blEgTgsz2l86PCG+ZUTGeeWh89dDKvM5wVjeWHllfqDtBfbM0tTtWEA==@vger.kernel.org, AJvYcCWw78IiZMYxiYcrnQriTQA+7RR0Du3VHp0HukC0QDkg5sgijJ8dnEziKKjhpVJJ1rjGyletBlMVcu7DM07t@vger.kernel.org
X-Gm-Message-State: AOJu0YwqnIitm4xhjP/hzg1X/FIfr1wxo7ePHMYvDGkC9g1atBtGEt7i
	jGKP5/TJLudy9rWy10RKQrmFZLYa8+ECHo44b0sLOrwNmRJVJlXQd8eg
X-Gm-Gg: ASbGnctzz4KGar13qF/yRre2x5EpRvhyUQV054Wqjn3ZjepWS46jK/GIBtv4Fx86kfe
	PFgicSDSM4GKbZ8K1xx30uBDR62b+DMv9BFd7Xw+pwgHzAs+arYWYtkcuRp0G4JVbL+Gggl9TJZ
	E13xD2vFt47BtHKLbGJ0QTkHHQjrML5U5/OQq89p8N8GKML7xFpX8UYGOUM70FJMzShFAuh8lWd
	GuzXD+ocri7tYwgcgYitGHDvgpQ72WkTeiUnAdzU47eQ7dmcpqDjnoEg0dCg6ePwrKu0erUavI0
	7DTcx7rXTmcae4LJK1VTk2u1U/uUNQIFCnNJTxJZiwtJKdWk+Ll8pmjLdJjCsQ8MANvUrP7+jF0
	ipCs4OuqaDB1OahBNRmi1JdH4
X-Google-Smtp-Source: AGHT+IGHopTKMDLrNy91dcBwnlGeBYYk8YgDhfPG4599R3YYx5c7CIxOz1VmF8L04MqVsJlAZiVs2A==
X-Received: by 2002:a05:6000:2404:b0:3a3:652d:1640 with SMTP id ffacd0b85a97d-3a57238b3dbmr6086391f8f.2.1750021057845;
        Sun, 15 Jun 2025 13:57:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a547d2sm8947987f8f.19.2025.06.15.13.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 13:57:37 -0700 (PDT)
Date: Sun, 15 Jun 2025 21:57:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jin D <alexguo1023@gmail.com>
Cc: deller@gmx.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: i740: Fix potential divide by zero
Message-ID: <20250615215736.3d850bdd@pumpkin>
In-Reply-To: <CAAi4Z-fDFw1gD2MbqucWRMN0DvKf5mk6B+GDD95x9o23G8iK6w@mail.gmail.com>
References: <20250614051837.3544959-1-alexguo1023@gmail.com>
	<20250615093003.6e524fa9@pumpkin>
	<CAAi4Z-fDFw1gD2MbqucWRMN0DvKf5mk6B+GDD95x9o23G8iK6w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 15 Jun 2025 16:43:58 -0400
Jin D <alexguo1023@gmail.com> wrote:

> >       bpp =3D var->bits_per_pixel;
> > +     if (!var->pixclock){
> > +             dev_err(info->device, "pixclock must not be zero\n");
> > +             return -EINVAL;
> > +     }
> >       switch (bpp) {
> >       case 1 ... 8:
> >               bpp =3D 8; =20
>=20
> The value used in the switch condition is var->bits_per_pixel. I can not
> find a deterministic relationship between var->bits_per_pixel and
> var->pixclock.

Brain-fade ...

>=20
> On Sun, Jun 15, 2025 at 4:30=E2=80=AFAM David Laight <david.laight.linux@=
gmail.com>
> wrote:
>=20
> > On Sat, 14 Jun 2025 01:18:37 -0400
> > Alex Guo <alexguo1023@gmail.com> wrote:
> > =20
> > > Variable var->pixclock can be set by user. In case it equals to
> > > zero, divide by zero would occur in 4 switch branches in
> > > i740fb_decode_var.
> > > Similar crashes have happened in other fbdev drivers. We fix this
> > > by checking whether 'pixclock' is zero. =20
> >
> > Doesn't it already hit the 'default' clause of the switch statement?
> >
> >         David
> > =20
> > >
> > > Similar commit: commit 16844e58704 ("video: fbdev: tridentfb:
> > > Error out if 'pixclock' equals zero")
> > >
> > > Signed-off-by: Alex Guo <alexguo1023@gmail.com>
> > > ---
> > >  drivers/video/fbdev/i740fb.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740f=
b.c
> > > index 9b74dae71472..861e9e397b4e 100644
> > > --- a/drivers/video/fbdev/i740fb.c
> > > +++ b/drivers/video/fbdev/i740fb.c
> > > @@ -419,6 +419,10 @@ static int i740fb_decode_var(const struct =20
> > fb_var_screeninfo *var, =20
> > >
> > >
> > >       bpp =3D var->bits_per_pixel;
> > > +     if (!var->pixclock){
> > > +             dev_err(info->device, "pixclock must not be zero\n");
> > > +             return -EINVAL;
> > > +     }
> > >       switch (bpp) {
> > >       case 1 ... 8:
> > >               bpp =3D 8; =20
> >
> > =20


Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580FA2417C3
	for <linux-fbdev@vger.kernel.org>; Mon,  5 Jan 2026 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625805; cv=none; b=AglFwH3hpsbDFBvvAB8rxrRxFYqpSntlfGFEuR7nZ+5pkiFLr28/GaxwLzX/6nRa1K3T0ZwgZCaIeQSFuOjZI+CIwfH1QQGeZLiVwkoZh7Pca9DBqR/oIoPSsoFIlXuXed6JBcRtoYXWGkrljHfAOHnkiSnN5mNIKVmwT004tgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625805; c=relaxed/simple;
	bh=qbkIUQxXn+yUKbjDX552tLsPC9KZIoC+f14OufuUoI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzKcGyU3IXoTp0zosml8u8PPLYs8tcvORypEg0izsHjrOV34vjiE+xHqzbAqzg943yn1P3QKwHw5bXiIeYvGqiglaXRb0g7DoV0hLsTW5UTaWkL/oTB/8YZga3uyu7qZF0WYoE2f4P1kYQew0lszNTFDJe2mYfnAUsNn6BVkQsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEpcxKpi; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEpcxKpi"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78fd6189c88so810177b3.0
        for <linux-fbdev@vger.kernel.org>; Mon, 05 Jan 2026 07:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767625803; x=1768230603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjgKkI960mta53SMy3Cx/puUXrH0qsBk8eh+vG4/oMQ=;
        b=lEpcxKpiNKBum8sdDzY8+X+0deowu23awkdOo8Q1PBL/XFThthId+IrOTupbtk/PXe
         depp3gDMlpE7wjhVkybx++keoRhzBmCJJODg0Iip2Izs851P5eFMR3lBaUOS2kLmj5RH
         xvkh40Zsm1+Niooo7EjRy96HHtOM9si9GwJqKrFopW6G49FUurudWsOLboubWCGU72y1
         p2DuYkHsDE48sA/1wN2OP0KtPm/6XUSIperj2Uq2D4INwUSL9N3rPuX5ViklRSRm6lbN
         WkmXcrcmhPUhCcoPMmZwO8dCdvZbo9AHisFvgVC0x6/9NP2DR/CAqffgD7o325GWfC6+
         Byug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767625803; x=1768230603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BjgKkI960mta53SMy3Cx/puUXrH0qsBk8eh+vG4/oMQ=;
        b=uThiWJWg1XFprk7cW0nIPnPzSTVKMW+ZoEB9S8lOZM2Lpvr5Vx7MzwFbGZtn7oUWvW
         UC9HBtQz0Rku1TZ3blwGyfb5IKK0pHpdRp/Sskv8lgj3AMaRr0FNMeJC1aYppuKDxP0Q
         JHCUrBMGQN1+z1Z6Lro4rbHiN/+rh5e8fsRZ+4ZCFQzZfFMILvv9h6yHXHASg1g+9Nqt
         S85s7x3UqfQMlUybYW69gCube+jqQE9ROQQLEpWbFbjZDQoIMUqqni1oPc5f+o02NoDw
         kpV+bneK61vCRMggF+WODCk4tTSxnj8Gk2dr59QAerQZIV8hweHwVUlAllGKe4sx+QkC
         BKyw==
X-Forwarded-Encrypted: i=1; AJvYcCWD2rJe8ttAJ/39Zn7uA4TXZRz3XtEbFbcrcPyYD0GBtZeO/idEYxdyHiCjyJ/rRM8lyYizX/RtA/xasg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIZNSxPKrRUw4+I/LEj9iuF+Rln+lV+NB5Pbg45FksJz3EEja
	JC/zERg+BZjgRwSpXCJ2EElTElEwpXwKaWxmjxiB9Ew4gpbSkzxFV8aJKfdlShp7YRJEXNdVbpV
	SvuixihaWJd2lrjTPREZ9rk8mBTo8yPk=
X-Gm-Gg: AY/fxX7aRgJlnLIsbmBlezf5LBmCD042CxBSZ1Bqq7ytmUEZ/PC52Vo/ZKeP96kKtsc
	6AyIurEJaWGMF00LcULAeapjkYUyBwDRjfELsxM5yBFPoFlTt57McpdVW9xZx4MnBly6XZqr5T6
	nM94CTYJE7HLAVIhuvNqjnZB7icCWOkgDa0uyXNHd3gwI1h6NNZxBv+F7/3tUfG2a3G/hg38TED
	KlCIAyZTFvBJfrt71up2oV+ynjuaHxc3OPuHINS9wDq3yfWYVf7GAO7mvHsgScFyR41KnCJQTv0
X-Google-Smtp-Source: AGHT+IEd4FoOYeV2bi6QTaTAdIjXmnqph1DvLN+wvfaAUUzyAym8Y4JISBI1VyDvskcD09yI/QPbCHBE8WjooHM5BLQ=
X-Received: by 2002:a05:690c:7484:b0:78f:984b:4bb9 with SMTP id
 00721157ae682-78fb405d23cmr421841917b3.56.1767625801687; Mon, 05 Jan 2026
 07:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104110638.532615-1-sun.jian.kdev@gmail.com>
 <20260104110638.532615-3-sun.jian.kdev@gmail.com> <aVvNJV93mprLcZwy@stanley.mountain>
In-Reply-To: <aVvNJV93mprLcZwy@stanley.mountain>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Mon, 5 Jan 2026 23:09:50 +0800
X-Gm-Features: AQt7F2pZF6GavYIHt7cH5Iy0vK4sqA7M4pPH0NYIVOmEsaNlJo1jShKyDDs3_nw
Message-ID: <CABFUUZErGq8tApjtDadG_gMnouJ0WTHXe10WyRHRAy5EWutijw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] staging: fbtft: ssd1351: send gamma table via fbtft_write_buf_dc()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Thanks. Agreed.

For v2 I=E2=80=99ll keep this patch minimal: only switch from write_reg() v=
arargs
to fbtft_write_buf_dc() and reduce the stack usage, without other changes.

Any follow-up cleanups (if needed) will be sent as a separate patch.

Thanks,
Sun Jian

On Mon, Jan 5, 2026 at 10:39=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Sun, Jan 04, 2026 at 07:06:36PM +0800, Sun Jian wrote:
> > Clang reports a large stack frame in set_gamma() (-Wframe-larger-than=
=3D1024)
> > due to the large write_reg() call emitting 63 gamma bytes via varargs.
> >
> > Send the command byte (0xB8) and the gamma payload using
> > fbtft_write_buf_dc() to avoid the varargs/NUMARGS stack blow-up.
> >
> > No functional change intended.
> >
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >  drivers/staging/fbtft/fb_ssd1351.c | 35 +++++++++++++-----------------
> >  1 file changed, 15 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft=
/fb_ssd1351.c
> > index 6736b09b2f45..b4ab2c81e528 100644
> > --- a/drivers/staging/fbtft/fb_ssd1351.c
> > +++ b/drivers/staging/fbtft/fb_ssd1351.c
> > @@ -119,43 +119,38 @@ static int set_var(struct fbtft_par *par)
> >   */
> >  static int set_gamma(struct fbtft_par *par, u32 *curves)
> >  {
> > -     unsigned long tmp[GAMMA_NUM * GAMMA_LEN];
> > +     u8 data[GAMMA_LEN];
>
> Ugh...  GAMMA_NUM is 1 so this is an annoying calculation.  So what
> this does is it changes the type from unsigned long to u8 and renames
> the variable.  I am fine with renaming the variable it's unrelated and
> makes the review harder.
>
> > +     u8 cmd =3D 0xB8;
> >       int i, acc =3D 0;
> > +     int ret;
> >
> > -     for (i =3D 0; i < 63; i++) {
> > +     for (i =3D 0; i < GAMMA_LEN; i++) {
>
> GAMMA_LEN is 63.  So this looks like a change, but it's an unrelated
> cleanup.
>
> >               if (i > 0 && curves[i] < 2) {
> >                       dev_err(par->info->device,
> >                               "Illegal value in Grayscale Lookup Table =
at index %d : %d. Must be greater than 1\n",
> >                               i, curves[i]);
> >                       return -EINVAL;
> >               }
> > +
>
> This is an unrelated white space change.
>
> >               acc +=3D curves[i];
> > -             tmp[i] =3D acc;
> > +
> >               if (acc > 180) {
> >                       dev_err(par->info->device,
> >                               "Illegal value(s) in Grayscale Lookup Tab=
le. At index=3D%d : %d, the accumulated value has exceeded 180\n",
> >                               i, acc);
> >                       return -EINVAL;
> >               }
> > +
> > +             data[i] =3D acc;
>
> Here we move the acc assignment after the sanity check, but it's just
> an unrelated cleanup.
>
> >       }
> >
> > -     write_reg(par, 0xB8,
> > -               tmp[0],  tmp[1],  tmp[2],  tmp[3],
> > -               tmp[4],  tmp[5],  tmp[6],  tmp[7],
> > -               tmp[8],  tmp[9],  tmp[10], tmp[11],
> > -               tmp[12], tmp[13], tmp[14], tmp[15],
> > -               tmp[16], tmp[17], tmp[18], tmp[19],
> > -               tmp[20], tmp[21], tmp[22], tmp[23],
> > -               tmp[24], tmp[25], tmp[26], tmp[27],
> > -               tmp[28], tmp[29], tmp[30], tmp[31],
> > -               tmp[32], tmp[33], tmp[34], tmp[35],
> > -               tmp[36], tmp[37], tmp[38], tmp[39],
> > -               tmp[40], tmp[41], tmp[42], tmp[43],
> > -               tmp[44], tmp[45], tmp[46], tmp[47],
> > -               tmp[48], tmp[49], tmp[50], tmp[51],
> > -               tmp[52], tmp[53], tmp[54], tmp[55],
> > -               tmp[56], tmp[57], tmp[58], tmp[59],
> > -               tmp[60], tmp[61], tmp[62]);
> > +     ret =3D fbtft_write_buf_dc(par, &cmd, 1, 0);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D fbtft_write_buf_dc(par, data, sizeof(data), 1);
> > +     if (ret < 0)
> > +             return ret;
>
> These are good changes.  Just change the type from unsigned long to u8
> and use fbtft_write_buf_dc() instead of write_reg().  Then do the other
> changes in a separate patch.
>
> Same for the other patches.
>
> regards,
> dan carpenter
>
> >
> >       return 0;
> >  }
> > --
> > 2.43.0
> >

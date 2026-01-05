Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC5F30FF33
	for <linux-fbdev@vger.kernel.org>; Mon,  5 Jan 2026 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603482; cv=none; b=SATKiopY6vfbYOj174eAnfiUgh6b3c0S5J6e5+vc44j8RplF6q9CaLfvhaQxg6os3Oq2ziQhvQgo5yOJlua0mVUZpeJYbhPlyOOrYM3uu8huPKsHns2Zf9II3P7NEgdHABa3eQ/syBJ42nT/8YIlBQ7pXTkQUefTCagw2s0OrL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603482; c=relaxed/simple;
	bh=XaX4bHRiH9ReiVTNHKZXGn1Ygf3lNSmqNcpoEyBFzX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i52PJMM7zq9THN+pKZkPsYTXW+foNDBDBjiBSh7C5/CMeTyT8vPi/A++XnulDvLy0cShyx4WXYU5DxBiDpkswYCInJdl3aEfNzaUaoit75DXDYax5HoY+AvWrq486feV2thUk1H7a1Wv9j7OBH2KRMj+ORMT9rmvWq5qU9txbF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiXZXVxq; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiXZXVxq"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-787eb2d8663so22673997b3.0
        for <linux-fbdev@vger.kernel.org>; Mon, 05 Jan 2026 00:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767603480; x=1768208280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfi641MhA/umVLqek5QS9tzsJKJD7eq/LZgECsG3MQM=;
        b=XiXZXVxqNjtLtZYpZibySrI5NrudLBtQZyntem4Ph97ghHkFBZ+Si0uGj005mGrECX
         Fi1B8Ii682ukjpMp4Ukx6DDfhl3IKUSjyxHxc//AkzaEZdDOGrgGMlQvMjo0z6fKpSjH
         Moe9FecrmGAa7TWLHUTOgnau9YgtFZnmCgjTvUmirqm0xU0kzLNSvoP4d62Lyo5LC5qK
         E7Nap8QP0l3Puh3XIoAubAJuNK4we55X7AwNB4Kg8Un+2iq4/lOEIpDFMORz71WXFUTN
         rPsennP0jgnH+x3UHRW8VONuOi52yFUlYPboVhfCbM9SFLqtrQwopw8XpmIemIAfcFFr
         yoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767603480; x=1768208280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lfi641MhA/umVLqek5QS9tzsJKJD7eq/LZgECsG3MQM=;
        b=c2PsaTZ420PGqs+4PuiBO+I5PHfOfLbu1svz6EiFcE2ey6fEWDqjrUKfB52/hpSunQ
         xBCkYHzHmBvOu71o+qx1JeRaYEowTs5rdiYAu/q9kYhIEj4qSoVa66e+z4dW6YEDbHC9
         oa2JYHE9wMzPBJXYIY7kl+ikhdMHRcuAedTPTesjJSYpQFVx9Qx9LxfCQ9jQgqCKjjUO
         yKeZ+l9Wthszq8o5ULKFf6pR5HTwZNAc8sJeNzX52b9V4rbFMWtfniuEOdtuN90o23Fv
         i+Dfpo4btmO8VHo+QFwsX2t3nfq1zmnhqqfYNzVm31lEqIqxNMknkzkd5msAcptr/Ims
         3Znw==
X-Forwarded-Encrypted: i=1; AJvYcCVSdEzm92GYgRgEqWxFVjJ9hfJnHM9y1puGtq+GDb8vJj3K6nPw2i2cYEAyCb5eDsNEZHtpIypxzyv4mA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/YESHaMDLKW6n0kB62k55unDNGtE5dwo+r1CNcD2u3koqOSxk
	YTpoNyWOxpYpbdvXHoiw4eGvjP87bILUs02bO0e6Xs4ZjM6jMHLpXLO/e8vGhfjCN3ryQUqeaSr
	f6VEXVsHLbSdTTkVd+V5lT82qUMvY4cU=
X-Gm-Gg: AY/fxX7TbIzKtaYkZ4iT9Xkh/Xn0ChHquYW23Yq1qkOkJolQVHwpbvwhH2v7GQXbOVN
	IKW9duCnZEgE+bRSR2/VPickrr4Nn/buZl5djxxb4OLbh0HVahufbBKoEHOs9CKSs2pal+ODDkQ
	55gLiIIa/A4awtXhcKli6pneMUqvBY55aNF0aI2htY5jh58UnR6rtcNhGeGl9ScBNqjiYN4OjB2
	g7Z2ryl+4u22QzJY7VAiaBSgTvHZZPwf+JajGZrztHkgWgWbpIHXIJFC3eNVTn3tWHAXrZoKgZe
	kspW7GL9/H4=
X-Google-Smtp-Source: AGHT+IGPvme/oa9EmRyX4NQ0cxB52KuQL58ODtWsxH46f6jDOlCmADYOjHWw9FTKJAzaY5s5UT/1HSQDRYK+fDcZT8M=
X-Received: by 2002:a05:690e:120f:b0:63f:b440:7f90 with SMTP id
 956f58d0204a3-646e3347886mr4238085d50.16.1767603480050; Mon, 05 Jan 2026
 00:58:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105021026.556244-1-sun.jian.kdev@gmail.com>
 <20260105074917.607201-1-sun.jian.kdev@gmail.com> <2026010505-surging-resurface-a7d3@gregkh>
In-Reply-To: <2026010505-surging-resurface-a7d3@gregkh>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Mon, 5 Jan 2026 16:57:48 +0800
X-Gm-Features: AQt7F2qTxov-obu2XVbbWDf_xbl8TSMp3O86wKEULY1m2e8OiP1LCqksFz8sQzs
Message-ID: <CABFUUZHRz919=C=fmMqH1sQcURbm+qiQB795xWPCd9Rax_M4ZQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: sm750fb: fix unused tmp in sw_i2c_wait
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, sudipm.mukherjee@gmail.com, 
	teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Sorry about that =E2=80=94 I mistakenly replied only to you.

As you pointed out, sw_i2c_wait() sits on the bit-banged I2C GPIO
transitions, so changing the delay semantics without hardware validation
is risky. I don't have access to the hardware to validate timing/behavior,
and I can't justify that udelay(1) is equivalent to the existing loop.

Please ignore v2 (and v1). I won't resend a warning-only workaround.

If someone with the hardware can help validate a proper fix (e.g. a
well-justified time-based delay, or reworking this to use a proper I2C
bit-banging helper), I'm happy to revisit.

Thanks,
Sun

On Mon, Jan 5, 2026 at 4:05=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Mon, Jan 05, 2026 at 03:49:17PM +0800, Sun Jian wrote:
> > clang W=3D1 warns that 'tmp' is set but not used in sw_i2c_wait().
> >
> > sw_i2c_wait() provides the delay between bit-banged I2C GPIO transition=
s.
> > Replace the loop-count delay with a time-based udelay(1) to avoid CPU-
> > dependent timing and fix the warning.
>
> Why is udelay(1) the same here?
>
> > Compile-tested with clang W=3D1; no hardware available to validate timi=
ng.
>
> That's going to prevent us from being able to take this, sorry :(
>
>
> >
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> > v2:
> > - Replace cpu_relax() delay loop with time-based udelay(1) to avoid
> >   CPU-dependent timing (per Greg's feedback).
> >
> > v1:
> > - Used cpu_relax() in the loop to silence -Wunused-but-set-variable.
> > ---
> >  drivers/staging/sm750fb/ddk750_swi2c.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/s=
m750fb/ddk750_swi2c.c
> > index 0ef8d4ff2ef9..d5843fa69bfa 100644
> > --- a/drivers/staging/sm750fb/ddk750_swi2c.c
> > +++ b/drivers/staging/sm750fb/ddk750_swi2c.c
> > @@ -11,6 +11,7 @@
> >  #include "ddk750_reg.h"
> >  #include "ddk750_swi2c.h"
> >  #include "ddk750_power.h"
> > +#include <linux/delay.h>
>
> Shouldn't this be at the top of the include lines?
>
> >
> >  /*
> >   * I2C Software Master Driver:
> > @@ -92,12 +93,7 @@ static void sw_i2c_wait(void)
> >       * it's more reliable than counter loop ..
> >       * write 0x61 to 0x3ce and read from 0x3cf
> >       */
> > -     int i, tmp;
> > -
> > -     for (i =3D 0; i < 600; i++) {
> > -             tmp =3D i;
> > -             tmp +=3D i;
> > -     }
> > +     udelay(1);
>
> You are ignoring the comments in this function.
>
> Also, if you reduce this to a single call, shouldn't this whole function
> be removed?
>
> thanks,
>
> greg k-h

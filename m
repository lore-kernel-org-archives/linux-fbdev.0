Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724EF20299B
	for <linux-fbdev@vger.kernel.org>; Mon,  5 Jan 2026 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632449; cv=none; b=Si9Jx+3+fFKlxfkGSAj3Qfs5xnOKmnfMN2bYx0NczuPn7hcsWQUSEqdcp+6uRqEDFaHau4TNu+gQwl29rBwaxAZWD3xcB+SesQet0kIWU3CY4PyI6KgXyE+rifh06PdJbfnwLMotmiLT7vzB2N/VAjMCA9xWlwjmkhfxdXW/7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632449; c=relaxed/simple;
	bh=aS6SnpOQY5vgvKBJl/D9xJKFVUhYpIpD33q2Gjj5JbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ge4HkxoJwGwdjI5c8rWYqZ+kPASaej15joBdwsnJZnUL1PueoOOYsck3Rvrtg3IgU3Pjna4FM7GkXsy13rBf7Kr1axg6iD75aXxsOt6yVSo5AoVWa4m34s5pL8ZbQgOCQtHad5OxNI/Z3Zj/6KzOObjUGF7IN02Z3JHperZsgsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpfAUsvt; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpfAUsvt"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6467c5acb7dso121094d50.1
        for <linux-fbdev@vger.kernel.org>; Mon, 05 Jan 2026 09:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767632445; x=1768237245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8NZXgPadPZEkwzWUBQYb5my2Ym2kpL3eDcs25dhOFE=;
        b=jpfAUsvtBkiJ9U+BoQvGMG5LIW3QWrq95MYxgpTqB5+we5jVXeKs1yTVDKPdcU79GF
         CPTzrhcNsrO6rX6E3hsMHvvUBbJO9ADfnc5PtH9/yxDs4XLvFPpOsJBk6AqYbhoIX/N2
         TxUzLtl7j52wvHEgKVPnld2Q3x9bX4sMR7LhFH+zYuGYt7qCQLx8X3bmPNLG3oezyyWn
         jD4klnQQ68jWvGVI5sMl8mHmcoonwBwRLPrzCVeC9nevNJyU8KHWRtGCpkg/5Tf+aqqT
         xo837QoUYnC0OYu1XOdTU6MtWc3F65VKrbnk5cxoYHfkW/Xw1tS/yQCwepZ99krvBCaY
         qfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767632445; x=1768237245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G8NZXgPadPZEkwzWUBQYb5my2Ym2kpL3eDcs25dhOFE=;
        b=C62z5cUUDXhmqrdpUwvF8iEScMelfhzwaFwFW6kGhl6UTBcVs6zoYfOtU3ZQiIGJCu
         yZ4pBmSYsMm6q+VBEu1YV0X2IGrEl1vL7bvnMJz7/F5biAIyDKN/H/CrV3ddSnnW46lE
         ErIH4UwcaYbRRni4CpkXIQkPuqYJEScgMQg1id91reaUm3sB+LR8zvllLyvO6GvGVTtG
         JJlaoqMJWjxywgofXfbWOuj+fzhbgNEaFa7ASgic37TifpxqZacEBkS/gvm3kqc22BBy
         VM/ESt7EASo8uqSX3pPSmN7RDW+iTHDtXv9JblgY0iqr0D77G2Uhcf8dBIkk0v0W+kYW
         MU0g==
X-Forwarded-Encrypted: i=1; AJvYcCVGwhrzv3NJm82yyp1BTRlHhJy4fN7+wiFQ8ulUu+8WdLE6G5j3XjXDwYK++SXo6RRtagN4Bojr393bBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwc+K8V4KX1MOEtOQqMJqLDDuF2UUgRTqgMIW92N4krhscbaQ0
	J4rGUvqFJVg7I2IbYJiSmfOHMa2X/+MxDh3eTjIVuIXCA2aHJswB8Afbkf5LkWz5yNdckJcPyOs
	/pLbF3VF7pKhiRgC0cqv5oG2B+Af62Ng=
X-Gm-Gg: AY/fxX4WfcyHNunPa8i+j3cULyVbsd5uXQuSgvs5m4kbUvyZsfEx+q0lph2UCjZ9dVM
	pDWx+TihfhqyFLFb2NhuatZLYZo8uhewTlJHPEtj1AGyvclemtAwkH6b9WPj1MQQG9DGkVTn6BW
	QA6wMpXD1YsLAu9d/Hl0TzQ7CCbg7A8WvZvmaOM3dQfRuDn9Uz49GNRJt2SmIam4uoG4sfbhPYa
	NktAz/TQiCuvTb3r/U3yamHylrd6GklsR7Treip0blTWVZrpHyn93MXhlN6eUEQ11O921C/Ob+O
X-Google-Smtp-Source: AGHT+IHIximRz2m2jGs8u0bx0xjsp8Um2C8mOpJTpVvJQsdOx3gGxbnLnp3w4IfsQ+GKL6y/oDU2erq+6ANxO3S6ECE=
X-Received: by 2002:a05:690e:23c6:b0:644:2e1b:c8bb with SMTP id
 956f58d0204a3-6470c8e2d3amr131608d50.59.1767632445026; Mon, 05 Jan 2026
 09:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104110638.532615-1-sun.jian.kdev@gmail.com>
 <20260104110638.532615-2-sun.jian.kdev@gmail.com> <aVvmr2qOrFvoEKGV@smile.fi.intel.com>
In-Reply-To: <aVvmr2qOrFvoEKGV@smile.fi.intel.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 6 Jan 2026 01:00:33 +0800
X-Gm-Features: AQt7F2ph6P0Bf8OBdam7XZpIqbRkmM7c3K-cx7qIKWaHmSFeDtSuMjBbQmYOqkw
Message-ID: <CABFUUZFeO51MW5n1uDp0tcwJeJvgxDRxY3rDqkj2Z-6cO23TwA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] staging: fbtft: core: avoid large stack usage in
 DT init parsing
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thanks for the feedback.

You are right: changing the DT init path from write_register() to
fbtft_write_buf_dc() implicitly assumes "cmd byte + payload bytes" and
does not preserve the generic write_register() semantics (e.g. regwidth /
bus-specific handling).I only have clang/arm64 build coverage (no
access to the actual panels),
so I can=E2=80=99t provide runtime validation yet. For the remaining 3 driv=
er-local
patches, all affected drivers have .regwidth =3D 8 and the sequences are
=E2=80=9C1-byte command + N bytes data=E2=80=9D (gamma/LUT). The intent was=
 to avoid the
huge write_reg() varargs call that triggers -Wframe-larger-than=3D1024.

Given the lack of hardware, would you prefer one of the following?

1. Drop the driver changes and instead bump -Wframe-larger-than for these
   specific objects in the Makefile as an exception; or

2. Keep the driver changes but I should provide a detailed test pattern /
   list of tested devices =E2=80=94 if so, what level of detail would be ac=
ceptable
   (exact panel model + wiring/bus type + expected output), and is =E2=80=
=9Cbuild-only=E2=80=9D
   ever sufficient for warning-only changes in fbtft?

Happy to follow the approach you think is appropriate for this staging driv=
er.

Best regards,
Sun Jian

On Tue, Jan 6, 2026 at 12:28=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sun, Jan 04, 2026 at 07:06:35PM +0800, Sun Jian wrote:
> > Clang reports a large stack frame for fbtft_init_display_from_property(=
)
> > (-Wframe-larger-than=3D1024) when the init sequence is emitted through =
a
> > fixed 64-argument write_register() call.
> >
> > write_reg()/write_register() relies on NUMARGS((int[]){...}) and large
> > varargs which inflates stack usage. Switch the DT "init" path to send t=
he
> > command byte and the payload via fbtft_write_buf_dc() instead.
> >
> > No functional change intended: the same register values are sent in the
> > same order, only the transport is changed.
>
> How did you test this?
>
> ...
>
> >       struct device *dev =3D par->info->device;
> > -     int buf[64], count, index, i, j, ret;
> > +     u8 buf[64];
> > +     int count, index, i, j, ret;
>
> Please, try to preserve reversed xmas tree order.
>
> >       u32 *values;
> >       u32 val;
> >
>
> ...
>
> > -                             buf[i++] =3D val;
> > +                             buf[i++] =3D val & 0xFF;
>
> Unneeded change, I suppose.
>
> ...
>
> > -                     par->fbtftops.write_register(par, i,
> > -                             buf[0], buf[1], buf[2], buf[3],
> > -                             buf[4], buf[5], buf[6], buf[7],
> > -                             buf[8], buf[9], buf[10], buf[11],
> > -                             buf[12], buf[13], buf[14], buf[15],
> > -                             buf[16], buf[17], buf[18], buf[19],
> > -                             buf[20], buf[21], buf[22], buf[23],
> > -                             buf[24], buf[25], buf[26], buf[27],
> > -                             buf[28], buf[29], buf[30], buf[31],
> > -                             buf[32], buf[33], buf[34], buf[35],
> > -                             buf[36], buf[37], buf[38], buf[39],
> > -                             buf[40], buf[41], buf[42], buf[43],
> > -                             buf[44], buf[45], buf[46], buf[47],
> > -                             buf[48], buf[49], buf[50], buf[51],
> > -                             buf[52], buf[53], buf[54], buf[55],
> > -                             buf[56], buf[57], buf[58], buf[59],
> > -                             buf[60], buf[61], buf[62], buf[63]);
> > +                     /* buf[0] is command, buf[1..i-1] is data */
> > +                     ret =3D fbtft_write_buf_dc(par, &buf[0], 1, 0);
> > +                     if (ret < 0)
> > +                             goto out_free;
> > +
> > +                     if (i > 1) {
> > +                             ret =3D fbtft_write_buf_dc(par, &buf[1], =
i - 1, 1);
> > +                             if (ret < 0)
> > +                                     goto out_free;
> > +                     }
>
> I believe this is incorrect change and has not to be applied. write !=3D
> write_register. Without any evidence of testing, definite NAK to it.
> Otherwise, please provide detailed testing pattern and which devices were
> tested.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

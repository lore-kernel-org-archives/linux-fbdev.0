Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81133E7155
	for <linux-fbdev@vger.kernel.org>; Fri, 26 Jun 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464285; cv=pass; b=SIdoYR1jp7ubEU4VOSslfP75C6bfG9jmYcSObj7lTGZyBomCpLbTHofKmCeuwi4pWGQEdJWybP9y/FY52AMN6GC8pBIogZmSZeQszHH1XT1SrTXs3ISzLah4IZ9rzKZg60RCev9bcYuoFTqOGzp/saphmSOXyIJdBf0Q/jwcIsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464285; c=relaxed/simple;
	bh=eXPcTw6phZ3ErZ9f/k0W/VATMdFxJLWfecMrfpJUEZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lT0UtXeOyHbozQK3Jg+Nj3iQtgfVJcwsvXru7qclQ6+Wnv3BPWfPiFW9I14VbYxguf6IY1RHggl4Xtyh7imgGXw+zSTBy57EKlMzzAIRVX/eNOyuqXJuZOOexKX06H1l8X1nXQgrQ35X6xUyVOVTtxLir5K4djzoi1J5dUbR6+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVY0u72w; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVY0u72w"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4924e6fda5dso3440685e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 26 Jun 2026 01:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782464282; cv=none;
        d=google.com; s=arc-20260327;
        b=ZM2Gx3fyKbz5Z2I3HyyOnhkKKpb9sFmqV7x/ODFUXTBdjmUQNV2i5+clpIR8KJKdOq
         MP3oWPUzg9KkdaTpI/BhNwnNVTO2PO3nicT86SpiNYjIY5ZdgzeazzICuC4ZERfItcRT
         MlBPVo1fRtBaNnTCxeHnHg8xtGNfTCK7tvIh9dQQ5iVL2EoTWbLMuQdhiLH4/0tYAaVx
         n2W1TY0SahCYobDm7R6vD4P3m5Bvxe6zLIUbj15fKMS68cb8WMwiYiq6uPjb1+univpB
         OHJ8Kp6R2swGvSZcFilrzc8tDTayppAJMiTBbMX8RrCforK58cXW9BW2j1K1+qVCDoMO
         Bl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8mr5BrX28M83c3h69JR5BGflOmg3dbIBV6JMrnAWs44=;
        fh=eGhStJ6aq+NNy6ppAeZbMkY1OcrGytnpUTxI70uJtag=;
        b=MlVAd1ox7G3KFu8F24bmmTf+r8CtQeB5Gc0+JCmgelkW5u7bfI+I8RkbV/u+erMf2x
         hRB624IdJQCSVFP/ZCG9+M/I5lZaxP48ji7KAOPJ2RZsJX3ZNloeRoeOO9jra/+GGa1V
         pvjj27lqdLIUvTRCisjTBtBB+rObIi1XYouGqYBvtyR3vtkWvO7mnRENvL4vXs1jQZML
         evscF51CW/5aik6I/CZfk3l0JfSyeJHbsU9tyYzOXn8ellf+MaUVSxYI0MOCMp+6O7Ub
         138UyCRL2OiraCnYi/tSn1KPk29Y0KQmKYkoGAL4nyuJWYCZVjl8J8nLiOUthV1DBopv
         MVdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782464282; x=1783069082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mr5BrX28M83c3h69JR5BGflOmg3dbIBV6JMrnAWs44=;
        b=IVY0u72wQS9cP8HrH3idaOm4pqfGn9cQQNsPKTLcJ0UBebRb7c44eO8h0Qw4PqGdqC
         0eNsOq6UbzzOMPM+k2kY0MAZpWwfOTplFD80Hpzy3NTXP4tXIm3E19FbdM/4cByCSZ7N
         WB3ZcJnJ3fUg1BHltbVfqidl4FLZsIhgdpuzvX6kC0z1w0Aw4yuD/UjUJFCMHI55Ldg+
         IUIb9ZYyoULNqOXMCnv9hhot7Dg3dEUns1EYsd3Yz5fKyLT2Bv50igUWy6FK+pN+dCSP
         O+SiXwhdFQywRQhoMoxxsm1Rq6rQ/jwKB0sPgZxAg5qvcurIUtm73+pAoAJ/u7ZF0BjC
         DFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782464282; x=1783069082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8mr5BrX28M83c3h69JR5BGflOmg3dbIBV6JMrnAWs44=;
        b=s6H2vfF7GHrv8oYeb5DElvz4AoNIGqshqk0/Suk74/WDyoc7N2A2NAmhOKpHVuIh81
         3T2p4YYVYLg2GnxD/ilVrILbz5HBNPmFAtpNMSaVDK/PUbcckytJzHBOrqFlkELk4CCl
         rZNyd5bdHnl3Gig1jJ3OpI/9lqevdUNxja+40Kz+gFK4kmg3SDnV5Csxe5rDrxXc4R0a
         mUOS5Vzg6yZKscJdSk25hQp8YS7xqX/NzQhPvCI75xx0PuDf3dFOkOEKttyjFoxS+oDL
         AIvId1aIN/2chx6mA/d4kWGApPUcgo/b8yE7oyilcLIckwGe+2oMAqaTqzqaHzbs+O6U
         IZ7w==
X-Forwarded-Encrypted: i=1; AFNElJ+ETRDFIcscqxhNjotPgOKlOZFl1WVlu91d92t54oIg4jlsF/LWfm2pFj9PuVOaWBWMFkpIFl+zo5Lkgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+gEtTdVKOX1exT7z/5FVxMK8KAVYfqUc0JomHDKLcriXXz2UB
	k+Lo3GSDaUymLngdU8x79HqOhGkhb5UScpdOl8bDnbEGewm6zNEoPXYD0KdkRS9Z6x+SQqKyJOL
	yGzYcD6y+bvipDnPrpVTKCHaTefX4b7w=
X-Gm-Gg: AfdE7clT0a99P6z7SqVdKCwB05TPjSmQ0P3E81BwM9Sjjh7RJaFGmPgPKWffj7TuQyk
	yAJNYT3j/4VkA9rfYHX5+p94SDzeq0NltntXGy2tRPYDr+3DTiiS1JyI4tE6kv01hSdJ/NNj0rB
	go3afBZOZ65LGEQlpIuyD32RAPTFO0U6S1DtXeMH+C3SpysZizoka57tJDaOs0gGXqND53Hj09Y
	rlVdR94NV4QBfTf/z3SYgNZSwLfx9BL5cfKsCKdDzxTCodT8DXFslEIlblo/gZVIZ6hPJTvrA==
X-Received: by 2002:a05:600c:8115:b0:492:6df7:942a with SMTP id
 5b1f17b1804b1-4926df7967dmr10375035e9.11.1782464282163; Fri, 26 Jun 2026
 01:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624073804.4391-1-joyetamdk@gmail.com> <ajvAGK-0kCfkThcs@ashevche-desk.local>
In-Reply-To: <ajvAGK-0kCfkThcs@ashevche-desk.local>
From: Joyeta Modak <joyetamdk@gmail.com>
Date: Fri, 26 Jun 2026 14:27:25 +0530
X-Gm-Features: AVVi8CewQ_sfNVDDCLAMxVIytH13-ftRD2ntaqkp8BztMQTvv7FNCKdpjmypRE4
Message-ID: <CAN3JnUCem3Mw17e5D9b-aX58_ZaAvC6GZ-sBPEQfTTTP=o-WHA@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: use ARRAY_SIZE() in NUMARGS macro
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the feedback and the question.

I checked every write_reg() across all fbtft drivers and found that
the largest number of arguments is 129 in write_reg(par,
MIPI_DCS_WRITE_LUT,...)
As COUNT_ARGS() in args.h only supports up to 15, it is not a safe fit here=
.

However, the kernel test robot reported a problem with my
implementation as the __must_be_array() check in ARRAY_SIZE() requires
the array to be a compile time constant expression and thus breaks the
call at several places.(example par->bgr)

I tried to reproduce this locally on my system using both GCC and
Clang with ARCH=3Dum on x86_64 but could not reproduce the build
failure.

Since the original sizeof() based approach had no such errors flagged,
I am thinking of dropping the ARRAY_SIZE() approach.

Any other feedback is appreciated. Thanks again.

On Wed, Jun 24, 2026 at 5:01=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Jun 24, 2026 at 01:08:04PM +0530, Joyeta Modak wrote:
> > NUMARGS() computes the number of arguments by dividing the size of a
> > temporary int array by sizeof(int). Using the standard ARRAY_SIZE()
> > macro is the correct way to count array elements in the kernel, and
> > ARRAY_SIZE() also provides a __must_be_array() compile time check. Ther=
e
> > are no functional changes.
>
> ...
>
> > -#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
> > +#define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
> >
> >  #define write_reg(par, ...)                                           =
 \
> >       ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_A=
RGS__))
>
> What is the maximum parameters .write_register() takes in practice in the
> fbtft drivers? If it's less than or equal to 15, we may use args.h instea=
d.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Regards,
Joyeta Modak

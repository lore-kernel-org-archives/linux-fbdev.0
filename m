Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCDE3F789C
	for <linux-fbdev@vger.kernel.org>; Fri, 26 Jun 2026 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481295; cv=none; b=YVFPOAw3O/DL4IRzLpzHW4yl4HsMpeU6m6wb5FHe4GSmrp09nfjPxGIfney6r8gySmeKO2d+71su2RucKJ+VbL/yaCbIswFZPHfXxFKyqYF45rENnFx0sNU175Vi9r80Lsi08L3RuvpmDoMX+ed3wb+mkA5O177CxaX/OHgLImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481295; c=relaxed/simple;
	bh=YXrVrVYcp68EEcS0zryKhbW8e+jMsX4pF+5qgEERs3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k3Kp+NvWo+TlslXP6qlhVIzBmfMlpkPI3KMoV+VtXUdq6yUSz94penqrR8g/zQjIcyXkdSEC7Y9dzsu/0Wmg4Wk69Ai4IaKrAj+wiC4ORwbZDjMAPvew3ViTTdoFtqJBYpU0M4eI3vAgA+JO1TX58bcqHJiEjIx75BzKjc/sRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnkkXCx5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnkkXCx5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4926046fbc5so10930875e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 26 Jun 2026 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481292; x=1783086092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inH5gHgw2GQJ8Jf/udrV2wKYoIHtRnRBi3E4+pGgxJ8=;
        b=UnkkXCx5XmaebaTPGuT+gHbXMrMwSqkNmx4hRRO3QievQLgcDbeAatYoWd50gzJPNA
         jxUqVJgqZCH1xZ/LORYhbuW1s644urhnbIMy69PeWXpXeViKLcj+fQxqA9M+a3ixpVsr
         WRs3GGPKQ2CCUogfWu2xzeheKprWJVmW/z2w1+9eLuarFP0O1SVF9ezhg5VXUwMrqJ6h
         oumQPdTMNsKRUKUWihNMOndUJs/cSyuWdkYcpusbpr0sWlTO4a/h0tsmrItNddLNRWnE
         QHkfx4el30AUFWJcr3Ply+H8y096T11M1yLZz70rrrUwMRC+DF3j56vQIJ7bHg9RnKz6
         ulgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481292; x=1783086092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=inH5gHgw2GQJ8Jf/udrV2wKYoIHtRnRBi3E4+pGgxJ8=;
        b=NVBN3ImLctNqx6Bt2bzn/6b3injVLC8Yp62axtP06lR8/4Z2P2rvoeFFwcBBlmPV8S
         L8gahx/9rQl1AdhNKwagfVIdOPGp+s4acCxrP8yrQ+EOJnEBuhHSO+x7DZcYWZEjqla4
         D80HevbyeQC3jRi7UEBAmlWcnzSRYKC0bvmN1CBqfKnGL8+8priT/VOfSwxemSNOdP2H
         4olBkGHG0cGzpN+U9i7eAEqBOIgLvjBU7yciEdBDlNAhgOvhrx0DEPE1J3+oB3fHiHA2
         pchyhT6y2nh5Ns8iycU6xkD0Ku9hMVfS7X2n3sq5uWeZv7zN69Z9T4N4AgI7VScap5gp
         XXVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tv5cigB63k15Uvz1CaW0WIGGcly5VsRgkvM+aY/RC1f2A/gYsTK6yALMpNrhjI9KKrYPusoiKuGGsPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbRUKKsmr57L+NDDrfrS3+t2o9U4vl4l8l8EngI7hAtUjq+zre
	LK9F01ZDhe2fyk9Ae6AO0XdN6GseiVLAkbX6SYyFe4yGcQ0QhZFYYGJH
X-Gm-Gg: AfdE7cm+FaDKVlAAqqau/t9SW9nIecthoghbI7eR4Yhb6JnMvaJhLWINnM9h0DugqVf
	jJjwVZEqET8cJtjzfQUTnlT04yx8Kv6GRITgK9T00mrgPwCKKtIXXtMaFoAzlICpaDXZhMG8iZg
	DhZ2YZAIwZe08TpxdeEIGYiKg42y4JgTxyr+Gsl38zHlVapwY4t+Cve/osdbdgTgwHBr8JNUG11
	2pO1EsxJlW9w2jlXSqNKkZXfxRsVp6efEsGKdjYXIfAjW/nhqySAvkq9TdDoYp+f9BSNCTDHrl2
	ZTmL3tVAacAz/atjfRaMtU4k81XNOjzyYv58VbzLckUHM//QzwbR7VvWargqd8pwwHGs5GVOlkX
	9fq9tzWPpggeeTqJlDVCUfwsb9VfkI2MspSL1WPuLKArZiP1L5hqf52EuuyPvneDbJ6vMMV2jJM
	Rfa8Le8ziKFaTfnz9lw/Guju/rxQhalEcb9zlgBCKmz9RhNAdMqg==
X-Received: by 2002:a05:600c:8519:b0:492:4889:3d18 with SMTP id 5b1f17b1804b1-4926641a911mr83146765e9.9.1782481291771;
        Fri, 26 Jun 2026 06:41:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268f7670bsm79114415e9.0.2026.06.26.06.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:41:31 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:41:30 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Joyeta Modak <joyetamdk@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, andy@kernel.org,
 gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: use ARRAY_SIZE() in NUMARGS macro
Message-ID: <20260626144130.6e3c924e@pumpkin>
In-Reply-To: <CAN3JnUCem3Mw17e5D9b-aX58_ZaAvC6GZ-sBPEQfTTTP=o-WHA@mail.gmail.com>
References: <20260624073804.4391-1-joyetamdk@gmail.com>
	<ajvAGK-0kCfkThcs@ashevche-desk.local>
	<CAN3JnUCem3Mw17e5D9b-aX58_ZaAvC6GZ-sBPEQfTTTP=o-WHA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jun 2026 14:27:25 +0530
Joyeta Modak <joyetamdk@gmail.com> wrote:

> Thank you for the feedback and the question.
>=20
> I checked every write_reg() across all fbtft drivers and found that
> the largest number of arguments is 129 in write_reg(par,
> MIPI_DCS_WRITE_LUT,...)
> As COUNT_ARGS() in args.h only supports up to 15, it is not a safe fit he=
re.

That is also a pretty horrid way to write that message out.
The function call itself uses well over 512 bytes of stack.
Then there is all the code to push the arguments.

It really shouldn't be too hard to pass the address of a const u8[]
all the way through to the code that copies the data to the hardware.

I tried to follow the code earlier. The 'common functions' that pretty
much just call back through per-driver functions with names the 'write'
really don't make it easy.

	David

>=20
> However, the kernel test robot reported a problem with my
> implementation as the __must_be_array() check in ARRAY_SIZE() requires
> the array to be a compile time constant expression and thus breaks the
> call at several places.(example par->bgr)
>=20
> I tried to reproduce this locally on my system using both GCC and
> Clang with ARCH=3Dum on x86_64 but could not reproduce the build
> failure.
>=20
> Since the original sizeof() based approach had no such errors flagged,
> I am thinking of dropping the ARRAY_SIZE() approach.
>=20
> Any other feedback is appreciated. Thanks again.
>=20
> On Wed, Jun 24, 2026 at 5:01=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Wed, Jun 24, 2026 at 01:08:04PM +0530, Joyeta Modak wrote: =20
> > > NUMARGS() computes the number of arguments by dividing the size of a
> > > temporary int array by sizeof(int). Using the standard ARRAY_SIZE()
> > > macro is the correct way to count array elements in the kernel, and
> > > ARRAY_SIZE() also provides a __must_be_array() compile time check. Th=
ere
> > > are no functional changes. =20
> >
> > ...
> > =20
> > > -#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
> > > +#define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
> > >
> > >  #define write_reg(par, ...)                                         =
   \
> > >       ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA=
_ARGS__)) =20
> >
> > What is the maximum parameters .write_register() takes in practice in t=
he
> > fbtft drivers? If it's less than or equal to 15, we may use args.h inst=
ead.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> > =20
>=20
>=20


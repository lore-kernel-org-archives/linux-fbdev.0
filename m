Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB99330D23
	for <linux-fbdev@vger.kernel.org>; Tue, 31 Mar 2026 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963824; cv=pass; b=K+oAoSrdSLRNUMTBWWJnswaF6gaGWbJnGxmTk2tg8zGqwYedZ7C+7R4CKmVLWuO6A5B2IvOYKOspw5Z6YFpnW+85E2KbpfbsWscaLoeExWDh80Rs9oOkqWcwkuR1bZimNBePoIOHkYkxxfCIHkS3bcWDqzB89v5/t79Nt3hwGaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963824; c=relaxed/simple;
	bh=jSfyyttUBcvgqpjRwBnLDE+FGujdOLlOGP5MX23vPkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4IFr5nHY8Sm3m5A75XMCCdX1QfS+mGof9bH6Gd1p+vTfaCjUsg8EAxrc4UuCfOKC20KCJS8LXC9MFvHIRSlVIZVygU8eIilbfSjVf51NGhY6ROa+gmi2KxbLVw6exKJObLJdLN3z4iL9dQoL8/mPYqiqmpRxX5+PVsRvv8xGyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcqzXxTz; arc=pass smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcqzXxTz"
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-5a2b636b944so1881428e87.1
        for <linux-fbdev@vger.kernel.org>; Tue, 31 Mar 2026 06:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774963821; cv=none;
        d=google.com; s=arc-20240605;
        b=X/8NI3yuaviNLVQZgAJR3C8Q6H+H42hvvk0jSFsGFM4XUUxsqSLam237az4aRs/h9E
         Z/le8BO3bMtVK+O7bYWRAsbR3Fu53tIhsVmLgXJUYizggCPCvlZRUfy8m2NrHT3EB/QY
         tYmfZlEKsW5JY1O8UA1As5BIts8LppxJFOk0N4T05OdomPkCCSzvT4FOA4s4GstFp2XI
         5OlG44/1iHpVD1qZzweXXBMCe8Ratgw7Hexxgb6Y28CPqm55R15c2BMxmsZd+KsIFNyz
         QmMXzgxKa0ibmk4XYGOnX3/p4TCle4TlhGV0ZQUBS+N33gh/naRqQiXREXk0lOo+TYXi
         J3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ETe0QSxwh76AiCkEnZcqenbJmuicOnxgpdv7wSckbN0=;
        fh=SdgQPksAvsZSJ9mlhyu0fTRMtMXjEn9Ug23uy+oJK/U=;
        b=NdnT4UvlIOnAI6t9hecBgPZVe8/IxKsK+FVI/QtYi1/HNIqBlj6SdpNMHAM36G2Htb
         Ygt0Pd258KEJJnAYevT4mMUSq5oZxGVNDImq2dTyYXJJXsSz+jXsWZTvfaP/GN5rJSUF
         T236HENDLpfCKSJs2LcKaFPdtbz7KK2Xp2SH4dvqngD7mnk49kOT6dA33BbQ2rY7K0v3
         lCf7BHcLeoWN5cAOdd97MRRVIDe7yLCEFr+tMXNG+Ls41Qop+AZvNgfzLunfy3CbSXd+
         rUK1kUcR8ey6z1W3o6hXQd5v9rmSdgsE5cd2NFi1Con+zbyBGxWuAa5phgTtH7P+XSrv
         ARyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774963821; x=1775568621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETe0QSxwh76AiCkEnZcqenbJmuicOnxgpdv7wSckbN0=;
        b=IcqzXxTzxPE5r96p0i0dud6lbIaLcnVgZujw0hWJooR9IzL2pg5v4xgqRUEiapYEFM
         Ch4WiOAih5/trbTSzz+iZQuuOjyvA0BSvt/dBgjmUQ5aHd76YwNH8CjSiyfmst4KNpey
         bzQLXnOKZNmkxER34HF0dVN51t9KB00uPzu/TKRB8B14/TNFoMc0WxgUzKPRrkBcZkSA
         XKwEZkPvkrxxPr1zDbhnxUaMuIAxlRRC2Mn+QiwlGfQnVUKFh3IiiMYj0PEfMRh0waFn
         nD+W8dYXPCvEikscOVvYxX6xGwsduNmqHK2uJx0fdl7OpC+TbNzbWLsTrYrKiDtUqHJ7
         Gslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774963821; x=1775568621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ETe0QSxwh76AiCkEnZcqenbJmuicOnxgpdv7wSckbN0=;
        b=cj4jDfx8iLJuRVfnrO24/BrN3Jpja4baNXeXFTWypRR2BocqwNFaTVyD+mPgFbrGvx
         u2sWQkxwvHe5qOSyjy6dKSW1QuIlruO3QhQJMdyrwBeilgCiYeB3KTLJ51/IC8UMs3jf
         RoYIL6wiL3Y+va3yPU/SfLYN24lyZNOQoKH6oW09GidCiEuI9JyFwnuh2Ixgax/odul1
         o4xrVxHM6yQjNUxeJDKZlJTPJKYeU44WiEXvioYo/P5kq/QB3FG+6xn/Jwm8HpV54/ks
         XIoZ43A45KfEzuuQ99XNJoXPtPIBcUzktj/6VEmQ1CbyJRqdrKrLJcAsITLziRrma2Py
         Jjnw==
X-Forwarded-Encrypted: i=1; AJvYcCXsiGaD52s1V41ek3kjRVaWQu1duKoCzDnmA2OOf1pDJq1XfQwq1w7559c/Aeqnt//eDUK5CiVKQjzSww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK4TJeH+sz0VQnOVH00fsubz7794Maun7Rjn1lkbxlT8sr87j0
	6zxb1uKN/vYSC+ga/TSxvHTx+tVrnVSeq4nN5jRWQP3oG45NExAuoxREwD0XC4On6UaeKc0QG0g
	UtLs9AbGTWPNXbqxl2pIlahLvPKpKvlM=
X-Gm-Gg: ATEYQzxrQx1RKbRWMh5YMGQjpTNqSc6G0xtvqhmwrCywXwbTylzUNT6XnLlmhddndKV
	ZHChnuY3nn49wDzsRSRFcb9cmY5aeEQLQ0I0PPv+IiUyEWWtmZPW7Iz+uosLpBtRsoqeyyJ+rM6
	CEunzzPzpA6NI4R5fgieW0FpwQHmzHz6mAExvrvaLOsesWO6VTeN7weh5ubuogaM4lIeiQ1WC10
	3orM9yu3QLYucHQ4c5CJfzaDHS7OdGYWSsxJjQxsuQoi/hF+JxSxqHVZFskmhuRv2tO8ElVKpcb
	zqmT92hJQ+yM0ZOHAGetF9aHHWEbohtZu0TJRfGl
X-Received: by 2002:a05:6512:1447:10b0:5a2:b0d1:d04e with SMTP id
 2adb3069b0e04-5a2b0d1d1b9mr3160561e87.36.1774963820581; Tue, 31 Mar 2026
 06:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331050738.1547-1-dennylin0707@gmail.com> <2026033116-possibly-reference-7ee1@gregkh>
In-Reply-To: <2026033116-possibly-reference-7ee1@gregkh>
From: Denny Lin <dennylin0707@gmail.com>
Date: Tue, 31 Mar 2026 06:30:08 -0700
X-Gm-Features: AQROBzBsjOcreeVlReST3iP7bntkqTFbh3Nlx0ULx6_8CQHN2eQCKNWEzc_adeA
Message-ID: <CAGEkeHci4UBTqGjE4A7zM2GERLSBFPv3RrQU-nf2ES2VO7jOQw@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: constify static char pointer arrays
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thanks for the reminder. I will make sure to test-build my changes
before submitting patches next time.

Best regards,
Hungyu Lin


On Tue, Mar 31, 2026 at 1:45=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 31, 2026 at 05:07:38AM +0000, Hungyu Lin wrote:
> > The static const char * arrays 'g_fbmode' and 'fix_id' should be
> > defined as 'static const char * const' to make the pointer arrays
> > themselves constant. This allows the compiler to place them in the
> > read-only data section.
> >
> > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> > ---
> >  drivers/staging/sm750fb/sm750.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/=
sm750.c
> > index 9a42a08c8..b0bdfaeca 100644
> > --- a/drivers/staging/sm750fb/sm750.c
> > +++ b/drivers/staging/sm750fb/sm750.c
> > @@ -33,7 +33,7 @@
> >  static int g_hwcursor =3D 1;
> >  static int g_noaccel;
> >  static int g_nomtrr;
> > -static const char *g_fbmode[] =3D {NULL, NULL};
> > +static const char * const g_fbmode[] =3D {NULL, NULL};
> >  static const char *g_def_fbmode =3D "1024x768-32@60";
> >  static char *g_settings;
> >  static int g_dualview;
> > @@ -728,7 +728,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, =
int index)
> >               lynx750_ext, NULL, vesa_modes,
> >       };
> >       int cdb[] =3D {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
> > -     static const char *fix_id[2] =3D {
> > +     static const char * const fix_id[2] =3D {
> >               "sm750_fb1", "sm750_fb2",
> >       };
> >
> > --
> > 2.34.1
> >
> >
>
> Please always test-build your changes so you do not get grumpy kernel
> maintainers asking you why you did not test-build your changes :(
>
> thanks,
>
> greg k-h

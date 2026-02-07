Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1047A13A
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Feb 2026 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770499932; cv=none; b=gL32DWOm9xX2dgjoH3boHb1HHE+VfHGjzAWrY6crszFtjyKXF99f+q7mVnQJBIOucqZkKbd0aGkroV8g3B+GLbSZeIwscEJx+dfsfui1ykKHu86HUDh3OFRKWk7MeR6QdJ4PI82cRKNPwD8Ng+IU9W1S+16h7C+yJLnzCvAnbdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770499932; c=relaxed/simple;
	bh=/Kx7c+smcPHw3s2wJ8ctgta/XhoEDnfBZoiAtm8POLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CA66MJyWmR1T+h9goeU8n8W+wmC4KVVF7/P5yWHIqutSYQCoSoxoNmsTfXUMiH8rylMli1sQ0LXDlStwpKfskK/aEySBKjPphSjMFVRT0IzVO/Tj1XCvDjEMhabTpI9ehwl5IktP/9z5TBM46Q+L8gWNMXh6RtA7i0WPLtgWFNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RC1l7+YE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RC1l7+YE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-482f454be5bso35184645e9.0
        for <linux-fbdev@vger.kernel.org>; Sat, 07 Feb 2026 13:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770499930; x=1771104730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BrPLLSWSjiawj1gbSbQ0ZlYLO5BlnXdXTmgTcb/Ius=;
        b=RC1l7+YEXyQovqw7YGdIz2GEnhXgwW6nUnkwUfVdNS7Ylr59OOH4tPtmirplaj9+Ty
         1OomLQLzYTY8c1nvdK9fQGSQnsrg0JS5m/DVOELX/DG5lgRHNvmK3tKaWyqFbrY9NFtv
         ZIsujCHWFz9eQFSQ7gr5cTj4dMCV9Dduq2pVdXiQf+1R9j5MVve0YHZ3COtHjWAiBbV1
         p/gpQNhAVXmdNIIQaGUd3P7QB6JqW7Q0vV62YKgQxoNK/iSRY+Uz7b/wKl53TnpgdQlP
         TMXiShXC7bpSOfV9SrIeL/FNLoDEU8NUl6UGHavLo2QMg3ZmtdfaA9qsAFv2QQe+QGLv
         XdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770499930; x=1771104730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BrPLLSWSjiawj1gbSbQ0ZlYLO5BlnXdXTmgTcb/Ius=;
        b=g1sZNZXoy/GrE5kBkKZ+Amzf3Znkt/mYKFX+u0ndlk759uXXslhyC13p3zzz/VbFx8
         6wle082EDDqYdW85+Zdavfca8P5GXiqCyBtka+UQyA8s6OQiBNV55VtE+DwLKromLSZL
         6E7EVJEVWeLId6YYznrsfcaQClsZSleCMUrxB/HfkwhlgG5/rCORD2fN7flMV0ABRklT
         jAw5+9mQYhxhDHSBZsQs2PySAuY+fDjBL+oPRKeQfD4E1roC6/kbxhlzY6ARDu0IAiHZ
         vEFg6KBZByPmhdOEqMjSbe1nScEgi+Kf8YYmj9KS8CMbZAcBV9340j1WYmbaecpKOA9Q
         BH6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4YvsND74tdn081cOHfolb/8iR4+FuE6MRiexTwptCCLAfCvPZoAFT0wjNiVAeoORhJxTviuOTBBko7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtbBvfULYph5nb7jS8hEcw8qs33/KDVYh52ZD4jO2bCGmqrrl7
	Ueav5oh0zAxT1f2+ZJTT51E1McvFdTyTSPDnLUDd/Y2H55hzQs0OdReM5ze/nWDH/WFJfY+P2mx
	x2pSb
X-Gm-Gg: AZuq6aJHWyrJxAd16z3hXwa4aDGG9N8ILC+HpmBaa2+PcP+8MMfLVkqsv/jEuozlggV
	5vnJHAtNUXhnOuIW5Q68pfIs+0Q9C0wvK7ljptgUaPv1544HuwS9vmWkleLvMOPNo4i/YWR8ajT
	KO4MHxq6H0J7FH5oT80l/+fZCRmj3l8Qme1hNPszyCePOx/mVBsIoeXsNWBVDdZSr7W6ZonywYN
	sYpfu1J47gx0PWszP2vYczVzQvYJ0rCVZo1fIynpTUua3kyNwaGoMeWMwTtZdARWTORrAi2veJT
	bzmkjK8hk5qE8K0S06O5hXIRaqwhOXz1xRLduuCVcFwbw87bpYpksLX2cNeoBWvuVhIN8Zl6I6X
	ziC0m8zW0jyMiPhgiisbnjqiysVxQwffJ8zOPe7VuyROZsOdlYFL+2v9AChFDxmcYvjFizajc8Y
	Pa+3pdMU/AJOnJq1s2
X-Received: by 2002:a05:600c:a00f:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-483203aaae7mr98657615e9.5.1770499929709;
        Sat, 07 Feb 2026 13:32:09 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-436296b20fasm16054853f8f.6.2026.02.07.13.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 13:32:09 -0800 (PST)
Date: Sat, 7 Feb 2026 22:32:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/4] fbdev: au1100fb: Use %zu to printk a value of
 type size_t
Message-ID: <aYeu_fgYxHSk9pjK@monoceros>
References: <cover.1770483674.git.u.kleine-koenig@baylibre.com>
 <444f0cd1a39cc665a9e2d76454138c3e71c7747f.1770483674.git.u.kleine-koenig@baylibre.com>
 <615c1263-fbdc-40bd-aff6-b1411af012fe@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ajzfog673aerj25p"
Content-Disposition: inline
In-Reply-To: <615c1263-fbdc-40bd-aff6-b1411af012fe@gmx.de>


--ajzfog673aerj25p
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/4] fbdev: au1100fb: Use %zu to printk a value of
 type size_t
MIME-Version: 1.0

On Sat, Feb 07, 2026 at 08:06:18PM +0100, Helge Deller wrote:
> On 2/7/26 18:12, Uwe Kleine-K=F6nig wrote:
> > %zu is the dedicated type for size_t. %d only works on 32bit
> > architectures where size_t is typedef'd to be unsigned int. (And then
> > the signedness doesn't fit, but `gcc -Wformat` doesn't stumble over thi=
s.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
> >   drivers/video/fbdev/au1100fb.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au110=
0fb.c
> > index beba8befaec9..a0e1aceaf9a6 100644
> > --- a/drivers/video/fbdev/au1100fb.c
> > +++ b/drivers/video/fbdev/au1100fb.c
> > @@ -456,7 +456,7 @@ static int au1100fb_drv_probe(struct platform_devic=
e *dev)
> >   					    PAGE_ALIGN(fbdev->fb_len),
> >   					    &fbdev->fb_phys, GFP_KERNEL);
> >   	if (!fbdev->fb_mem) {
> > -		print_err("fail to allocate framebuffer (size: %dK))",
> > +		print_err("fail to allocate framebuffer (size: %zuK))",
> >   			  fbdev->fb_len / 1024);
> >   		return -ENOMEM;
> >   	}
>=20
> I think there is a second hunk missing?
>=20
> @@ -470,7 +470,7 @@ static int au1100fb_drv_probe(struct platform_device =
*dev)
>         fbdev->info.fix.smem_len =3D fbdev->fb_len;
>=20
>         print_dbg("Framebuffer memory map at %p", fbdev->fb_mem);
> -       print_dbg("phys=3D0x%08x, size=3D%dK", fbdev->fb_phys, fbdev->fb_=
len / 1024);
> +       print_dbg("phys=3D0x%08x, size=3D%zuK", fbdev->fb_phys, fbdev->fb=
_len / 1024);

Ah, the compiler didn't stumble about this one because print_dbg is a
stub without DEBUG defined.

I will prepare a v3.

Best regards
Uwe


--ajzfog673aerj25p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmHr1QACgkQj4D7WH0S
/k4pBAf/SEz7V6p2eFrCGkaO4pc4w8gT474jPM3+vx9iVk0bZtVywgFXYkzkgezN
Ho315SJi/3R8JIi6FhTnvmbtfty8gNJE6GmWsoKxDcQcXUIzlo/KSgLLU2aeRO1D
t/ga8kM0ypOCispx8JSLE3qcFzdsAFZVDD8NPSo9/z3nAG6kHi541td5y9sFULQu
RYojnIyH4vAXwIh2btzh/1L4pyLt5/83+0s3Q0lG3Zpt+pZJzMx4Fuo2jKfnT0Mx
WnecP/3cEr54Eis5el84SqNfBzORQV5zebPCXrih9etY4779CtvvvCHm2TnfOFn+
S8RMidMXAG0S++Cq0PfBZ1UGNrmdbw==
=aNGH
-----END PGP SIGNATURE-----

--ajzfog673aerj25p--

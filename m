Received: from sonic310-21.consmr.mail.gq1.yahoo.com (sonic310-21.consmr.mail.gq1.yahoo.com [98.137.69.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA32550DC
	for <linux-fbdev@vger.kernel.org>; Thu, 17 Apr 2025 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744911555; cv=none; b=oJHsdZaUPj+73vDYDbtgeDFDKTfNALe4015bajlxcj2tJqFqMqiamXfgiHuA/nvqXbvKvTteA0xvxUd6nT4EtNn8+YRXr17OIYx6ziBNGAbLMvZhYJKFkMVeS9ykZrrOuIGLZ8xUpWk3M5mcGbrwmJ1nOghTH7U48GZ96K5KxL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744911555; c=relaxed/simple;
	bh=87u6W1TihUzP8Z4D1g73cGTWePCPzbowKmmvBeLq2Bg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EcT2xWyFBSsssVKVqnGPOqAheIChtoR9IDrkFrYl9V1LhgsyhJRN/WfsQ366dq0Okw19cL4DVxPyKGwIbMReiH1mGqA2PdtIVYMl9rGbPkFuI6acO2rch1HdT2TWtYBITSfmKg0nBiHNcfB3uIUNDRqVsJM0yk/KSDg5nwUs/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=Qjda+O8l; arc=none smtp.client-ip=98.137.69.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="Qjda+O8l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744911552; bh=B5EIQ+T8gzw3O3ySM34rCVBGg45rFyrTsDX/Alk2S/s=; h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To; b=Qjda+O8lrR8EX0/IVevUX/lXWrc0mmEaVV/VgW5wymZJykuhbcquwu7Lhs3G2DqjxnIEEAIOpKeEr4yHjR6A3JJnHklXB9fLRBdY4bC6m7ytc70NNdqKb9VGOL6BVNEyVnb1xhNK3ug+j9nu42ohiRHG+5uWTL3NAKs4MrWUO6oeXJKHU9mjNwDxfkD7pwU2gbxuh21TnoWBFM+u8ChTmEmURLkRXhGrx34GF8lFjSxmEgOVEAmVQ8rxZ90tnRlfVfgbij62H7dF0mmw5ycfe/doJaZ1Zql8HnZzBvDnOiAD337OUIcH4Z/rH/2Msvqu2hd9PrKEqRaTkZKmkgu+ow==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744911552; bh=8DE4Wd9JKl5Y/QSGeNaGvXdI7nBWYT2iG/jDtWA9Z2M=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=BSfuN+3rP2OYM37caBGU0yxhW1z91xnO/1ozJBLJSltXjGmkSHyjs4iBwuuJGJ5QL8oANppui1QuUQZ9kwsmxEdkGLwhUQux/gD5205LhS/KqwiAElL+plgsC+A6RqctSu7/3D0dgoWBWPUkpzzu3WfT8WsnX4nU5+dJK+UBdyUqHIPD7HVPBD/PlXAnDdFTNxQOOpoy+gtwv4wyW8onAjBuivNgzaic5LjAhyrRISnhyFagCe+n5rqAYxnr3gmrIiiorqN7zGtEibr1ZEpY+tthaEwqtzGhBnZmXBlyXefM2qB1iP1AEUFtwBK6ObZVeetZUUGzI6laMj+oRVpXug==
X-YMail-OSG: ZRGNm8wVM1nSCMBiOomP0Kf7VL1XYubqDjRsawjuIqNj_0vYGbqGIf247rDcTou
 y0IBQxgbjx_5WLjNVwP.hm33RsTgZSuPQWrzt7C.QS9PnlqvUNWAIo4g3wGP4hDWaDDcGrUyEo9j
 LbdSBxnZiS_vY7EQs0oL64VVWDi65djzPnUCiwrnIc0GBZR8VftG_lYjadUpvmSfnnokXU8x6.Wg
 sTvzHpPlBA57hUuE5AoDP.VkKvWW2rViKLxMiiUfed3q423lLJUGXT3_p.62x5qNxeRC9SmtKbU2
 evnGPOvORBqlNlsK6lCTaL2qU9TBtUbhAssLh_ieHaFuuqlNPrDopgqE6hZw6lLaq4WKQf_e32LU
 eLKnYfnkehhp3KmWLTIDZZtXbkgDcCgxZJRr_g_Cxrb3Q_2IN71XprlvtKYy2WdkeOzuu7a52d_m
 W.kvHDbIXDdBLCn6YniSHZIW7pIMhXjv1EH.XvvxOk5ZPIfFv9EpakDXZsLg7REtSfziLH3_DQ1W
 VxnIHqs2f5gy_mEkeZ3JxvnvIqNMgLexkvgq.Yb56WDVHjMNy0JLnRg0h79s_uhyfCC5oSfiJ6M2
 LAeAzoW_8uLCFJEf_lATEihIrunINqvWJr8GXvOeWCGo3JPRxx_DyU.nbRfb5SdQay0b30LwV4GZ
 3M26XvIIoyRC70zy0.sUhLMV8M6hMiFDuRc2KXwwqM4FUOP3RG04i8QKOq.eZugF14rWjBTpPY44
 ea7HppiSbp_hv6R9ozyFEqzV5hYc3n.CHxsX1JGPv6WP1qSMYpbgOVS3GJBd0K4FVCqMcGKbCb8O
 2qDFItxMhUhmxWJ2RdZL13cRCqqvVbfTT21joCsa9Mdl9x5AAQmAiyv8QIS_BTuVhMOa3oJwY7ql
 pRIdvyStF996t50JlcQrnj0CInYioWV8ce9lfO9x7cig0IcTqHedbtyqcPl3QrMP7u2CN7xa6Zki
 GU0OzViYqAhyl7_UyJv5fx.mIJBuhlyWjGXpuYEsbGIIQZRvDMaQWdNN97_A8D5sQGXUFqFA_t9N
 PahFpkPbL9nTwASnZCIg.PiKSEBXq1hSJjDhmwisLbwk6N5oyVIq5JfYa_nEDCUGC4kqcBlMa4WX
 gRWxRo7kyfZqW3zcYzREDGVABWU_EPYDuQf1jaG1lnbAkeMzc0Fb.wgy75CAv.TeF5smO8Y9Frcx
 j7jDXa9HTzw4nhhAVStyOMIblZkm5FdxHs31JKQ7qRQnRfGyAUIh.W.Qcmj4kVUyJKhy4w6czzb5
 DVaqTWGA.UK7aL5PNxGl5xzOoV3yBUxhDHLgH2uMLMQ.IrHdd0p5pckr0CbVoUUebTenqNfRru6t
 kqqcPv1DBG8.bsl6zfzR6cAIv9tV_E61ztq3yx._.g84CTmrtN3e2siKvDRkYirvmvbT7i13JgIh
 ln.cLziX9Tmy28NTAhMtyn1S16I36kxhMVBei1nsboqze3myIGfVbQ.rNWZG3ZUO92ZLwCsfaZ8B
 1XUr5xnIbFNJyA_cS44do9_M1yTnsHkVtxWZ83Z60qogYmn2kVbL3RGWnywR_t5HlzPTjBw.AMnR
 C.De_zWcEs.uE2bWfuYKm3zs3nHeNF4kXiR6A3AsGQnkFfm2ymw7HLkUjrU_J3R2owUTOW8Vgalz
 paS.1GLsGrdnGCc_Vfiyjcd6rhyWnHeW1BUAOtvo3qofQUtnSFAwy2U7v9bUmRgwlqznFD.vCnr9
 GZnPwELe2xY0q0ZqKHtZNYkIIQtqA8emWZoQ07W5x3QNIovMWCh.EmAijmHaieqiOIdWN6eFCfxe
 bkpGlRhl9SCIUmKv_5TbDw5WqOl.GwEA.oXs8Q2m9o48MuLMrYukRE1WYoU8doqPLxbyvkGRfgnl
 ldKGO2W7QhhnTxipccCnjUeQniPnC704zibYtIzzAkWncdDFNz0.GTRh7GpDfh_Fca9o8nJkIOsd
 MculkKYU_kbhIlGhA809PoMcyU412p8AyknQRMdaeZwkwY_TopwzDC.p2Zkvg8GOY1pgwE9H7EJi
 RrF3hn2STcyeavp.8KztzgDVckJaLKMNfrxdva34qm866fe66eIX770BWaMaV91zGWRXHdIa47Lw
 oYN3Qa.TH030zhjzromLhjOn0Rdbe0QCbEbHWZDDRSkdkMb79xXFAprAUEt0hccik0buf4m__AaX
 bRITRdVzb8B7BJzjmgEH.SbL276IcwdP8cOMGk1IKtXUW.zhppz4YD6xs7usSDiaaULXUo_F_13U
 ome4kZNZoXpc7Pf_4DivfKG6nTbhjju57zF8yfQ1gSnupFL.wiKVahv.LsQ--
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: acb42ab2-e095-4176-a93b-893fd3fd75f2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Thu, 17 Apr 2025 17:39:12 +0000
Received: by hermes--production-ir2-858bd4ff7b-rtzhj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a26aee031807310d262ca66c92894fe7;
          Thu, 17 Apr 2025 17:28:58 +0000 (UTC)
Message-ID: <6ec1fa494ee823549fb97a48121cb28e37f1cc4d.camel@aol.com>
Subject: Re: [PATCH] staging: sm750fb: fix instances of camel case
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Korah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang
	 <teddy.wang@siliconmotion.com>, Sudip Mukherjee
	 <sudip.mukherjee@codethink.co.uk>, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 17 Apr 2025 18:28:07 +0100
In-Reply-To: <2025041758-mounting-populace-458f@gregkh>
References: <20250417153101.353645-1-rubenru09.ref@aol.com>
	 <20250417153101.353645-1-rubenru09@aol.com>
	 <2025041758-mounting-populace-458f@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.23665 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Thu, 2025-04-17 at 18:58 +0200, Greg Korah-Hartman wrote:
> On Thu, Apr 17, 2025 at 04:27:47PM +0100, Ruben Wauters wrote:
> > As per the kernel style guidelines, and as reported by
> > checkpatch.pl,
> > replaced instances of camel case with snake_case where appropriate
> > and
> > aligned names in the header with those in the c file.
> >=20
> > Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> > ---
> > =C2=A0drivers/staging/sm750fb/ddk750_sii164.c | 113 ++++++++++++-------=
-
> > ----
> > =C2=A0drivers/staging/sm750fb/ddk750_sii164.h |=C2=A0 26 +++---
> > =C2=A02 files changed, 69 insertions(+), 70 deletions(-)
> >=20
> > diff --git a/drivers/staging/sm750fb/ddk750_sii164.c
> > b/drivers/staging/sm750fb/ddk750_sii164.c
> > index 89700fc5dd2e..20c2f386220c 100644
> > --- a/drivers/staging/sm750fb/ddk750_sii164.c
> > +++ b/drivers/staging/sm750fb/ddk750_sii164.c
> > @@ -12,11 +12,11 @@
> > =C2=A0#define USE_HW_I2C
> > =C2=A0
> > =C2=A0#ifdef USE_HW_I2C
> > -=C2=A0=C2=A0=C2=A0 #define i2cWriteReg sm750_hw_i2c_write_reg
> > -=C2=A0=C2=A0=C2=A0 #define i2cReadReg=C2=A0 sm750_hw_i2c_read_reg
> > +=C2=A0=C2=A0=C2=A0 #define I2C_WRITE_REG sm750_hw_i2c_write_reg
> > +=C2=A0=C2=A0=C2=A0 #define I2C_READ_REG=C2=A0 sm750_hw_i2c_read_reg
>=20
> Close, but these are really a function name, not a macro, right?
>=20
> And what sets this #define?=C2=A0 If it's always enabled, then unwrap thi=
s
> indirection instead of keeping it around

Will take a look into it, if it turns out that this is in fact actually
used/different, what would be the best way to name this? checkpatch.pl
doesn't like the camelCase that's currently there.

> > =C2=A0#else
> > -=C2=A0=C2=A0=C2=A0 #define i2cWriteReg sm750_sw_i2c_write_reg
> > -=C2=A0=C2=A0=C2=A0 #define i2cReadReg=C2=A0 sm750_sw_i2c_read_reg
> > +=C2=A0=C2=A0=C2=A0 #define I2C_WRITE_REG sm750_sw_i2c_write_reg
> > +=C2=A0=C2=A0=C2=A0 #define I2C_READ_REG=C2=A0 sm750_sw_i2c_read_reg
> > =C2=A0#endif
> > =C2=A0
> > =C2=A0/* SII164 Vendor and Device ID */
> > @@ -25,7 +25,7 @@
> > =C2=A0
> > =C2=A0#ifdef SII164_FULL_FUNCTIONS
> > =C2=A0/* Name of the DVI Controller chip */
> > -static char *gDviCtrlChipName =3D "Silicon Image SiI 164";
> > +static char *dvi_controller_chip_name =3D "Silicon Image SiI 164";
>=20
> This is a totally different thing.

It is, however I believe it is somewhat more descriptive, I suppose it
doesn't really matter though and if it should be the same, just made
snake_case, I can do that.
>=20
> > =C2=A0#endif
> > =C2=A0
> > =C2=A0/*
> > @@ -37,14 +37,14 @@ static char *gDviCtrlChipName =3D "Silicon Image
> > SiI 164";
> > =C2=A0 */
> > =C2=A0unsigned short sii164_get_vendor_id(void)
> > =C2=A0{
> > -	unsigned short vendorID;
> > +	unsigned short vendor;
>=20
> Why change this?

Again removing camelCase, kernel style guide says that shorter names
are preferred (unless I misinterpreted that), I could make it vendor_id
if that is preferred, I believe the same would be with device_id below
it.

> This is a mix of lots of different changes, please break things up
> into
> "one logical change per patch"

Would it be best to split each rename (function or variable) into a
separate patch? I do agree it is quite a lot and I was a little unsure
when sending this one, but I also don't want to make a lot of different
patches and spam your email with 100 patches at once.

I suppose I could make one rename per patch and do them a few at a
time, that may take longer though.
>=20
> thanks,
>=20
> greg k-h


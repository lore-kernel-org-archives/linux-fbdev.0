Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95D7FBA2
	for <linux-fbdev@vger.kernel.org>; Wed, 31 Dec 2025 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767143583; cv=none; b=SPXAalPx13+GEv50wBreqT1tkNnhF6w5l85iYCsECJooL10BjZrbpaJbNAJFS96DD8x+I3bwkluZICKBJuH5AAqjn1/qMyTiXG3GiDHI7pB9Qx+Gewus+41z3hAFCZ98PUwDfXs4VzFT1JcElq+LOP96tmSrjWKy/ip5fNFYms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767143583; c=relaxed/simple;
	bh=MG84PfllaFsqOwbsNp4bk/AcdG++Q3JJfePHL114pkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEXP+DJBhfOvVOBqKNz9EGNHeI7OAc1+fHMzjLZuR5J+mpn56ksfG4VTylJKC1S5nJ7abYy4GDjF7mw4Re/k7sDYc2cqw4s9sMxdjbAg3KXbYCOjvKCLwhsoaov1I+ywf4JT+o1ec2bjUVRe8TwxzgKipOksrlFzk+D/TSMg6iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsK1tlnK; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsK1tlnK"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c03ec27c42eso5830485a12.1
        for <linux-fbdev@vger.kernel.org>; Tue, 30 Dec 2025 17:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767143581; x=1767748381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeQcQUJ0nVxM8AF8UlKdRHzbwF3mIH0Sw6rdC7jjj/k=;
        b=fsK1tlnKVmghOGDfOYhRxKFnLeUsLAfj+5rNXIwbvR4hGuYIRz5nFXtm6qXOWgZMYC
         eKR3ZUJJA6w9EYTbZyNEGjiLYBTGf2bJtHWWE3dSXquRe/kqr/1itKI8MLlPh43Ns3CT
         hMyf/h0vBHnOIsAsokXApkz9x/0tl0pgjeGvlKib5phZHKSqIPFvRkanyplGxke9XGVe
         dAuBPwT0TVHPEsLfK/6fINYmgfvZy25S4ER+Su1H9jgz2z1iM+exVPBcXf73cO6GOdHP
         pAmGse9IjyMUtAj5RScBbYUpgivtCzafwnLPPhjBKjdNeRE8Rqqo4D7HEqJNeCJIk2x4
         vByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767143581; x=1767748381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IeQcQUJ0nVxM8AF8UlKdRHzbwF3mIH0Sw6rdC7jjj/k=;
        b=g/RLmjhia460xFn3RVQ23G8HccO25FLxLSyi5g7IZkCKuJYbtpZduEayKECXeoAMqc
         SsA6v02De1PULoAAN/g+AOVC3UrMoIm7GlT9vmI+Bcb4Ruh766G+uMwPepzaEWrfdT7f
         EtP5DJQYjnYXBl7lkPDExzOhRdXhIH7k0HcWXbsTVtYW3QMnVHGbV7EVOtc13nEUB08n
         vWuSNbTsb97k4+3MZOuW48izHaUyNyXxTBHweOCnJhQYpUxR464eH+CtG3KmQ/OyO1nZ
         FNI0om5MlFvS8CXRzwMHmBdwTmdEURdCyV9mtO3EKmi72bABbvQ2mDXzMXJ2TF4UcSKM
         NhkA==
X-Forwarded-Encrypted: i=1; AJvYcCUbrBahZoeJ1kJPR5n4NxaZcj/spYCUjeHahG/Y6MgyMi7AvG+ogQzy1tqiV5YSQKnUPiOMdSRkAGemag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/IPTsZj87Ryog4DQSHm052eSAcmraj5Gbc4z+q2zKxFazOpuz
	SXUW8mw2mGll+vcBhHf030Y3xpBhpl9v/208svhXZR/0sE5/5Lc2gZt2TMpgx4dvmAr9eYZz/S1
	XiR+nhWGlfLqI/nNiqamGn2nGE4Pk+2o=
X-Gm-Gg: AY/fxX56RX3AZsbY3HWrnCkGDJj8Tzk+sYPlS6VV5uVzPoH30qtseO/8H2rS8dnAH9Z
	aKILsS5oh1qMRTq/KE9lIGW4wWhZSqUigC3kJ6Yvuv0U6PfRNLAy3MLEOhcAGKQjT0+4WgQEeY/
	Uvhbj/fmL0LbNeA39xFwnME/GkplHiKaYIF9I4dsL1jtk0NaQfF5OB8u6G/wVUyE5UCgb2gpl9Z
	W1fRQ6T6wPf2GtM2Dvnlt8t2rjm9jSM4or9hFKSRKq/mKTUQFLUjrt/abjUUXN84oL+2Pyw49u5
	vlfJpvJNevmTIQ0rrj9KvWBVK8K0xDBkPMd/Me0C
X-Google-Smtp-Source: AGHT+IHbJxSw1M3musp0bYbX/SCruq7+cMntd+0nwNFLBVEvPaHZrydSXj/YPxC7Mx1rvics9S2yxNHLP1jgYX4iRyk=
X-Received: by 2002:a05:701b:240e:b0:11b:95fe:bee3 with SMTP id
 a92af1059eb24-121722e8c4dmr20769496c88.37.1767143581083; Tue, 30 Dec 2025
 17:13:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215225305.3820098-1-patdiviyam@gmail.com>
 <c3253bfe-e967-48ae-9376-a65ad1d53419@gmx.de> <CAM19b+s73Fo6Ej85qk72UPn12VQ_iFAYpHv7K=wOapb0-+1XBA@mail.gmail.com>
In-Reply-To: <CAM19b+s73Fo6Ej85qk72UPn12VQ_iFAYpHv7K=wOapb0-+1XBA@mail.gmail.com>
From: Diviyam Pat <patdiviyam@gmail.com>
Date: Wed, 31 Dec 2025 01:12:49 +0000
X-Gm-Features: AQt7F2riJ6pSzSd-igUXfxPmknjpaTscQSQNu4tgJyw4w_cn6eGpa11dBIMkTUU
Message-ID: <CAM19b+vFf9YJGdtysuG+DrxLnnvbcbzhR_Ad5PzR4q4zkVdWzg@mail.gmail.com>
Subject: Re: [PATCH] fbdev: xilinxfb: request memory region before mapping framebuffer
To: Helge Deller <deller@gmx.de>
Cc: tzimmermann@suse.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi
No, this wasn't tested on actual hardware. I don't have access to it.
If someone is able to do it, that would be great.

Thanks
Diviyam


On Tue, 30 Dec 2025 at 23:21, Diviyam Pat <patdiviyam@gmail.com> wrote:
>
> Hi
> No, this wasn't tested on actual hardware. I don't have access to it. If =
someone is able to it that would be great.
>
> Thanks
> Diviyam
>
> On Tue, 30 Dec, 2025, 3:27=E2=80=AFpm Helge Deller, <deller@gmx.de> wrote=
:
>>
>> On 12/15/25 23:53, patdiviyam@gmail.com wrote:
>> > From: DiviyamPathak <patdiviyam@gmail.com>
>> >
>> > The xilinxfb driver maps a physical framebuffer address with ioremap()
>> > without first reserving the memory region. This can conflict with othe=
r
>> > drivers accessing the same resource.
>> >
>> > Request the memory region with devm_request_mem_region() before mappin=
g
>> > the framebuffer and use managed mappings for proper lifetime handling.
>> >
>> > This addresses the fbdev TODO about requesting memory regions and avoi=
ds
>> > potential resource conflicts.
>> >
>> > Signed-off-by: DiviyamPathak <patdiviyam@gmail.com>
>>
>> Was it tested it on physical hardware?
>> If not, could someone test?
>>
>> Helge
>>
>>
>> > ---
>> >   drivers/video/fbdev/xilinxfb.c | 30 +++++++++++++++++-------------
>> >   1 file changed, 17 insertions(+), 13 deletions(-)
>> >
>> > diff --git a/drivers/video/fbdev/xilinxfb.c b/drivers/video/fbdev/xili=
nxfb.c
>> > index 0a6e05cd155a..f18437490de8 100644
>> > --- a/drivers/video/fbdev/xilinxfb.c
>> > +++ b/drivers/video/fbdev/xilinxfb.c
>> > @@ -280,19 +280,27 @@ static int xilinxfb_assign(struct platform_devic=
e *pdev,
>> >       /* Allocate the framebuffer memory */
>> >       if (pdata->fb_phys) {
>> >               drvdata->fb_phys =3D pdata->fb_phys;
>> > -             drvdata->fb_virt =3D ioremap(pdata->fb_phys, fbsize);
>> > +             /* Request the memory region before mapping */
>> > +             if (!devm_request_mem_region(dev, pdata->fb_phys, fbsize=
,
>> > +                                     DRIVER_NAME)) {
>> > +                     dev_err(dev, "Cannot request framebuffer memory =
region\n");
>> > +                     return -EBUSY;
>> > +             }
>> > +             drvdata->fb_virt =3D devm_ioremap(dev, pdata->fb_phys, f=
bsize);
>> > +             if (!drvdata->fb_virt) {
>> > +                     dev_err(dev, "Could not map framebuffer memory\n=
");
>> > +                     return -ENOMEM;
>> > +             }
>> >       } else {
>> >               drvdata->fb_alloced =3D 1;
>> >               drvdata->fb_virt =3D dma_alloc_coherent(dev, PAGE_ALIGN(=
fbsize),
>> > -                                                   &drvdata->fb_phys,
>> > -                                                   GFP_KERNEL);
>> > -     }
>> > -
>> > -     if (!drvdata->fb_virt) {
>> > -             dev_err(dev, "Could not allocate frame buffer memory\n")=
;
>> > -             return -ENOMEM;
>> > +                                     &drvdata->fb_phys,
>> > +                                     GFP_KERNEL);
>> > +             if (!drvdata->fb_virt) {
>> > +                     dev_err(dev, "Could not allocate frame buffer me=
mory\n");
>> > +                     return -ENOMEM;
>> > +             }
>> >       }
>> > -
>> >       /* Clear (turn to black) the framebuffer */
>> >       memset_io((void __iomem *)drvdata->fb_virt, 0, fbsize);
>> >
>> > @@ -362,8 +370,6 @@ static int xilinxfb_assign(struct platform_device =
*pdev,
>> >       if (drvdata->fb_alloced)
>> >               dma_free_coherent(dev, PAGE_ALIGN(fbsize), drvdata->fb_v=
irt,
>> >                                 drvdata->fb_phys);
>> > -     else
>> > -             iounmap(drvdata->fb_virt);
>> >
>> >       /* Turn off the display */
>> >       xilinx_fb_out32(drvdata, REG_CTRL, 0);
>> > @@ -386,8 +392,6 @@ static void xilinxfb_release(struct device *dev)
>> >       if (drvdata->fb_alloced)
>> >               dma_free_coherent(dev, PAGE_ALIGN(drvdata->info.fix.smem=
_len),
>> >                                 drvdata->fb_virt, drvdata->fb_phys);
>> > -     else
>> > -             iounmap(drvdata->fb_virt);
>> >
>> >       /* Turn off the display */
>> >       xilinx_fb_out32(drvdata, REG_CTRL, 0);
>>

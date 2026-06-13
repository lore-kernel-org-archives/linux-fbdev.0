Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B127C3876A9
	for <linux-fbdev@vger.kernel.org>; Sat, 13 Jun 2026 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781378121; cv=pass; b=MCicOP8clDAEaHugF3swpAZP2m7LGb1QRKheXv7EHwkFiLTB6BteoUmaqePVONsgR2APCS3E46ZrUKNqCFxMfaQ8AZNRciUSHcufTMemNQxVmNddHXNA+UQYqexjlXo36wKTeVVxVhmeLqS8o01BrOJxsAHInw/YXQM5KMfuiec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781378121; c=relaxed/simple;
	bh=KM5Qf8IcukoP9exOeIUkV1KLefZ/AF3fZN4wnS0EUeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyFmZbn/+SR90wy/JV/vtu6L+ZSKzWtsnq8ycK1zwJJLkz2VTbmt27DwTnUNroxT2QJMR4/yK8g4MlwAat6mXrP6RjABGk8ZUrZG61dvKmwE/n7GsowuJu3hWT9e3WQ8LBXd1Hk70mtO3HfWYFiqkdL69sI3ofg4kCZvPWKakng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdLcCufd; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdLcCufd"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bec3f69d343so302105066b.0
        for <linux-fbdev@vger.kernel.org>; Sat, 13 Jun 2026 12:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781378118; cv=none;
        d=google.com; s=arc-20240605;
        b=InD3uTCis2oY9a6FyjHYjfqNiuFXUcPN/OVFPDqHqByHLDrwjxzmqAPoWe7Bb0rsjp
         mPAss0MqO3A+Q5zWYwkiRJqXnFmSm0Q4YchaXF5oydEJDRjZ1zG42UzWk9GLQ2W7crHC
         PidxlDKnP7KPEfQ4//GyB4lj997FMWGCSyc8n5d+tmvfpu7XUh57AtSniE4GkQx78ryT
         ekzQAJvEiiS4Zh6oXKT6PSlOGDbx1Sf+OytrQlppDZUtCHV83HtphpGHsYmqzzIplE+n
         D0LmArORkJz9R/tIkR+kM1ojsaas1kmYxQY7ADnALOvQ8cj5t1HKl2yPCoslrgcUMENj
         HXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gRrXmp1TB9x8FhYANwmYNqe1NtmxJ8SE9yU4lYafYsA=;
        fh=OadQblhzQWuseefAZMq1UwVSKRifC0TBHn0BPsrpnPo=;
        b=P5OtiGaUgXTKXifv7Q+GVyTIeh0fNHhz08ANpGIoCMEvIRUYYrMTEylNxuxP1N2A0h
         MZUoA9gGsg+T+EwDFs+4ZC47xPSoqld4SAaNytUj88Zmm7htb+jSZv2FukgO7dycQxGH
         yIyV8CNN6dnJbyfUPP3aSjtSRWpTzLxNBU//LZd8XZppyFhCy+0yQK86ut/2cwVN9c5n
         2ZJLKmqE7g1AFkJ6M8kWRN368qHXsKCvnkp/3ASc3CxVpfDXOMuymcpgnKWahMZJzDdD
         Ij9V/UYnYMLoeyZsaaLTNdTPF/agWPA1H5FRVOfmOGhgzsedHAOEZIKpdrJUAU5IhtMH
         RWrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781378118; x=1781982918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRrXmp1TB9x8FhYANwmYNqe1NtmxJ8SE9yU4lYafYsA=;
        b=qdLcCufdRTe0KXw9/wpeccqX8HD1O+snlX1onJ7+h7LT6rLS/a/L45NDUwxuIeKHDe
         k83l3Djkh5nAr+hqV1XNsZoGCkuk8dOpkTR37617k3/NhrtbHXBu+RDhizxH9pSbKd6z
         lFbuqZkUfg/GZgCoC8VEeEtlfA70p6Jdo8WKa9FFdgsTEvTPMR/QBUBAFAfy+bD3qss9
         1SKtxbqog/szwOHtG2XbE+jwT/UnZ33Js6kpKJicDJxXFD0UWaDM+2WHvhu3wpwAHEk5
         3FnYe/iK3jsRz69soOKL+oxxG8WAJYylz4CSb/PFaFrg/SJyDurfZ/sIcA1Pc7Eh0EAu
         UT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781378118; x=1781982918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gRrXmp1TB9x8FhYANwmYNqe1NtmxJ8SE9yU4lYafYsA=;
        b=SYOWE/dZNG1DHhQLZYCNU5TYKASDrm4cfLj7Na7AF4x+8tTUTAy35K1b9iBG1YP0x1
         fy9t23D0BqAphlpsDSRFVVaeLusY4uXfshbuk+8oSc6gwFQMiIflddhh3mbkFQSLnqor
         O9XDDAhfvPp6Qgg3m2Lv8cQ8AkBeFuxPBtN1CDytFY2xn6IazrzlYyC546UUPBf4sEtv
         f7wuD5ogTbS/M6YlXMet8vrbqxn/GP1wkxJ0PryQZTGcRBKfKF6ippqTYOJA68rFAigC
         lPl8qKu4Q6k26csFF9FLB5QWFtszsuHPqJSozkmsHP5dDsm7hoMY0H978euMSjyFCPa8
         fRmw==
X-Gm-Message-State: AOJu0YzXbyAIv11M+1u5suWtUMr8gzfJ0gReDa1lmYcpXiKmh+mwgPI0
	S+cC6OjqlJxpsQV392U7WYm7y89/iK8eSVWcv6duXtiEC0UOMK/ePNYqy2WUWtO1BPPQ7axr1MT
	rkK/BTqSl3pb2CNgQuXeG9f9IyGKl2yc=
X-Gm-Gg: Acq92OHjqSau8iMzUBSGGKJ7ZDk19160Y3hKuNwDShm0bx6XtfmB37+LvQidOAMSc3d
	1vnWdM6Lp5OCuN6uWyTsYh/atX8HNEqGmv5iMHOiVgYXz/gjjsWcHOGwbNN+VGXw0kIEfpmgO+S
	qhLtlnDosUJiwsx3UMj/wfq2+ePJ7RRd4wpXFTyZY90ufJrWapZRahBh6HVpUNfCj+ycQdfa3LU
	HZ+LjTCkw/FdehIwNypYmAKV+yPSis5Tf0PbRS5FyK1JcsZHrHtekqFBzLAwBH2fOiHUnYT4VYq
	yHhjYHynAI0BrdRYsJwTNfIoIa6KyrCxT2n2lg==
X-Received: by 2002:a17:907:7ba2:b0:bee:9809:3ccd with SMTP id
 a640c23a62f3a-bff499220e7mr230874866b.4.1781378117955; Sat, 13 Jun 2026
 12:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529111927.14138-1-neharora23587@gmail.com> <CAOWJOptv1JcOGcEt39HVy7LkpAsvzbw9yj64kJG+X5J=VbWrMA@mail.gmail.com>
In-Reply-To: <CAOWJOptv1JcOGcEt39HVy7LkpAsvzbw9yj64kJG+X5J=VbWrMA@mail.gmail.com>
From: neha arora <neharora23587@gmail.com>
Date: Sun, 14 Jun 2026 00:45:05 +0530
X-Gm-Features: AVVi8CdZ2hBYy2R3pen1MThHg0ehnRxeApw9ackzpdndzMPMAZnrBSG0y53Dj9g
Message-ID: <CAOWJOps9RBNAGsPFsBCbzFkEUN1=75YvwmqJX6RdQBbt1C6W-Q@mail.gmail.com>
Subject: Re: [PATCH v3] staging: sm750fb: rename pv_reg to io_base
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

Just following up on this patch to ensure it didn't get lost in the queue.
Please let me know if any changes or a V4 are needed.

Thanks,
Onish


On Sat, Jun 13, 2026 at 11:29=E2=80=AFAM neha arora <neharora23587@gmail.co=
m> wrote:
>
> Hi everyone,
>
> Just following up on this patch to ensure it didn't get lost in the queue=
.
> Please let me know if any changes or a V4 are needed.
>
> Thanks,
> Onish
>
> On Fri, May 29, 2026, 4:49=E2=80=AFPM Onish Sharma <neharora23587@gmail.c=
om> wrote:
>>
>> Rename pv_reg to io_base to follow kernel naming style and improve
>> readability.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Onish Sharma <neharora23587@gmail.com>
>> ---
>> Changes in v3:
>> - Added mandatory Signed-off-by line.
>> - Rename pv_reg to io_base to remove hungarian notation
>>
>>  drivers/staging/sm750fb/sm750.c    |  4 ++--
>>  drivers/staging/sm750fb/sm750.h    |  2 +-
>>  drivers/staging/sm750fb/sm750_hw.c | 12 ++++++------
>>  3 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/s=
m750.c
>> index 716a8935f58d..c2d2864f135b 100644
>> --- a/drivers/staging/sm750fb/sm750.c
>> +++ b/drivers/staging/sm750fb/sm750.c
>> @@ -743,7 +743,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, i=
nt index)
>>          * must be set after crtc member initialized
>>          */
>>         crtc->cursor.offset =3D crtc->o_screen + crtc->vidmem_size - 102=
4;
>> -       crtc->cursor.mmio =3D sm750_dev->pv_reg +
>> +       crtc->cursor.mmio =3D sm750_dev->io_base +
>>                 0x800f0 + (int)crtc->channel * 0x140;
>>
>>         crtc->cursor.max_h =3D 64;
>> @@ -1047,7 +1047,7 @@ static void lynxfb_pci_remove(struct pci_dev *pdev=
)
>>         sm750fb_framebuffer_release(sm750_dev);
>>         arch_phys_wc_del(sm750_dev->mtrr.vram);
>>
>> -       iounmap(sm750_dev->pv_reg);
>> +       iounmap(sm750_dev->io_base);
>>         iounmap(sm750_dev->vmem);
>>         pci_release_region(pdev, 1);
>>         kfree(g_settings);
>> diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/s=
m750.h
>> index e8885133da2e..c42800313c6a 100644
>> --- a/drivers/staging/sm750fb/sm750.h
>> +++ b/drivers/staging/sm750fb/sm750.h
>> @@ -97,7 +97,7 @@ struct sm750_dev {
>>         unsigned long vidreg_start;
>>         __u32 vidmem_size;
>>         __u32 vidreg_size;
>> -       void __iomem *pv_reg;
>> +       void __iomem *io_base;
>>         unsigned char __iomem *vmem;
>>         /* locks*/
>>         spinlock_t slock;
>> diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750f=
b/sm750_hw.c
>> index 95f797e5776a..dc1118808b4f 100644
>> --- a/drivers/staging/sm750fb/sm750_hw.c
>> +++ b/drivers/staging/sm750fb/sm750_hw.c
>> @@ -23,18 +23,18 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct=
 pci_dev *pdev)
>>         }
>>
>>         /* now map mmio and vidmem */
>> -       sm750_dev->pv_reg =3D
>> +       sm750_dev->io_base =3D
>>                 ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size)=
;
>> -       if (!sm750_dev->pv_reg) {
>> +       if (!sm750_dev->io_base) {
>>                 dev_err(&pdev->dev, "mmio failed\n");
>>                 ret =3D -EFAULT;
>>                 goto err_release_region;
>>         }
>>
>> -       sm750_dev->accel.dpr_base =3D sm750_dev->pv_reg + DE_BASE_ADDR_T=
YPE1;
>> -       sm750_dev->accel.dp_port_base =3D sm750_dev->pv_reg + DE_PORT_AD=
DR_TYPE1;
>> +       sm750_dev->accel.dpr_base =3D sm750_dev->io_base + DE_BASE_ADDR_=
TYPE1;
>> +       sm750_dev->accel.dp_port_base =3D sm750_dev->io_base + DE_PORT_A=
DDR_TYPE1;
>>
>> -       mmio750 =3D sm750_dev->pv_reg;
>> +       mmio750 =3D sm750_dev->io_base;
>>         sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
>>
>>         sm750_dev->vidmem_start =3D pci_resource_start(pdev, 0);
>> @@ -58,7 +58,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct p=
ci_dev *pdev)
>>         return 0;
>>
>>  err_unmap_reg:
>> -       iounmap(sm750_dev->pv_reg);
>> +       iounmap(sm750_dev->io_base);
>>  err_release_region:
>>         pci_release_region(pdev, 1);
>>         return ret;
>> --
>> 2.54.0

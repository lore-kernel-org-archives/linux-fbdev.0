Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC64C227E95
	for <linux-fbdev@vger.kernel.org>; Sat, 27 Dec 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766845205; cv=none; b=obuQm3pOZC3PweRXTehSyAEIQZeY3Z6mxTb/P8SmIaifNiktXkao+3AHmW5nR5DG/6HRG1+QTuzNLDWvogs6PCOdaYc/7qcAUAQYX+L3fvYGECSkEPUCYaVjHFE66JFg+oMtw9CRFph4E2fp8kA2F3EL+u5RG4RtMPl+28dqRDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766845205; c=relaxed/simple;
	bh=qVm/WbD0OkOzktJs0xypVZ5JiX+A86nrc1r124G+N4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LX/6beJpmnoQcZCFEdfKgie/5c0F7qj6vlIHJOR3SSFcH7jfF3ItcjgU4BOUPA4QiVIQTZ9GfjIVDTuvYbOxUn17Es1kqSUXCNX1wXzGJMOhiF0nLFRbXE/8IBqjdLQ8rD82KLdMF0AhDkG1YxhmAoK1rAOjyFovwyGRvR4B/Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvTeVO6M; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvTeVO6M"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7636c96b9aso1426763666b.2
        for <linux-fbdev@vger.kernel.org>; Sat, 27 Dec 2025 06:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766845202; x=1767450002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3rVAXM2uA2BUpYCLCItwXy4Hyvoocs+aIR9WcWlcsk=;
        b=SvTeVO6MVVqVbmfPn9szsF8EJxBfd59gZuOicA+iNEUHNhC5bLFbAqHttptJ6dGh9q
         XJXsP0PPOZpxdqdjvweHlyG5i2RdppyifgnYYM08jSLGaVIHvuQ6r0Y3sCJcVJA1VHbP
         BQJKV4ByFq3RSP7qtfSCBeJZoma1BAMkm8GN/ew8M7t47+XHqWr9p+FSFStI2XXQqKem
         ggLbNznjCEMcS17lubNgoXu0ZsGh9Y4cXLh4fAH8cMm5/S6jO/mGKWTOSpEZWgHIT0sT
         pUNoyTT0kBF7e4E6/qRLB3rG0MXvLafApzb7OLxazzrDwoe1523gOxJFSfS+/hiCtf1Q
         hGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766845202; x=1767450002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e3rVAXM2uA2BUpYCLCItwXy4Hyvoocs+aIR9WcWlcsk=;
        b=PdwINudQ7kMA2Hjn1XQX3gcWQoex8cMV1LxPAAspSzCdqb/PyMiX6HgLIsvWaFnGQR
         YOrHq0NVS6r02wA44BE7ylj4ONSuyOMnpf/2sMgGZV5pRUVWRKULCMRn+Nq2NkH8XX1n
         yLvhyaC6SHV0jFV8+iByi/tVevZrqpa08/z7bzFGXS24zYHvHbK688ySiZxEv2VzotO3
         YmdGDNiXU9UXT+czSZ7IWGLg9Q3FgPaHXOLi5nlkfSwVHLxVqekoxvroRNa0u23qETTz
         jIOeYxk/a75PThA2GgWzxzMWBbFujZGOWnqB0HgyNU0wKmDqnXXWHLvicqyMqzCp6JUy
         tDlQ==
X-Gm-Message-State: AOJu0Yzi/WNw0ZZdWwvBsbuH9SPsit2ujOXFUkJ0g9ISS2IBvXBhLNNN
	3We6KOX7L/mGpwcw4dnydGqyVIQRWgULi09o8iAG1H9nCN96ZikGO2r6dDfgMrqFMVO4ZnM3upc
	DVQu3dF9yEtHlObep5fjJu+4yk+ivtnE=
X-Gm-Gg: AY/fxX5pMstpHQL0jNsa6qfrxhOKtoeBxJl7dO2B70qmzy6A6/7UudDHfecRRBH0GkO
	fXUBis1S+dr9/r1Sx66UQTh/UApCWCU0JSFiy5RP/cL464T7d8qRpcUAmBDJjyXgP5PVN5qgZg/
	p631HwW8c5FB5gYu5Mr9Hz4/6VcZMdMHaNMELQ8+hM30/O7HI7hmhw3zfPZqksWeDcmEwHIGSD+
	wTbvW3fsXVqg+PHhtYp51nO+ittIMRZPDLtMeQg/jPmnTbbzdrTvJ8illTDXynkBtpx/LjE2qii
	6u+1uIYENZYIdIWj5KKg20NY8qdOVfQF6eKKB2Xdej4TN4wHdvHkHN0DmcBN4uwUOUkaoRc=
X-Google-Smtp-Source: AGHT+IF8S2vZ7+R+gmMHpDxIPniiRhAY4GhOubuUewd59zPB/hHlKmS5S1gCB4cVMV+kZ1atbDLTB1f1Uuy9kvPPTQ4=
X-Received: by 2002:a17:906:7315:b0:b73:398c:c5a7 with SMTP id
 a640c23a62f3a-b80371a7253mr2621691866b.41.1766845201824; Sat, 27 Dec 2025
 06:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219054320.447281-1-chintanlike@gmail.com> <20251219054320.447281-3-chintanlike@gmail.com>
In-Reply-To: <20251219054320.447281-3-chintanlike@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 27 Dec 2025 16:19:25 +0200
X-Gm-Features: AQt7F2qzW7hXhSkhTQqqZrlX5yqv6kNuSTsnbNk-OS8FE2UIntKjLzVunWTLcHw
Message-ID: <CAHp75VeLF8nd-JiPFnxJ2H43ZS=oYgW4=BTZjR_GuUuj03gyRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] staging: fbtft: Make FB_DEVICE dependency optional
To: Chintan Patel <chintanlike@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, tzimmermann@suse.de, andy@kernel.org, 
	deller@gmx.de, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 7:43=E2=80=AFAM Chintan Patel <chintanlike@gmail.co=
m> wrote:
>
> fbtft provides sysfs interfaces for debugging and gamma configuration,
> but these are not required for the core driver.
>
> Drop the hard dependency on CONFIG_FB_DEVICE and make sysfs support
> optional by using dev_of_fbinfo() at runtime. When FB_DEVICE is disabled,
> sysfs operations are skipped while the code remains buildable and
> type-checked.

> v2:
> - Replace CONFIG_FB_DEVICE ifdefs with runtime checks
> - Use dev_of_fbinfo() to guard sysfs creation and removal

The place for the change log is either a cover letter, or...

> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
> ---

...a comment block here. It's not so important to be in the Git
history since we have a lore.kernel.org archive.

>  drivers/staging/fbtft/Kconfig       |  5 ++++-
>  drivers/staging/fbtft/fbtft-sysfs.c | 18 ++++++++++++++----

...

>  void fbtft_sysfs_init(struct fbtft_par *par)
>  {
> -       device_create_file(par->info->dev, &debug_device_attr);
> +       struct device *dev =3D dev_of_fbinfo(par->info);
> +
> +       if (!dev)
> +               return;


The better way is to decouple the definition and the assignment in the
cases when it's followed by a conditional (validation check). In this
case any new code added in between doesn't affect readability and
maintenance efforts.

       struct device *dev;

       dev =3D dev_of_fbinfo(par->info);
       if (!dev)
               return;

> +       device_create_file(dev, &debug_device_attr);
>         if (par->gamma.curves && par->fbtftops.set_gamma)
> -               device_create_file(par->info->dev, &gamma_device_attrs[0]=
);
> +               device_create_file(dev, &gamma_device_attrs[0]);
>  }

Ditto for the rest.

--=20
With Best Regards,
Andy Shevchenko

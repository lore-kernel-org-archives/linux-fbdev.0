Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502A7313525
	for <linux-fbdev@vger.kernel.org>; Mon, 12 Jan 2026 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768201703; cv=none; b=aMvL4YCo7pBF2UaslRnYqmJ2byQ0R0A6R3kKNOu/pODaQVcaR/Rse9BGqx5eWzgh6c+lOB8fDBAtVkdYtLv7qGbAeJXJgt2sipNnJaCJ3dwFLziWadw//a37K4EZYZ4p09Uxy6IKKLoBlroDc9ELmJXg1NBkQv02cyN54dBs4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768201703; c=relaxed/simple;
	bh=mBAm1uaioaQGqHopFkT/acZ01rHlHsqYy9cqOpr62vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cosi2uJBYkvTmm2uEF3QDVvSn0hFICAjDp/XccWz+ueQbs9sFuAS2ZZXYE8lCOI+IdDGjSrwfE0d6/yMjQimFQCxtstFVX8oJcL5cWxTXM7mfacnxf37QF4wG1VhjNDiZbbNL2IPz2PkMU/2XIAsLVeWHFbvHHgb1IFCBL+SkJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8XogKCc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8XogKCc"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b87124c6295so102922666b.3
        for <linux-fbdev@vger.kernel.org>; Sun, 11 Jan 2026 23:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768201700; x=1768806500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDtobSm2s3UkTYNtP162SerczReKzDGTa8FA9CeAFBg=;
        b=k8XogKCctV2jX3XXlri8DrHTexvNJzhuFHLi5GJ2e7TtJbYBpMT372m284C7YFdBJI
         TkgJ1prGzqsMduZrAmHr1vjIrXFvncJv/YpwSv7TWLxQATGYSLZBQkxNR3AoNdKGf1eD
         LIe7S5jvUFb6g6nZdknFcbMkKbdNMu4W3lWJtQ5PRkVUdcsX9dvBVjctBpMk9rhDMa+s
         xmibjr/EHyflCoAYr4zYOtyEafegfWqNN5wyRGXzySeXNCBPdXRVog+QnynvT60SXKU5
         E2HMbZA3bMtpq4JJos0298xG5dwVMXQ91xgy1mGvLRbLNGka5pzPlkvmQfJRKpx0CiAK
         qfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768201700; x=1768806500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tDtobSm2s3UkTYNtP162SerczReKzDGTa8FA9CeAFBg=;
        b=K1ExHYqNPHueScx6sxvI1lXJh6UcvTPAHeUnPHXNS/A9o7HmG6fxTZKnPdJXGgsGJq
         btCyF1U/8Dx3Gm4gWa/T6g/qzj8OhuDtMtGCU1T3nlpvFZ+ozDq8D36opKZ662YAcPFv
         Wk+zqATeqUoLUzBpBk65BFE15meZlainzUSxCeMUCT3jrd+wuEEtsC1Gdi+EZBRawAXn
         2aflzpY6C68USEB027X63KIZGNNBR5w4Q8z4s2CNMuOgBfeF33q/BH/odiHOKJMWqgCN
         Fywog47vblAkt+IBVv1xWIVR9gcKr2BCD+88ZiK2xxCvVOmjCx3T+agZkcrjJA0Yjq1g
         K30Q==
X-Gm-Message-State: AOJu0YyEotjaB6frKJh7J2xC4ovdLr860YTUYeC1LniUkHTnoCvZwAFK
	w1Lgi/IPcK9wqBAFpBDehSGkyvflc8OVtxReYIR3ZHMsWF8wU1xibTqdqSSFYuIsAJSfcosfpEo
	p3DJu0/CUz5lcOBAkHteRUzUttGhv5O4=
X-Gm-Gg: AY/fxX5xEXI4Q/Ef3+4/VZqUyDMtfkGCqTZmYn3eTl4VOtFnXSwKLSjVIBLDjKAQkzu
	UJIOkS3IV43fqgEAekXsFhGCW2CTea/DRPdyTcAchGFFReAc8Jv2Xm70aLVzxlr+m4YoNHdCye7
	I+dybTS6kHS0+ScTo7v/OtHkG/jTx9JJais1lrT0QpVAeKhDLKLUc9U4MipAGIZHFzd347P872/
	9XepAWdfeS4FO2p3he/9/2Tne+zPWLjYmbOkkoKrcl70EsHxmDPlVesAAV0ec7Oxt/CVAK1MIF7
	nakm/8yWacFgi9hBNw0JPcpjnyT/GBbZ8bEspbQd80UM9/7x+6JtH4H5m3OFveoEU/fHU48=
X-Google-Smtp-Source: AGHT+IGpYjqq+pg/XnsC/5GM0k5nhevTAfoh1OMUUjQOBvSBPsf/kZ7p8LloN/33VrzRKiJwU/cvplIIHQUOpkB6aIk=
X-Received: by 2002:a17:907:e106:b0:b84:5927:6ed1 with SMTP id
 a640c23a62f3a-b8459276eefmr841165266b.30.1768201699516; Sun, 11 Jan 2026
 23:08:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112010740.186248-1-chintanlike@gmail.com>
In-Reply-To: <20260112010740.186248-1-chintanlike@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Jan 2026 09:07:42 +0200
X-Gm-Features: AZwV_QhOYCW6xjV6nzt8R01WACOin2n1BWUyz1yiKwXq9XWTu9UtzwIoiSzFyuU
Message-ID: <CAHp75VeF+Sj=dxA4RZAvVddGSG3brUsy8kz7mvtst2YpqNm99w@mail.gmail.com>
Subject: Re: [PATCH v5] staging: fbtft: use dev_of_fbinfo() instead of info->dev
To: Chintan Patel <chintanlike@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, tzimmermann@suse.de, andy@kernel.org, 
	deller@gmx.de, gregkh@linuxfoundation.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 3:07=E2=80=AFAM Chintan Patel <chintanlike@gmail.co=
m> wrote:

> This fixes commit
> a06d03f9f238 ("staging: fbtft: Make FB_DEVICE dependency optional")

Convert to be as Fixes tag instead.

> from my previous v4 series:
> https://patchwork.kernel.org/project/dri-devel/cover/20260107044258.52862=
4-1-chintanlike@gmail.com/

This is unneeded churn in the commit message, also this patch wrongly
marked as v5 that triggered Greg's bot response. You had to number it
as v1, but now please, address the above and below comments and make
it v6 with a Changelog added (explaining changes in v5 and in v6).

> All direct accesses to info->dev or fb_info->dev are replaced with
> dev_of_fbinfo() helper, improving readability and ensuring
> compilation succeeds when CONFIG_FB_DEVICE=3Dn.

...

> @@ -364,8 +364,9 @@ static int fbtft_fb_setcolreg(unsigned int regno, uns=
igned int red,
>  {
>         unsigned int val;
>         int ret =3D 1;
> +       struct device *dev =3D dev_of_fbinfo(info);

Try to keep it in reversed xmas tree order.

...

>  static int fbtft_fb_blank(int blank, struct fb_info *info)
>  {
>         struct fbtft_par *par =3D info->par;
> +       struct device *dev =3D dev_of_fbinfo(info);
>         int ret =3D -EINVAL;

Ditto.

> -       dev_dbg(info->dev, "%s(blank=3D%d)\n",
> +       dev_dbg(dev, "%s(blank=3D%d)\n",
>                 __func__, blank);

Since you are changing it anyway, make it one line.

...

> @@ -739,6 +741,7 @@ int fbtft_register_framebuffer(struct fb_info *fb_inf=
o)
>         char text2[50] =3D "";
>         struct fbtft_par *par =3D fb_info->par;
>         struct spi_device *spi =3D par->spi;
> +       struct device *dev =3D dev_of_fbinfo(fb_info);

Reversed xmas tree order (as much as it's possible with this added line).

--=20
With Best Regards,
Andy Shevchenko

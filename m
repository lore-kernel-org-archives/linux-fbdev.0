Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F7D246768
	for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779014085; cv=pass; b=GAd8PlmDU0ZEERUbzbRD0fE0HZ3BFPoTrbxOu3tZswaFn4BmhRgc5VYcRQxDyO/T4ylBvqKUOBPPEUILxH5ITl/lUquk3dUsBuyLhjkSJFQjMOpN8i239V3IW71QCoiaByIYm9DpaF/cqzgC+/mKJ2LxXhfmygb4xABHGU+m05U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779014085; c=relaxed/simple;
	bh=nTJbFc77QasgjHvHoJgTMqvmWisdPMyl0OLuKjBSzuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPgiYhxCtdWg9AkUeU6Ctf2rs2umALFYdNVZBcbcNT012QvndE8TohDdv65qzk7EfuhOMc6UwbTlm/xMRWPsjsetkgwkeu0IBGssC4LN8pv+m/CQdsPdIto1empODSxHVL2hyy9Cq7P+rXVMz8F6yHZ68ydUsgX647sGS25R9SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcJJW2TY; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcJJW2TY"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso1249201eec.0
        for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 03:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779014083; cv=none;
        d=google.com; s=arc-20240605;
        b=XQkL5WQUWsADJkKKl35jZSEuvtIRCjE6FSLxiZc286Kg773AKsUVZOCSNPB1NqPQsa
         p4AC1TiB+oa7V9aT4xioOOzuExY+3S2bz4isro4l03jXRiKvy22cI3HISc7zXPI2I5fK
         LQVgldDYiX+yypn1vhjTSXlBNpJSGIx1WsdynuoD5+yd2LXXNZ5eBMfSXz/AE1WrhbtO
         /zpj5ULv0B8hd6tApe5LQL5FY660Xqje6ROXLLlu96HgldGg1hD5oDz6xcHK5uCScL+3
         RdFB4fk41rvVTKF2LcdOwwn9HwklAWD2rWhTmDKtnjWphmvgjIGbbTpPVFbNsZAsiTfu
         xzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nTJbFc77QasgjHvHoJgTMqvmWisdPMyl0OLuKjBSzuM=;
        fh=VPvohT7SMlXGM+L0ON0c6oNq1rKsPKyffbulPsfgsZY=;
        b=KHw8W8SN/ku8d1zsS9A4etrynt7cex+gb3jQ9SVDF39Pc8b+b55LXuVb80MlDx3b4t
         ovKwLw4+gxUggyYDpjYljStZLOEpfMWuL3QvVzyqtj0CEJD52ulXMc5PZH6AyC2B6fwm
         BYYvXpeFysc5mR3ILTDdo343ITF2Ct5RAV++qkuApKRTZTSuLlbMr3m3tihMb0Vl9mSA
         BOp8b//ZxxIdRbcpFJb2ykb8SPQ1HOzkiJcXi1fQmoDj/d4waSvJRS6StYXMK+fa1Vh+
         01uyHrbnAkuhWZmOXagr2BXirGZ9nC4f3dL4WKOxay7s0iI3Rc85iCR8TLvIVwsYYZKF
         MCog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779014083; x=1779618883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTJbFc77QasgjHvHoJgTMqvmWisdPMyl0OLuKjBSzuM=;
        b=NcJJW2TYmk9QsK4GzkxjqOBIQ7SsvqUYeBfbkpTrUHcbjLIxIUNtdkTIECFVixcjAr
         RsbRx2qlJRCuvt6/lnOjF1W1e9Kh36ZvRDOZcID+7XF469K6XV97DVe2yCqfNGAS9Bnp
         x09bP5L7iMYHWb2JYhoRRxVCkkWME1Y6WQR4hGOB8gnaexhCLJKz3F7/YFH2iuRX3XkO
         aT9gPuCbMiHGojqQJA03TQoLw2KuM+FUHy+2nTMp5L/opA44BDn4IYWOMciGESFemCuI
         6lT2S4qw4bSj+BnhUI1Z4U8qQXj0NH1ygxxi6PnE1Kb29SxliQNyxvytn5escOHKtHjj
         4j8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779014083; x=1779618883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nTJbFc77QasgjHvHoJgTMqvmWisdPMyl0OLuKjBSzuM=;
        b=QuxfZ2sEnhc08EbPHMgCkU888hkEIbUdN9pABCNbMF5HvixXUFsf67QcHHQg3m1esm
         6nv20P/o1wJhnB4aVv6uCzRWkxOCtzbpMsqNvJkrAcUy5+C2vCZxASRYRqAl8sH6pP1J
         4NMq+GxND/6pw+xQaRSA6m0i/CF5PJag+JAg5Z5mlW22ycl4xcJDxYjNOouzzWU4ia/A
         pc+BP6Vs35DCJlV+sGLNioQPEncbPs1fm8RHiF6feKno1VOmc6YSvBiqi9DuIroN24Yw
         bRVNRwOJj8Ep0k/4PNXwaYhAuYZ/UfYU3MtYZqwtI+Ip8LvOmxiSIalPcBvpHKhhavob
         xlOg==
X-Forwarded-Encrypted: i=1; AFNElJ/u9nCmdNEbRPZsYSF5XLifvNabRF8CVmhAd52n7b5I6L0UEx8nGkOZanZ2ZmDs3EFWe3yOegC7NXMBVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvU6PiBgj7dD8jWNEKBb0aw51HSDvqHoynXYMU95BmVB+Pckt5
	vYCUPmfD9HVKen5Xin6MQUm8YitYHhk4reyp5TGHTZAlsTpfPGqHr8Tf5LEKpF5RLmGBbB3dTl2
	FiuwRkB1+xDtvDE/jgk6krJBmin6BdKI=
X-Gm-Gg: Acq92OGW7JdGWfqxXzhMbUxBxg4i84AmNFJ0IyHRNGwsj+imfys+9wv/qfmv6R/n3iZ
	yA861bp0tx+rweiPWL0xrZcmYRfH4OKsuDfubWX/oOujWA6utkJAvoVk7FVrpwr86E9cnS4KMD5
	6OJAIcC9fGWFnlpd5wM6GyOrHhaPdtj4FLxdIwMvHQio+J0oKoKdOcMxl9jXL6d9g74zgQldJo5
	cIEPvynnXtUjBWjsTpZqgXlXsnYyWmY2W3oAbNq0G+WP498x3OkCIQbQ+t2KBZecynmH+hc+hhy
	AnCPBCx/4qlkdJqHsQ4=
X-Received: by 2002:a05:7300:b586:b0:2e1:e5c0:7992 with SMTP id
 5a478bee46e88-303982ac675mr4634265eec.8.1779014083372; Sun, 17 May 2026
 03:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com> <agl1T8O6kwP7SFZ1@ashevche-desk.local>
 <CAPVz0n0tfbwa1AbgO4eKrmNunHvmTFLDqXDFd1=VfLayuafH8w@mail.gmail.com> <agmWVdi3TkBb2cxV@ashevche-desk.local>
In-Reply-To: <agmWVdi3TkBb2cxV@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 13:34:32 +0300
X-Gm-Features: AVHnY4L5_rkIuV0CHLrjLCbs5l5KmhnavBVglVDy6x95ohpe8OW3F3iZSgNhyEI
Message-ID: <CAPVz0n3Kn5VVxWxCgq2EcRiOaLWnB85hD+-S2Eou=H1PyycJCQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] mfd: lm3533: convert to OF bindings, improve support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 13:2=
0 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, May 17, 2026 at 01:13:22PM +0300, Svyatoslav Ryhel wrote:
> > =D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
10:59 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=
=B5:
> > > On Sun, May 17, 2026 at 10:43:00AM +0300, Svyatoslav Ryhel wrote:
> > > > Convert LM3533 to OF bindings, add missing VIN supply, add support =
for
> > > > setting mapping mode and LED sources based on device tree.
> > >
> > > How is this being different to
> > > https://lore.kernel.org/lkml/20250218132702.114669-1-clamor95@gmail.c=
om/
> > > ?
> >
> > I have decided to have a fresh look, this is continuation.
>
> Then it should be something like v4?
>

That was more than a year ago, lets start fresh. Those patches are
gone, though I did add many of suggestions from there.

> > > What about this comment
> > > https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.com/
> > > ? Have you talked to Bjorn A and Johan?
> >
> > No, but since grep -r "lm3533_platform_data" * gives 0 results there
> > are no platform_data users of lm3533.
>
> Johan was against driver removal (while it sounds logical due to above) a=
nd
> referred to some other patches from somebody else. I think you need to
> synchronise with the people to have a clear roadmap that all stakeholders
> are agree with. With that, the split and other technical issues can be so=
lved
> during the normal process.
>

And this discussion was 2 years ago, and

"This device is used in a bunch of Sony phones and Bjorn A posted a
series adding devicetree bindings a few years ago"

They have had more than enough time, don't you think? You would
definitely know if there were any activity since you are IIO reviewer
and would be included, were there any activity?

> --
> With Best Regards,
> Andy Shevchenko
>
>

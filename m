Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672DE18C925
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Jul 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355531; cv=none; b=LkSYVvNWqGXiicw9HKDrFtRLXMWZBWs9yEMkv0qbisA/M0EIBsCoAF2J8gz++ZKhifjjVeGoPfe9Us2UxR4zuj3xdfMvaeqpfQPLKApLAkfDl+LwOfBPVWzOTkjgz0WUejBX0bbUHBaG4t5xaRwTpwjR3BQPfKXWBX8JeLn4/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355531; c=relaxed/simple;
	bh=ciJceeDlK4Y/meCsbSLF/LMnhpaQTDx0EUKSZhsR9W4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G2K6/unD51V9Qe83FdNytw7FCwdsWReYa/fP2hHbtU92CBFCiHsZHO3z8By1Uy0y5T+uUdC933FgJpa6R3dSelviO0NBIo/ZERo42F20xelRdYflhpDZBjSTfECM8rG4oRgJGpCTNyqBhZ8ttodDJBHBgfPnTehQER/FCQuwTRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=XdOCXwhp; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="XdOCXwhp"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d7bc07b7so295106285a.0
        for <linux-fbdev@vger.kernel.org>; Tue, 30 Jul 2024 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1722355528; x=1722960328; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ciJceeDlK4Y/meCsbSLF/LMnhpaQTDx0EUKSZhsR9W4=;
        b=XdOCXwhpN0yub2HlUY6AQOOhY9sYPsEVQzdax6eDLWt8kGCIkdoJ92Eexduf8+fa5D
         Zu+rztyRtF71yc/v3fPYnJOu3PhYSJnHB521bhFYC88LXNWdQzp9uUERsT/fD4oxIY/2
         04Oc64A4I8Dyw0F+OZb9Az3ROBCcdYYy5kMuAiw0WtL5B5JQwm987vaX4tLOccXLgb7K
         zjFyWwHIPo3grguRWzvI9qyy1YCwIGb8FiBiPtR0SXgxEAd/UaYFLYQmjZSD4XO6YOFA
         gbAGo1bFnFzlhfn37th8drHnuJryw78AfOitHEdeMlYzT6NHF3xzXWLDh3H9NGTFuttV
         /lGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722355528; x=1722960328;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ciJceeDlK4Y/meCsbSLF/LMnhpaQTDx0EUKSZhsR9W4=;
        b=NOPCu0g2gfkxr4vkDWFQeRidfb9TE8+ksPH5LJERyNT6IcAf+pntW75zHurtK2IvGS
         Tj96NbUaNp1YzVOdGX/d4nc9vXc56n06t+Y2TBrEHTGrlKwd57KAAYGPAi7N5cc6hPvp
         21lNDMQU3hFqNAIRAdWijRUZDwmWkv4WKBKpXwvm+Ia0Ka//xUmzTabV/+lIEjz5bYtk
         rXBsNecD0aoGz3OsLs173A1VQnCfu8zsjooZG4cZRR8V7rA62FfXM5mrksEAiZ13O6BB
         P08iJgiz0dNjNrIwYNpMMzZmtgBUx+tj6ArTrQFgrNZbA7wAVbqrNTyqHSdi93a40n5w
         SB4g==
X-Forwarded-Encrypted: i=1; AJvYcCU6OPLv4is+U0mi3If88Qjzc4RJURF0OuG8xZKMpV2pWWZuwHfJxZL17a9lOFKnMI0mBqhjA/plwuBTum9xOKMsuT6QpyQj7f+AOuk=
X-Gm-Message-State: AOJu0YwWC++blMuqy6NSYEg1A5InWXMeEretZEn6kK3L/aPpAhsBQFg5
	n7CcgJY+Rclz7lKuPphW9Zh5uFgk/ED+45mE/7E37w3mZh+mnPf2UbNtvOqskjM=
X-Google-Smtp-Source: AGHT+IEqLv3C2h4BQ+3fI7pKVhff0eutIQIkZ2jsV14fbu5lHsoFKAnZxlGiOhZ4pHufize9xVS64Q==
X-Received: by 2002:a05:620a:4090:b0:79b:efe1:1222 with SMTP id af79cd13be357-7a1e52fbb32mr1673543485a.63.1722355528312;
        Tue, 30 Jul 2024 09:05:28 -0700 (PDT)
Received: from nicolas-tpx395.lan ([2606:6d00:15:820c::580])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d745f06asm644089685a.134.2024.07.30.09.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:05:28 -0700 (PDT)
Message-ID: <2229769f3a9baf58fbeeed93fa4b0373a02055e3.camel@ndufresne.ca>
Subject: Re: [PATCH v2 2/2] media: imx: vdic: Introduce mem2mem VDI
 deinterlacer driver
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Marek Vasut <marex@denx.de>, linux-media@vger.kernel.org
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, Fabio
 Estevam <festevam@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>, Sascha
 Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Steve
 Longerbeam <slongerbeam@gmail.com>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev,  linux-arm-kernel@lists.infradead.org,
 linux-fbdev@vger.kernel.org,  linux-staging@lists.linux.dev
Date: Tue, 30 Jul 2024 12:05:26 -0400
In-Reply-To: <8aea6cc0-10bf-48b8-add9-eb3f1caa2d66@denx.de>
References: <20240724002044.112544-1-marex@denx.de>
	 <20240724002044.112544-2-marex@denx.de>
	 <5e5fba4fd6c3c0c9df23697bd328367e5fdfa923.camel@ndufresne.ca>
	 <8aea6cc0-10bf-48b8-add9-eb3f1caa2d66@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le lundi 29 juillet 2024 =C3=A0 04:16 +0200, Marek Vasut a =C3=A9crit=C2=A0=
:
> On 7/24/24 6:08 PM, Nicolas Dufresne wrote:
> > Hi Marek,
>=20
> Hi,
>=20
> > Le mercredi 24 juillet 2024 =C3=A0 02:19 +0200, Marek Vasut a =C3=A9cri=
t=C2=A0:
> > > Introduce dedicated memory-to-memory IPUv3 VDI deinterlacer driver.
> > > Currently the IPUv3 can operate VDI in DIRECT mode, from sensor to
> > > memory. This only works for single stream, that is, one input from
> > > one camera is deinterlaced on the fly with a helper buffer in DRAM
> > > and the result is written into memory.
> > >=20
> > > The i.MX6Q/QP does support up to four analog cameras via two IPUv3
> > > instances, each containing one VDI deinterlacer block. In order to
> > > deinterlace all four streams from all four analog cameras live, it
> > > is necessary to operate VDI in INDIRECT mode, where the interlaced
> > > streams are written to buffers in memory, and then deinterlaced in
> > > memory using VDI in INDIRECT memory-to-memory mode.
> >=20
> > Just a quick design question. Is it possible to chain the deinterlacer =
and the
> > csc-scaler ?
>=20
> I think you could do that.
>=20
> > If so, it would be much more efficient if all this could be
> > combined into the existing m2m driver, since you could save a memory ro=
untrip
> > when needing to deinterlace, change the colorspace and possibly scale t=
oo.
>=20
> The existing PRP/IC driver is similar to what this driver does, yes, but=
=20
> it uses a different DMA path , I believe it is IDMAC->PRP->IC->IDMAC .=
=20
> This driver uses IDMAC->VDI->IC->IDMAC . I am not convinced mixing the=
=20
> two paths into a single driver would be beneficial, but I am reasonably=
=20
> sure it would be very convoluted. Instead, this driver could be extended=
=20
> to do deinterlacing and scaling using the IC if that was needed. I think=
=20
> that would be the cleaner approach.

Not that I only meant to ask if there was a path to combine
CSC/Scaling/Deinterlacing without a memory rountrip. If a rountrip is neede=
d
anyway, I would rather make separate video nodes, and leave it to userspace=
 to
deal with. Though, if we can avoid it, a combined driver should be highly
beneficial.

cheers,
Nicolas

Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2EA13D882
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Sep 2024 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432230; cv=none; b=h6XrYvmX8n2/GT9hXz/jLzTds3PnCOOmVwqvFZodZ7XXk/b8jepgVfDYfZBj6nlz/1mvP5xZLSNwa1l9z+DizeDKjQkWWyAEZa8WQ9Y1BfTJEcRDuWGHG1JIZFKkU4U09AgFlXV7SuWsN40QmmlFxk0Ir9FioQH5FaZESez+MEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432230; c=relaxed/simple;
	bh=S3DjLInLvvJeVY5lM6aG4ZOAUryW0O5w+xi23UTFSYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=las39ioNXTNhTV6uPu3GXdwYgBJajI4q23u8wHnhYbND8vasjMzk31Md8urRKF429BuRR0gkBnMQHjr1jKD93PQIrYowyIC7w68hROrGpgaBwSeqOEm/RJdiFAF+Qt5rNSPpuYqZQr5HrI+SDytpZ8oBNU2O2xH52EjzkNTyus8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=W1Upok6o; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=sqm09y4x reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="W1Upok6o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="sqm09y4x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1725432226; x=1756968226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oZ9nwWS0YNp+mLVTCNW4ilThXDRVNQPwZwdjxyjZJOI=;
  b=W1Upok6oAITzgZecZjgrqNm3OJDLUc70+TZhyauELaGizp/hRTC9p5nt
   h1Qz5I/7kR/TyXbkQln4Z5KIHRI8biRF0RwQRAUf1cOwqJ/TbSaOLFExE
   ufc/p+ASQS1d9VukU7tU5HAOnyRwA1EL0uIEV+EtjjDSD7NgRiEg2PqDb
   02t2BQ6opZNirddaKW4/SfoXIEPHZ1cQxWzQzh7tytSFtgZuM+SqhNQNL
   kXiF9lT4XYvt720YHRQ2i7yUJYbpi1ABRqJ0fwvL8RX7fKaZavbrhaapO
   Co3z8nbUfmSuvk/QNuTj1fjpej9yTNo7GWbOH4EMJ7LjyTET8FbxHnPI2
   Q==;
X-CSE-ConnectionGUID: 22/jB1P2RaugFwhcH9Cz1w==
X-CSE-MsgGUID: XrJmGhVAQpOOxVKlTo+xmg==
X-IronPort-AV: E=Sophos;i="6.10,201,1719871200"; 
   d="scan'208";a="38751339"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Sep 2024 08:43:43 +0200
X-CheckPoint: {66D8019F-1D-6568578B-E2E34638}
X-MAIL-CPID: 86606A6CE1EDE36F4DC495A0162270C5_3
X-Control-Analysis: str=0001.0A782F1C.66D801A0.001F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 871F716532F;
	Wed,  4 Sep 2024 08:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1725432219;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oZ9nwWS0YNp+mLVTCNW4ilThXDRVNQPwZwdjxyjZJOI=;
	b=sqm09y4xUTNuMAKS9iPLDLbyeU++muVKRGmAFKz4ma2XrogufJCdKCnOuUo5ZRsAQDjERb
	KuiPJjVLU+7tt+n7DBbxOD8y21IQaq59iIixYqVCsGo5veZjsJxyKhJmJi5ScDNO+7ohDk
	Nmtl96N2q7+0UrJOn21wDBrcCU5TdWNcTdE8ITkg85wgk4xiBB8hMI3v10wad07BiQt4g4
	srP9a+B9TEWUXUCl2xap0Perx53GQcEXC1W1gy0BV0qSINTi4sH/3THUsk4qJtJpMxSDpq
	Acj4U1Y+2MArPvLzt2irRe9GoZwFqTbjcVbYEOnNcGVD7GiLM1dodhLuBvpyDw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, javierm@redhat.com, deller@gmx.de, airlied@gmail.com, daniel@ffwll.ch, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 21/43] drm/fbdev-dma: Implement damage handling and deferred I/O
Date: Wed, 04 Sep 2024 08:43:37 +0200
Message-ID: <4596037.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CACRpkdbJEv7pV_LOZO_2s_otSth9EYM7=fH9VPgxUyPom_BZ4Q@mail.gmail.com>
References: <20240419083331.7761-1-tzimmermann@suse.de> <12510239.O9o76ZdvQC@steina-w> <CACRpkdbJEv7pV_LOZO_2s_otSth9EYM7=fH9VPgxUyPom_BZ4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi Linus,

Am Mittwoch, 4. September 2024, 08:36:46 CEST schrieb Linus Walleij:
> On Wed, Sep 4, 2024 at 8:09=E2=80=AFAM Alexander Stein
> <alexander.stein@ew.tq-group.com> wrote:
>=20
> > Can you please check in which memory zone this VRAM is located. In my c=
ase
> > it's important CMA is located in Normal zone to trigger this problem.
>=20
> dmesg says this:
>=20
> Reserved memory: created DMA memory pool at 0x18000000, size 8 MiB
> OF: reserved mem: initialized node vram@18000000, compatible id shared-dm=
a-pool
> OF: reserved mem: 0x18000000..0x187fffff (8192 KiB) nomap non-reusable
> vram@18000000
> cma: Reserved 16 MiB at 0xef000000 on node -1
> Zone ranges:
>   Normal   [mem 0x0000000080000000-0x00000000efffffff]
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000080000000-0x00000000efffffff]
> Initmem setup node 0 [mem 0x0000000080000000-0x00000000efffffff]
> percpu: Embedded 15 pages/cpu s39052 r0 d22388 u61440
>=20
> So at the top of the normal zone at 0xef000000 as I read it.

Okay, so it is the same as for me. It seems you don't have any HighMem.
On a different model having more memory there is also HighMem available:

[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000010000000-0x000000003fffffff]
[    0.000000]   HighMem  [mem 0x0000000040000000-0x000000004fffffff]

If I explicitly configure CMA in HighMem I don't have any issues.
But the 512MiB models don't have enough memory for fixed allocation in High=
Mem.

I was about to send a revert myself as I didn't get any feedback yet.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



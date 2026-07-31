Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0F2EEE9D
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500367; cv=none; b=gJAx/aaGXyHpCxE2xkqWF5ykU5VRwOApRRY0gzVr0GXsOG8PTkgw5+zYuDwAsDjH1FX7XO23Kqbg3pdRp/t81u1acuyeid4Xw+mijtyq0LkPkPcbBo3cJpgENGcJc5bgP8x4YS3sbcss0lN6aVWHsXTuNq60ti2cFsfIgfLIkNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500367; c=relaxed/simple;
	bh=bnhNzO3Xy8mHR74f90xbWQJw1wFb5MM+YbuZQoS3mcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1hdtDXDzu7xeZmoCvX0GdZywB08bCg7SF+WMnx0VLviNiZaB15AqoBODd6fK3CEVIvMn3+l3xx9a5X6BKiLof34/cQA4HzsnS4hfnNa8hJD727XJLGneVoEO4YiKfNa59TpaiFT7KreUthhscd1wlTqKh3PQkQH7Pb8TKMK2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=Dn7giSnF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Dn7giSnF"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so901208a91.0
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 05:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785500364; x=1786105164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hRCEkgyL5maguOe88SdUQWVzbN/lQncmrY8r9dbt88k=;
        b=Dn7giSnFmIKEd1VNEBCiA4tlz7hncM8DsgvDVZ6aJovIz2wBKWTDmj5sCe4FeChWoG
         UrlEgZ9F93/2s6Cp72/foARs5F7PD9HClUxndReV0xpfiJoR0WB+t3dmlsJiU+o/AfNI
         GPIQxvwgloovNHFqIP7UEzN33CzAR3WEqlFfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785500364; x=1786105164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hRCEkgyL5maguOe88SdUQWVzbN/lQncmrY8r9dbt88k=;
        b=l9bhLLDK3SG/mDbG+pLKXuW5f3LfvsTBkeKjyuRbFtAsYFA0l/RGAFrgeHHoRBKMGE
         dC6m8Ly52BCYEbSEDW/tuUxDuZXGNYS/AH6tS+pJYcjlCdrsH8czZTU/pp/GnOE6oard
         RszkmmKH4a0W25il+Xr+5ixcY5yFO0Ju2Dvh7pfmVzKzthzgw6zn0Q2UIjfbAp/PZeix
         1CVwJgLGTLC3YIqTTlvMAHggHExSHmOdjyR2Z09wL/G9KE+n9y4zXtD5HTH6r55xU+U6
         5LnrEyF2fgMwAKccoLQqxzS0JBnEd5bEJZrchAW903lMdnnces2YLD7zk+cvFbMaxkhK
         Vt6A==
X-Gm-Message-State: AOJu0YzEfAn9Y4oSiHeKA6BL85oNmhg1YLcoaftUY05CloU92Lzh14F3
	/x/6YfZCZEri6d+VS1JQUp26/pKaoNugXpwXzOArE9HakzanbdyBW/yj/uXCeQdqkO8=
X-Gm-Gg: AR+sD13vsqZzGbY7VVnTNz5qxFKC2aR/G9ooNhmxmpXTYatZnRs7bKJkLXipGV7lzuN
	cNpK5M+mHb6PiYLjPz9svaZvsZsitl+XlqxPOmq7x+UYODFuMDnZjoRFPKplSvVcVLIi6Zkjx7Q
	rJSwGpXTguqM+xG/fRABWvxhcfWRuNnODlRiHBD0Mns1kRKGUHin8pA1Dx48rrcTLI6Z7AGSAwG
	ZJYBnDD/J+3w6qPWO30zIvAtKsqkcwYsZQPMomZJPOAlziZLjqMJMyaOmCBQr3d4PniIjDn3bz7
	aruDKPUCIoiAA0Vgls2vRWONtB9EA6uOa2c6LL9Q+21JERWDnZ9zQA1yAOfntU32EC6xf06ow5N
	pTXq/jljpFlOKjuZ2CTpyQPff+7VB16eiw1RJY1tORziiiBjD+mIaQ3+SbnbzOKW0FCzdlVNknJ
	6GQeA2dMneTT0oZLFvLMxci7rNR/dsOoDJ2onKQTkilyXEIzTNW5A=
X-Received: by 2002:a17:90b:5290:b0:38d:c0f9:30be with SMTP id 98e67ed59e1d1-38fb1429190mr1671305a91.38.1785500363814;
        Fri, 31 Jul 2026 05:19:23 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:77cc:841c:1fc1:22d4])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-38fb2b8c5c5sm321981a91.4.2026.07.31.05.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:19:23 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 0/5] fbdev: tdfxfb: Make "unbooted" cards work
Date: Fri, 31 Jul 2026 21:19:09 +0900
Message-ID: <20260731121915.3362232-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently voodoo cards that weren't booted by the video BIOS aren't
usable because the hardware is never brought up.

This means if you happen to have a proper - non-x86 - computer,
another card is the primary or you have a new BIOS that cannot
run the video BIOS tdfxfb would probe but you will be staring at
"no signal detected".

This series implements manually booting cards using the
values from the video BIOS' own table. Currently this only works
for the voodoo 3.

Debugging was partially assisted by Claude Fable 5. I could not
work out why this would not work for months so I told it to
create a voodoo 3 emulation for QEMU to compare the BIOS against
my code. That made it obvious my init sequence matched the BIOS
but the VGA core wasn't running.

This has been tested on a real voodoo 3 in an x86-64 board and
an Amiga 4000 with a mediator PCI bridge.

I have some patches to add an interface for doing 3D rendering
that are not included in this series and 3D rendering is also
working so as far as I can tell everything is good.

v2:
  - Fix up some poor 3am English mistakes in the cover letter.
  - Limit this to the voodoo 3. The BIOS layout is different
    for the 4/5 apparently.
  - Fixed the valid sashiko complaints - mainly clearing the
    framebuffer memory before fbcon might have bound, retaining
    the current behaviour if we can't get the video BIOS to get
    the config parameters.
  - Tweaked the wording of some of the commit messages.

Daniel Palmer (5):
  fbdev: tdfxfb: Add helper to read config table from BIOS
  fbdev: tdfxfb: Attempt to detect if the card wasn't booted
  fbdev: tdfxfb: Manually boot unbooted cards
  fbdev: tdfxfb: Wake the VGA core before programming the CRTC
  fbdev: tdfxfb: Program the initial video mode

 drivers/video/fbdev/tdfxfb.c | 155 +++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

-- 
2.53.0


Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D5F3B4E87;
	Mon, 27 Apr 2026 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284873; cv=none; b=HIPBy2GYEkaNZCBx7pyfylirXwT/TSnNT2YoVMuBNbtq88cs0TtkDccir9Lddr7zREbM9/7fdDUouCsLBZ55reAYyceZ9oJF0xojLxhGKSJKFk5fcOYXGMxu+tGJJmZElajva8W2hhQXswx1KkNlfcKSIpBBCGAfbFys1HRzZBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284873; c=relaxed/simple;
	bh=EwGmzFPqzgbncknvZivMRZbDi0fNWaa/Sli5xc1kWf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tW/GDWoJRWNW+dlFtZqSgj1+QKgLEYO5I7ydzpZheagIvjXfUHEAVVwCS4MY4sQ6GCt5LRMzqsmkNOLn2Tij2V6v2Y9J+ov29JnegxEXbeb2NOl1I4wRiEHSGSBXomC46MYcgh8tZH92lMVd6voDOmenqDcHIDcAY0W8EGsKapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dbb47b66422111f1aa26b74ffac11d73-20260427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:42a87919-8872-4d14-b715-ee17e98e16c3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:fbda4651c2406ebcf9e57774bb9946c3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|83|102|898,TC:nil,Content:4|15|50,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dbb47b66422111f1aa26b74ffac11d73-20260427
X-User: aichao@kylinos.cn
Received: from thinksys.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1929850333; Mon, 27 Apr 2026 18:14:21 +0800
From: Ai Chao <aichao@kylinos.cn>
To: deller@gmx.de,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux@armlinux.org.uk,
	dilinger@queued.net,
	adaplas@gmail.com,
	James.Bottomley@HansenPartnership.com,
	FlorianSchandinat@gmx.de,
	alchark@gmail.com,
	krzk@kernel.org,
	kees@kernel.org,
	rene@exactco.de,
	tzimmermann@suse.de,
	rongqianfeng@vivo.com,
	thorsten.blum@linux.dev,
	chelsyratnawat2001@gmail.com,
	soci@c64.rulez.org,
	gregkh@linuxfoundation.org,
	daniel@thingy.jp,
	linmq006@gmail.com,
	fourier.thomas@gmail.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-geode@lists.infradead.org,
	linux-parisc@vger.kernel.org
Subject: Re: Re: [PATCH 03/35] fbdev: sisfb: Use safer strscpy() instead of strcpy()
Date: Mon, 27 Apr 2026 18:14:17 +0800
Message-Id: <20260427101417.2199601-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Helge
...
>>> So leaving it as strcpy() is fine - and possibly even better.
>>> The header files might get changed to error strcpy() unless the compiler
>>> knows the source string has a constant length and the destination is
>>> big enough - but that hasn't been done yet.
>> 
>> struct sis_video_info {
>>      char    myid[40];
>> }
>> I have rewritten the code:
>> strcpy(ivideo->myid, "SiS 730-0123456789abcdefghijklmnopqrstuvwxyz0123456789");
>> Used gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04.3)
>> There was no compiler warning or error.
>
>Sure it would
>But the compiler issued a warning that the string is too big..
>So, such places will be detected at compile time.

gcc-version: gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04.3)
aichao@thinksys:~/dev/linux-next$ make W=2 drivers/video/fbdev/sis/sis_main.o
  CC [M]  drivers/video/fbdev/sis/sis_main.o

There was no error and no warning.

Thanks,
Ai Chao

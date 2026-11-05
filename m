Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909545;
	b=zg2M7I38mT++MPdsCjH2qTEutRf2Ne1Mc83D37E8tjChVQAYMMZ4ARvsiqvt/I3FWnuj
	 pxZIC8oi8IM/2wIu6qqhyWgskY/qH2RqtsPaUPuthV33DeJGOF3gewsGvVRZhq6gv19eM
	 EqxSSajoPQPXU9OZCIyzNmNfPCEgCwBdtvAixod4/46x4DAKhUAdRP56WGVUVIeo8LOgs
	 ytRXilH/LHRRMmGswMvAv/3uHm+cnUCJWIKCiKqUSDzXArFl9irCySeQ53nIbngimdi3U
	 XLLSQInQr8tZlo/CupN8gtGKJN0gAOIpBaYeQ0w0W5oTNBfk1EYdrGDSUQiCQllD2qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oj4+ZYy6IPmEk7n48ZoOfVMyHB9K5zKwdNLmj5eS60A=;
	b=DtUOIX1rvSUglCoF/0sOZCSlvmvTk+RUBDNpS256fxLgXbZTs6DoylhfIQu0kIovEJ4z
	 BuJiLJFniYRd1EAjXdXFso1FpHLVjzWA6XJTInHZSsgNXTwkIQAdcp8DkTjfelVxxiqMz
	 K0a23mC087q5Fe5IrCmPT+aHQgyaxx+dEoJBOQd18byMuN1BgO/uma0JZ8/c1xbHkzsg6
	 biyUwQEXL6x0um3fJ+pQIQJggE2dlcwDJ7+c0xgw6lqIoTeFs3DFQziakJBL+E01RdhIo
	 hB3yNZl4yKSKfdaocu4g53CX7t/DzYy+uSoUD7yO6J/PX9IG5Xb/P92RGNgQse8mjOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJW1RlPT;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7966A606A32C
	for <linux-fbdev@vger.kernel.org>; Thu,  5 Nov 2026 20:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7966A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJW1RlPT
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so27665455e9.3
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 12:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793909544; x=1794514344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oj4+ZYy6IPmEk7n48ZoOfVMyHB9K5zKwdNLmj5eS60A=;
        b=WJW1RlPT4nBYc85BjmKGFu2S3pNJc9h7p7KxVzEu5ni8QwEhD6AZYZE1PHvNpvssVy
         C5+q+IbtF7LYPXEPEBRaZkzdujhWyQ0fUe4f5Xz/c5Vqe9MDfRDZsDQt8IHtK49XKXLI
         ae8sWtCDBYWI/5gseIUrC/+ZUjLbhQdgHuNQefnHAPOH+81+q7amXVCwCXPYDNrtW2sc
         n9nLehpHgJ9SuJU8R6QuJDwXGiC8NpgU21mQc3O/SLnA6J1YXqXkQEA2Og9BpDp3KDq+
         xEbiyGKqj+IBXKZBJU/daPFdn9kSiL/PN4Gn9LkJCkB4ihpud59kUVf35uGxaQaScdSC
         pbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909544; x=1794514344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oj4+ZYy6IPmEk7n48ZoOfVMyHB9K5zKwdNLmj5eS60A=;
        b=Uy/6YVia2vN22gOD58K6S8BhmnNpvgrjgoAZT0zR32IbhkxgxTX/8aY3WdiboYX1w3
         xEQJwTgrwAHa0/DP145iaFT4pIlYMwtj1MPuXRz7xmn5EveGsOrPL9QIqcrN9kJ0Z2mD
         pzShBfWq0yYQEvIcHGi98snPzZwXOYtUWWTGMIc++ufRtWf08JFiUM1W3oLRP4YKm/G5
         w9TXVmT/mAU6IoE5zP9cx3TthCSIG8iIexeXfjdofsoJoBqzh2LzvIXeDKN82O2G/Oip
         qWfB5u+JDKVhCybfLaBOn1hHEFn228LS783wMj28ssP805weZpkFBwxicTGg4jAms+Uk
         Xkuw==
X-Forwarded-Encrypted: i=1; AKwUvBxUmJP/O+wheLgD3id9cqdM8iGeLZeKjFrI5ENqD6IjT7HmNOc8rmU+0AzhonMHTAMStdrSTS71sgQGqQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+nyexyCQhNe2ure3S28DbrWsrwFYtddjI22xjkipCPckfPQLSc
	V9+caROdBFYZxIhbnIjPUOhNbelA5ZW1UqRikb2GR5Ui5THESTYMYzI6
X-Gm-Gg: AYBFou1a0erPAxJNonk+rixrHlj+qzzfBkATW2zrLJLIMjz/Eh4tBmVZQrsbFNotFuJ
	7ZnL/+vxrpJvm/zpwEm98/pUZ71YrDsfnGv45LxjTlpkZcPdNtcCLc7S2Rm1qGhdPBJEOt6o8eH
	plWuqfb7O3FCSiHGNthp5ERFMKIAP1DGJ/oJMUSLxR0zUHUa+AKIaXxt5gA1D8+MxEaSWdMlfhD
	mxSvcJ9XTanIqCPvsmDfcWXlusgZshsF1V5UlnIwMMXIafn6L6zoPhkuf2FuBsDDRno8fTBiJxw
	ckOivOG5EY3zlZ3TGMbHz6zXRVbtJe2w5Rz/lTpwaAu0oAHix9SBbhQvsOxGzYRxvcxMLOhsdzT
	lEejL7ulZdA19SVepDgEbX/zfzkl7AoTiChbmOxwrVeTGyLpTHxa53qdkd57loVRseWMSCFbDrh
	6db34inmeFBtUEF6nqItb2IVOg7aG74fJFFKxstUIke6+QtX+bjAofioJhrJciNkzqZ+vnJyMwI
	B7n+1MSYDfkOWmGd3vwrAYpfG2/+SgvRj0JcHfHkn5j8hjfcUC8T8T0PsQGy2nGVPDSDGxHj1EC
	7sxK8u1eM1msk8iMKvmBogz1NoBNa4Z6GC/PHXH7iXadIitvKUcnOzg=
X-Received: by 2002:a05:6000:2dc9:b0:48c:7f18:c85e with SMTP id ffacd0b85a97d-492778d2076mr1325704f8f.45.1793909543495;
        Thu, 05 Nov 2026 12:12:23 -0800 (PST)
Received: from localhost ([82.77.126.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecac1caesm11108369f8f.17.2026.11.05.12.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:12:22 -0800 (PST)
From: Daniel Matyas <matyasdaniel006@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Daniel Matyas <matyasdaniel006@gmail.com>,
	linux-staging@lists.linux.dev,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nam Cao <namcao@linutronix.de>,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [RFC] staging: fbtft: Moving fb_ili9341 (and others) to DRM
Date: Thu,  5 Nov 2026 22:11:53 +0200
Message-ID: <20261105201154.37294-2-matyasdaniel006@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I'm looking at the fbtft TODO (convert drivers to DRM) and want to check
whether fb_ili9341 can be dropped. Findings against v7.4-rc1:

1. fb_ili9341's init sequence is the MI0283QT-9A one. Comparing register
   writes with drivers/gpu/drm/tiny/mi0283qt.c, the values are identical,
   including the default gamma tables. Differences I found:
   - mi0283qt writes EN3GAM (0xF2) = 0x08; the fbtft write is commented out.
   - mi0283qt always sets MADCTL BGR; fbtft makes it configurable (bgr=).
   - fbtft rotate=270 also sets ML; mi0283qt does not.
   - Rotation maps as DRM rotation = fbtft rotate - 90 (mod 360).
   - fbtft also offers runtime gamma adjustment.

2. fb_ili9341 registers the compatible "ilitek,ili9341", which is also the
   fallback in the dt-schema binding, so it can match nodes that the DRM
   drivers claim via their specific compatibles.

3. In-tree users: no defconfig enables FB_TFT. canaan_kd233 (62363a8e2f56, Feb 2021)
   has a status = "disabled" panel node compatible with "canaan,kd233-tft",
   "ilitek,ili9341". It predates the first DRM driver accepting ilitek,ili9341
   (5a04227326b0, Jul 2021), and none of the DRM drivers match canaan,kd233-tft.
   fbtft requests "dc" and "reset" GPIOs, which fits that node. I haven't tried
   binding it. I suppose that, if the board is used, then it is built against the
   fbtft driver.

4. fb_ili9341 has had only style/mechanical changes in recent years.

Questions:
 a) Is removing fb_ili9341 acceptable, pointing users of other ILI9341
    modules to panel-mipi-dbi? The KD233 node would then have no driver.
 b) Or should KD233 panel support go into a DRM driver first? I don't have
    its init sequence or physical size, or the board...
 c) Is removal of all of fbtft already planned?
 d) Several other fbtft drivers have drm counterparts. Should I inspect those
 to see if removal is needed?

I have not tested on hardware.

Thanks,
Daniel M

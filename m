Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C472B1A3178;
	Fri, 18 Apr 2025 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965805; cv=none; b=FbX2uj0KSzDBsWGsgXkcF5wStfyr0t3p0oPkM6jGGfE1XPQnQNVjc5OS4Ig8vltN/uYHN27eBkKqXhwidml0qk4QlRVARiarzr1p/wOrieHY+GYdByXPahdmHPO4/pKKPK4e1u/+z7wzX38sttuXPNXA8AI5WtnuPMu7tZOpeCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965805; c=relaxed/simple;
	bh=lmorddFDclvs7FCXPtABeuLvxJT51WRtU07RGNBL0bE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rlMvjM4xwglN4OsRTxEJD3vdIj/QG9KN/ts8tgG2raYD113lk3aNed4OooFt83YL1s3Bln9QILQ5KeNC/8sDvHZPLdpOq4zdk65CAfAfAG2H9wubj3muEyXYs/yZPxtHZjVK0BaNMZGLfohdaDH1ouI67WL6wHtqMttYyQy+kfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOf/wvse; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOf/wvse"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 371CAC4CEE2;
	Fri, 18 Apr 2025 08:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744965805;
	bh=lmorddFDclvs7FCXPtABeuLvxJT51WRtU07RGNBL0bE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nOf/wvse+bmFozGioOWKP21tl7DRKepWw6PCaF1qQKe/+xv/z6YSRSNllixlAsOIq
	 +w2lqk8savQ4Nq0xyiqEjEPuIsXCjeTtggebh4N4aPfxR3wV85fEkcd2LGdNsTWM3z
	 ZNL5apMZ8V9PPkNiBClAmmN3HGXukpej4z8dvan0SRHaeMiiYVqqNV0GLdw4JoTep6
	 pNkeo4j+05K64mYBeOrfKeiqorDhJyadXLXF+E4syr2xJpvM64eNXh8BY5P3ZFnjuD
	 bS9QpT9vzB1ltBk40lPc93FN8g3S3fqVRqSxw9C24QGbSPYJ9NrmNjIBleFhMEdPGU
	 fZxxtd8m+2p7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E45C369AB;
	Fri, 18 Apr 2025 08:43:25 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Date: Fri, 18 Apr 2025 10:43:22 +0200
Subject: [PATCH v2] backlight: ktd2801: depend on GPIOLIB
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250418-ktd-fix-v2-1-cf3d19bafc9e@skole.hr>
X-B4-Tracking: v=1; b=H4sIAKkQAmgC/2WMQQrCMBAAv1L27EqzNk3w5D+kh2pWs1SakpSgl
 Pzd2KvHGYbZIHEUTnBuNoicJUmYK9Chgbsf5yejuMpALem2Uwqn1eFD3mhGzdrZXpubhVovkav
 eT9ehspe0hvjZx1n97P8jK1TIpiPtyJyot5c0hRcffYShlPIFEY6HN50AAAA=
X-Change-ID: 20250411-ktd-fix-7a5e5d8657b8
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451;
 i=duje.mihanovic@skole.hr; s=20240706; h=from:subject:message-id;
 bh=NvkEKW66oVkFED6cl1L9OEBr+ZdxEWUqxuIzm2YmzSg=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlMAmvM9CdPb+m7JZzJc36l/CX7loglnypbg2edbVi5o
 1iaJ+xTRykLgxgXg6yYIkvuf8drvJ9Ftm7PXmYAM4eVCWQIAxenAExkUhEjw5fgD3Hzz0zc8MLo
 gWtc3Zd6Zra5ec9b9pWYbhY+WLi5ZTvDX4kC5SNTFrFKbpFLqiif6btkr6KWmuOhaRyi+akfKnp
 usQAA
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Endpoint-Received: by B4 Relay for duje.mihanovic@skole.hr/20240706 with
 auth_id=191
X-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Reply-To: duje.mihanovic@skole.hr

From: Duje Mihanović <duje.mihanovic@skole.hr>

The ExpressWire library used by the driver depends on GPIOLIB, and by
extension the driver does as well. This is not reflected in the driver's
Kconfig entry, potentially causing Kconfig warnings. Fix this by adding
the dependency.

Closes: https://lore.kernel.org/all/5cf231e1-0bba-4595-9441-46acc5255512@infradead.org
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v2:
- s/Link/Closes
- Pull Randy's tags
- Link to v1: https://lore.kernel.org/r/20250411-ktd-fix-v1-1-e7425d273268@skole.hr
---
 drivers/video/backlight/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index d9374d208ceebbf8b3c27976e9cb4d725939b942..37341474beb9982f7099711e5e2506081061df46 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -185,6 +185,7 @@ config BACKLIGHT_KTD253
 
 config BACKLIGHT_KTD2801
 	tristate "Backlight Driver for Kinetic KTD2801"
+	depends on GPIOLIB || COMPILE_TEST
 	select LEDS_EXPRESSWIRE
 	help
 	  Say Y to enable the backlight driver for the Kinetic KTD2801 1-wire

---
base-commit: 01c6df60d5d4ae00cd5c1648818744838bba7763
change-id: 20250411-ktd-fix-7a5e5d8657b8

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B312326ED25;
	Thu, 12 Mar 2026 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349322; cv=none; b=NYp4FoOtQp55ypmFS1O2telXbtkvbPO76zkczmDHCO0ipNEgYwZUbKMDPEP7MKScpKzySYaPB+bta6pb1heQyvxi7602F40bt8pWwupPG5A1t4FSpy7dzRX61F42NDYGf187n0tHXA4adDVNXkqroqgVgAG72ctXPVkqBeKxUvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349322; c=relaxed/simple;
	bh=gPy5B/84GswJ33DdF4BraPNfAjU/zsG5oJbx24QJs/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lV5B0oobcAXGRZLj9lJZ/FMGMxDizMwfIudBUCTCDu9gPi4yNU0G26qiXE4Jp6JN6BcuFjf68p3MnYwV32FLVmNUrm7dFwAuscTJAEJWaf7gt7uVvnHO/UopgONqIUXwyOuCYkMzo/4pVBH02GwGhRx112Zo/VCVgKOab2/v4b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jumpstation.co.uk; spf=pass smtp.mailfrom=jumpstation.co.uk; dkim=pass (2048-bit key) header.d=jumpstation.co.uk header.i=rob.github@jumpstation.co.uk header.b=PoBIT30U; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jumpstation.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jumpstation.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jumpstation.co.uk header.i=rob.github@jumpstation.co.uk header.b="PoBIT30U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jumpstation.co.uk;
	s=s1-ionos; t=1773349303; x=1773954103;
	i=rob.github@jumpstation.co.uk;
	bh=V9Jz4M+Z9QN56aIB3snMb32hgRyUtBNNksRT8e1ZYxQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PoBIT30UGEFyrSl1oauOpUQlI4O9ivtH4FqZhtYS1mPTiJ73Lnrdd9qeYQZahoCW
	 UIwzwYhw76tmthNvjokJknzysTc8vLE6QCuzmTRLSpNwG2a7vp8V+odHd8FdtIzsr
	 zzEkHjIEGK0c8wt7QRy8l5s2VofrZGwzg5eaVz4mvjH2rtQnkRfdlQvsDP2tjxzRE
	 dgVVvi4R48cRAmxgMaMkZU4Dm5c++d0KilAKPHpeah6kOl2/0Gfd5+LT/AuuNrDN9
	 JxH4TgI+aGoKrU/FriLYSfs99XAiFoFxZwb7h+WoAvlxyV6xn7BMFMBJeKYB+Znkd
	 FGYnpEMLR9bD6MPW0A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [212.227.15.153]) with ESMTPSA (Nemesis) id 1MYvTy-1w5F2h3Aky-00YwXR; Thu, 12
 Mar 2026 21:55:39 +0100
Date: Thu, 12 Mar 2026 20:55:07 +0000
From: robgithub <rob.github@jumpstation.co.uk>
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-fbdev@vger.kernel.org
Cc: robgithub <rob.github@jumpstation.co.uk>, Prasanna Kumar T S M
 <ptsm@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>, Michael Kelley
 <mhklinux@outlook.com>, Sukrut Heroorkar <hsukrut3@gmail.com>, Randy Dunlap
 <rdunlap@infradead.org>, Mukesh Rathor <mrathor@linux.microsoft.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: fbdev: update outdated help text for CONFIG_FB_NVIDIA
Message-ID: <20260312205507.70b9013b@hexa5>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/yGBOsdgxZKPDmDkoTfe./G4"
X-Provags-ID: V03:K1:m4dxKb2C/lhZ6yoYeupD2qV4gdJy+SHNHiOBkdjEWEM+AXGZQdf
 Dd+MLdHQ8sIBriWhNWbrrNvgibU7MqoW81ArvXzay0of27YKPh5qQ1KYlShh3QE0fSWcmpb
 Oguyfcr/kzc9VmB3ec4eF2R9iSvnrikB+Q0Ja6lEDXgP/rFNPXYRyIEdyfck4nKGsfxhwOU
 atvldWUXkwgLWf4+YXY+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kdXYFJvUeWY=;kcXWZdYCSmujfv6pfMLcVnUXiTK
 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
 ptli1zPKX6YaDhqZyvS1/GPk/SROI=

--MP_/yGBOsdgxZKPDmDkoTfe./G4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The help text for CONFIG_FB_NVIDIA refers to obsolete hardware and
incorrect default behaviour. This patch updates the description to
reflect the current state of the driver and supported devices.

Signed-off-by: robgithub <rob.github@jumpstation.co.uk>

--MP_/yGBOsdgxZKPDmDkoTfe./G4
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=0001-fbdev-update-outdated-help-text-for-CONFIG_FB_NVIDIA.patch

=46rom 688a061ba0db71fc2d5facd8344db7a4d5b1575a Mon Sep 17 00:00:00 2001
From: robgithub <rob.github@jumpstation.co.uk>
Date: Wed, 11 Mar 2026 22:14:43 +0000
Subject: [PATCH] fbdev: update outdated help text for CONFIG_FB_NVIDIA

The help text for CONFIG_FB_NVIDIA refers to obsolete hardware and
incorrect default behaviour. This patch updates the description to
reflect the current state of the driver and supported devices.

Signed-off-by: robgithub <rob.github@jumpstation.co.uk>
---
 drivers/video/fbdev/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ac9ac4287c6a..d8e331427443 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -668,10 +668,10 @@ config FB_NVIDIA
 	select BITREVERSE
 	select VGASTATE
 	help
-	  This driver supports graphics boards with the nVidia chips, TNT
-	  and newer. For very old chipsets, such as the RIVA128, then use
-	  the rivafb.
-	  Say Y if you have such a graphics board.
+    Supports NVIDIA GPUs from TNT through early GeForce generations
+    (NV4=E2=80=93NV2x: Twintor, Twintor2, Celsius, Kelvin).
+    Later architectures (Rankine and newer) are not reliably supported.
+    If unsure, say N.
=20
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvidiafb.
--=20
2.52.0


--MP_/yGBOsdgxZKPDmDkoTfe./G4--

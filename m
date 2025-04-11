Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388B3230BC1;
	Fri, 11 Apr 2025 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392144; cv=none; b=CnydrLxy/uX6+iiuPQgVw16uo4nwJki7y5GBS+JoiLjMOSBCu8k+ZuMkn6RHWceFtYy7R5o6rkEp/tl7y2/8ZdHf66ZwrCmr3wEvjfH1Px6NXBkDR01JIB+FeVHvE0a/6s1nDkmXbTLBTJpZS7S/xNJjxNmjF8G6yfX1jiv/AjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392144; c=relaxed/simple;
	bh=OwUuupjd6ppxMTNlxFAWEzXqt/lV2dBlXne2MEl+yEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KdaJAJEwcfi1E+Ct/l5do9f5MHnJUBPv32Q79WkWgYmZePrBbSCahLOxeA+X5D/fq9O1WTI5ZkQlXZ9fO+HxMS7l4vu7BtLf05yLp0ZbYh5hBss+DiJmH1YY3/lF0NzrT02ivU8DTI434XlwDxxO9GqgZDYSKCnsduJPE7eyzjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hp4lgkTF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp4lgkTF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99D5EC4CEE2;
	Fri, 11 Apr 2025 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744392143;
	bh=OwUuupjd6ppxMTNlxFAWEzXqt/lV2dBlXne2MEl+yEE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Hp4lgkTF4orD504lFUgF/nynv3WBTyAhENsarLQSp0Omh2Ghzk5kBeoZ9mV5V7piU
	 WnUBipeBgrCc6pfi7GE6xLPtY+qwwz+oaKNtj0PMVfd3QVL3GPkk/tQ7bNOG6uc1Ll
	 CgJTWq8G3sZ7vHh/sls/6jFbduRV9KQkPIULzcH6CRO2hE94vAQvIfHUcQYtZts8+i
	 1nLCN6IALVeTkiyyHrzTSgqYUFGE96/JeFsCyIx9ehW/CiPpN/XCUsbrQsbh8IbfKe
	 IXnr5H/1qE8IGgD7tKugBmz2AKzCORCuj3YRA7Y9TkMcngveF50PMQ32FIHDEMFUNk
	 l5imcS9X+TK6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871FDC369AB;
	Fri, 11 Apr 2025 17:22:23 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Date: Fri, 11 Apr 2025 19:22:18 +0200
Subject: [PATCH] backlight: ktd2801: depend on GPIOLIB
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-ktd-fix-v1-1-e7425d273268@skole.hr>
X-B4-Tracking: v=1; b=H4sIAMlP+WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0ND3eySFN20zApd80TTVNMUCzNT8yQLJaDqgqJUoDDYpOjY2loAP6Y
 vb1kAAAA=
X-Change-ID: 20250411-ktd-fix-7a5e5d8657b8
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157;
 i=duje.mihanovic@skole.hr; s=20240706; h=from:subject:message-id;
 bh=3jhAi95ad/Pq/CAnIxFn10PecnGB9M4btMKtmLNxZjw=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDOk//c+9yV+Rt06Ib7nb1FUL2uax6eh29s5ckHS1ROldc
 ZP1dX/1jlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZiIkRPDfyfbZyuP37/vcWSO
 wPaCJP0fes1NbZ1X7lg5pszwaHz1aRojwzyjo1mC7DNEEjUZxOTzqz6XF7yPvGd6MVHQsPFbbI4
 pDwA=
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

Link: https://lore.kernel.org/all/5cf231e1-0bba-4595-9441-46acc5255512@infradead.org
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
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



Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4037FF60
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Mar 2026 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640387; cv=none; b=N9y4RxycG2WgvuB78/+PJsDDwFEv1755vUtDJxCk1vqSKTTRs2ZF8SHw/tnb8HL6btXYu/sRgwrcPc0TUAUXBFQIB18Ab4vD+/RPJheVp1iKDxPBgg/MfCcvAw2kIcIPm+S1AiXzIK3ZEUhe8eIh0+6V+sfrmZ08OfT0mRgOA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640387; c=relaxed/simple;
	bh=EMOfmj1E8tOqpKhmh6cgSz/1MUVNnNg9ABAOmnG+5Rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lt6faaDCsKWGQs1+wTQ+em5lJhkV4cspdggYuWelRQu0MqhWk5NRG6t7K7fbPOWOGqXyf8R1+t8sGdac2IHCd76jciLaM3RMTvY5vJmIzzcaZrpNOzKio49gCoHtCXyhUKLeznmcP2ORBeyeW6TewcfLVgkGt5qJIsZMrFeG3Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YBP/iJgv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YBP/iJgv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 22E874E4282E;
	Fri, 27 Mar 2026 19:39:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EE83660268;
	Fri, 27 Mar 2026 19:39:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7510210451AF8;
	Fri, 27 Mar 2026 20:39:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774640380; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QBXw6xFuqX0scA2nxRBDxbSxByrStwiIMm6x28ahDaY=;
	b=YBP/iJgvKAkBfLp6+yHhmKTPpVUrD7qTUx5pt47aKDs9zzGmXGZ8mL0JSwkLXHe5jGGwCP
	hw2JZyAxoPhvGDJ49xyVzFsN0JQV0q/FcoUXWnXVeizyJsFc00/BaZxBJXn+N8N+GOmg6x
	T/W/DyO3nj9uPCPVTkQdNpxwA/U5S/xj1GLAYf79BgCEqXr2OX6Q70OEDHTGlTTBQTxGDO
	KdD/0c4LlVPTIJu8rSU+BKe8tIokKujXWMEsDL4RyM4hhQnD6XF2HDV1rrcMN1e4dJEc6g
	ynvrDIZoAa+awVPREGqyfoA4J8UcwCGppqzMiguZraIx8zysaefgOstMpsLyYA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Fri, 27 Mar 2026 20:39:33 +0100
Subject: [PATCH 2/2] MAINTAINERS: Add cgbc backlight driver
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-backlight-cgbc-remove-x86-dependency-v1-2-4851c9e95371@bootlin.com>
References: <20260327-backlight-cgbc-remove-x86-dependency-v1-0-4851c9e95371@bootlin.com>
In-Reply-To: <20260327-backlight-cgbc-remove-x86-dependency-v1-0-4851c9e95371@bootlin.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add missing backlight driver in CONGATEC BOARD CONTROLLER entry.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d10988cbc62..c210dbb94459 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6476,6 +6476,7 @@ F:	drivers/gpio/gpio-cgbc.c
 F:	drivers/hwmon/cgbc-hwmon.c
 F:	drivers/i2c/busses/i2c-cgbc.c
 F:	drivers/mfd/cgbc-core.c
+F:	drivers/video/backlight/cgbc_bl.c
 F:	drivers/watchdog/cgbc_wdt.c
 F:	include/linux/mfd/cgbc.h
 

-- 
2.53.0


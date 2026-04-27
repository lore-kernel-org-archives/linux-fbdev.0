Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96053B2FF1
	for <linux-fbdev@vger.kernel.org>; Mon, 27 Apr 2026 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282848; cv=none; b=sylps1CLxC2i4qEC8E5WKw2X12sRqYn04W6kc0Z0qUcytL0UJkt5atSBRf/dkO8/R7rjx5ceLkqooTGGCSu2KarmjIoStrsf4/18UKDQOyeF0ZtNRbI5n/qovyShNNilh4ZAcB1/gaMT3OZZy2L22GExst/G39u13Rpad0q13w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282848; c=relaxed/simple;
	bh=p3UMujP9GxlC4pAKxmVcyI2i6Qyxet+WaXjZz8D9hsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gvnpZZj6arSWEiyXSSA97tWruF4/oztlRhaZMwc+yT4om4zyuC0aksJS32CbGGtyCR85f0Y0IKuJB2Wse5nh7/iZ1IGvf7+T01J9FVSDnRPZ25fODiufqpUIB0/nztRQ13pFbrLWeNMMuF+UQK8a38xLT9bYC2/ycsrjbaK8PUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PI13SUlr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PI13SUlr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5C7CC4E42B32;
	Mon, 27 Apr 2026 09:40:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 33202600D1;
	Mon, 27 Apr 2026 09:40:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 912A21072242B;
	Mon, 27 Apr 2026 11:40:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777282844; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gB5C1Vp+oUxvDgPzpB0utak4Vhj0PTvajTmSSeRNoUw=;
	b=PI13SUlrLSvWKiKCuUvsCVSaqpQtv48TJ7ik+wztK3L7F351Pt+TzaBzPHwS05rNsMcZv9
	Kd+XuvhqvhUOU1WlM73Dnsh0B3rIyqVyvT0XNJSHCU2W26Tkq29HfraRU/X+PbbWXnDvfN
	5ME5RjLIERQ5i3mJRCJmPrsjxn6u5vFurj8VbBs8eCk7nMMdUFZM+o6eIgBYICtNvy6vV3
	KEHA4ZNXFQeNEADOmEf4xu73NYgF/d5khVg74RdrtR7OSEXnZFHbWY/wucA2fZP/JpcKYb
	XL9eMohETsE7iTxFjPb3WmN1pSPbu8KefTIOIuIIU4G8dNO4mKaiNjhzOu9MDw==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 27 Apr 2026 11:40:34 +0200
Subject: [PATCH v2 2/2] MAINTAINERS: Add cgbc backlight driver
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-backlight-cgbc-remove-x86-dependency-v2-2-da9f2375a34a@bootlin.com>
References: <20260427-backlight-cgbc-remove-x86-dependency-v2-0-da9f2375a34a@bootlin.com>
In-Reply-To: <20260427-backlight-cgbc-remove-x86-dependency-v2-0-da9f2375a34a@bootlin.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add missing backlight driver in CONGATEC BOARD CONTROLLER entry.

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..15b8db0721ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6474,6 +6474,7 @@ F:	drivers/gpio/gpio-cgbc.c
 F:	drivers/hwmon/cgbc-hwmon.c
 F:	drivers/i2c/busses/i2c-cgbc.c
 F:	drivers/mfd/cgbc-core.c
+F:	drivers/video/backlight/cgbc_bl.c
 F:	drivers/watchdog/cgbc_wdt.c
 F:	include/linux/mfd/cgbc.h
 

-- 
2.53.0


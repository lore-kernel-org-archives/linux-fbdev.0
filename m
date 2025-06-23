Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E421EEA5F
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Jun 2025 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661103; cv=none; b=cBuZSAiV+Ug9DxQEQGBKE+7VKz960ISjqZK/WprKhZwUoakmRRYar2+em/3tvImE2W6JlKnpCrU3tMazjkSB5tkJbx7SG46Rn4TKubQLT5ZhZJouhS2DDLPL6m9F0kTX8m5XH2Un+4osFJ11vovHVeoQJ8BF4JG/m7G9wYIDNr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661103; c=relaxed/simple;
	bh=FuWpotRDIyEvFRCG/nxmNN/jO2swjOVfbhbhqHJw88c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IXsj67tK+iNwlzRBQ7a/IwXafSeh1lgjaoTX7ExA84WDSiva8aas9tHXs7kmrhwieoF4QATtrE/7SAmRTAqUihcafR8rr3c2Xg4oqXGpH2iBExEnor0++5vDOSq6e1VQWnVI7ZmcVehhOqwvosHOeg+sjZMLRafKc+aLyYA6tr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=G1OUBWLo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="G1OUBWLo"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad8a8da2376so594781666b.3
        for <linux-fbdev@vger.kernel.org>; Sun, 22 Jun 2025 23:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750661100; x=1751265900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8j0earuMk91sZoSa/Jgd1WatXgxkmiiaUFmqx99Roc=;
        b=G1OUBWLoRGJO5hYXNyYDrAC9ZlJGqa6YS9GWQBWHQXacu1WKYLBvL+jI/JG94SplEK
         HVBxpc5HVXz1xFpG3n+TKkptVlCosGg1jMhKOi0crexvFzVlaLDKUMMLMYJBx9qwRgUu
         QOrI+iddwSwsFzXKIv75vNHGgD6bdIRhL8oa2lnrpsAmv+cQQ6bsh6620LiqrkIaTgXR
         brpgt3P2buMYeJpQW2vuQhBd+r7/IltDu6STgxfbNsk2ICN/Vh4g7P/1UOI18uxEFlHa
         CMNE+I97Jj/Kz1zlubLVfKdaSe1Sy2pl1eXOvTSXatGyQOMEDv1qSrRLKk0MFXJ3zHBT
         CAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750661100; x=1751265900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8j0earuMk91sZoSa/Jgd1WatXgxkmiiaUFmqx99Roc=;
        b=HFafgzRmLk2wCIR3YJ+CH0yPRJexHH0HYUdGzQMWSJt9SrCwh1tk+6e9HugBM85SKl
         hMjHTu6ak87BMuxx/h6ThpzfXHrqbmIblhTXZHxHbjnD0Ku6ONOq7vWszif9Mr9OYfdy
         AzTOvR6vGhDc+7qavNYUDROXsSsXPffGy1ITiEqtpZh6FzyBVkg9Ry50GpR32VyD+Sq9
         /SNUdvnt7WL3qKGvj0tNiDkLW2LxVPfaX+ryl7LhEqQ4ZOXE/RInPO2/ZklitEs/9Y5C
         lVs3s0IIDK0UIhDXfubpFRpEKaKpu8npGKG/2wQBtB4CIVI/MkPySUHLPybZlk8dX0q/
         TQgQ==
X-Gm-Message-State: AOJu0Yz88DM7KkRM7Rp0ns5JR9XQjczc4xOjYVZQDkAfSCTygyp3uqav
	8JWua6W31wSvcmf58uhc/3V5OsKR7Qm79oDO5RG4DpA6OYnfMTROJDC99Lf6BRdmFEc=
X-Gm-Gg: ASbGncuIHuKYAuCqPVWppaQTLuKgjWghzj+5LJXgQNubTj1MfEPdxhsnTUm7hpt8I3Q
	va3X5x7BLaILv3PryeTEvDkJVj7yr/od0OwZZxQgdKSGfPkrzq82GKTetWuqd9IforS4WuWlscJ
	g2mGjmxFpXRiLLxpaTMQe6xbK6AiFt7SnTacJJYtj0lwIpXHVc1HH1MHctg04gGEgRoAuEl39nz
	88vxK15WxrXV4etaSYQ2lXVNsFNXlwI+tpq5zmCdphzfCwJcEf2wA/HFbar2TzuiWFtthquF3YZ
	Nk2jysaBGomeBmbCM9fKzI5opoxCWRKjC4RBIDXnPbUUY/c91PqNboxXmEMeHKZ/grMaTWwVPlM
	+PkjydJ8DXK4YIoqd0fdlDmyNpRi2oqUQ
X-Google-Smtp-Source: AGHT+IE8m6sV6mGT4W4Z3eOR9YDBYYzBxtwk7TVZKt44W93HSiVrTunOecK2T81aA/Q+qJNWY1i1yg==
X-Received: by 2002:a17:907:1c95:b0:adb:449c:7621 with SMTP id a640c23a62f3a-ae057c0f672mr1169047266b.29.1750661099726;
        Sun, 22 Jun 2025 23:44:59 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ee4ce9sm659258266b.69.2025.06.22.23.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 23:44:59 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 23 Jun 2025 08:44:48 +0200
Subject: [PATCH v2 4/5] fbdev/simplefb: Sort headers correctly
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-simple-drm-fb-icc-v2-4-f69b86cd3d7d@fairphone.com>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
In-Reply-To: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750661095; l=1094;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=FuWpotRDIyEvFRCG/nxmNN/jO2swjOVfbhbhqHJw88c=;
 b=kXVSPEOY4GhdxIVGXUvtFGyi8NaioGV03rhp+XgPSoKPhDZTGGSFak070HpEI5tJff8X94PQS
 azxFMPS9dLaDcaEfVYWwQaXl3Ps5kdOPKrCiKnmBij4JtYNIp525Z22
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Make sure the headers are sorted alphabetically to ensure consistent
code.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/video/fbdev/simplefb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index be95fcddce4c8ca794826b805cd7dad2985bd637..db27d51046af5cc3c46a0bc81ad9d9ed9a0783cc 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -13,18 +13,18 @@
  */
 
 #include <linux/aperture.h>
+#include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/fb.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/platform_data/simplefb.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
 #include <linux/of_platform.h>
 #include <linux/parser.h>
+#include <linux/platform_data/simplefb.h>
+#include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
 

-- 
2.50.0


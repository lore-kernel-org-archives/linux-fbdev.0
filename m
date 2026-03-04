Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD939D6C1
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772617152; cv=none; b=I2vVdZ17qPrLs34TlPY3onFYbkXFril+wQ+3B9Rn+7hcaxhdK7R73dekojV04w/JACBaWN0MlV5ZHTzHM1+fGAjTa4nLwGXrcAp7cUliIMzirQUTPIF5Ddjb6UecysPsdw1moLsRfVxWLxe6z3xYfMRyMunfPQabWzrMXbQQtkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772617152; c=relaxed/simple;
	bh=evyLIuR2VctR/Yu/KfgkAyoz3VqqLa1hcx5Cx+bQe44=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HBBerjRjN863QDKTkeklAdODNXW2lsFEe2J2GOM+gNb1dIYXKAGTe7o6j4W7CNcNcasjdB3cYEbCjSTCnAL7Db1PwIZOYDjX3DVc7298u+u4qaq9ZuTDdA54d+xvelqqSWfDwwQbs5IGttMSAyiOQemhsgDH2ILVcs33xmu6Y7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEYarudv; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEYarudv"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c6e85f76efeso419540a12.1
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 01:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772617149; x=1773221949; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rN93ANA+HWtDdddG3XEUggwOUXjfX92/pIpoIVfilZ8=;
        b=XEYarudvLJ75KHG+n+tZ/WNfPOjLhF6ibB6YiOmQ9f68I/C/4vKY0Ee1MPfraN/oSO
         iu7GxKIFC0b/CrTPGK4xLuC++f9wMpvfQtz6cd2CjV+pu9s95OwIev6npBVjy8q6hnRE
         RNGA8Y6eVITw26f7GIn7z3xiiiPLmuz/No7iJxEyo2dvmWg9prQrpYXvlnPnJUiQHUMp
         0YQwk+XuksynjUJPgT3kZDFQupfd0kB0Fz7HXYHYJ0GOUwD4l91JQomZSm4ZLiZiwz8E
         pqRJqp4g1x8Np5FravUDa+bbxqC2VmpgAGYQZaSJ9k6oMlHid+v0x5k0vwRAFRUSugfV
         lQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772617149; x=1773221949;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rN93ANA+HWtDdddG3XEUggwOUXjfX92/pIpoIVfilZ8=;
        b=RlI1tuVw+5gOoFITgPn5bIIPsoOdmI6sp6xU3knUkCeV7Oi7OIKyS2C5vs6CjL0V92
         obiCAAXMi83hjULA6dWMYWazORQTGLmxKujMIF2cRu5jC9K2DCOExjnWaFNOft7ofzS9
         p24dK7P9o5dfsKhLOmo+eAiFP+AsvVF0juAazC5JTkelBy+uCCLAkgKdQZnKfxnHMVO7
         metoFkXthwlPJ0qAtQUc/Z22Tqfn4BbKIyv55rKFv7R/A41abNP6QHLS4It+OcIuhiXW
         huMX7vXjDfacbZkm84cikLnxjX46LsdkgpNuzwzNoReOGx92lNK6h9lkQbqXagYH6w5Q
         tjbw==
X-Forwarded-Encrypted: i=1; AJvYcCUwv7WaPeFuQ7HFhwPR4Z9OHPnTmMsIl1wbNFy82/0rNtJ8J0TADJoe7vL378Ud6sP/rFUtHPsht4y9kQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4sAhSNTkVrT+IlFPmi0A0iSNwnm2d7wu36Vyf6LiwYWFOks2o
	uv8xJeycNrtnV0YugDHmV9aVuKq1oAs7IfLd2vbU+Cme3LvssNwnrWd3
X-Gm-Gg: ATEYQzx6Wl3hI4JpB2pzt9aymm5kvCM0bKJi0xXDehfu/GoeMQGjSEcRNEh0ONJqhaL
	+5x1WG5dTBdxkiUR7rz40QgwCobwDmVic17Aur89e9Nt0jQq24l7dXdPslt520eODxo1NfIspFh
	awHL++VVmjp0HUdL+eVcX1wAn7JM7wcN6xhA0en3H7fi9Wxt8aNQrFSN6jzryIPaYwiWNjDvaub
	JQzhqFNsGUdLJJopaVkjs4GKsA7IZfnB02TB7QlWDfh0KrKCyGE7p1hFvgX5UrBrk3TzTgXXoCk
	QfGjv6MhTCTlCzBwhFJ7hnl73joRWRLcHgCzZlA07atNkbxqpt7Pv+oZkYh7Dfo+MRoc0gaoUd3
	dGtV4U7rtlbr1+FjDyhuf9czV6qkuq2JnilGtk35pxWqBEk1WUyxKwoMFoHvPuDFgYSPPbEkgzf
	0NzwplSiulNrbZK9XeP+E=
X-Received: by 2002:a05:6a20:12d1:b0:341:730a:ef54 with SMTP id adf61e73a8af0-3982dec6183mr1099807637.1.1772617149371;
        Wed, 04 Mar 2026 01:39:09 -0800 (PST)
Received: from marchy ([180.75.247.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a081a14sm17142736b3a.64.2026.03.04.01.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:39:08 -0800 (PST)
Date: Wed, 4 Mar 2026 17:39:05 +0800
From: Adam Azuddin <azuddinadam@gmail.com>
To: andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: Update RA8875 Kconfig help description
Message-ID: <aaf9uQOBzCwQuff4@marchy>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The current description is too brief. Update the description to
include the manufacturer (RAiO) and the supported resolution
(up to 800x480 pixels) to help users identify the correct driver.

Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
---
 drivers/staging/fbtft/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
index 578412a2f379..92943564cb91 100644
--- a/drivers/staging/fbtft/Kconfig
+++ b/drivers/staging/fbtft/Kconfig
@@ -86,7 +86,11 @@ config FB_TFT_PCD8544
 config FB_TFT_RA8875
 	tristate "FB driver for the RA8875 LCD Controller"
 	help
-	  Generic Framebuffer support for RA8875
+	  This enables generic framebuffer support for the RAiO RA8875
+	  display controller. The controller is intended for medium size text/graphic
+	  mixed displays with a resolution of up to 800x480 pixels.
+
+	  Say Y if you have such a display that utilizes this controller.
 
 config FB_TFT_S6D02A1
 	tristate "FB driver for the S6D02A1 LCD Controller"
-- 
2.53.0


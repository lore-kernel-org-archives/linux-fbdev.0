Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAC7476CCA
	for <linux-fbdev@vger.kernel.org>; Thu, 23 Jul 2026 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784809705; cv=none; b=ufLN6hSd5Iy9GLyNCwWOs35xRSlIfU6aA0iM3jmbEQL2lPHtCrxp/gHY89ydf+zwnxDOThnkeo4+/DyhT37rlt+GF459iKveYqo79/aBc07lo0xWdlR2xtHtcwevbLfJN7bxmP/SBrwly1inuXBUX0w+5xez/hWoWF+3MRVOpk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784809705; c=relaxed/simple;
	bh=qJeWLqqHGhywHLzf/EYgOC1kFld80TPrXuXaJUKz/v0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PRzpfZHjEfsTcAuzIOoXj+Xope+OL8uAytk4aGHFNjBxiBxSm03O1HFd20Nm6hm3dDd/IZgtmnTfV2OY2DvsiBgmJsm1bho817aei7gHUtq8O9SFEeuniX280Br9oLF0H+X9H1YVTohbPfYCYKGshpi5S75IIO41SbkYApfZiYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhIv7P2h; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhIv7P2h"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-495590dde14so6891545e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 23 Jul 2026 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784809702; x=1785414502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kHSxDwM0Y6FUMCJyC98ds2ox0gHcqUAID04qqyOi0zE=;
        b=PhIv7P2hbQza2paTo+jnAX9VUHTpoWyg/QmI4r/scIuMu5g9GtcTOxjpm6kMy0511h
         CxHI2uwrHLy/sHY9d14X7ESSbuuRcN1gqfGvOLiaxzm0JYBqbrIohhM0CYWNDPH1ZxZT
         IFKLSTMH0rRqPy+TrxFOq4xr1/6uE3fvGcWwsHoOlRMUxHQL0rpqVJCPzMfJOzU6Xy7o
         ZnhCYK4wpllKk0/4cIltdGChwGYPZxxNtJUNRDYoRcCKT3WMqt6hdFXGveAI1jNyBLyW
         qEinVfhpGsbxz8F5tqhmbU/ACIY50gc9SZzvp8c8/QX6G62C9uG1wgbZDCWFnoISJbDw
         w/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784809702; x=1785414502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kHSxDwM0Y6FUMCJyC98ds2ox0gHcqUAID04qqyOi0zE=;
        b=emgl4f5HXqgOYFN7wjhy+gs7MPFe38qL8nP+Qp3Hh+S44a9srkX3FqQVCChPrrsyLy
         9Fjt1QRTBNPB5I827UrTxLyOgHRyaKjI20K9y9LaabtMs2kixK9Z2DfR8HlNIL85CzE9
         OGod9wlAHIjc75Vn0Hd9SMpV7E392tkAWRqK5ZKIjsWsS2bFaIQlVMIMUyy48Dmh6yEq
         wzUAh80BkdH6psR9YQDYEBFi/ED4VWwiJIFH/XoltHpimKg06CmDbK4A70HeFtilzFqG
         +ZyxyOib/sD4tGqTsTMUCBM5AsWj+R8/7EC6PNyZ1sMVUrhlKSxoCbcee+XoVg4i+p/9
         bE9g==
X-Forwarded-Encrypted: i=1; AHgh+RqoZrstFwpDx42thDI0YLmrTPe1ujJuISG0cXBIbwga0ZeOgy4ZYuscQzlbBA8qMaNZp/cyl8zGs+2/ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmyOiqmqD0R816yHFSZJuxvnePil/4WlUlt1g2AK2mZ1AMAQ8k
	UT21S3tiLt64xDX3Q5+fM6r3bR+imbu5fj1WPfQSjhzN+sCEUtBNsmmm
X-Gm-Gg: AR+sD10cnSZ8WJw6HY+/vmJB39yWS9e6ZZQTtguP/6V+2KNmzkooiOFzzZTwMQiLsF/
	Lj9Uq0Ybw1QCudIbsrC9Rc+HuDUhfrmz8grQjJAk6znszpk4HBrVlgftDKWC9pOGlG5NYVv4cSr
	DwJHFV4mSs5GNBgEyae2sPRWawqyeqg7YKW0LSxLwaTGtWNrPet8QeurkdX1dEmjJDeHM4bJJkU
	h6GxLKzuGoCmS4IAjlYOugbbSJXQ+URcsfqt+Swxidcq2OBE+gLYeyFYwChNfWZLAbR3ZaSCf92
	m9Col39bszxfDbJ4pHye5RLWvgzJl55pI1G64ZkS6R9QPkzVNI8KVoglEDpNDxEcHco5hJb5P96
	rGreFBRX+35hmvXRkJbdwoETTISMCTf+O1oH6cueSs3q/bH5JqDn6F/et1QDCQahqqlmZWMk50S
	njAhN/EyICXkbIDkei0kGmlj8gW49pOo+8xsEd2CX5EX9fGAwgC8tBwAT1vl5BS//hytGpzmyvl
	tmX
X-Received: by 2002:a05:600c:a218:b0:495:6788:c229 with SMTP id 5b1f17b1804b1-49573cb99bamr18898445e9.4.1784809701703;
        Thu, 23 Jul 2026 05:28:21 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a509901sm255799575e9.8.2026.07.23.05.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 05:28:21 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: deller@gmx.de
Cc: tzimmermann@suse.de,
	wei.liu@kernel.org,
	ptsm@linux.microsoft.com,
	arnd@arndb.de,
	u.kleine-koenig@baylibre.com,
	hsukrut3@gmail.com,
	rob.github@jumpstation.co.uk,
	enelsonmoore@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v2] fbdev: replace dead select with dependency
Date: Thu, 23 Jul 2026 13:28:18 +0100
Message-ID: <20260723122818.437802-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'select' does not work on config options in a 'choice', so currently it is
possible to enable FB_MB862XX_LIME without FB_LITTLE_ENDIAN.

We cannot replace the 'select FB_LITTLE_ENDIAN' without also changing
FB_FOREIGN_ENDIAN from 'select' to 'depends on', otherwise we will get
a recursive dependency.

Since the default choice is FB_BOTH_ENDIAN, let's use:
'depends on FB_LITTLE_ENDIAN || FB_BOTH_ENDIAN'
to avoid breaking defconfig.

This dead select was found by kconfirm, a static analysis tool for Kconfig.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
Changes since v1: support the default FB_BOTH_ENDIAN
Link:
https://lore.kernel.org/all/20260722220023.196029-1-julianbraha@gmail.com/
---
 drivers/video/fbdev/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 085d3a202148..e8cd8cb76874 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1717,8 +1717,7 @@ config FB_MB862XX_PCI_GDC
 config FB_MB862XX_LIME
 	bool "Lime GDC"
 	depends on OF && PPC
-	select FB_FOREIGN_ENDIAN
-	select FB_LITTLE_ENDIAN
+	depends on FB_LITTLE_ENDIAN || FB_BOTH_ENDIAN
 	help
 	  Framebuffer support for Fujitsu Lime GDC on host CPU bus.
 
-- 
2.54.0


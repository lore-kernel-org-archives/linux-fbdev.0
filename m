Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D21C93AE;
	Tue, 27 Aug 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772365; cv=none; b=ibdaggXvhs4incSPq8kC8UywAOCZYUimpm+uu+TKpeXGF53MCb7DI9swTeyLtXPgQFPFALSiFPeEaorcpLB64TfBXQqdUZHaVYpvUYaOMkkpaAWNzwhlgxvix8YEf4JfIh6PXyktsdmy4/Sb0OQSVwLpwWlLFZ+pG5GZUCFAPRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772365; c=relaxed/simple;
	bh=2e4vyf28xxH0Hr6la1wTNPqSQ1+adyxwjIEbYSuV2ZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TMJPNg5DnIfzFmyjhlo0LOKfLsjQBCgE7HSo1QQ0+zTiMn+rSqNY7pHVM2mBA828GFGO9R2L6yL/ApPZfLt45TXgUJN+d9a6TgkoYIwXV50K3Ei4Uns1JkJbQ8l9ABG/mzPBpqU+S4CHjMFybcZu6RrzeQKq/5twg6lqWvduVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tky1Hq3+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tky1Hq3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724772360;
	bh=2e4vyf28xxH0Hr6la1wTNPqSQ1+adyxwjIEbYSuV2ZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tky1Hq3+/fxIo0PR0yLhX4NeR2JZSc/FpDc/+iBEYIVZx4tKdGLw00kqmM651bNzx
	 sd/ivrIlYFCsOdOLZ7rW7yGaUt5cSBkW2IUp7YpXHJZ7zqNPzqlNN6f+cUB8uQtxj4
	 agBtu0KwAJHvWLvPv1OlQD8y27tatHW9ABsom+58=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 27 Aug 2024 17:25:16 +0200
Subject: [PATCH 5/5] fbdev/efifb: Use driver-private screen_info for sysfs
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240827-efifb-sysfs-v1-5-c9cc3e052180@weissschuh.net>
References: <20240827-efifb-sysfs-v1-0-c9cc3e052180@weissschuh.net>
In-Reply-To: <20240827-efifb-sysfs-v1-0-c9cc3e052180@weissschuh.net>
To: Peter Jones <pjones@redhat.com>, Helge Deller <deller@gmx.de>, 
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724772358; l=1194;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=2e4vyf28xxH0Hr6la1wTNPqSQ1+adyxwjIEbYSuV2ZQ=;
 b=+Pk0n0e5P2rpmmg2vlrNRCkM2i9FDYVDXSk03eilvNcK3JU9PZrT56fs06i4gUziwWgueLNAH
 XoyCQh/LzQbAT60VaYMbFxlv0u10WFRv1JQti4gSy+KJhNvN/dOi9qd
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Since commit b9cfd1d271ab ("fbdev/efifb: Use screen_info pointer from device")
efifb uses a local copy of screen_info and applies its modifications
there. Adapt the sysfs attributes to also work with the custom copy
instead of the unmodified platform data.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/video/fbdev/efifb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 7215973ef602..1f86a07bf292 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -304,7 +304,7 @@ static ssize_t name##_show(struct device *dev,				\
 			   struct device_attribute *attr,		\
 			   char *buf)					\
 {									\
-	struct screen_info *si = dev_get_platdata(dev);			\
+	struct screen_info *si = dev_get_drvdata(dev);			\
 	if (!si)							\
 		return -ENODEV;						\
 	return sprintf(buf, fmt "\n", (si->lfb_##name));		\
@@ -369,6 +369,8 @@ static int efifb_probe(struct platform_device *dev)
 	if (!si)
 		return -ENOMEM;
 
+	dev_set_drvdata(&dev->dev, si);
+
 	if (si->orig_video_isVGA != VIDEO_TYPE_EFI)
 		return -ENODEV;
 

-- 
2.46.0


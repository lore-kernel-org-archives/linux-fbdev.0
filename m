Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D09F143C69;
	Sun, 15 Dec 2024 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734274691; cv=none; b=oNMHnQ+YVN5HhjQJcmWMmnswzzFeKcCuEkZcS2snDSMwmXigHku0M0tms6+/bUSKJELz4BdYxXLDbDktynwtc3zHwdZ3Tzj+Pn+o8+y8wPPjtV+bt+s2h0I3UN7gJpLUtskFVPHb2D6CUakhV1rCFLcyUiUlQ92LuNWpxBnk3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734274691; c=relaxed/simple;
	bh=w9nvy9g1FOojXUI4vOJQb1SM3VY2aQLrTqmaDrLN1Xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qfQpFzXss/q9Lib+NswkjcZuHlRs49EWcBmwowv5siwZXgF58Y4GBGxQmC3V2dRLXNeQYrPuStFpWuMXDsyht0JG0i/bsOk/dzDmXD6IbJnv8q7ZJLXOSf91WP/4diD5smGOW7j8GJIv2Xqu+lEJNLIOXg8EgmrgbS0a7fQlc6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Na4fR/kt; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Na4fR/kt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734274688;
	bh=w9nvy9g1FOojXUI4vOJQb1SM3VY2aQLrTqmaDrLN1Xk=;
	h=From:Date:Subject:To:Cc:From;
	b=Na4fR/kt6LgwpxNgI6tz2AcZDhoefq7v24LZjhBbrFRcfq5/hGSzfj9rQPhPaeIlw
	 BipUGzrVTVGAon1OKBSlZXU77dYHXW6NvkiVIlsJiwNantLuZY6vbldTG3zAJe7s4S
	 nfaoH5kWQG/Znv7vZrubEv+Fg3JT4dlaV33U2514=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 15 Dec 2024 15:58:04 +0100
Subject: [PATCH] fbdev/radeon: Use const 'struct bin_attribute' callbacks
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-sysfs-const-bin_attr-radeonfb-v1-1-577bcffa1100@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAHvuXmcC/x3MwQrCMAwA0F8ZORtoyxS3XxkibZe6XNKRFFHG/
 t3i8V3eAUbKZDAPByi92bhKh78MkLcoL0JeuyG4MPrgr2hfK4a5ijVMLM/YmqLGlaqUhDeX8uT
 clO4jQT92pcKf/788zvMHA+6DgW8AAAA=
X-Change-ID: 20241215-sysfs-const-bin_attr-radeonfb-60bc9009b84e
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734274687; l=1982;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=w9nvy9g1FOojXUI4vOJQb1SM3VY2aQLrTqmaDrLN1Xk=;
 b=BslxGOrxS0iJMK1+ZAjFPUiwzPYaJt0wmnvkgiMQ/6rEGZThdAkBroJrhihP8t2YCdX351uoG
 sufuPtSdUjmDMjTcW+35fDzfdIB1D2AKD9OuLYqxXHSD7rfQ24p1fx8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now provides callback variants that explicitly take a
const pointer. Make use of it to match the attribute definitions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/video/fbdev/aty/radeon_base.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 36bfb6deb8abde5268953082d096b97786ba3644..d866608da8d18f1987ea831f97a7f304ae62fa2f 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2199,7 +2199,7 @@ static ssize_t radeon_show_one_edid(char *buf, loff_t off, size_t count, const u
 
 
 static ssize_t radeon_show_edid1(struct file *filp, struct kobject *kobj,
-				 struct bin_attribute *bin_attr,
+				 const struct bin_attribute *bin_attr,
 				 char *buf, loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -2211,7 +2211,7 @@ static ssize_t radeon_show_edid1(struct file *filp, struct kobject *kobj,
 
 
 static ssize_t radeon_show_edid2(struct file *filp, struct kobject *kobj,
-				 struct bin_attribute *bin_attr,
+				 const struct bin_attribute *bin_attr,
 				 char *buf, loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -2227,7 +2227,7 @@ static const struct bin_attribute edid1_attr = {
 		.mode	= 0444,
 	},
 	.size	= EDID_LENGTH,
-	.read	= radeon_show_edid1,
+	.read_new	= radeon_show_edid1,
 };
 
 static const struct bin_attribute edid2_attr = {
@@ -2236,7 +2236,7 @@ static const struct bin_attribute edid2_attr = {
 		.mode	= 0444,
 	},
 	.size	= EDID_LENGTH,
-	.read	= radeon_show_edid2,
+	.read_new	= radeon_show_edid2,
 };
 
 static int radeonfb_pci_register(struct pci_dev *pdev,

---
base-commit: 2d8308bf5b67dff50262d8a9260a50113b3628c6
change-id: 20241215-sysfs-const-bin_attr-radeonfb-60bc9009b84e

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


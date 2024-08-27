Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B05954767
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Aug 2024 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776782; cv=pass; b=IRj8O8QGLTsBXp2hMpumSTPqF3hSZe/BBM2qvzoydgYV7Uoeiak+ZW5Vs47lDReLyrx43tC2Oo21AAJOFIrMpbR+C61Chh/7sBS7FNUgbszbAYm+5G03aXXb+3cNONajJGDMZ92TEayFtrnUFvN5/GxEmg5D4ZzFEpRDCHkbJPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776782; c=relaxed/simple;
	bh=7tgzdslDVuoIpnuX82SerTuH7FPN3KxBHXu2qbH8c0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dvr3YQohtbRUeMJcsr4lJD/D9sr5LpJjWuftCIUXAyWn1EXt9pn2EsGIzeT1A/AM/KTE0x5neGz1Knj5vIunuIL6dy2WGJ2dmQNhorHKNpwO2q17n0ve3oGu0PupB/vs+uAzFRAhuth3FzEivQu9mLn5PQv2XlZfEEdnMCyBHIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=derek.foreman@collabora.com header.b=BnGj81Zd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=derek.foreman@collabora.com header.b="BnGj81Zd"
ARC-Seal: i=1; a=rsa-sha256; t=1724776770; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ms4VjhhhQLSp/cOdSmmB9m0GI2z2Mf38RQZ+jjR9wIVM11hoXjGCbE8su/J7DWcoH+Wu1Ed1HCpTOotLfbNXoQBnC+LWcFDht9il6kVk6WP19yysS5iQaIxdIKWSbjaYmBV1IVTJPN7w/AaAJJELwJ3m3iKkk8PSVEG4eZwrgpo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724776770; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PysjLYYTobfjpCkNvp5rpF4+UHOJO/yIh0Yk4ecR/F0=; 
	b=dsJGXNF7ZW4tI6Vu3PJCNWihoVvhK9Jqjn5CNYb+HwWOQbMkuufc7RULJ9U9vFfS4dOh5TOsrFe5XzXggvrHRrQ4MUTpaXXRzcPNWAx0B29PJPFCPM/ey0Xf4a+ola3G7bka0s+bTe4Tr4uzQGguYGqyLvbk6vs6JOQtsdSI18c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=derek.foreman@collabora.com;
	dmarc=pass header.from=<derek.foreman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724776770;
	s=zohomail; d=collabora.com; i=derek.foreman@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PysjLYYTobfjpCkNvp5rpF4+UHOJO/yIh0Yk4ecR/F0=;
	b=BnGj81Zd1mDeGLMYPor5iRYrWmA50jHjHGhNHtswin7e6FAgFPA/ODbaT2Lqw+Ew
	BKDMC7fnqNF8CQYhPC1Ef2ql6NGFpAJ7jh4+Sms2xrZwx/ibU+mGfpCfXeV5BHJ4zwZ
	hhKsLZOny9xwac0oFrfLuWMs3vFjVfRMOvTuJ5Ms=
Received: by mx.zohomail.com with SMTPS id 1724776769491557.6911820771234;
	Tue, 27 Aug 2024 09:39:29 -0700 (PDT)
From: Derek Foreman <derek.foreman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>,
	kernel@collabora.com,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	Derek Foreman <derek.foreman@collabora.com>
Subject: [PATCH v4] drm/connector: hdmi: Fix writing Dynamic Range Mastering infoframes
Date: Tue, 27 Aug 2024 11:39:04 -0500
Message-ID: <20240827163918.48160-1-derek.foreman@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The largest infoframe we create is the DRM (Dynamic Range Mastering)
infoframe which is 26 bytes + a 4 byte header, for a total of 30
bytes.

With HDMI_MAX_INFOFRAME_SIZE set to 29 bytes, as it is now, we
allocate too little space to pack a DRM infoframe in
write_device_infoframe(), leading to an ENOSPC return from
hdmi_infoframe_pack(), and never calling the connector's
write_infoframe() vfunc.

Instead of having HDMI_MAX_INFOFRAME_SIZE defined in two places,
replace HDMI_MAX_INFOFRAME_SIZE with HDMI_INFOFRAME_SIZE(MAX) and make
MAX 27 bytes - which is defined by the HDMI specification to be the
largest infoframe payload.

Fixes: f378b77227bc ("drm/connector: hdmi: Add Infoframes generation")
Fixes: c602e4959a0c ("drm/connector: hdmi: Create Infoframe DebugFS entries")

Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 4 +---
 drivers/gpu/drm/drm_debugfs.c                   | 4 +---
 include/linux/hdmi.h                            | 9 +++++++++
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 7854820089ec..feb7a3a75981 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -521,8 +521,6 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_check);
 
-#define HDMI_MAX_INFOFRAME_SIZE		29
-
 static int clear_device_infoframe(struct drm_connector *connector,
 				  enum hdmi_infoframe_type type)
 {
@@ -563,7 +561,7 @@ static int write_device_infoframe(struct drm_connector *connector,
 {
 	const struct drm_connector_hdmi_funcs *funcs = connector->hdmi.funcs;
 	struct drm_device *dev = connector->dev;
-	u8 buffer[HDMI_MAX_INFOFRAME_SIZE];
+	u8 buffer[HDMI_INFOFRAME_SIZE(MAX)];
 	int ret;
 	int len;
 
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 6b239a24f1df..9d3e6dd68810 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -520,8 +520,6 @@ static const struct file_operations drm_connector_fops = {
 	.write = connector_write
 };
 
-#define HDMI_MAX_INFOFRAME_SIZE		29
-
 static ssize_t
 audio_infoframe_read(struct file *filp, char __user *ubuf, size_t count, loff_t *ppos)
 {
@@ -579,7 +577,7 @@ static ssize_t _f##_read_infoframe(struct file *filp, \
 	struct drm_connector *connector; \
 	union hdmi_infoframe *frame; \
 	struct drm_device *dev; \
-	u8 buf[HDMI_MAX_INFOFRAME_SIZE]; \
+	u8 buf[HDMI_INFOFRAME_SIZE(MAX)]; \
 	ssize_t len = 0; \
 	\
 	connector = filp->private_data; \
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index 3bb87bf6bc65..455f855bc084 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -59,6 +59,15 @@ enum hdmi_infoframe_type {
 #define HDMI_DRM_INFOFRAME_SIZE    26
 #define HDMI_VENDOR_INFOFRAME_SIZE  4
 
+/*
+ * HDMI 1.3a table 5-14 states that the largest InfoFrame_length is 27,
+ * not including the packet header or checksum byte. We include the
+ * checksum byte in HDMI_INFOFRAME_HEADER_SIZE, so this should allow
+ * HDMI_INFOFRAME_SIZE(MAX) to be the largest buffer we could ever need
+ * for any HDMI infoframe.
+ */
+#define HDMI_MAX_INFOFRAME_SIZE    27
+
 #define HDMI_INFOFRAME_SIZE(type)	\
 	(HDMI_INFOFRAME_HEADER_SIZE + HDMI_ ## type ## _INFOFRAME_SIZE)
 
-- 
2.45.2


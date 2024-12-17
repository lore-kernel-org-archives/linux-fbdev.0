Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989491E480;
	Tue, 17 Dec 2024 01:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734399546; cv=none; b=oPOYKO954nNvGISFMmsOEH4VQE4bL8mPs0nO+NgGRJJnModKTxaC+6MmrM3zmpjzDly8u4V04LFEiMVnPEZSmEtnYxMbBG0zoh5xK0Il4WtwWFlRkzoIWVPbrfGBu35CVpwE58lifdrf2tpNP/ZKBlFvyIhpAb0Lm+U7N1LEE70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734399546; c=relaxed/simple;
	bh=/JQxTLrSk+bn9KCS4BhHq1XaHn24Um+rn7bVloKUnXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAtnGRYpwl4Hjhcxx1+Nctm4y9D83A0wbYVKaa4eZBnPq7rao2uw35J13FI7pCNJ39ZqGpEv90Erf3voceCQKczTbaJicdUI6R6ktQAHv8lI0Fa5o63XSkiSsaFZAK9ViLmJS+1pBhQDQdsV0bEE9DuVVLey54gmR54Ec8ZJ5lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Tthv0tKF; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Tthv0tKF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=vvJ4qNUEi44vMx2Ffy89gG0D5fOc9H17NxvnqOiuKjQ=; b=Tthv0tKFt2LU2XGk
	vA2H11+SwzVqEq/3jrRSHr+BMxewubJ7/w/7x6d/+6/DV+kXFCFGWJgKxblzpx4RHxd7As41234o9
	2Cz9jzWdYav8T1JQXRVZ+eEGfllIY3XBq4fqlyniFHe7UN0De7w5Fchc4zhioWbYYDCXya77xoQKF
	H532etx1TcRcE/8k84kzdo1qTJLLDYo2vFd2UARsFogTKQib/QIxQMy6KJIynL5i2fPvSGOJCnFET
	aYjsxSQSvEH9PvJS9/sPwf3H4ag3wkSEs//EZJ74g5uVF7r4ngUdC/Oz9cWva6gVZ9DvO/+qGKVBK
	eiNyJFaC9vVdsTwVNQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tNMY8-005lOw-14;
	Tue, 17 Dec 2024 01:39:00 +0000
From: linux@treblig.org
To: deller@gmx.de,
	linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] video: hdmi: Remove unused hdmi_infoframe_check
Date: Tue, 17 Dec 2024 01:38:59 +0000
Message-ID: <20241217013859.2132527-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

hdmi_infoframe_check() has been unused since it was added in
commit c5e69ab35c0d ("video/hdmi: Constify infoframe passed to the pack
functions")

Remove it.

Note that the individual check functions for each type are
actually used, so they're staying.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/video/hdmi.c | 28 ----------------------------
 include/linux/hdmi.h |  1 -
 2 files changed, 29 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index ba301f3f4951..45b42f14a750 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -894,34 +894,6 @@ hdmi_vendor_any_infoframe_pack(union hdmi_vendor_any_infoframe *frame,
 	return hdmi_vendor_any_infoframe_pack_only(frame, buffer, size);
 }
 
-/**
- * hdmi_infoframe_check() - check a HDMI infoframe
- * @frame: HDMI infoframe
- *
- * Validates that the infoframe is consistent and updates derived fields
- * (eg. length) based on other fields.
- *
- * Returns 0 on success or a negative error code on failure.
- */
-int
-hdmi_infoframe_check(union hdmi_infoframe *frame)
-{
-	switch (frame->any.type) {
-	case HDMI_INFOFRAME_TYPE_AVI:
-		return hdmi_avi_infoframe_check(&frame->avi);
-	case HDMI_INFOFRAME_TYPE_SPD:
-		return hdmi_spd_infoframe_check(&frame->spd);
-	case HDMI_INFOFRAME_TYPE_AUDIO:
-		return hdmi_audio_infoframe_check(&frame->audio);
-	case HDMI_INFOFRAME_TYPE_VENDOR:
-		return hdmi_vendor_any_infoframe_check(&frame->vendor);
-	default:
-		WARN(1, "Bad infoframe type %d\n", frame->any.type);
-		return -EINVAL;
-	}
-}
-EXPORT_SYMBOL(hdmi_infoframe_check);
-
 /**
  * hdmi_infoframe_pack_only() - write a HDMI infoframe to binary buffer
  * @frame: HDMI infoframe
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index 455f855bc084..96bda41d9148 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -445,7 +445,6 @@ ssize_t hdmi_infoframe_pack(union hdmi_infoframe *frame, void *buffer,
 			    size_t size);
 ssize_t hdmi_infoframe_pack_only(const union hdmi_infoframe *frame,
 				 void *buffer, size_t size);
-int hdmi_infoframe_check(union hdmi_infoframe *frame);
 int hdmi_infoframe_unpack(union hdmi_infoframe *frame,
 			  const void *buffer, size_t size);
 void hdmi_infoframe_log(const char *level, struct device *dev,
-- 
2.47.1


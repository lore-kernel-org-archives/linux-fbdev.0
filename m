Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F25CDF1;
	Sun, 28 Dec 2025 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766927831; cv=none; b=WTMqrJ13nIFo4JNKaW89M9NtTsdJcWspOlockXzJkNPUEpkPTShEqc0IjdDDc+zpHvLtIOVlEYc5jWdIso0d/5YrcP9IRU4aYBYiN0kGkqUXwZYal0+o99QxWSGTXA3+3LmCPZ3N39dIeB5o75Y2v2OqebBpWsWpdqH+G4McmRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766927831; c=relaxed/simple;
	bh=crYlwRlqaJavxXix+Gjl2xj2LDbppnAwbmN4FTzg9ic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PmLSDQt+MJobii6pHcgkyKxXf/aE53rWmqyUmlYw15o97rtlwgDfcxJSTudVrs+FQ9NSfWu1bmS5HT0gYf0LwIBFit2fG9DhvqtiV6tKQB1P5TnKVtsRrifDwmJ4q4zcbjasnzpXRsDjdRnC1CV2N1Z12U19jZatVAF9+mWJZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zRrPGK7F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zRrPGK7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C61C4CEFB;
	Sun, 28 Dec 2025 13:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766927830;
	bh=crYlwRlqaJavxXix+Gjl2xj2LDbppnAwbmN4FTzg9ic=;
	h=From:To:Cc:Subject:Date:From;
	b=zRrPGK7F2ivs+i4NLX3/FhOTS7NVru6dZU3YM325f292MShJ2UJuTFC0DroXDK5tP
	 wSofBsZ21lJT0naY66oiK5X6E1D3yFRbgVkP7gBoNCmNFgHZ7w/oa7cLfnlJItMKc9
	 wWdfCp0OmF2EuipK4XkMpDxOrQiSf/PG2RjZFj2U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tianchu Chen <flynnnchen@tencent.com>,
	stable <stable@kernel.org>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH] fbdev: smscufx: properly copy ioctl memory to kernelspace
Date: Sun, 28 Dec 2025 14:17:03 +0100
Message-ID: <2025122802-radiance-vacancy-11da@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=crYlwRlqaJavxXix+Gjl2xj2LDbppnAwbmN4FTzg9ic=; b=owGbwMvMwCRo6H6F97bub03G02pJDJmBuufOG3/fNvnx1slm+70bti9Z4xwoUDShZerMGdv3r zp7f2ZVQUcsC4MgE4OsmCLLl208R/dXHFL0MrQ9DTOHlQlkCAMXpwBMJKibYX6QvDH//tAMg9XH nfx8WTbLb3Ge9ZxhDl//HfdoJp6ExxKNNyXVDi+b8c2YEwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The UFX_IOCTL_REPORT_DAMAGE ioctl does not properly copy data from
userspace to kernelspace, and instead directly references the memory,
which can cause problems if invalid data is passed from userspace.  Fix
this all up by correctly copying the memory before accessing it within
the kernel.

Reported-by: Tianchu Chen <flynnnchen@tencent.com>
Cc: stable <stable@kernel.org>
Cc: Steve Glendinning <steve.glendinning@shawell.net>
Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/smscufx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 5f0dd01fd834..891ce7b76d63 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -932,7 +932,6 @@ static int ufx_ops_ioctl(struct fb_info *info, unsigned int cmd,
 			 unsigned long arg)
 {
 	struct ufx_data *dev = info->par;
-	struct dloarea *area = NULL;
 
 	if (!atomic_read(&dev->usb_active))
 		return 0;
@@ -947,6 +946,10 @@ static int ufx_ops_ioctl(struct fb_info *info, unsigned int cmd,
 
 	/* TODO: Help propose a standard fb.h ioctl to report mmap damage */
 	if (cmd == UFX_IOCTL_REPORT_DAMAGE) {
+		struct dloarea *area __free(kfree) = kmalloc(sizeof(*area), GFP_KERNEL);
+		if (!area)
+			return -ENOMEM;
+
 		/* If we have a damage-aware client, turn fb_defio "off"
 		 * To avoid perf imact of unnecessary page fault handling.
 		 * Done by resetting the delay for this fb_info to a very
@@ -956,7 +959,8 @@ static int ufx_ops_ioctl(struct fb_info *info, unsigned int cmd,
 		if (info->fbdefio)
 			info->fbdefio->delay = UFX_DEFIO_WRITE_DISABLE;
 
-		area = (struct dloarea *)arg;
+		if (copy_from_user(area, (u8 __user *)arg, sizeof(*area)))
+			return -EFAULT;
 
 		if (area->x < 0)
 			area->x = 0;
-- 
2.52.0


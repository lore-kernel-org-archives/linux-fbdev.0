Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B9347A0C3;
	Wed, 23 Sep 2026 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154584; cv=none; b=kOKWQpyqd8GxTw2LyrrGWgfkBhJJa1sfIUp5JuifeGDKuy1PpItLijeS7Ay/RgAPKvScUZpH0LS8AnCaG4tovuemUkmy8baq8KJDtW+NNV6K3bDTJUz+M+aDgvZbgxTyJMnFRJGxNlx2U53LeORSQl62++oFxp357B4/MvvFJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154584; c=relaxed/simple;
	bh=5tMF/y/2lHq35n8+ZKRafbktmyjplBB/jZZEPef+IOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FvxRkcTqns5em9U6az2JQX4hfr5EdI+4xY9kwfeiET0HH4owzasyQ7IU+9EEo+pqrOaYF/jpHKTZ9jgbBNhyLpVlrTOaOwHSgkNYybQnvscXymji0bS8VG4Knk5gKwmB9Zyr74i1zN2eTQfwDpHHUUhM6Ho1GJo9WRLD1deog74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830B91F000FF;
	Wed, 23 Sep 2026 09:09:41 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Helge Deller <deller@gmx.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] video/logo: Improve logo help texts
Date: Wed, 23 Sep 2026 11:09:38 +0200
Message-ID: <024a2d7e9a6b63d261f6ca4afb1a75d4f540defa.1790154481.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit dfa6ce636cb8faea ("video/logo: allow custom logo"), the
LOGO_LINUX_{MONO,VGA16,CLUT224} configuration options no longer control
the inclusion of the "standard" Linux logo, but the inclusion of
(possibly custom) logos specified through the correspondig *_FILE
options.

Adjust the one-line prompt to reflect this.
Add long help texts while at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/video/logo/Kconfig | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index cda15b95891ed3a8..3cb66ac88d6be0fe 100644
--- a/drivers/video/logo/Kconfig
+++ b/drivers/video/logo/Kconfig
@@ -19,7 +19,11 @@ config FB_LOGO_EXTRA
 	default y if SPU_BASE
 
 config LOGO_LINUX_MONO
-	bool "Standard black and white Linux logo"
+	bool "Black and white Linux logo"
+	help
+	  Include a monochrome (black and white) Linux logo.
+	  This logo can be shown on all kinds of displays.
+	  Say Y to show a logo on monochrome displays.
 
 config LOGO_LINUX_MONO_FILE
 	string "Monochrome logo .pbm file"
@@ -36,7 +40,13 @@ config LOGO_LINUX_MONO_FILE
 	    magick source_image -compress none destination.pbm
 
 config LOGO_LINUX_VGA16
-	bool "Standard 16-color Linux logo"
+	bool "16-color Linux logo"
+	help
+	  Include a 16-color Linux logo.
+	  This logo can be shown on displays that support showing (at least)
+	  the standard VGA 16 color palette.
+	  Say Y to show a logo on color displays that are limited to less than
+	  256 colors.
 
 config LOGO_LINUX_VGA16_FILE
 	string "16-color logo .ppm file"
@@ -55,8 +65,13 @@ config LOGO_LINUX_VGA16_FILE
 	      -remap drivers/video/logo/clut_vga16.ppm destination.ppm
 
 config LOGO_LINUX_CLUT224
-	bool "Standard 224-color Linux logo"
+	bool "224-color Linux logo"
 	default y
+	help
+	  Include a 224-color Linux logo.
+	  This logo can be shown on displays that support showing a palette of
+	  256 or more colors.
+	  Say Y to show a logo on colorful displays.
 
 config LOGO_LINUX_CLUT224_FILE
 	string "224-color logo .ppm file"
-- 
2.43.0


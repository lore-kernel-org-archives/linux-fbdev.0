Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670D2DE6FA;
	Thu,  1 Jan 2026 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767281158; cv=none; b=aczP/yT2UudHkLKTHnw4nSHd6pR8UuaE4na89n6XrTH8vs3m/RUzBalR71HnS2zBK6pvw2aSDdobcPgGCDiKpuILoSu8cBkGtVcx4GMGd6pXW8Efsdgx6UWIaq+8C0xtMkaLWElW6vmEBl3qUXKWL7zxTAPSn3GQfKMtiWuWvfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767281158; c=relaxed/simple;
	bh=gtqLKaPEROvOwx883495hrk9NUNwDLHOl6hXc0CN0IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NLepYTxufpgj2jMERjp4yE9mAHBIBKlr2a+uOB++LFkaXjSUm4FFuLOTaYQ6IN4AUOJfBSOOD6WKBXerMQV0JarqmKp4AeG5gDySbUqiJgs6RqtxHAnTt9v/6+g8Pi0i63P+N/Axwwbq3k0Ml9FlW6ZyHBqgmeUzg1iwgj3x540=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiB8/56D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiB8/56D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8DAC4CEF7;
	Thu,  1 Jan 2026 15:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767281158;
	bh=gtqLKaPEROvOwx883495hrk9NUNwDLHOl6hXc0CN0IQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MiB8/56Do1UMk1qmOfyDoZN+vq969Zm1beOb3u3NUPVqJ5GgD6nmAGCzHENPiania
	 4BRR6iMpRPHt0EuvZnLiS62q8J/zk57bU2Hg2ZxAYRbqkYqajWYWF67aCUbrkrFemM
	 cRfR0666dKRYEHQ0Vx95Y8tilGvrpQpjTRBYDg7q+Yl7s5x8PcCqZ1ACHT3JwJiBFk
	 Tzx61LxkIfH3K8U5q+JAnhAoyViBhYycRh5i8+cvYGGHm5AUneZ+OCun49DAMX/rdd
	 jjH2PMdPdF5CZq0SbkQND3MiQQVvvWVWhWrSxLR1GshWmuXn2g8cDlYczKLjWxAv/j
	 eSIEfvQRNTq4A==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 01 Jan 2026 16:25:17 +0100
Subject: [PATCH v2 3/6] video/logo: allow custom logo
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-custom-logo-v2-3-8eec06dfbf85@kernel.org>
References: <20260101-custom-logo-v2-0-8eec06dfbf85@kernel.org>
In-Reply-To: <20260101-custom-logo-v2-0-8eec06dfbf85@kernel.org>
To: Helge Deller <deller@gmx.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4512; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=gtqLKaPEROvOwx883495hrk9NUNwDLHOl6hXc0CN0IQ=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJlhE9/qzFj0TW+6lN/aw3UtlVc1p5Z0Gl7v2GHZ3lnNk
 8H3ef6sjoksDGJcDJZiiizLyjm5FToKvcMO/bWEmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 DXWATAYuTgGY6nOaDP8L/t8NVmmL27N5T/bas/fulQaqvqubyrDo573uCQEhm1+UMPz32CY58V+
 gdq31dfdG/j7f4q1CZUv27rz685daVHWyjxQTAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Some people like to replace the default Tux boot logo by an image of
their own. There exist a few tutorials here [1] and there [2]. But
this requires modifying the sources which is a bit cumbersome.

Add a string entry in Kbuild for each of the logo categories
(monochrome, 16-colors, 224-colors). The string entry takes a path to
a .pbm or .ppm image allowing the user to more easily provide a custom
logo without having to modify the sources.

Add an help entry with a short hint on how to convert images to the
portable pixmap file format.

Update the Makefile accordingly. When converted to .c file, the logo
will have one of these fixed file name:

  - logo_linux_mono.c
  - logo_linux_vga16.c
  - logo_linux_clut224.c:

depending on the image type and this regardless of the name of the
.pgm/.ppm source filename. This will allow for further simplifications
in an upcoming change.

[1] ArmadeuS Project wiki -- Linux Boot Logo
Link: https://www.armadeus.org/wiki/index.php?title=Linux_Boot_Logo

[2] Timesys -- How To Use a Custom Boot Logo / Splash Screen
Link: https://linuxlink.timesys.com/docs/wiki/engineering/HOWTO_Use_a_custom_boot_logo

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/video/logo/Kconfig  | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/video/logo/Makefile | 11 ++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index ce6bb753522d..1d1651c067a1 100644
--- a/drivers/video/logo/Kconfig
+++ b/drivers/video/logo/Kconfig
@@ -22,14 +22,55 @@ config LOGO_LINUX_MONO
 	bool "Standard black and white Linux logo"
 	default y
 
+config LOGO_LINUX_MONO_FILE
+	string "Monochrome logo .pbm file"
+	depends on LOGO_LINUX_MONO
+	default "drivers/video/logo/logo_linux_mono.pbm"
+	help
+	  Takes a path to a monochromatic logo in the portable pixmap file
+	  format (.pbm). This defaults to the Tux penguin.
+
+	  For example, the below ImageMagick command can be used to reduce
+	  an image to black and white and convert it into a pbm file:
+
+	    magick source_image -compress none destination.pbm
+
 config LOGO_LINUX_VGA16
 	bool "Standard 16-color Linux logo"
 	default y
 
+config LOGO_LINUX_VGA16_FILE
+	string "16-color logo .ppm file"
+	depends on LOGO_LINUX_VGA16
+	default "drivers/video/logo/logo_linux_vga16.ppm"
+	help
+	  Takes a path to a logo in the portable pixmap file format (.ppm),
+	  using the 16 colors from the drivers/video/logo/clut_vga16.ppm
+	  palette. This defaults to the Tux penguin.
+
+	  For example, the below ImageMagick command can be used to reduce an
+	  image to the VGA 16 colors palette and convert into a ppm file:
+
+	    magick source_image -compress none \
+	      -remap drivers/video/logo/clut_vga16.ppm destination.ppm
+
 config LOGO_LINUX_CLUT224
 	bool "Standard 224-color Linux logo"
 	default y
 
+config LOGO_LINUX_CLUT224_FILE
+	string "224-color logo .ppm file"
+	depends on LOGO_LINUX_CLUT224
+	default "drivers/video/logo/logo_linux_clut224.ppm"
+	help
+	  Takes a path to a 224-color logo in the portable pixmap file
+	  format (.ppm). This defaults to the Tux penguin.
+
+	  For example, the below ImageMagick command can be used to reduce
+	  an image palette to 224 colors and convert it into a ppm file:
+
+	    magick source_image -compress none -colors 224 destination.ppm
+
 config LOGO_DEC_CLUT224
 	bool "224-color Digital Equipment Corporation Linux logo"
 	depends on MACH_DECSTATION || ALPHA
diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 3f249e9dcf37..ac8e9da3f51a 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -22,7 +22,16 @@ hostprogs := pnmtologo
 
 # Create commands like "pnmtologo -t mono -n logo_mac_mono -o ..."
 quiet_cmd_logo = LOGO    $@
-      cmd_logo = $(obj)/pnmtologo -t $2 -n $* -o $@ $<
+      cmd_logo = $(obj)/pnmtologo -t $2 -n $(basename $(notdir $@)) -o $@ $<
+
+$(obj)/logo_linux_mono.c: $(CONFIG_LOGO_LINUX_MONO_FILE) $(obj)/pnmtologo FORCE
+	$(call if_changed,logo,mono)
+
+$(obj)/logo_linux_vga16.c: $(CONFIG_LOGO_LINUX_VGA16_FILE) $(obj)/pnmtologo FORCE
+	$(call if_changed,logo,vga16)
+
+$(obj)/logo_linux_clut224.c: $(CONFIG_LOGO_LINUX_CLUT224_FILE) $(obj)/pnmtologo FORCE
+	$(call if_changed,logo,clut224)
 
 $(obj)/%.c: $(src)/%.pbm $(obj)/pnmtologo FORCE
 	$(call if_changed,logo,mono)

-- 
2.52.0


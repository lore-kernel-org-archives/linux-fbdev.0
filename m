Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C1A2DE6F3;
	Thu,  1 Jan 2026 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767281165; cv=none; b=pUaeLu7dTgEtn89A6Z7Pua93e3eALADainvRWVLO73BPbLUb4xJHfENa/E6YBaMEwl8Jf5/gspZIePmtJKm/RPbSWIA40FwkeWXY3heSR0JPZA3Of/6KDofYO0jIuTrdVrXoFd2R8WI2bstv8eV2eSfa5qZGfbaRxKdX2lff9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767281165; c=relaxed/simple;
	bh=c9rs47Rq9JsGR2S4cjbA10der3BMDGHlAJIPw4Woy/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L1Ojl7EiO34vOsISKRJ5Bnoex8ffu6G4Fp37VfQuDeBq9NFBA5KmurluEJDjGpLs3zmzuG32wY7UO7IvKaScMkpFABwmiZ5Zb7mzIzEXvbMATuLjz1WMlu/U838yeZvHT2s6Sq7PljHv5IY18CmRCVwNi0Xodg+3omw2PS8FsUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss2CuzqI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss2CuzqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D62C19423;
	Thu,  1 Jan 2026 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767281164;
	bh=c9rs47Rq9JsGR2S4cjbA10der3BMDGHlAJIPw4Woy/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ss2CuzqIjsc6+WbNYlMSXZia6DjiHdiscnwEoIUyFEOBxAbphyT9C7NutJ+90eHx1
	 KY2SdMpmhYXuLcaXXPr/bVHKElfE5Id8TzUuH4cTCwnuZrO3aJhfrMGgg3xDmXWaFD
	 ccfW1m3DcxJ8ONzwtFs5IcdFmak17yR5NWcpi9yzDBUS0m5LEmYo+h7gsGqYMUTwSV
	 LVWEPEw7n6bJdnNi90dn4ADnVA8cQmCnHhanmOWWlqnJZFld7n0tsQv4OgYXi+YCLX
	 iFL3ox/K+w1RMDXIiDn/W82yC49gpQlrUbYS3z2HMiGdahjf5txUUfZGWYlYa055v8
	 x/leN1R8DRp9Q==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 01 Jan 2026 16:25:19 +0100
Subject: [PATCH v2 5/6] sh: defconfig: remove CONFIG_LOGO_SUPERH_*
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-custom-logo-v2-5-8eec06dfbf85@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5952; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=c9rs47Rq9JsGR2S4cjbA10der3BMDGHlAJIPw4Woy/o=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJlhEz+vlA0r8Sz3vPBO/t+eusPvj5mvyFh/6ekt3U/qT
 3qubZL73zGRhUGMi8FSTJFlWTknt0JHoXfYob+WMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaEOkMnAxSkAU628gpHhH/u6uh+HBM8FTbG5mlqmoukgErHPfFfcWq98gaSS+4cMGP6ZHLwx/9s
 V13POytpLqsRjUk9znH7o89bnQc3tXUKi245wAAA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

CONFIG_LOGO_SUPERH_MONO, CONFIG_LOGO_SUPERH_VGA16 and
CONFIG_LOGO_SUPERH_CLUT224 will be removed in an upcoming change but
are still referenced in some of the defconfig.

Remove all the occurrences of CONFIG_LOGO_SUPERH_*.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 arch/sh/configs/dreamcast_defconfig      | 2 --
 arch/sh/configs/ecovec24_defconfig       | 2 --
 arch/sh/configs/kfr2r09_defconfig        | 2 --
 arch/sh/configs/migor_defconfig          | 2 --
 arch/sh/configs/rts7751r2d1_defconfig    | 2 --
 arch/sh/configs/rts7751r2dplus_defconfig | 2 --
 arch/sh/configs/se7724_defconfig         | 2 --
 arch/sh/configs/se7780_defconfig         | 2 --
 arch/sh/configs/sh7785lcr_defconfig      | 3 ---
 arch/sh/configs/urquell_defconfig        | 3 ---
 10 files changed, 22 deletions(-)

diff --git a/arch/sh/configs/dreamcast_defconfig b/arch/sh/configs/dreamcast_defconfig
index 4573d5d64989..dd58797e8298 100644
--- a/arch/sh/configs/dreamcast_defconfig
+++ b/arch/sh/configs/dreamcast_defconfig
@@ -60,8 +60,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 # CONFIG_LOGO_LINUX_CLUT224 is not set
-# CONFIG_LOGO_SUPERH_MONO is not set
-# CONFIG_LOGO_SUPERH_VGA16 is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index 458115d83184..e751933ac840 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -78,8 +78,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 # CONFIG_LOGO_LINUX_CLUT224 is not set
-# CONFIG_LOGO_SUPERH_MONO is not set
-# CONFIG_LOGO_SUPERH_VGA16 is not set
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SEQUENCER=y
diff --git a/arch/sh/configs/kfr2r09_defconfig b/arch/sh/configs/kfr2r09_defconfig
index d80e83e7ec38..056ba52600f9 100644
--- a/arch/sh/configs/kfr2r09_defconfig
+++ b/arch/sh/configs/kfr2r09_defconfig
@@ -66,8 +66,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 # CONFIG_LOGO_LINUX_CLUT224 is not set
-# CONFIG_LOGO_SUPERH_MONO is not set
-# CONFIG_LOGO_SUPERH_CLUT224 is not set
 CONFIG_USB_GADGET=y
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
diff --git a/arch/sh/configs/migor_defconfig b/arch/sh/configs/migor_defconfig
index 7cdaa909ffd6..1d9d543eef4c 100644
--- a/arch/sh/configs/migor_defconfig
+++ b/arch/sh/configs/migor_defconfig
@@ -71,8 +71,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 # CONFIG_LOGO_LINUX_CLUT224 is not set
-# CONFIG_LOGO_SUPERH_MONO is not set
-# CONFIG_LOGO_SUPERH_CLUT224 is not set
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_M66592=y
 CONFIG_USB_G_SERIAL=m
diff --git a/arch/sh/configs/rts7751r2d1_defconfig b/arch/sh/configs/rts7751r2d1_defconfig
index 0c54ab2b06e6..745490d4807f 100644
--- a/arch/sh/configs/rts7751r2d1_defconfig
+++ b/arch/sh/configs/rts7751r2d1_defconfig
@@ -50,8 +50,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 # CONFIG_LOGO_LINUX_CLUT224 is not set
-# CONFIG_LOGO_SUPERH_MONO is not set
-# CONFIG_LOGO_SUPERH_VGA16 is not set
 CONFIG_SOUND=y
 CONFIG_SND=m
 CONFIG_SND_YMFPCI=m
diff --git a/arch/sh/configs/rts7751r2dplus_defconfig b/arch/sh/configs/rts7751r2dplus_defconfig
index 3173b616b2cb..cd90f5354459 100644
--- a/arch/sh/configs/rts7751r2dplus_defconfig
+++ b/arch/sh/configs/rts7751r2dplus_defconfig
@@ -55,8 +55,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 # CONFIG_LOGO_LINUX_CLUT224 is not set
-# CONFIG_LOGO_SUPERH_MONO is not set
-# CONFIG_LOGO_SUPERH_VGA16 is not set
 CONFIG_SOUND=y
 CONFIG_SND=m
 CONFIG_SND_YMFPCI=m
diff --git a/arch/sh/configs/se7724_defconfig b/arch/sh/configs/se7724_defconfig
index 8ca46d704c8b..9b4f8f3a1fdf 100644
--- a/arch/sh/configs/se7724_defconfig
+++ b/arch/sh/configs/se7724_defconfig
@@ -79,8 +79,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 # CONFIG_LOGO_LINUX_CLUT224 is not set
-# CONFIG_LOGO_SUPERH_MONO is not set
-# CONFIG_LOGO_SUPERH_VGA16 is not set
 CONFIG_SOUND=y
 CONFIG_SND=m
 # CONFIG_SND_DRIVERS is not set
diff --git a/arch/sh/configs/se7780_defconfig b/arch/sh/configs/se7780_defconfig
index 12463b766120..13fa6a59b8f1 100644
--- a/arch/sh/configs/se7780_defconfig
+++ b/arch/sh/configs/se7780_defconfig
@@ -66,8 +66,6 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
-# CONFIG_LOGO_SUPERH_MONO is not set
-# CONFIG_LOGO_SUPERH_VGA16 is not set
 CONFIG_SOUND=y
 CONFIG_SOUND_PRIME=y
 CONFIG_HID_A4TECH=y
diff --git a/arch/sh/configs/sh7785lcr_defconfig b/arch/sh/configs/sh7785lcr_defconfig
index 2fcf50d8c820..8738c590d5a0 100644
--- a/arch/sh/configs/sh7785lcr_defconfig
+++ b/arch/sh/configs/sh7785lcr_defconfig
@@ -60,9 +60,6 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
-# CONFIG_LOGO_SUPERH_MONO is not set
-# CONFIG_LOGO_SUPERH_VGA16 is not set
-# CONFIG_LOGO_SUPERH_CLUT224 is not set
 CONFIG_HID_A4TECH=y
 CONFIG_HID_APPLE=y
 CONFIG_HID_BELKIN=y
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index f51ff6b1ec38..e7924db29b69 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -86,9 +86,6 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
-# CONFIG_LOGO_SUPERH_MONO is not set
-# CONFIG_LOGO_SUPERH_VGA16 is not set
-# CONFIG_LOGO_SUPERH_CLUT224 is not set
 CONFIG_HID_A4TECH=y
 CONFIG_HID_APPLE=y
 CONFIG_HID_BELKIN=y

-- 
2.52.0


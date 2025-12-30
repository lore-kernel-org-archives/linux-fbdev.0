Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62A32BD597;
	Tue, 30 Dec 2025 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767133246; cv=none; b=Rh8BojDwz+HrBbi3+RyrYtB/No6gYtzCouqmAcPzDrRNSROUG4vNLtkNo9LtS8VDTkv1t2T+lC3B0mkNkGxio1g1uSxxmTjKOiOmouV2I3OwiNom5voN7v1j1JgBQ7UZgSJ37Xv72h/8V0cLqt1a72JOcYOHKd0cSfk6SzHxkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767133246; c=relaxed/simple;
	bh=NNCSULr2nRdE2yYWQR8DwWPhpf7lqz4No+9QPkhz7fU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rcSqVN5+b5njMRyeXA0TYm7oJm8JqmxgbzH57uvEQJLxOLt/f5Tej2mCbeDOHPAVdVgjDMUngBFBc9EP795ITeJGQ0zWiC3R4RTsbczHzCVRDaDezJ+CNRk1zUl5EBZk7gml52beJc/zpabaPjUClg404DZ5CSYIK9Iw3WvvmU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRkcgSNB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRkcgSNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAC0C113D0;
	Tue, 30 Dec 2025 22:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767133246;
	bh=NNCSULr2nRdE2yYWQR8DwWPhpf7lqz4No+9QPkhz7fU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qRkcgSNBcPguuY/ndScjetUz8gZf8VpwWDvFBamXau7VLtAbdMkNLh01o3MQ2J4Av
	 hKlGkm5KtQ5ke73AyNbnnYSuA9zJGjzT9++tV1ePxHiUf4x94uYEyhV6EtBLvEkMkM
	 yZA8m1F9DepWU9UB5WLP8XzJ4ctPsdqBQd5OYxzWL9kCmC+O6qy6ZEZNtOeqwOf2oE
	 QeQ4z3MJIXvHedHMOfL/vfkFqw3MelRceuDF80y9ghUaKjmD9aycuAZsZG5LcOCAxm
	 JLsHzNNEzFElRklwGf4ru6VMTXULscVvhcshXV3C6szO9GxCfHj1/Qd3jQbj5GJ0Nf
	 r7RTo8WIiI6pQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 30 Dec 2025 23:20:05 +0100
Subject: [PATCH 6/6] video/logo: move logo selection logic to Kconfig
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251230-custom-logo-v1-6-4736374569ee@kernel.org>
References: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>
In-Reply-To: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>
To: Helge Deller <deller@gmx.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7578; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=NNCSULr2nRdE2yYWQR8DwWPhpf7lqz4No+9QPkhz7fU=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJkhAarP5c2f/p45d23xMpentp8lQy57Wdz1NPCv17F92
 ma/RIurYyILgxgXg6WYIsuyck5uhY5C77BDfy1h5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 Qx0gk4GLUwCm2vQVI0PfxNsMe27uk1M8yRhwjV17pwZb3vrKNfssn4X+l+j4szKRkaHXjUmqYxN
 jgtLs/VmXTkgEH1E4GlqlHud6/MOBZdJPtnMCAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Now that the path to the logo file can be directly entered in Kbuild,
there is no more need to handle all the logo file selection in the
Makefile and the C files.

Move all the logo file selection logic to Kbuild, this done, clean-up
the C code to only leave one entry for each logo type (monochrome,
16-colors and 224-colors).

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/video/logo/Kconfig  | 49 +++++++++------------------------------------
 drivers/video/logo/Makefile | 21 +------------------
 drivers/video/logo/logo.c   | 46 ++++--------------------------------------
 include/linux/linux_logo.h  |  9 ---------
 4 files changed, 14 insertions(+), 111 deletions(-)

diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index 1d1651c067a1..9bf8f14c6856 100644
--- a/drivers/video/logo/Kconfig
+++ b/drivers/video/logo/Kconfig
@@ -25,6 +25,7 @@ config LOGO_LINUX_MONO
 config LOGO_LINUX_MONO_FILE
 	string "Monochrome logo .pbm file"
 	depends on LOGO_LINUX_MONO
+	default "drivers/video/logo/logo_superh_mono.pbm" if SUPERH
 	default "drivers/video/logo/logo_linux_mono.pbm"
 	help
 	  Takes a path to a monochromatic logo in the portable pixmap file
@@ -42,6 +43,7 @@ config LOGO_LINUX_VGA16
 config LOGO_LINUX_VGA16_FILE
 	string "16-color logo .ppm file"
 	depends on LOGO_LINUX_VGA16
+	default "drivers/video/logo/logo_superh_vga16.ppm" if SUPERH
 	default "drivers/video/logo/logo_linux_vga16.ppm"
 	help
 	  Takes a path to a logo in the portable pixmap file format (.ppm),
@@ -61,6 +63,13 @@ config LOGO_LINUX_CLUT224
 config LOGO_LINUX_CLUT224_FILE
 	string "224-color logo .ppm file"
 	depends on LOGO_LINUX_CLUT224
+	default "drivers/video/logo/logo_dec_clut224.ppm" if MACH_DECSTATION || ALPHA
+	default "drivers/video/logo/logo_mac_clut224.ppm" if MAC
+	default "drivers/video/logo/logo_parisc_clut224.ppm" if PARISC
+	default "drivers/video/logo/logo_sgi_clut224.ppm" if SGI_IP22 || SGI_IP27 || SGI_IP32
+	default "drivers/video/logo/logo_sun_clut224.ppm" if SPARC
+	default "drivers/video/logo/logo_superh_clut224.ppm" if SUPERH
+	default "drivers/video/logo/logo_spe_clut224.ppm" if SPU_BASE
 	default "drivers/video/logo/logo_linux_clut224.ppm"
 	help
 	  Takes a path to a 224-color logo in the portable pixmap file
@@ -71,44 +80,4 @@ config LOGO_LINUX_CLUT224_FILE
 
 	    magick source_image -compress none -colors 224 destination.ppm
 
-config LOGO_DEC_CLUT224
-	bool "224-color Digital Equipment Corporation Linux logo"
-	depends on MACH_DECSTATION || ALPHA
-	default y
-
-config LOGO_MAC_CLUT224
-	bool "224-color Macintosh Linux logo"
-	depends on MAC
-	default y
-
-config LOGO_PARISC_CLUT224
-	bool "224-color PA-RISC Linux logo"
-	depends on PARISC
-	default y
-
-config LOGO_SGI_CLUT224
-	bool "224-color SGI Linux logo"
-	depends on SGI_IP22 || SGI_IP27 || SGI_IP32
-	default y
-
-config LOGO_SUN_CLUT224
-	bool "224-color Sun Linux logo"
-	depends on SPARC
-	default y
-
-config LOGO_SUPERH_MONO
-	bool "Black and white SuperH Linux logo"
-	depends on SUPERH
-	default y
-
-config LOGO_SUPERH_VGA16
-	bool "16-color SuperH Linux logo"
-	depends on SUPERH
-	default y
-
-config LOGO_SUPERH_CLUT224
-	bool "224-color SuperH Linux logo"
-	depends on SUPERH
-	default y
-
 endif # LOGO
diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index ac8e9da3f51a..c32238fddaa6 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -5,16 +5,6 @@ obj-$(CONFIG_LOGO)			+= logo.o
 obj-$(CONFIG_LOGO_LINUX_MONO)		+= logo_linux_mono.o
 obj-$(CONFIG_LOGO_LINUX_VGA16)		+= logo_linux_vga16.o
 obj-$(CONFIG_LOGO_LINUX_CLUT224)	+= logo_linux_clut224.o
-obj-$(CONFIG_LOGO_DEC_CLUT224)		+= logo_dec_clut224.o
-obj-$(CONFIG_LOGO_MAC_CLUT224)		+= logo_mac_clut224.o
-obj-$(CONFIG_LOGO_PARISC_CLUT224)	+= logo_parisc_clut224.o
-obj-$(CONFIG_LOGO_SGI_CLUT224)		+= logo_sgi_clut224.o
-obj-$(CONFIG_LOGO_SUN_CLUT224)		+= logo_sun_clut224.o
-obj-$(CONFIG_LOGO_SUPERH_MONO)		+= logo_superh_mono.o
-obj-$(CONFIG_LOGO_SUPERH_VGA16)		+= logo_superh_vga16.o
-obj-$(CONFIG_LOGO_SUPERH_CLUT224)	+= logo_superh_clut224.o
-
-obj-$(CONFIG_SPU_BASE)			+= logo_spe_clut224.o
 
 # How to generate logo's
 
@@ -33,14 +23,5 @@ $(obj)/logo_linux_vga16.c: $(CONFIG_LOGO_LINUX_VGA16_FILE) $(obj)/pnmtologo FORC
 $(obj)/logo_linux_clut224.c: $(CONFIG_LOGO_LINUX_CLUT224_FILE) $(obj)/pnmtologo FORCE
 	$(call if_changed,logo,clut224)
 
-$(obj)/%.c: $(src)/%.pbm $(obj)/pnmtologo FORCE
-	$(call if_changed,logo,mono)
-
-$(obj)/%_vga16.c: $(src)/%_vga16.ppm $(obj)/pnmtologo FORCE
-	$(call if_changed,logo,vga16)
-
-$(obj)/%_clut224.c: $(src)/%_clut224.ppm $(obj)/pnmtologo FORCE
-	$(call if_changed,logo,clut224)
-
 # generated C files
-targets += *_mono.c *_vga16.c *_clut224.c
+targets += logo_linux_mono.c logo_linux_vga16.c logo_linux_clut224.c
diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index 141f15a9a459..91535f8848da 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -48,59 +48,21 @@ const struct linux_logo * __ref fb_find_logo(int depth)
 	if (nologo || logos_freed)
 		return NULL;
 
-	if (depth >= 1) {
 #ifdef CONFIG_LOGO_LINUX_MONO
-		/* Generic Linux logo */
+	if (depth >= 1)
 		logo = &logo_linux_mono;
 #endif
-#ifdef CONFIG_LOGO_SUPERH_MONO
-		/* SuperH Linux logo */
-		logo = &logo_superh_mono;
-#endif
-	}
 	
-	if (depth >= 4) {
 #ifdef CONFIG_LOGO_LINUX_VGA16
-		/* Generic Linux logo */
+	if (depth >= 4)
 		logo = &logo_linux_vga16;
 #endif
-#ifdef CONFIG_LOGO_SUPERH_VGA16
-		/* SuperH Linux logo */
-		logo = &logo_superh_vga16;
-#endif
-	}
 	
-	if (depth >= 8) {
 #ifdef CONFIG_LOGO_LINUX_CLUT224
-		/* Generic Linux logo */
+	if (depth >= 8)
 		logo = &logo_linux_clut224;
 #endif
-#ifdef CONFIG_LOGO_DEC_CLUT224
-		/* DEC Linux logo on MIPS/MIPS64 or ALPHA */
-		logo = &logo_dec_clut224;
-#endif
-#ifdef CONFIG_LOGO_MAC_CLUT224
-		/* Macintosh Linux logo on m68k */
-		if (MACH_IS_MAC)
-			logo = &logo_mac_clut224;
-#endif
-#ifdef CONFIG_LOGO_PARISC_CLUT224
-		/* PA-RISC Linux logo */
-		logo = &logo_parisc_clut224;
-#endif
-#ifdef CONFIG_LOGO_SGI_CLUT224
-		/* SGI Linux logo on MIPS/MIPS64 */
-		logo = &logo_sgi_clut224;
-#endif
-#ifdef CONFIG_LOGO_SUN_CLUT224
-		/* Sun Linux logo */
-		logo = &logo_sun_clut224;
-#endif
-#ifdef CONFIG_LOGO_SUPERH_CLUT224
-		/* SuperH Linux logo */
-		logo = &logo_superh_clut224;
-#endif
-	}
+
 	return logo;
 }
 EXPORT_SYMBOL_GPL(fb_find_logo);
diff --git a/include/linux/linux_logo.h b/include/linux/linux_logo.h
index e37699b7e839..d5a66af27fd9 100644
--- a/include/linux/linux_logo.h
+++ b/include/linux/linux_logo.h
@@ -33,15 +33,6 @@ struct linux_logo {
 extern const struct linux_logo logo_linux_mono;
 extern const struct linux_logo logo_linux_vga16;
 extern const struct linux_logo logo_linux_clut224;
-extern const struct linux_logo logo_dec_clut224;
-extern const struct linux_logo logo_mac_clut224;
-extern const struct linux_logo logo_parisc_clut224;
-extern const struct linux_logo logo_sgi_clut224;
-extern const struct linux_logo logo_sun_clut224;
-extern const struct linux_logo logo_superh_mono;
-extern const struct linux_logo logo_superh_vga16;
-extern const struct linux_logo logo_superh_clut224;
-extern const struct linux_logo logo_spe_clut224;
 
 extern const struct linux_logo *fb_find_logo(int depth);
 #ifdef CONFIG_FB_LOGO_EXTRA

-- 
2.51.2


Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9B495036
	for <linux-fbdev@vger.kernel.org>; Thu, 27 Aug 2026 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856640; cv=none; b=UphyqPfesv72P/B5rSfM7EMkwbCH/rKc3is5+X5VpMggUHDr7zwQ04JBnhsoU6gt1ls02SQ17MD6TJ0cMw24GA2hfrev91GmNdPzaSZIKP0/GlpHpgUr0EZij1DrsqgguD3jJSjLPP2aByL7NP2RTv9ILnbcq4xjpxQ+N1Mkhuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856640; c=relaxed/simple;
	bh=eqhWNla3CHBLC6LNETZCUoNSGmVWhcTFwVqs4rVNZP8=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=h3M8KK94DQgvoqju0t39dVICAa420m2eQNx3nJ59noTv2mdK2EKCuRdBEVUL2OVbxdhnPData+y3+twodKJ8zSy8JDtaOg5ugJTEtBY4LRS3sZqVXqQkkRJ/TULu/uL+DpLXDk7zJB4PDrQbXdr+W2wL/CTyyEawRWObGNlh6SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 19691 invoked by uid 3782); 27 Aug 2026 20:50:37 +0200
Received: from muc.de (p4fe15cdf.dip0.t-ipconnect.de [79.225.92.223]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Thu, 27 Aug 2026 20:50:36 +0200
Received: (qmail 31100 invoked by uid 1000); 27 Aug 2026 18:50:35 -0000
Date: Thu, 27 Aug 2026 18:50:35 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
  Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
  linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: acm@muc.de
Subject: [Patch 5/9]: vt: Amend three Kconfig files
Message-ID: <apCG-zHyuMVYHJ6j@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apCEDM2sWv_M354-@MAC.fritz.box>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de


vt: 32b glyph: 5. Amend three Kconfig files

Until it becomes clear how to integrate CONFIG_A11Y_BRAILLE_CONSOLE and
CONFIG_SPEAKUP, they will remain disabled when CONFIG_FB_GLYPH_21BIT is
#defined.

Signed-off-by: Alan Mackenzie <acm@muc.de>

diff --git a/drivers/accessibility/Kconfig b/drivers/accessibility/Kconfig
index 6b2f79d1f1b8..8f27e1c657b6 100644
--- a/drivers/accessibility/Kconfig
+++ b/drivers/accessibility/Kconfig
@@ -21,6 +21,7 @@ config A11Y_BRAILLE_CONSOLE
 	bool "Console on braille device"
 	depends on VT
 	depends on SERIAL_CORE_CONSOLE
+	depends on !FB_GLYPH_21BIT
 	help
 	  Enables console output on a braille device connected to a 8250
 	  serial port. For now only the VisioBraille device is supported.
diff --git a/drivers/accessibility/speakup/Kconfig b/drivers/accessibility/speakup/Kconfig
index e84fb617acc4..458bee03d3e8 100644
--- a/drivers/accessibility/speakup/Kconfig
+++ b/drivers/accessibility/speakup/Kconfig
@@ -3,6 +3,7 @@ menu "Speakup console speech"
 
 config SPEAKUP
 	depends on VT
+	depends on !FB_GLYPH_21BIT
 	tristate "Speakup core"
 	help
 		This is the Speakup screen reader.  Think of it as a
diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
index 6096c623d9d5..0ce8c1506eaa 100644
--- a/drivers/gpu/drm/clients/Kconfig
+++ b/drivers/gpu/drm/clients/Kconfig
@@ -42,6 +42,15 @@ config DRM_FBDEV_EMULATION
 
 	  If in doubt, say "Y".
 
+config FB_GLYPH_21BIT
+	bool "Enable 21-bit glyphs in the frame buffer device"
+	depends on (DRM_FBDEV_EMULATION = y)
+	help
+	  This option enables 21-bit glyphs in the fbdev framebuffer,
+	  surmounting the traditional restriction to 256/512 glyphs dating back
+	  to the VGA hardware of the 1980s and 1990s.  To use this effectively
+	  you will need a suitable font and possibly a suitable keyboard layout.
+
 config DRM_FBDEV_OVERALLOC
 	int "Overallocation of the fbdev buffer"
 	depends on DRM_FBDEV_EMULATION

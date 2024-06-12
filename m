Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015ED1E504
	for <linux-fbdev@vger.kernel.org>; Wed, 12 Jun 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199756; cv=none; b=UW3raOllcGdyMMgzoLp+9q9UIvEABvPftlMgHcCMPhnFnybj9g5jjaRzteAaiJyopc4Ju5U+XHatfp1hgTJITjjB2hKagNaU/rHjaGc4bXzEM45bQTgqKfrmHauzyVRoRSxbXKNUoUW5Sb4arkFeSbtEAJL+gPV3e9/BmIYryMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199756; c=relaxed/simple;
	bh=84VAyrU/6BHGLHSQRkCLi+n3OPH6tYImSm3m5ByeYHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QB52mZF0gmICXcQgNKa09l27hdM5BLzA/+R/XwoQ3Diry0BfhiEOEbdC/pas2RqS6wdoSzCZJ/9BEkws45QmitUlSaNtUCZp6u2EPEYaWUyGpeNLjiEpcIfhtAhNiswBzy6UcAo7deCtFEKV5lqSz/88nbz+/hm1zDMLKORUSzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:170b:1b4a:247:a009])
	by xavier.telenet-ops.be with bizsmtp
	id adiX2C00J3axqkY01diXux; Wed, 12 Jun 2024 15:42:31 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sHOEA-008cnA-2T;
	Wed, 12 Jun 2024 15:42:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sHOFD-00EaNg-5F;
	Wed, 12 Jun 2024 15:42:31 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Helge Deller <deller@gmx.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] video/logo: Remove linux_serial_image comments
Date: Wed, 12 Jun 2024 15:42:29 +0200
Message-Id: <427f78490365b38195f142d0aad7c9594a5bdd76.1718199686.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last user of the serial_console ASCII image was removed in v2.1.115.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/linux_logo.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/linux_logo.h b/include/linux/linux_logo.h
index d4d5b93efe8435bd..e37699b7e8393df0 100644
--- a/include/linux/linux_logo.h
+++ b/include/linux/linux_logo.h
@@ -10,9 +10,6 @@
  *  Copyright (C) 2001 Greg Banks <gnb@alphalink.com.au>
  *  Copyright (C) 2001 Jan-Benedict Glaw <jbglaw@lug-owl.de>
  *  Copyright (C) 2003 Geert Uytterhoeven <geert@linux-m68k.org>
- *
- *  Serial_console ascii image can be any size,
- *  but should contain %s to display the version
  */
 
 #include <linux/init.h>
-- 
2.34.1


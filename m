Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE160EC4
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Jan 2024 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935903; cv=none; b=JSA8s9lviTv9FJhgt5GRAqv4gsdjS/XjAAE5yKar4HUggbMlf2k1Vg5Xuc66rOvym2kcBOXIUJYli2dU38PyLFGKd/P4w6CHP59N7BG6enMC77VfVAZf1CplAItmJKEdvaUzXEUXkHTQHwn6+u750xtb4UCA5/ai7x3S7RIH0J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935903; c=relaxed/simple;
	bh=7l9o4lthNaLkEEvA/a2tt2w4ortykSw3aUwLFif/jI8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G8BWOxhARsTaCpt4+8Gr4/bjzzMRXSyy8vlNJ6/K4+pfKkm0Qr5s81gK0Q54+1J+tsMQojhR7XYYV20y41GB01zB9pIL+tk4TnsKdhATgz805bRs1CRoJX4pF1gGOlt4z5k7vzzBZGLHxFclDDp8hdv7PrnEzI4qBXHE8T3Rg8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:955e:bba5:7ff4:cfb6])
	by baptiste.telenet-ops.be with bizsmtp
	id dr4z2B0090ZxL6o01r4zwW; Mon, 22 Jan 2024 16:04:59 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvqM-00GH0a-0V;
	Mon, 22 Jan 2024 16:04:59 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvr9-00CG2n-0o;
	Mon, 22 Jan 2024 16:04:59 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] fbcon: Fix incorrect printed function name in fbcon_prepare_logo()
Date: Mon, 22 Jan 2024 16:04:58 +0100
Message-Id: <d15dd1d81ffebed4e5028e156f0082c44ebbf2fc.1705935864.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the boot logo does not fit, a message is printed, including a wrong
function name prefix.  Instead of correcting the function name (or using
__func__), just use "fbcon", like is done in several other messages.

While at it, modernize the call by switching to pr_info().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/video/fbdev/core/fbcon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 63af6ab034b5f1bb..1183e7a871f8b270 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -631,8 +631,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 
 	if (logo_lines > vc->vc_bottom) {
 		logo_shown = FBCON_LOGO_CANSHOW;
-		printk(KERN_INFO
-		       "fbcon_init: disable boot-logo (boot-logo bigger than screen).\n");
+		pr_info("fbcon: disable boot-logo (boot-logo bigger than screen).\n");
 	} else {
 		logo_shown = FBCON_LOGO_DRAW;
 		vc->vc_top = logo_lines;
-- 
2.34.1


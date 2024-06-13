Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DEE152533
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306297; cv=none; b=bcy2+V/uULRVTG6eQky1maIMf0fhRYpJXe31pTVgZTXvI8Mm6zH6F9Zew2wXhAHamlDM2xxgiwstaFJydeXAIbyx+SJN4xmmi9cagTbsSO6GSrJB+GjaZvOTSBGC++Ue9RYI7+MeCAtJrKCwqAoeC/PodUAO3xs2j8/C58AXLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306297; c=relaxed/simple;
	bh=Rg4B6D/bwEKjMcrukcRStwxKfCFviBM5ZIM1wC7n26A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmyYLaft5sNsPDsheSFp/KECaStb4tRXlzNK8gX9qWQQfjLJfOp/O2mVgyXaQe3grEl+968DLKxLnkq0f2RN1zyJnfXXprKUPcve1kBUYJv1Kt/nogPiNqHcRRERE9msKg93O0zKKz0Rua7RQ8Hn4jGcvqKxVQ9uxpUltCnIuzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:be2a:f066:50f0:dff7])
	by laurent.telenet-ops.be with bizsmtp
	id b7J62C0073w30qz017J6YW; Thu, 13 Jun 2024 21:18:08 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sHpwS-00Ax6j-CJ;
	Thu, 13 Jun 2024 21:18:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sHpxW-00FL8T-CT;
	Thu, 13 Jun 2024 21:18:06 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/7] drm/panic: Fix uninitialized drm_scanout_buffer.set_pixel() crash
Date: Thu, 13 Jun 2024 21:17:59 +0200
Message-Id: <4c250d21880ca0b97e41da7b6a101bdf07e9d015.1718305355.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718305355.git.geert+renesas@glider.be>
References: <cover.1718305355.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No implementations of drm_plane_helper_funcs.get_scanout_buffer() fill
in the optional drm_scanout_buffer.set_pixel() member.  Hence the member
may contain non-zero garbage, causing a crash when deferencing it during
drm panic.

Fix this by pre-initializing the drm_scanout_buffer object before
calling drm_plane_helper_funcs.get_scanout_buffer().

Fixes: 24d07f114e4ec760 ("drm/panic: Add a set_pixel() callback to drm_scanout_buffer")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 drivers/gpu/drm/drm_panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 293d4dcbc80da7ba..fc04ed4e0b399f55 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -582,7 +582,7 @@ static void draw_panic_dispatch(struct drm_scanout_buffer *sb)
 
 static void draw_panic_plane(struct drm_plane *plane)
 {
-	struct drm_scanout_buffer sb;
+	struct drm_scanout_buffer sb = { };
 	int ret;
 	unsigned long flags;
 
-- 
2.34.1


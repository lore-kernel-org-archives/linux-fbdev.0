Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C7321ABB9;
	Sun,  1 Mar 2026 01:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330295; cv=none; b=uZWviga7hW2fg71dB9FKYzNZi6IY1hSka3kw9ejgn7GnMiBaI00uCQ8zUHo1OVSPIYZ2kFZ29BYGS8/OqYEUSsIMVBzFIBz7uq1zAub2EbVMSI+YCsawo5RVsRgV+02k1x6H3OGkY4hA/ZAaD/Hy/qHBgD2NF+rAPGCA0VRCCZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330295; c=relaxed/simple;
	bh=wADx3ny5QdlcZD9mcMNhL5YrsN7Yc6RWZlAnpVzDePs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRGINQYtUwcq7uAWGGrdwHLVbSUpDFL5OLKPharNtH2TX3O7AKEHBJ+/03Iw78AG0QZ+EhaohN1mjyHwJOhGI29WHrm4sxuhX2ER/C+jmIw2t59asmsuFEQ55N1tdBZuXdHKgF5lPswwHzE9kBWgTkdfrpH82LcVnKafg2TE4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8lfwlvX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8lfwlvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD368C19421;
	Sun,  1 Mar 2026 01:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330295;
	bh=wADx3ny5QdlcZD9mcMNhL5YrsN7Yc6RWZlAnpVzDePs=;
	h=From:To:Cc:Subject:Date:From;
	b=L8lfwlvXKdlRtb1jVn/s34JJfbLK2S2cFGhi+H6u0hPVOefDTimj2TP0pEUDfmYmc
	 zz4gb9P5cKMUvInmvf8swFYCgy6y/NcvIpsEmv9pcCj7NkBgrbYF4urXdmC1wkI/hY
	 R1VwDwW9iRekEd2ogFi2X2FeHGlJG1LiOmgO/kOLjGPTsdjPx/nb0H2BjPunL8cp2m
	 jSZ4deH6Xp6v1fdXw7VlIa+M8TjlxMsaz0VbyFAT3TdZJK/5Rb9bcfKMepylau5wZT
	 WMzqO8F+dYVked0cd/xAJPMHc4Sl+DYsUKlxOTYd9k39xdxk2RPLEP+XLgCYQ+lNiA
	 XpwDU57EZXPDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tzimmermann@suse.de
Cc: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "fbcon: Remove struct fbcon_display.inverse" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:58:13 -0500
Message-ID: <20260301015813.1723622-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 30baedeeeab524172abc0b58cb101e8df86b5be8 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 9 Feb 2026 17:15:43 +0100
Subject: [PATCH] fbcon: Remove struct fbcon_display.inverse

The field inverse in struct fbcon_display is unused. Remove it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # v6.0+
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/core/fbcon.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 1cd10a7faab0f..fca14e9b729b9 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -30,7 +30,6 @@ struct fbcon_display {
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
     u_short scrollmode;             /* Scroll Method, use fb_scrollmode() */
 #endif
-    u_short inverse;                /* != 0 text black on white as default */
     short yscroll;                  /* Hardware scrolling */
     int vrows;                      /* number of virtual rows */
     int cursor_shape;
-- 
2.51.0





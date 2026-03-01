Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6924302CD5;
	Sun,  1 Mar 2026 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329668; cv=none; b=RvHxwVIlP4OXqY8cat+q/AQ+v6f0CDslzkM6zN4DivO+u5nJ5mjj5l5CBk4yBC/OT9G4kD0+EyHifyvJmfi56RKoWoBWjaat+m84DGbUUnnZm5dxLweKtjXYDlNKhEj6FeXPHRd21ajAbTZCLWiffa4YIkN3f1yTvdgVuqOccEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329668; c=relaxed/simple;
	bh=HuTMJOqkUBOoADNGhYDPWB1z63YlljsSpPnCYdRr7DI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VE6qmTHNCmSC8Iyd2EDUn1ohYwjVKRkYx72Ui6P6XKEP/ItJXY0aE9saOHSq3TFVYHGf7mAf6Cx0xOHDbyo+OSNGSy0KcbKdmjdIJVMbrptha6Ck9dQV07/s8rIIHi79ebx7yLT7iyeRuI6FBQOtEGFxrzt1Y7prkn6FNlk7YMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofn1veZ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofn1veZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08436C19421;
	Sun,  1 Mar 2026 01:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329668;
	bh=HuTMJOqkUBOoADNGhYDPWB1z63YlljsSpPnCYdRr7DI=;
	h=From:To:Cc:Subject:Date:From;
	b=ofn1veZ4olGyHIVwO++TU1k5WbJR71SLFLgIH8eZ7CfVIsmN8bYoVphh8iD/SOzLB
	 VXNpRVmJhf571hnU+zwPTe/5Abn9vuzTa1KZ6Slh2WLKzQYUI1FRwgZFhVVVkSVDnD
	 PaxAAE3tTvmq8KgXYUuAIKcBw8RbGD9iigobUEfpDXMLHqpp9nHgEei85QtXtoW99f
	 rvLGWfUA/3AiwbvLl6f2pPR3iKGvyBz5jha+EaMbq9lU7mmfGDXrGnHozlEZRayYVl
	 2OvKUek65Flh1W6Z6Fxq2wULwrokfpB0vDCSdwWky2IRt7SuyTV+796SXjBt1X00ug
	 PZDmFLVdDPASg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tzimmermann@suse.de
Cc: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "fbcon: Remove struct fbcon_display.inverse" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:47:46 -0500
Message-ID: <20260301014746.1711753-1-sashal@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
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





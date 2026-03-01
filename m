Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05082899;
	Sun,  1 Mar 2026 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329135; cv=none; b=tzmIz1sYifiRyi1y8POAeBM6u7V1nq8urCvB82WrMv+ld8kH9tTyJ3XDJsn0Lpl4IZ+aakAMIrW5MoVmmvw81p9QasWpxQp2xv6rQini7IUczdkX5XjR0vgxLOtHB4YRK8TJqA3Z5jENFNb71vzRTt8tNAy4Ce7d0zKkMAbX+SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329135; c=relaxed/simple;
	bh=WrRldZHKCM57Wj+ZSwnWa1FPyVNkymSyoQSVQKYT1nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgY/YBGtdqqf6ZIHTb/+rHlL9MPVTvrBhioilN03z4BmRFx90o8a3VBC9FwGJgF/CAu/Drlx9KfOjHPgUJAKTDFkCQoyAI2sGQ7o5Fz47OunlGoHAgCSigmIKdRHAKZY9+nhuOKpT5WZqCJd5ORX+rgjJVL8GrY37wFovWrsvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hshb0Xp6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hshb0Xp6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CCEC19421;
	Sun,  1 Mar 2026 01:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329135;
	bh=WrRldZHKCM57Wj+ZSwnWa1FPyVNkymSyoQSVQKYT1nQ=;
	h=From:To:Cc:Subject:Date:From;
	b=hshb0Xp6X5K9Z7qTseNtivOA2Rttm4dosunmsH20YJ0RPdWwUDB9rVR/oWauFQY79
	 ykvNHfr6BQinHf5y/7ca3qU0wF1ICD7SL0EYdTKkJKMKWF8M/Ul3cv7LuNO1EO/+wv
	 FGpdHXNH//nLT8IlfMtySytggqyJtPoJfKGdch/8PZnPdEoGExSFYyKjUsfsmXqb7g
	 6rxgDm93xdM2CNJM12neUf0dMRO7ANz8mOCzdSygLCaaX6iseEOHBXEtHqoDsmWuRZ
	 QvMbqyR4iHopqt3yJM+E0wkX6FhijaCZzKU4vCrwJ6kGO2//WYrAvsGz/48WyAg1rC
	 Ryz4TzHn0niwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tzimmermann@suse.de
Cc: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "fbcon: Remove struct fbcon_display.inverse" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:38:53 -0500
Message-ID: <20260301013853.1699698-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
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





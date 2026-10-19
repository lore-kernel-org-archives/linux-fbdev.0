Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA9401A2E
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403038; cv=none; b=mNQT51TVLJqc7XtgVDdhUVIb4WPsYwvm1QXv4LRR826aFlntmRyFooxaNkMdPmZAm1zWVnXpJGKreFDP4AcQ9P2h89q4TqKu9Zltnu0HIkj9lqzTJxszciAQZnyO27aBXTA80L3TvTIDp59Icje0trDuKph7Ue0WOfJY40xJ18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403038; c=relaxed/simple;
	bh=NHZMWsqhaQ33Uo0xDtcv+OHeiqkGvqLsEmmgfpGzEN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwrdPHLpgwleVRUjdPG30wMKllYYnTpYY8dC1kMRj8qPX8YXR10iQe8kpIH7HOhfSB2S4A3OTyhe1HCDipCHy1e9sN/II0yeQ2NHBdJfO9IgduS8SZY8L7sWXCovASBBHdXOQB0d8fSxIWiBwDOe8pHW0iWhLkyqZf6iF6gov+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQzwGP2n; arc=none smtp.client-ip=74.125.229.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQzwGP2n"
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-33e48934fa8so921101eec.0
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 02:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792403036; x=1793007836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wD2WIpjKVnC6AxNSYVPPB4T+WOtPpt82EYJQTf5ufN8=;
        b=BQzwGP2nE8HTSgirKKpAkkAnaseifqzHpb1rf7SwAeJSpDY5kdrGcbuPZU40h3Pe80
         jpPNeodaQUQYQzoJRV378uVOcI2klYp0Z8OsB3ZecB2G/xt96QGeg9Q8tXfbUR7tQ0by
         yz/kWCNfUDB2xajVt+agCh+rA1T8o4pTWG+L4TMW4fZlbeALaSlNoe/2TeyhnTMhwwJF
         ex/n6bzvuMhgClkKNAos1bd9azlE0P+aOzTo/6yAJPuNY/3rlVX7K5tEGux7Myeu5Wp0
         nBTrMN/UZ873Z/R1Ixbnbd2XwCH8EpwdfhTXz0DU1vREUFu8koBEllT+Fkd2nk6J3YA/
         DA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792403036; x=1793007836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wD2WIpjKVnC6AxNSYVPPB4T+WOtPpt82EYJQTf5ufN8=;
        b=ZpgP7IicLZjHn0rV5hz5R37CvFVbx/clsAB1ASKRc6nYV+HIYKR7EG8rb5/tTVUmRU
         ChB+1ibN6/QFw29SbWdJ4+DHb7yIhzjAAkW9GeJI1Tdg9Y1aEQmuYr++TU1DptIADTqi
         0n/D8iVGhzhCgI6uJBiGsmLjPNutNxSnIFFzwKAD+Y2wj/74NBqFwdgL3hnS/f3YvUQ/
         3qkE842e7C1HegrUZoGNsdVDBdU0I+ke6RAoTuKDE29CYW67yZECR65WNbWWjwdS2/U9
         KapxfK457fJIej1ZICOu26N9jB1oDBUXKWxXvFVc+JQN7AD/tKX4qPpHHiz/C1WzYtZK
         jJdw==
X-Forwarded-Encrypted: i=1; AKwUvByaITuTLPUl1ExxaU+5hiy7BIsFkIn2xutyncabbegQZZq9TC51356U8lpmokSEm762uv5iQJER8WlEMA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL5n8wNboi6RzLSKxTu+qW2iSTiKy8kky1zmRgQ4ngFb/cQyvVM
	gNN/DN6LnYNEP9qrrEUBy3/X3mzOzUF3XdpXuE0ERZG5o/dTE28vWNrZunGrwl0dnIXLZw==
X-Gm-Gg: AYBFou0LJ5s1WVBbjJk3EPdxRn2PA3DwvT0oXl8ukNtVK9Mj7LQAZPohsELfdC5xKxH
	phZDs1uz3elU7AorCUy51O4L+sqDvEJyb40CHA1VMUf6KAAKOZReEsZBIAo2pQ655rOOtER+kB9
	KIdWn57qCKihVf2QmtI4awfM5vVQoJLoss3lduPhxuQtZ/26kLtZiaVAveL4id6vrIGHwQ9D8TU
	9sVuv8XLZymRjOXv3YHQKfUTn4E9IQQxHDe7M90jDbq1nH8gY6pE30v2ExAaf7J9O88abZyG/fq
	eX6sEQNVP4kpduZ0Pn+x0kE+h2uHwVmPku+LnLi2HKcuSc4fbnWqaZtE8XqTL6BAPlMvY2EPjPF
	eg009gGQ7U7cldFWn0V+vMG7rIDjpWzvFa182ynYunDiReEKMOdHndR5EKJq6RG9ZQ15J+qeji4
	fuaHNwEZPYxS0qH55A01yY0OsuBTijIOtt0tJPjZdV/zLWwMER2BT5uR2ZoMqeH2L/Tj7fecvwX
	d+z3r0v9k8iuGY8cPOLppUnVDoIRSEpGDE=
X-Received: by 2002:a05:7300:a214:b0:35e:ebb1:8e5a with SMTP id 5a478bee46e88-361a1b5251cmr9702651eec.26.1792403035840;
        Mon, 19 Oct 2026 02:43:55 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607bc950f9sm34370074eec.0.2026.10.19.02.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:43:55 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	Yao Yiqi <yyaqia@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 2/3] fbcon: Rebuild rotated font buffer on font change
Date: Mon, 19 Oct 2026 17:43:30 +0800
Message-ID: <20261019094331.1128871-3-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019094331.1128871-1-yyaqia@gmail.com>
References: <20261019094331.1128871-1-yyaqia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() caches a rotated copy of the console font in
par->rotated.buf. The buffer is sized from the font's width, height
and charcount, and is rebuilt in fbcon_init(), fbcon_switch() and
fbcon_modechanged(), but not in fbcon_do_set_font().

When the font is changed through KDFONTOP, the new geometry is
installed and vc_resize() redraws before the buffer is rebuilt. The
rotated putcs/cursor ops then index the old buffer with the new cell
size; KASAN reports a slab-out-of-bounds read in soft_cursor().

Rebuild the buffer for the visible console before the redraw, as the
other callers do: select the console's blitting state with
set_blitting_type() (which also uploads the new font's map on
tile-blitting hardware), then rebuild. Background consoles keep
their rebuild at fbcon_switch() time, as the buffer is shared per
framebuffer and must not be updated for a console that is not being
displayed.

To ensure a correct rollback when the rebuild or the following
vc_resize() fails, save the rotated font state, clear it before
rebuilding, and restore it in the error path of
fbcon_do_set_font().

Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
Changes in v5:

- Save, clear and restore the entire par->rotated state instead of only
  the buffer. Restoring only the buffer left the cache key describing
  the rejected font, so a later switch could take the early-out and
  index the smaller buffer with the larger font's geometry. Clearing
  the whole state also makes the rebuild unconditional, so it does not
  depend on the next patch's buffer check (found by the Sashiko
  review).

Changes in v4:

- Restore the saved rotated buffer on failure instead of re-running
  rotate_font(), so that a second allocation failure cannot leave the
  console in a third state.
- Keep the old buffer out of the rebuild by allocating a fresh one.
- Abort the font change when the rebuild fails.
- Guard the rotated state with CONFIG_FRAMEBUFFER_CONSOLE_ROTATION.
---
 drivers/video/fbdev/core/fbcon.c | 46 ++++++++++++++++++++++++++++++++
 drivers/video/fbdev/core/fbcon.h | 22 ++++++++-------
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 01715873ea49..9a5d50d69d00 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2414,6 +2414,10 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	font_data_t *old_fontdata = p->fontdata;
 	const u8 *old_data = vc->vc_font.data;
 	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	struct fbcon_rotated saved_rotated = { };
+	bool rotated_saved = false;
+#endif
 
 	font_data_get(data);
 
@@ -2432,6 +2436,27 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!vc->vc_hi_font_mask && charcount == 512)
 		set_vc_hi_font(vc, true);
 
+	/*
+	 * Select the console's blitting state and update par->rotated to
+	 * match the new font, so that the rendering below does not use a
+	 * cache that was built for the old font. Clear the cached state so
+	 * the rebuild allocates a fresh buffer; the old state is kept until
+	 * the font change can no longer fail.
+	 */
+	if (con_is_visible(vc)) {
+		set_blitting_type(vc, info);
+		if (par->bitops->rotate_font) {
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+			saved_rotated = par->rotated;
+			memset(&par->rotated, 0, sizeof(par->rotated));
+			rotated_saved = true;
+#endif
+			ret = par->bitops->rotate_font(info, vc);
+			if (ret)
+				goto err_out;
+		}
+	}
+
 	if (resize) {
 		int cols, rows;
 
@@ -2448,12 +2473,26 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		update_screen(vc);
 	}
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	if (rotated_saved)
+		kfree(saved_rotated.buf);
+#endif
 	if (old_fontdata)
 		font_data_put(old_fontdata);
 
 	return 0;
 
 err_out:
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	/*
+	 * Drop the buffer built for the new font and restore the saved
+	 * state.
+	 */
+	if (rotated_saved) {
+		kfree(par->rotated.buf);
+		par->rotated = saved_rotated;
+	}
+#endif
 	p->fontdata = old_fontdata;
 	vc->vc_font.data = old_data;
 	vc->vc_font.width = old_width;
@@ -2466,6 +2505,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
 		set_vc_hi_font(vc, false);
 
+	/*
+	 * Re-select the blitting type, which re-uploads the font map on
+	 * tile-blitting hardware.
+	 */
+	if (con_is_visible(vc))
+		set_blitting_type(vc, info);
+
 	font_data_put(data);
 
 	return ret;
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index bfbd70f8b1cd..a618adf3c871 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -72,6 +72,18 @@ struct fbcon_bitops {
 	int  (*rotate_font)(struct fb_info *info, struct vc_data *vc);
 };
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+struct fbcon_rotated {
+	font_data_t *fontdata;       /* source font */
+	u8 *buf;                     /* rotated glyphs */
+	size_t bufsize;
+	int buf_rotate;              /* rotation of buf */
+	unsigned int buf_width;      /* geometry of source font */
+	unsigned int buf_height;
+	unsigned int buf_charcount;
+};
+#endif
+
 struct fbcon_par {
 	struct fb_var_screeninfo var;  /* copy of the current fb_var_screeninfo */
 	struct delayed_work cursor_work; /* Cursor timer */
@@ -88,15 +100,7 @@ struct fbcon_par {
 	int    rotate;
 	char  *cursor_data;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
-	struct {
-		font_data_t *fontdata;       /* source font */
-		u8 *buf;                     /* rotated glyphs */
-		size_t bufsize;
-		int buf_rotate;              /* rotation of buf */
-		unsigned int buf_width;      /* geometry of source font */
-		unsigned int buf_height;
-		unsigned int buf_charcount;
-	} rotated;
+	struct fbcon_rotated rotated;
 #endif
 	u8    *cursor_src;
 	u32    cursor_size;
-- 
2.56.0


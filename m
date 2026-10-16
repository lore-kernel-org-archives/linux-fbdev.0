Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E513BCD33
	for <linux-fbdev@vger.kernel.org>; Fri, 16 Oct 2026 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122355; cv=none; b=KDcF2ktl51M8i9cYbqoXO9zJEEZH29TOdclhSYgx6G0t5KqP2oiIHnbOHZ1R9W0gSM9CNp0qNne5MC8MyKibguRZXldX9Vk/8rv1cTF7xulOzazEksozjXIw3aT5XkJ3qR+hjUXLuE8ApitMgRBKVup9q4lW49L4OiUnrpH6KOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122355; c=relaxed/simple;
	bh=XEYpBK4JT8bu1SDqkA6FLNfAXmiC58NHQz5kNRkO1cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYVJfQA3rjMYc4GUwkygHDn5f0xdwQZXg7Dca4nJzkM0OUnOluAgzVD1+jI0UKzTyGUJ6seox3CcgcIt+D8w+BMMjMzIZgS7hGQCD4Q8Py19KrOQKwJPgVboe7+TgSUhaXkDpLolLGTDzYSyuAMkSVWLHySC7SHDRcZVOfQdDr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DW4Aypwh; arc=none smtp.client-ip=74.125.229.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW4Aypwh"
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-3537dfdcabaso7799415eec.1
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 20:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792122352; x=1792727152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=daqdSqsQywkW4QFvPS0cowFZqZyMXgakPffXgvi9+4c=;
        b=DW4AypwhqRams30ksruRESqzIHmavGLeWnlb3VjkCIlJVEmoMoN/uVErhrW7J/FsqS
         iKOAiRdJN+l05VksBux4M0YDufwbXHXqRPdYdo3fdbTLAwJHYPjLQp/h8FKQA+sdIHYm
         EHycTQ70Ak6syqJlx5YgKGmvwd+eVqHvwsZ6tQqGLHeJv2a+QFiP7PJjR4TdouDlzldr
         DCBxK3draTzmR99LU7IY2NROKjMdC79x3HctfqI0N4wwKKQdriMJEUvbWxhcWQvcAwIt
         jWmfiyi+25c6y1WCjbaRGdg+bG0eH6Yq0hzUcfldEW6O+BntI1D6U/jKgLUNBSvWUNQr
         E2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122352; x=1792727152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=daqdSqsQywkW4QFvPS0cowFZqZyMXgakPffXgvi9+4c=;
        b=k24R/+taqF9nbqapEM26JAB7fNcDY+HpnDSNQswh3uRQd6XLFyKgf3oc46lGXPtt0Y
         u0HBomOEe51K4qAz2Clw5Kn+L/VFtRlWnJwKAFq7SZoK3KJRHioEIC9vRpTh9XI3Per/
         B+vc1XKXIIXOTosddAnkYGN4JN4+BrvYYadlXIMHKM3JaXFkO1u4DTMoQGvOLuP1sNHq
         yCRdhbw7uL6depfycWQ1k22WreShPF6ISIMNaPd5EpeOzly7ls8FxsFXdGmSoCLMETo/
         07cKCeom0CE9HcN2hLvbiqgyBY+t9NJsdGYNf6mOaMbYjViuOo+PRjG8wxfg0laFK/g+
         /jpA==
X-Forwarded-Encrypted: i=1; AKwUvByo7p1SO3Rrrxbo1RAF2ukA5Ifl01u1BE1oXgnxom4rTVETb2MXiAYVid9iN0Hv5fm6bnn94B1Uvnlgqg==@vger.kernel.org
X-Gm-Message-State: AFq9FYI/5NlnuPeh2GkXlPSvH3PXZ/LAXYiSr/k8wTdemeGH5eMISOH7
	lWgrI50kZTYeWw79btZwYgAPhdBR1tuwsXTfkIzVnic3bNX5HqzUaHPl
X-Gm-Gg: AYBFou09fX1N719MD+1RIaQXFPeh+JQdYJCQLsKbW7Bmd+2cEC0hZO/oOe8iGxQSSKj
	0s0SEXKMBkI2DMwoiZNzr51o2MGko8tgZ1/9xk75bFzv9JnB4g+fw8gnwhELt7BxSfVLNfKYBIV
	KWVhWqAWR+tDkzVVhZghEfPnEFnDwLYMcrZUG5GktjLpYALLMvFoHLQeqIXCNopuXiYn1SeE4z4
	VpgA32EAiaHQMOfv+cGLfSIP+2Zuw4l/Mactv9+1REk1gei9dJzK3HuakxssKqm6zhY+i0yeW2/
	UiRLouLzAUt5wpdz+L6UTZFjBR1ZuYd0hkN3V1tuZlUmWJPm3SNJ9mdMkNTp6F1twcjrYKeFHGS
	r+GLA+n236JakRJPwI+Qu+K1iBF8dOWgbc5Ct9xkfp9Z7tIYXL4NBHpIBpOwAJYI4Cu3nasc3Sp
	Gjbs/Uhucgt9Ah9LexVKB8q03FGIC/4kwagLYF3WRhdXYGqLwJoTU2QxiD30s4rivElT5f+lvtD
	QkQuWSSfyVCJkjRAIe+cSYny1LXgNTMZEsLmP7itPVH74o3FA==
X-Received: by 2002:a05:693c:80c1:b0:35e:51d6:9f6f with SMTP id 5a478bee46e88-35e51e5fd78mr8412093eec.27.1792122352334;
        Thu, 15 Oct 2026 20:45:52 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608297f4f7sm2434229eec.23.2026.10.15.20.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:45:51 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
X-Google-Original-From: Yao Yiqi <yaoyiqi3@huawei.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	Yao Yiqi <yyaqia@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] fbcon: Rebuild rotated font buffer on font change
Date: Fri, 16 Oct 2026 11:45:32 +0800
Message-ID: <20261016034533.445862-3-yaoyiqi3@huawei.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016034533.445862-1-yaoyiqi3@huawei.com>
References: <20261016034533.445862-1-yaoyiqi3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Yiqi <yyaqia@gmail.com>

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() caches a rotated copy of the console font in
par->rotated.buf. The buffer is sized from the font's width, height
and charcount, and is rebuilt in fbcon_init(), fbcon_switch() and
fbcon_modechanged(), but not in fbcon_do_set_font().

When the console font is changed through KDFONTOP/KD_FONT_OP_SET, the
new font data and geometry are installed and vc_resize() is called.
The redraw that follows reaches the rotated bitops while the buffer
still holds the old font: the rotated putcs/cursor ops index
par->rotated.buf with the new cell size and character codes, so a
stale, too-small buffer is read out of bounds.

KASAN reports, for example:

  BUG: KASAN: slab-out-of-bounds in soft_cursor
  Read of size 64 at addr ...
   memcpy
   soft_cursor
   cw_cursor
   fbcon_cursor
   hide_cursor
   redraw_screen
   vc_do_resize
   fbcon_do_set_font
   fbcon_set_font
   con_font_op
   vt_ioctl

Rebuild the buffer for the visible console right after the new font
geometry has been installed and before any redraw. Select the
console's blitting state with set_blitting_type() first, as
fbcon_init(), fbcon_switch() and fbcon_modechanged() do before their
rotate_font() calls: fbcon_rotate_font() reads the source font
through par->p, which may otherwise still refer to another console of
this framebuffer. Background consoles keep their rebuild at
fbcon_switch() time, as the buffer is shared per framebuffer and must
not be rebuilt for a console that is not being displayed.

If vc_resize() fails, err_out restores the previous font. The rotated
buffer that was rebuilt for the new font earlier in the function
cannot be restored with it: font_data_rotate() has already reused or
freed the buffer that belonged to the old font. Rebuild the buffer
again after the restore. Otherwise the console keeps rendering with
the old geometry against a buffer that was laid out for the rejected
font, and par->rotated.fontdata keeps referencing the font data whose
last reference the error path drops. A failing rebuild leaves
par->rotated.buf NULL, so the rotated ops skip drawing instead of
reading a mismatched buffer; the next patch retries the allocation on
the following call.

Unlike the other callers, this one does not fall back to unrotated
rendering on failure. The "par->rotate = FB_ROTATE_UR;
set_blitting_type(vc, info);" fallback they use does not actually
switch to unrotated rendering: set_blitting_type() calls
fbcon_set_rotation(), which immediately re-derives par->rotate from
par->p->con_rotate. Replicating that pattern here would not change
the outcome; repairing the fallback is left to separate work.

Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
Changes in v2:

- Rebuild the buffer again in the error path of fbcon_do_set_font().
  Without this, a failed vc_resize() left the rotated cache describing
  the rejected font while the console rendered with the restored one,
  and par->rotated.fontdata referenced freed font data (found by the
  Sashiko review).
- Select the console's blitting state with set_blitting_type() before
  rebuilding, like the other rotate_font() callers, instead of writing
  par->p directly.
- Reworded the note about the unrotated-rendering fallback, which is
  now left to separate work.
---
 drivers/video/fbdev/core/fbcon.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 01715873ea49..1a2fe9fc1dc2 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2432,6 +2432,17 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!vc->vc_hi_font_mask && charcount == 512)
 		set_vc_hi_font(vc, true);
 
+	/*
+	 * Select the console's blitting state and update par->rotated to
+	 * match the new font, so that the rendering below does not use a
+	 * cache that was built for the old font.
+	 */
+	if (con_is_visible(vc)) {
+		set_blitting_type(vc, info);
+		if (par->bitops->rotate_font)
+			par->bitops->rotate_font(info, vc);
+	}
+
 	if (resize) {
 		int cols, rows;
 
@@ -2466,6 +2477,14 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
 		set_vc_hi_font(vc, false);
 
+	/*
+	 * The rotated font buffer was rebuilt for the new font before
+	 * vc_resize() was attempted. Call rotate_font() again to
+	 * overwrite par->rotated with the restored font's state.
+	 */
+	if (con_is_visible(vc) && par->bitops->rotate_font)
+		par->bitops->rotate_font(info, vc);
+
 	font_data_put(data);
 
 	return ret;
-- 
2.56.0


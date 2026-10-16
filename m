Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1933D812D
	for <linux-fbdev@vger.kernel.org>; Fri, 16 Oct 2026 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135864; cv=none; b=R+XbH3AZy7p+wIEgN/2c/4Tjqw53kheBL1WaufZx29LKhtlTWkjlgUHBHUh4aE1w7wvlchYzQsFDAztuEEYBxWON4CogeKTxu1OIFhKNtWLY/UF840io2oxGlf79RjpMJGmekvVMDoKlvXU/cMXChzqPdUQEF7v8sby8G4gZKFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135864; c=relaxed/simple;
	bh=w78AxETGPHyzfmayF6RqGh9MNLfHyZeAJnbAFfjzWAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZCg9i1q5xJrTUMkZfcQY9CTwDFG4By2O2y6VGUyC9UjhziCWqR4ZyFleNEXFcIrGwEPr+1zCOB3PsQOMAw9EGpYLJ3IdPWtiRDZWARUgxgGhh71VEnmqOiifXS9Vic6Uh41Ii5w+kq3n7qljNm9+nb4onNIRUfUWGZm54WHx4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sL461faJ; arc=none smtp.client-ip=74.125.229.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sL461faJ"
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-139b659a45eso1511302c88.1
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Oct 2026 00:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792135862; x=1792740662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddI7wafcUO9ClL5oaRHB8Y5QOHWEf7RdloyAjD1mNAk=;
        b=sL461faJjIl2+cWt/R+J4hg5eBKnmPIFj3ytOAQEtjli1AtOpkcjAGsdNgsFN7dr31
         x1A6SQ1zO+VSwI2mrkdABeLRP2HUiCUrJFROIitaKMGqZhrB24OtFgHQg5JtydP50Unl
         p73zRKT3yymEJniuz57cRf2DDHUglSn0FTU4/mdLSnAEPIjE7KnXoHXpqnGnpfDIgGQD
         8FG2lY+JIwsCimquzqqjU8AvM+sqgY0IAFz7GyEo1iYt5E2IGhgDnxbsTll05AdBu439
         Z60jBUFJjR9lNr0HrdYTTcgWzLrH+ExP47h7G5Dwwhe+crtWGT3sSeSSs56P8p1Q3cpV
         i0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792135862; x=1792740662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ddI7wafcUO9ClL5oaRHB8Y5QOHWEf7RdloyAjD1mNAk=;
        b=qi9zqEjOy4DsRvEN6pTk/qM1VCE/J2bfUV6MtBQfNCsUPQHlz0yYyGdHtjGLbZ+/Iq
         EhZmAmoL5EV1eBz5le7zJ/wvD9PVUmz5SW/f+jIqU01sPeJkwlcTeG6L4gZdtccENefB
         kUxHnYmpj2qv2PV3soLdxz2GDNTumpcDe6B8S5P6CwRDrfjlrygHdolVzggfwHOwGJoL
         P1PHtxIDgfo5xw2PWdyPuXyqtnUrsix3Xz1jZtP3j+bcEKFWh/cQmGt0KsbOLtfaepmY
         /8FXMTtTLxxnlJcJHAW2FFhAjVyLBZXpNRSRSB3oh163cKstoG2OcVd1tGuPktMS6aew
         uEGw==
X-Forwarded-Encrypted: i=1; AKwUvBwt2PPxvUt/Et/Qibql6Pftdr6/OEVBXVNq0JxxwfINQzA1AuOPUoxQBRcL/i2YMvDdbXYI+XjbA/YZAQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIh/urz3JAYC0bI6HtlTi5ni2JGn5gVC0+KZzYdDkO8omvastmP
	BY5EfqR9ZIu9wPy1T77p9rwhtoCo6A8NTEOdFtOMS8XKzQVZvF+vJrb7
X-Gm-Gg: AYBFou1/kLk9JWPLyXXDmEcP7Kc4A4AHKtjvlMpQU3qWO2XkFhO6RcMt2tmaROUXU+r
	8zdp7Bw+rCeKbj2rnP5WReyjki9YULmvYA5vH/ZWb8phFZ7bUCUmI7E910HCcrIhkJ8nMHdQgXz
	Ho/RYT5k9bPF8sFnFtispFpLfaO9IG5q+7RbDnOYizaZ5mE0Rg4MTik+UaNshKcl10e96JRRDqz
	+3w+dylKRAgAghPsAHN545YPg6wZCPaj8tP/ZtWBQfgEDllUzycnFdfxPd6tHyrVESLtUdWxZoK
	IsWa+KThB55sPsaCQZnwjtAhwvTlobNRjz6m3JCXMzK7OJgX54oiNTd4RVGTMDKrqnIQtIPNW67
	WqHTxr6lBQ9P1d5e0arYhej5ARDWeLd5dGUlWV75IXHjcq/bbmYm4RmjxMbO5yq5fMJ9vbe+CWK
	JlbgQVsh4qu2E+y2LcmCFbpocK9+J+tmUnLLJVnRAMl2pvhEd86QdwLcR3k4yIlRc1zPC70/Tih
	WjePHZFAHzb7hM6LGzhPAxWd1WyCWW3WzptnQ3DN1dbFjI=
X-Received: by 2002:a05:701b:2713:b0:143:26cf:8615 with SMTP id a92af1059eb24-16a6169558fmr30706517c88.25.1792135861737;
        Fri, 16 Oct 2026 00:31:01 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f58c2sm5367021c88.11.2026.10.16.00.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 00:31:01 -0700 (PDT)
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
Subject: [PATCH v3 2/3] fbcon: Rebuild rotated font buffer on font change
Date: Fri, 16 Oct 2026 15:30:22 +0800
Message-ID: <20261016073023.490430-3-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016073023.490430-1-yyaqia@gmail.com>
References: <20261016073023.490430-1-yyaqia@gmail.com>
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
this framebuffer. On tile-blitting hardware, the same call uploads
the new font's map to the text engine, which previously happened only
when the console was switched. Background consoles keep their rebuild
at fbcon_switch() time, as the buffer is shared per framebuffer and
must not be rebuilt for a console that is not being displayed.

If vc_resize() fails, err_out restores the previous font. The rotated
buffer that was rebuilt for the new font earlier in the function
cannot be restored with it: font_data_rotate() has already reused or
freed the buffer that belonged to the old font. Select the blitting
type and rebuild the buffer again after the restore: the upload to
tile-blitting hardware and the rotated cache would otherwise keep
describing the rejected font, and par->rotated.fontdata would keep
referencing the font data whose last reference the error path drops.
A failing rebuild leaves par->rotated.buf NULL, so the rotated ops
skip drawing instead of reading a mismatched buffer; the next patch
retries the allocation on the following call.

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
Changes in v3:

- Also select the blitting type again in the error path of
  fbcon_do_set_font(). On tile-blitting hardware, set_blitting_type()
  uploads the font map to the text engine; without the second call, a
  failed vc_resize() left the engine with the rejected font (found by
  the Sashiko review).

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
 drivers/video/fbdev/core/fbcon.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 01715873ea49..d90a2ad45053 100644
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
 
@@ -2466,6 +2477,18 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
 		set_vc_hi_font(vc, false);
 
+	/*
+	 * Restore the rendering state for the old font: re-select the
+	 * blitting type, which re-uploads the font map on tile-blitting
+	 * hardware, and overwrite par->rotated with the restored font's
+	 * state.
+	 */
+	if (con_is_visible(vc)) {
+		set_blitting_type(vc, info);
+		if (par->bitops->rotate_font)
+			par->bitops->rotate_font(info, vc);
+	}
+
 	font_data_put(data);
 
 	return ret;
-- 
2.56.0


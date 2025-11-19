Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE15034AAF7
	for <linux-fbdev@vger.kernel.org>; Wed, 19 Nov 2025 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559505; cv=none; b=D+3rSILeapVdz/nulpG9wV1RKvMpABAWIjivZ9p+tUCk/9lmXfRmtCcsYf9VlwmaxxyxoLlmwnF7yJ90FcVDx7Ygq3Rx2JljBEZdBW19ziPWnlmXSiRXo8xw6xlITTOzHxlwy7ddvVc3V4U9kVRTtn6+pNYFPZu2T2d84X6Bojo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559505; c=relaxed/simple;
	bh=0qU80fu0dZKqAV9HWfzbTdwSn8lOEuNgWIuw7pAl1FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WHJBRgf0UuBwguE04BPg1jhfcByKRYLCLmrwZ2FzsDmYw3KSws0ER9ZulyQxbC9dC/AlEMwH9Wq3ZOGIxkVCiShwrBH0H2k8TOsA8pWZ6d153NVySOJVz3w1fkM+GOpgGOV+wM52XiC7AG+gazTFJnodHYBRzNeeZSe5oNYpHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=KOAUk9WU; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="KOAUk9WU"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-343f35d0f99so5716975a91.0
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Nov 2025 05:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1763559502; x=1764164302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tBH1paFXTcehxT4QWVpPVMUi1/uSoFqOUzJ/8Lmr994=;
        b=KOAUk9WUkiTLLl277I1zA5JbeS9RlKtw2alQX0dzXh6Z4aHs2pbwqqTK/1BC6RRnC5
         wlehhxulp7lI4kNkNC2i9XlbB9iwIaVkz0XJRwwJb0ZQ2SYG9PLFgwcdmmRddxGbkC4d
         8Z9/fIGtgn6CQuygivdD6kbKeqvG8EDC8pz+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763559502; x=1764164302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBH1paFXTcehxT4QWVpPVMUi1/uSoFqOUzJ/8Lmr994=;
        b=c/hxd4JhfKe4WtJw7TZgVqu83Zg2tGYBifgP4MzMZXdzOY2jwHvxxmGz9Kzrw5f9UW
         gaQrvMdKLPLRYT64cpObx03dJ1ZfzGt4extdEN+Sv7WNPyfH+6Q9bmtF51D6kgdMrufr
         tnBsbbjwiaB/FEb5qGf5LeIUYsuOu9zWjlK4tAGWytJENV4Ae/wf9l/7U9ooz9I95S0V
         /Qqoh+U8JOi3NIa6EIiAnRwqSVXNkZqhiRIjsNKkC2egP+F3hkcWaGffZ0fbVXEUSFG9
         2BqY4R3pWxCsDuZk8b2Kc99IPEZlC4dJ6t3OZS3Iv5GsEhanu6MyocB97c3rHzr1ryPT
         oSXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYQv2Rm5WaGe3tgBGTaSJtKtgct97d84GN6mynPvonBCH81ccBcVW56ikCbXHJLIJxPEbRF8aE+dQVGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy9Tq0snoC3cL8PiyXFBuOLFuHQx+UBBEnytclHMwEaqtRxB/9
	rVZza1DspA6u0VvjJh29Jrg7vZ0siYM0RGjGFTCchWEzBG+TJ/Fwxx6VhxjtUK/5oiAXd4ba9n5
	ffM4VvZm4iU+dH58=
X-Gm-Gg: ASbGnctEgxCbGyOc+kIgFpK7I04i02BC4cjlbPj7G6HKQrw12ecBqO6MWZx7dmweKs4
	YFmPrpfnXJSOfKnmhXA0dn0I/3KwP6JAQK6nHOciWgmtERP+H5p9X4iLxHX2d0ECosYp3hKkiVK
	+IIZCJ3vyojnE7JNumdiJr69nJB9RAGx940jCFzLd67QHeRJVJ4gBOl40w9N81/sYS9PJNoJ+Sr
	zKgE8SRrbNycYHIAH9lLMxzf9VBnpDfnOXSRU7t+2nH78V42Yyu5EfNdMxwMCi65YPstJ3s71oD
	ipSlWLR6WoDug8AwPQ+oh1fViu2plBdBLqwz8dD4g0jC0WNGhpq/bvCXONQL0oe17OC9FvEPK7A
	8lL3Gb82qHAALYSFveK25Y8oH3UbZIe7cbNt7J2wJsuffnbT85rBpK2zjPvq0fWQJXm3V1iFEJ/
	lfhAG4XOk3cYo/YeDa/VHC11z1TXDJl3uqeQkfkkonsDP6MtFQW43qmyrhIFYkkeQKhsFUc70Pd
	zxP
X-Google-Smtp-Source: AGHT+IHHNBq8xvSVzoTsfO4QPAjwgiIHwukUdPe5JdTymryqzDGKGjkE8HCddxs/abUlkIdhe2q8+Q==
X-Received: by 2002:a17:90b:1a86:b0:343:7714:4cab with SMTP id 98e67ed59e1d1-343fa52559cmr20451425a91.22.1763559501918;
        Wed, 19 Nov 2025 05:38:21 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345bc24f941sm2856614a91.10.2025.11.19.05.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:38:21 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: Zsolt Kajtar <soci@c64.rulez.org>,
	Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Cc: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	syzbot+5a40432dfe8f86ee657a@syzkaller.appspotmail.com
Subject: [PATCH] fbdev: core: Fix vmalloc-out-of-bounds in fb_imageblit
Date: Wed, 19 Nov 2025 19:08:21 +0530
Message-Id: <20251119133821.89998-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

syzbot reported a vmalloc-out-of-bounds write in fb_imageblit. The crash
occurs when drawing an image at the very end of the framebuffer memory.

The current bounds check in fb_imageblit limits the drawing height (max_y)
by dividing the screen size by the line length. However, this calculation
only ensures that the start of the last line fits within the buffer. It
fails to account for the width of the image on that final line. If the
image width (multiplied by bpp) exceeds the remaining space on the last
line, the drawing routine writes past the end of the allocated video
memory.

This patch replaces the insufficient check with a more precise one. It
calculates the effective width in bytes of the image (accounting for
clipping against xres_virtual) and ensures that the last byte of the
operation falls within the screen buffer. Specifically, it checks if
'(dy + height - 1) * line_length + effective_width_bytes' exceeds
screen_size. If it does, the drawing height max_y is reduced to
prevent the out-of-bounds access.

Reported-by: syzbot+5a40432dfe8f86ee657a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5a40432dfe8f86ee657a

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 drivers/video/fbdev/core/fb_imageblit.h | 66 +++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_imageblit.h b/drivers/video/fbdev/core/fb_imageblit.h
index 3b2bb4946505..0c0d05cff3f8 100644
--- a/drivers/video/fbdev/core/fb_imageblit.h
+++ b/drivers/video/fbdev/core/fb_imageblit.h
@@ -485,11 +485,69 @@ static inline void fb_imageblit(struct fb_info *p, const struct fb_image *image)
 	struct fb_address dst = fb_address_init(p);
 	struct fb_reverse reverse = fb_reverse_init(p);
 	const u32 *palette = fb_palette(p);
+	struct fb_image clipped_image;
+	u32 max_x, max_y;
+	unsigned long max_offset_bytes;
+
+	/* Validate basic parameters */
+	if (!image || !p->screen_buffer || !p->screen_size ||
+	    !image->width || !image->height)
+		return;
+
+	/* Calculate maximum addressable coordinates based on virtual resolution and buffer size */
+	max_x = p->var.xres_virtual;
+	max_y = p->var.yres_virtual;
+
+	/* Check against actual buffer size to prevent vmalloc overflow */
+	{
+		unsigned long effective_width_bytes;
+		u32 right_edge = image->dx + image->width;
+
+		if (right_edge < image->dx)
+			right_edge = max_x;
+		else
+			right_edge = min(right_edge, max_x);
+
+		effective_width_bytes = (unsigned long)right_edge * bpp;
+		effective_width_bytes = (effective_width_bytes + 7) / 8;
+
+		if (effective_width_bytes > p->screen_size) {
+			max_y = 0;
+		} else if (p->fix.line_length) {
+			u32 max_lines = (p->screen_size - effective_width_bytes) /
+					p->fix.line_length + 1;
+			if (max_lines < max_y)
+				max_y = max_lines;
+		}
+	}
+
+	/* If image is completely outside bounds, skip it */
+	if (image->dx >= max_x || image->dy >= max_y)
+		return;
+
+	/* Create clipped image - clip to virtual resolution bounds */
+	clipped_image = *image;
+
+	/* Clip width if it extends beyond right edge */
+	if (clipped_image.dx + clipped_image.width > max_x) {
+		if (clipped_image.dx < max_x)
+			clipped_image.width = max_x - clipped_image.dx;
+		else
+			return; /* completely outside */
+	}
+
+	/* Clip height if it extends beyond bottom edge */
+	if (clipped_image.dy + clipped_image.height > max_y) {
+		if (clipped_image.dy < max_y)
+			clipped_image.height = max_y - clipped_image.dy;
+		else
+			return; /* completely outside */
+	}
 
-	fb_address_forward(&dst, image->dy * bits_per_line + image->dx * bpp);
+	fb_address_forward(&dst, clipped_image.dy * bits_per_line + clipped_image.dx * bpp);
 
-	if (image->depth == 1)
-		fb_bitmap_imageblit(image, &dst, bits_per_line, palette, bpp, reverse);
+	if (clipped_image.depth == 1)
+		fb_bitmap_imageblit(&clipped_image, &dst, bits_per_line, palette, bpp, reverse);
 	else
-		fb_color_imageblit(image, &dst, bits_per_line, palette, bpp, reverse);
+		fb_color_imageblit(&clipped_image, &dst, bits_per_line, palette, bpp, reverse);
 }
-- 
2.34.1


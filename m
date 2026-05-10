Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E865933EC
	for <linux-fbdev@vger.kernel.org>; Sun, 10 May 2026 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778380840; cv=none; b=f/4AtqP5qcOENVZgv8T69IUvFI+YnNWR89pOqaRdKczoD+lHv6t9cCPWNXQPKa6r9TMSHDAh1WOOBCxz+PCZOBvA/YQGpdw8dSARrRP4TK8KwWBtW26qc/REMqw/Ua0Pf+C2NM8I/g1sCU4AgtLrQe5nYGdU6aA/XW1PAG1J9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778380840; c=relaxed/simple;
	bh=VWvOZkyLed4xSBfBpWRJiQmTA9H1LQukW05qXNtvUEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qAbfupiRO143aoWKorVLrNA0NGvwIRdeSLkGhgfImIoBCM+DiOWNhnzxV9GutgA0zK5oQBlrCwkKv+hgk58REQ7VoFweTUbApF71b32w0KPajS6spfGr/9VmZizWQMDk2nC6gYugQHiDAiY4C+6zHnel3VYP6FjRR6nTQ82BpuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Chmhkhok; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chmhkhok"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so4508644eec.1
        for <linux-fbdev@vger.kernel.org>; Sat, 09 May 2026 19:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778380838; x=1778985638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PcSo8RFa+0/2ySKkmfJmXSREIu83Q6JJsPeDJVxe7g4=;
        b=ChmhkhokYBqOYOFOLleVWOrLwpvVXNFGVUNdbpdzqM5UZKuj6zEzLgz7Mqf2E7TF1a
         mZvYdg+lOUE3o0pe+Y4dgSfoJ0xkwqj/oXEe/xI1ZEvAsJDdZPBbYG2jOTue2fOUswvE
         8SBra9z4wxnQD6YKu0/K7nVDxj6cxJXYLXzLr+jQv29h2q9UbLCfwiihRO7Bly4NXzDG
         18sQvP9idk6TXg+vW/JAAUjTeuQ4PSFStT7j4MN54YhOT4fYPk1vLhsmntLopOVmsRoC
         LlbD0ZEHtmozkNyEhhe4dC7TmupYYYUPqsJQK8KS9vv7Loc4dbxtNOBQ3MPVjFGWWm2P
         mjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778380838; x=1778985638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcSo8RFa+0/2ySKkmfJmXSREIu83Q6JJsPeDJVxe7g4=;
        b=c5M6AKOot1y3V8QxJH0OqhR9i58nYD0xFzMmTsqklN3E7MajOJv/oP/v+bWulG/ed6
         l5M29DDVfrpnFafr6XWqbGSRjpxlUzE7+i7KjMZ6lZIfKOyxalaW77jgBYbA8IFsIOEP
         IwvjmqfL2BgrGHEi1ZSRogfZ9/nmYyUJu27hHlrjipCPUeXeGneM29NpZs1KBtVx8IO9
         dPxuwx+fXD8QCiA2FBrO7E24T2spbGDY/C4JLdnoeC6Y14iYVeja7sYD7awV81KN/ub1
         eHrGkIf0CpP7Vk09H4cKAwXDI2+uKNYkq4AcSxYEzP9yXt7osKyULo8rM6qu8k74q+sF
         8PcA==
X-Forwarded-Encrypted: i=1; AFNElJ9yhXRURvBR528wyRSOCQA+M7xL+67RIWlkzwjOBUsgvtx85GTIGZHXElb8M+/gsjvJmrjjJiuAzsx8KQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlt+Ad9NRJiKaL0KM3wTImHP4Z01/TWwWc3ncKWl7+ICQwqGSs
	cVYS1B5q3Z8RsPRZTov5Jy1Lz7jgLHiPVnIwycFjDr7ElERzUrMGxpLNRIVLl9PEA/k=
X-Gm-Gg: Acq92OGysCz5cJ+KErpHA2rqe+krF1R646VATursFZMG7e6/MQeZRba1JK4dnmXPXUz
	XkRh8DMIMwfoJEj1X/tqoex4YlvJ6N2lfDJSKXOwoqUejzQiDIysr7Zu7z4ZzHA6qExy3ujEPAw
	Ex6g8nSFKScGfJtTZjAkMPMg8CIZew+ahxb2M3XGEtxlC6ewW3F3iunRKrW3qp3Zp4DxcUPaYQg
	0iQX10+JgF4NVoLRv9nEyCl4xyiNMml1FSAPcKgusPfmEPqlkGG0idHTGN3gX8RM/25HSs5M8D/
	sAViy7KQExP9LG9CAooCYKwRlep81jNGOrY1riXOm+cHRje1DUemsXEWIMmF5crbGg6xf8gBjsd
	wg3P36siUQofrj9EI0aNuNltqYECn5T6XZFEaIBFIVAdHbEUYxdQNzEdrT7flDRvaxPVowKUQYh
	bnn1/+lv9EQp4NiEcvz30SuvGatc2i6cialonhHxrWVaMPtxoDl2Vl1TP6WHwZr5/aWifjCIYl7
	KK3f6m+00oN7k6GYAVeX0kJhFkQBsdIWWDtZfQoRq9kNoo+rjkcgo5Cphjvi+hPvFnwQjc3SCaB
	LfZTBpsIsx9cgrJtIcQcBq8Hgz8Y
X-Received: by 2002:a05:7301:4b15:b0:2dd:5641:ef2 with SMTP id 5a478bee46e88-2fb4bdffa2fmr1757235eec.25.1778380837843;
        Sat, 09 May 2026 19:40:37 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88885b87dsm10003795eec.21.2026.05.09.19.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 19:40:37 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-fbdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH] ARM: mach-rpc: fix zImage build after recent font-related changes
Date: Sat,  9 May 2026 19:39:38 -0700
Message-ID: <20260510023941.190396-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The text display code used in the Risc PC kernel image decompression
code uses arch/arm/boot/compressed/font.c, which includes
lib/fonts/font_acorn_8x8.c, which further includes <linux/font.h>.

Since commit 97df8960240a ("lib/fonts: Provide helpers for calculating
glyph pitch and size") <linux/font.h> contains inline functions that
require __do_div64, which is not linked into the ARM kernel
decompressor. This makes Risc PC zImages fail to build.

Resolve this issue in the least intrusive way possible by preventing
the inclusion of <linux/font.h> (and the definition of a struct that
relies on it) when the decompressor is being built.

Fixes: 97df8960240a ("lib/fonts: Provide helpers for calculating glyph pitch and size")
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/arm/boot/compressed/Makefile | 6 +++++-
 lib/fonts/font_acorn_8x8.c        | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index a159120d1e42..0e198a6ce447 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -157,4 +157,8 @@ $(obj)/piggy_data: $(obj)/../Image FORCE
 
 $(obj)/piggy.o: $(obj)/piggy_data
 
-CFLAGS_font.o := -Dstatic=
+# Defining _VIDEO_FONT_H prevents including <linux/font.h>, which contains
+# inline functions that require __do_div64, which is not linked into the
+# decompressor. OMIT_FONT_DESC is used in lib/fonts/font_acorn_8x8.c to omit the
+# definition of the font's font_desc structure, which requires <linux/font.h>.
+CFLAGS_font.o := -Dstatic= -D_VIDEO_FONT_H -DOMIT_FONT_DESC
diff --git a/lib/fonts/font_acorn_8x8.c b/lib/fonts/font_acorn_8x8.c
index 36c51016769d..6b5291c23fc8 100644
--- a/lib/fonts/font_acorn_8x8.c
+++ b/lib/fonts/font_acorn_8x8.c
@@ -265,6 +265,7 @@ static const struct font_data acorndata_8x8 = {
 /* FF */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 } };
 
+#ifndef OMIT_FONT_DESC /* Used by arch/arm/boot/compressed/Makefile */
 const struct font_desc font_acorn_8x8 = {
 	.idx	= ACORN8x8_IDX,
 	.name	= "Acorn8x8",
@@ -278,3 +279,4 @@ const struct font_desc font_acorn_8x8 = {
 	.pref	= 0,
 #endif
 };
+#endif /* OMIT_FONT_DESC */
-- 
2.43.0


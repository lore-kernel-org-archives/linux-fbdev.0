Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CC5280339
	for <linux-fbdev@vger.kernel.org>; Sat, 27 Sep 2025 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758959434; cv=none; b=rM4VH5aocdwvYyEuQNTfZNp7Bsz9b8AdNXwyyhbW1sCgYQNTJ1o/mbRU0IneGJNSwLp466xGPmp2FR6u8LEQMwYxhYqYIyId8JoHHEDu92U7Z+XHed/FH/6C9chkj8T/TfOkXn2ZKm84F6f0xoEvVnw/166ASx04pd6Kd9DDJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758959434; c=relaxed/simple;
	bh=18wu7FR6Yh7UiKlpOC82WgZL7X3EtF2rIULwmTLxiL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1kalqwQcxiyxa1muZtsZ+3RdWR/SOBXW1mDLFHP87AiRSiXrlXny+3b8A1Dtdzl+p1voKfiSyYch9rTBqrcT3jL1ma4II9VdjPC3kJ2IOl0WGiYlsmPFWY52S2gOGBB6cAFpWDHI7A0RDcka8uI3/Gub5zksi2JmP60tB+QK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHaoh/jl; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHaoh/jl"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8599c274188so298311585a.1
        for <linux-fbdev@vger.kernel.org>; Sat, 27 Sep 2025 00:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758959431; x=1759564231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgfPKSQNysrHS9dWJ30TPeInwwtlPIqd1YDWoMjDLSU=;
        b=gHaoh/jlihj0WCk6VC7+A4U+v1cUOJDS8wBr7VURZdtBuq1macboKr3GHMzSuM1FJ2
         bAF+1fmUspN3/uibpT89VS3crxfuxL8iy9u5KXd9iu5gjFbJAASRT6jFPoSLN40MAdyQ
         NfesaemNIJ0FrA1zGiuj9QqrX1pG9rZI73gqwVsqeIetbSlVKHh+4I89XFUC370Zhpik
         WUQ/WPw/VoGuqNem86zSxQvEBxg8+3zZZYU9eeHiPQ6XSh7oTbieEwycZyh8FTz+KtUr
         K4p/ntT+B4ZxS2u27tcTcbOGJA2CcNWLB53FLGMTClKz3aqyO4BTpykbzLR+kcDFrzno
         r8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758959431; x=1759564231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgfPKSQNysrHS9dWJ30TPeInwwtlPIqd1YDWoMjDLSU=;
        b=d12fI/W9v2pOtGF3mikCTK7xEUwcZ+hZkIF4/1s/pvxz8+xOrISGmY8rYhcgZe9tXG
         t7GOXHcuZFseUS1wi7Ejq1z7xpb/8NZe6fUsg0hBzR2GNjLvWJh0I1g1Cjs5nb017qzW
         K85Np2pHXe9wi4ehwaR5R13Dua21EFtLE05PzYWCId7daJIIljgDm5fz4dMqPFg92FzC
         x/Gb03tIpXCyQOEpPBOkDhTwdrT0uR7SJ0LTUQ0Y6AJ3Ia/B4iYTN+1jXiEocyu/c8AN
         EGcylvbwPtchKaGzMkmv2dSCs12Pzwbg8dBpl8kLmSrsQsBeUoFnD0pCW9jv5s2r9OVw
         u77w==
X-Forwarded-Encrypted: i=1; AJvYcCVIVxmQifzWvTLtpRIqJsViYrkqoyoJxPsE5hhsgxzW1Swz3FtNJ1JZz0KEhGC4cIml6yMpY1ybmk7N2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7iwHCKj6f0XQteFhs8LxqUQxhIkUkceuP+bmnaheKgLRpvuHk
	SUDiYRP/1EUsJViLxYejXIMehAoMGyvR0zUtRvE9MtOqg2m2qLN0ADwZ
X-Gm-Gg: ASbGnct0ceNUKyLf5OTSpkquNE1H1tB5Xsejrx4556iJvyt2lMUvSzYtajoNDTwEOug
	2mF02bGYwrVYZ5dawP910I5Q5jtiZWeK50zN69qxobbY/Mt8X2YFXC9RWF2lPg/o+BrhwE5mPet
	cYc7ZdyDNvBpAMOC2kWdjbxSjDWfrK/RvkoL+ksYXrnLX4eiEXhpv6dLHlruu4tLqe/yYXUDkIZ
	z56/3AHCrmHyCI7FvJSFtu1vPsanx9nVM0GKh7otGlIk7Y8htTOcdXBaCKaW0u1MVihgSh8ZUSL
	fov23TlFfjrJEXJgfDOqdSFWQJfsP+MDdkvO+5m595eJovIc4un5MF5zqO/p+YOlxinR91baPKw
	vYF+3lmrCEqCzJdJ6sXPjbL/4vw3A
X-Google-Smtp-Source: AGHT+IGDAZZkx3WIl9guUtfSPbuaq94sVuUIs0iollEMe6q0H0aWqiaDGpBWQY8KPFyB2BFDhYgIQw==
X-Received: by 2002:a05:620a:f06:b0:80b:139f:f61a with SMTP id af79cd13be357-85ae0527294mr1731949285a.23.1758959430710;
        Sat, 27 Sep 2025 00:50:30 -0700 (PDT)
Received: from arch-box ([2607:fea8:54de:2200::9c5c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c2737848csm415143585a.3.2025.09.27.00.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 00:50:29 -0700 (PDT)
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Cc: Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
	syzbot+48b0652a95834717f190@syzkaller.appspotmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds
Date: Sat, 27 Sep 2025 03:50:09 -0400
Message-ID: <20250927075010.119671-1-albinbabuvarghese20@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KASAN reports vmalloc-out-of-bounds writes in sys_imageblit during console
resize operations. The crash happens when bit_putcs renders characters 
outside the allocated framebuffer region.

Call trace: vc_do_resize -> clear_selection -> invert_screen ->
do_update_region -> fbcon_putcs -> bit_putcs -> sys_imageblit

The console resize changes dimensions but bit_putcs doesn't validate that 
the character positions fit within the framebuffer before rendering. 
This causes writes past the allocated buffer in fb_imageblit functions.

Fix by checking bounds before rendering:
- Return if dy + height > yres (would write past bottom)
- Break if dx + width > xres (would write past right edge)

Reported-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=48b0652a95834717f190  
Tested-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
---
 drivers/video/fbdev/core/bitblit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index f9475c14f733..4c732284384a 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -160,6 +160,9 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
+	if (image.dy + image.height > info->var.yres)
+		return;
+
 	if (attribute) {
 		buf = kmalloc(cellsize, GFP_ATOMIC);
 		if (!buf)
@@ -173,6 +176,10 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 			cnt = count;
 
 		image.width = vc->vc_font.width * cnt;
+
+		if (image.dx + image.width > info->var.xres)
+			break;
+
 		pitch = DIV_ROUND_UP(image.width, 8) + scan_align;
 		pitch &= ~scan_align;
 		size = pitch * image.height + buf_align;
-- 
2.51.0


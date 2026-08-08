Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3C243964
	for <linux-fbdev@vger.kernel.org>; Sat,  8 Aug 2026 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786200156; cv=none; b=IwZWEiMBneojXJojnTZPs46V8rHlq9cWNC6GveedLjAQvS73hBTt4184RSh1035d57cpeJrOe3HPhuQpwTYat7oeDY7AQj27ATENy+oYxFld4pPYaNN1MTf2K5MhxYDWLecmX4ZUIHtglWnZlcJw4uNgloffCR/pHTTPxT7/fbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786200156; c=relaxed/simple;
	bh=J0F7Mgxefo3F8e9j2luIjqY4W1sip0quXK+PCqr2nx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TmaiWKumA1oJYbIta6m+rTVibWe3linMqQgxUcPdeYV1DMlOBGOYVFcbco6H5KhILW22M+5ncfBrBw9KLlsTTLaLUkjWLuuOG9CZs3KtWPjttDK29KVa+51LavW3VzmMArKdlx0LLG6Dc6OY7Y7qOg/Lg/q2njyT72FJkZ5Gr0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJZxfR17; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJZxfR17"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954df200ddso2924215e9.0
        for <linux-fbdev@vger.kernel.org>; Sat, 08 Aug 2026 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786200153; x=1786804953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SjP/0fisv2D7yJeeOFlGdQEogU/eo5V7y2aRYQ0iQAI=;
        b=dJZxfR17RsHHZJ6dVb9ezNFBAz68TIVxfJCAwy/aI0LStJRDH51WtCV6e+5K9ukI2v
         tw9lymN26CHoo07utsvB4nK4gT9egkJIRfWHdSwGDmHOptUloamJKmeNQZjpx9TNmijq
         4Tp/iM+cOz78SvEliv2DU1DcVZBiEPiAR0p1q8HDHVvGayPYejYCZHEvxNb2Hv3XQBMx
         kv3M4j3HMLyCjb6D1S7EwXtAjOhzZvkYxiscnyMKhrXinsTGXGdx4x2dCoz//nUNywmO
         tugXphNBE8kEqZ7sifLPwmGa9DtQYGEMaEWTgjA7GzBeUoS/mTlCYMt/DD+dcim5/ad7
         TpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786200153; x=1786804953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SjP/0fisv2D7yJeeOFlGdQEogU/eo5V7y2aRYQ0iQAI=;
        b=dKZDKTLtfEe8VFaSZofGxsMnKerDgWDzEppE1IZoxx3WhfUiukoYz1FNOwKOEXoKSU
         T5mTkWo5wTDRLCh1floluEEBr7fL/bzim/l4ktDcBFC4k4cui5v57gDkOp0B/HaXCEwA
         ingGvX5rE8Suha3S01UbIfZ9Qs2+ev6Y8kV5Wv4uMM7gWBgfP+mcdvISmaRS5ekfQ1Rc
         Urkc+Vi449tOWmjzyY9OYJffrn807EJBKWavpou5RlIt/BBDmRXNEIUiBcEM+NphCWVv
         RugA+v7/JJVywX2T9Cp2w1Si5u8ScAk5YJxGQBmW4ZaOF+2eguqZ0TJvDVZ8MLpwXfTk
         iH/w==
X-Forwarded-Encrypted: i=1; AHgh+Rp24kiEZK0tkqs3S1uewq2jHvzg1m56MRDOPyaRfTcdee4DT2EZdjBQV8BolsVmxJ3DX/59icq+vQ2uog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf8Ws8x7+NUy/gnwl8EvUW3axIa99Mq4qu2zbwNUTEC0ofAnpx
	iTmpLgfAOStO1uaq9f6XUC2hRxrNcAylelzT5//jfec1FS8fwSaFvqm8
X-Gm-Gg: AR+sD12vAdO4Q5UMu6a2pNmou+2WTPKrVlQWH06PLwqWz6NbOU249jWekCjJrz+hK3N
	9fOB+EZHGdkhIp1aHp0HLYa8ispmmIi15RzkOXOY1AxcU1bqEHQcEPb1IOKx05aaEeCfYEEOTEr
	Mxz3EhfhcEsX2otyTnpsXH4HD4rtUXF/nhZwhbht8qcucfWffbuBJvpU0jFipAAcFdUWQaF8TW4
	/dlXl6PV+cVnYsI2++LrZ87xH0AfGcLDZBWW3XVlIx+V6YxkKwPOYrLkB0VDVYWfxxCdnCm96Wv
	DcI0HF+HESMlm+FnD4bSHfppiM60l+vT7N9w1rPkeP2kXgsY4h1eXGgBWk1NNiamBgXjeR/flX9
	5HcrkJH+765y9YcjGxtHYx4O/PuYCc7/IoHawWmj1OcNnEDsNZ1l1tyTjiFxqVQJgfooQtFCJVf
	xR2hTQNEj5ysO+JtdD7nkaCbCmLbBE7ilmPf7jZI2f2LVipywUS6rOWdc7nq9nni0mTk5ZzWsgD
	faAZ6N7d2iUVDBmNuBYTnOKNbb3drJkKko2Ly4yhybK16n1/opfrYUmojsxDcXxoYiwTsjRtIAY
	KVi8xzc+mbpX8jLlrejW
X-Received: by 2002:a05:600c:6b4e:b0:496:bbcb:b0bb with SMTP id 5b1f17b1804b1-4994e7e863amr318623325e9.18.1786200152966;
        Sat, 08 Aug 2026 07:42:32 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-004-134.77.7.pool.telefonica.de. [77.7.4.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995bdbe02esm97346925e9.1.2026.08.08.07.42.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Aug 2026 07:42:32 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: clps711x-fb: Remove unreachable unregister_framebuffer() call
Date: Sat,  8 Aug 2026 16:41:14 +0200
Message-Id: <20260808144114.77505-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The unregister_framebuffer() call in clps711x_fb_probe() is unreachable.
register_framebuffer() failure jumps to the unwind label, while success
returns immediately.

Remove it.

Found with Clang's -Wunreachable-code.

Fixes: 36462ac193088 ("fbdev: clps711x-fb: Replace check_fb in favor of struct fb_info.lcd_dev")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/video/fbdev/clps711x-fb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
index 7a7db7100499e..6789773b22fbe 100644
--- a/drivers/video/fbdev/clps711x-fb.c
+++ b/drivers/video/fbdev/clps711x-fb.c
@@ -329,8 +329,6 @@ static int clps711x_fb_probe(struct platform_device *pdev)
 
 	return 0;
 
-	unregister_framebuffer(info);
-
 out_fb_dealloc_cmap:
 	regmap_update_bits(cfb->syscon, SYSCON_OFFSET, SYSCON1_LCDEN, 0);
 	fb_dealloc_cmap(&info->cmap);
-- 
2.53.0


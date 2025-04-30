Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9D0145FE0;
	Wed, 30 Apr 2025 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992626; cv=none; b=pLuFxvIPqSOF1KRgoMCWQMKBTnXE2mCE+/jCyEyShZ8Kp24hM/CkRWB+l280nmCI3YOVwF0ifa6LTXMcWbZf2G0dhuV1wjfn7auL1t4+ZoWEPgfeW5Opl0702x2ZEUaDD4m29KhC3MMEN8MW6AL/aBYbzpvDBReaKUpi6MOxFqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992626; c=relaxed/simple;
	bh=xQWuZMTq0hh7aj71PuWsI8OaIedNtEW7vEhDBtQsPLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u6BtMv3JeIYOuHSiSyd5+us569kjwF6K13kgf7kekkenYnEGbeCxKVa1LH/fIb9nV4ntVO2JZ8iFFwhjNS+JWzIDJ88FHCYxT0OpnclbdwPX79Rs3jfL1k3SWZOjU/S1p3Ud9CryVIzXP8hJH/x5Qj3wFmSeIze0/WQUnbSMqRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwCnJkVe; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwCnJkVe"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-224172f32b3so15772215ad.2;
        Tue, 29 Apr 2025 22:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745992624; x=1746597424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seto0EvwO9CguWWdu55KVw6IwEcNBbzxE9pkjuWZDxk=;
        b=KwCnJkVe+EOQkiW8dPfPhkU5HwBHRsPNMkK+gnCNloIcVEq+8rLlj/XFEfKp00Inqu
         s8lR2wlBbak6hJQ2X9IyhKRlnW3HAhKpNoaruqWfRp/wSRllfaFZbVQayaXIPvXDOXwG
         p8HYFXEXnrS/SRlNyiA8E4fDnFr6ONEP3itQvQIF06TvZKQNzewduC1lcnGU8NsE7yex
         0gAen74LaVlQkfcx/d83YqoulVat3lhrEKdAjVDhYTfno1EyZNTmDGonZ55sFbfraqAx
         SwJcRPDpkMbep4+s9guKGNY6q2izR9TrYIlVItSQMdyQx3NKL9H/3KYBDrXceekkCjjV
         Fypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745992624; x=1746597424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seto0EvwO9CguWWdu55KVw6IwEcNBbzxE9pkjuWZDxk=;
        b=QVvichKof/VpVQUPolzmaBc799DZ/pCxUAYCZtySuDBo+3kW1urk28rNXO+1G2nMZq
         /4lUfM5LAsdA10cIDlHlKf0mePy+//H0xO+AlFislSEoUZjLqSsrsfdnJS7rKZuBZQNM
         QXAHvz2k1GmP1ycRV00qfnZ6iye++ncn8PiMg1p7VuON8dHcZl3rd9rJ7SO4hUm/ItQ/
         Sy7R6viRrW8aE09vwNt7tGwQ15qKO/SGSKnJHNiJG02Zxtp8LKEl3zskNsbVzlthKiTd
         Ukmb3v2UZwrJUYTZ+Q5AAJ6lVEfpWMoPp/CzCDevBU52Cl86IPWCL5tStJl99hSg03Ke
         Cdhg==
X-Forwarded-Encrypted: i=1; AJvYcCXfADcKAkgpB/NoJA7Erv273OTmunl6JCGCUdWEdfrkff6cNwJVBy2+SO98494KgvUpjcyQlZloxxp6a3qo@vger.kernel.org, AJvYcCXt9/1wZ3QzCOqzySC36XZChLQrY+/kwcHoF4ZkV8O+Bu5bk/WpB9QphxQ7V9rnBGHifF9WsUojmq8+Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpEcc3tIIOyWeqNHEmAe0rEGStCiG6rbPvidut1BKGTaHHKii
	QfhcMJv2DeIG0s5AsufvTTNuSLXpPgelU0X9uq3gq7zgztzD1NNV
X-Gm-Gg: ASbGncuIfV6hylZC7q3WJ0JZnNNFRc/QCIKuipb67VCnH2M3xnOxZ/eZJknZgpWyYvR
	RTYlDAO8UNMorScXiWYICUK7lhb3qZFX896QQLQemPHWL7ZJA2eRQ1kfzMEit8U5LjNt9qb7/AC
	iMRwCqStQPnofZrQsOEX05rYpCJ9FHcpMmBA5uHVNakE1b8QdhGXgGngzmbDLVlJH7yhORx7Zpy
	HAESJo9wGbTmAOqJtPC0E4hO1BmlrCFzV8KPXunOWulvb+iyC1/TiFOBA8IbvA5pERMi0/W/NOB
	sNS14ibn1kgV7GAhPEVF+GV3/VpctKdCZm9SRKPrsjFYGCVKE24U7ruxZ56N0PPGxXV/R6ZZIR9
	EGtMqspTLeFCmdSenmawtyAjb7QfZ/n/Qd1iNMkM7qPKZzGh0VDgjJQveKpLejKvmtQ==
X-Google-Smtp-Source: AGHT+IEXnD9wHiSCGCMkKbOlp7xQ9e5zytOGDgtWJgQa2i3lIm9DdLbVfnfIdtD5AsZa5jZveAeOMg==
X-Received: by 2002:a17:903:2cf:b0:224:8bf:6d83 with SMTP id d9443c01a7336-22df57b3ae9mr7884765ad.8.1745992623808;
        Tue, 29 Apr 2025 22:57:03 -0700 (PDT)
Received: from kerneldev.localdomain (162-225-124-171.lightspeed.sntcca.sbcglobal.net. [162.225.124.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221a82sm113383895ad.257.2025.04.29.22.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:57:03 -0700 (PDT)
From: Eric Florin <ericflorin.kernel@gmail.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Eric Florin <ericflorin.kernel@gmail.com>
Subject: [PATCH 1/5] staging: sm750fb: rename sm750_hw_cursor_setSize
Date: Tue, 29 Apr 2025 22:55:35 -0700
Message-Id: <c465a42743c4fef0853ffa7f7c304dc569592d3e.1745982772.git.ericflorin.kernel@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1745982772.git.ericflorin.kernel@gmail.com>
References: <cover.1745982772.git.ericflorin.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename sm750_hw_cursor_setSize to sm750_hw_cursor_set_size to conform to
kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <sm750_hw_cursor_setSize>

Signed-off-by: Eric Florin <ericflorin.kernel@gmail.com>
---
 drivers/staging/sm750fb/sm750.c        | 2 +-
 drivers/staging/sm750fb/sm750_cursor.c | 2 +-
 drivers/staging/sm750fb/sm750_cursor.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 04c1b32a22c5..47c84331e3d9 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -120,7 +120,7 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 
 	sm750_hw_cursor_disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
-		sm750_hw_cursor_setSize(cursor,
+		sm750_hw_cursor_set_size(cursor,
 					fbcursor->image.width,
 					fbcursor->image.height);
 
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index eea4d1bd36ce..3128ff3f4b70 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -57,7 +57,7 @@ void sm750_hw_cursor_disable(struct lynx_cursor *cursor)
 	poke32(HWC_ADDRESS, 0);
 }
 
-void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h)
+void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h)
 {
 	cursor->w = w;
 	cursor->h = h;
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index b59643dd61ed..edeed2ea4b04 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -5,7 +5,7 @@
 /* hw_cursor_xxx works for voyager,718 and 750 */
 void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
-void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h);
+void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h);
 void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y);
 void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg);
 void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
-- 
2.39.5


Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0F2264DC
	for <linux-fbdev@vger.kernel.org>; Tue, 23 Dec 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766517115; cv=none; b=OV2tJ4BdctxxoMrVaAtw7HHsv0ogn8OSzCHMr0clGxJAwwJ+BXieZtJGU2WhDp926EF3fP0fYB4E+lBr82XENFxbddKc7rRfrtBkzkqPLTSRzMlSX5SeC+K0tyLRqzSrwcuJ/IQT6EqnOgCFNWFfqr3ixLF5lsnNGWD4eLwu0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766517115; c=relaxed/simple;
	bh=xmCrjaqyaABNHnrmNxiMMpVEhoqh23q2bG1gMisEM3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MCIbVt8vzTVDD96ZWZSMzh2ydDQOfy1I710Tsxcx8Q09TOBUY3ucMEUYGaOGpGzSycblrpQRw+8MwM6XwEYDdEgSz0ps49IyRKZ91iHw16/VhDfAxIjxFCwD6hb/onPB+t60vdc50NHOF7kTw+RolWeXLtVELgj0UT8kFG2z1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1Mh72sm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1Mh72sm"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0a33d0585so49915015ad.1
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Dec 2025 11:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766517113; x=1767121913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/gpB+cRHxjPZOPxdkNzpOyE/YKlTlYotkRf4EGRknIE=;
        b=A1Mh72smK3XrZEXYLQzWfmxuy0C/Ytep4OlUUmdmzdg4sKWaPAZZF9+tOzwnm6VGkw
         pGqzEBdAoKPaI4Kpgj+3eWR1S7WNmHUA7IoXVB0uXbMBk8+ZklxoGDDxP2DWg7yYhMYK
         XdGKR1DibRkmcCsgRur7/Ro8j9f7evCc/hndCFDEqxDs3fwbFpvfsqdMHAqfal+N/EmM
         +UD1uU44A0k4RkXuR9GzOdylUQjmX2agkf3P//WrFwJq4h0IVIKP4+4WsBVyEk7lvzof
         UqloZ3bE5Jkans0DnXaCt/EQjT7p24oRAnnybgmtddYagX2LKEIFBUxuL6vzj7+vSM7+
         f7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766517113; x=1767121913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gpB+cRHxjPZOPxdkNzpOyE/YKlTlYotkRf4EGRknIE=;
        b=vngJt1bgmKKSM8gKu3Mq6UAxGvmQ/tou8RmKMtXwvGnGsF8KNW7TVZjBwjvbhBYGDk
         rodP6KeEIHw2K7jv6/ddZszjsRhRK2S0EC+gn4YtJgra/M6CZoAwSEJt/G+ha2JzZiZm
         n0m6ESwdUXa6+zPgxsWxFVVzrUmenmRAJm3My8ge0Fj1dEED7BJhdWWIRIxzkrtfLsM1
         qFgeLrCAMQUBGEQiREew5i6IkFILfKmjPpLF054dvgR7stLy8Mxhj+KEb8Pkz6zDmyZ6
         oIhXcB36ZY+CgKbtwtRDO1YbDqVUm7fCZ7M7Zlg7YALodeDx5nZ2hZjx3P8ILldisikb
         4MDg==
X-Gm-Message-State: AOJu0YxXAXsEBT8iFhDRljfCtmNR4dCmHkyN3DDGKHqUBFujcNVle+37
	SY66CQZEok9VSDr6R6BlJeg6B+PahVxKvsuYp3rMa+FdByQTxxWb6o6NnfOiHg==
X-Gm-Gg: AY/fxX4jxwaztq9BRdtxfs5VjsRu7usJtB3ShBWYyrRiu2RWaFDolv2eE5Vj+O27Xyj
	CtD7/yLdp21VaxJTjM3HBiCWK1ASj1yom8RrhBnHkGRTGt5FT0lIsjPt/oLgvYlPP7XgyrHktyi
	4zYLl3Bm1JR8No69ayGA6mpBhbDBr56yFWZEuQMOPdlv+GlKhyK/Tp0P1hVOqQx5S2h17NH9M21
	/eZLVdDqYcSjtCtEtoia0zqNgstZ0dgvcKu58TI7NljoNcM0PnM3QAPUGSokgYrG/pefrRuzrKo
	yvzTDRzmm0Vt325Aab7iVWHn5gZnAR3kvi/hc+b7tkz+w+4L+Nv/HHhkdGhzNoXyYqb/i+AIgg4
	nuXo3BU9mqdkElHpTWAcDzwlhZz9VA7CcuIb4XfPFkOYSPQFj2en/5sBWWzk66b/8Poz2yXh08r
	Ot05ejhozaLPpjx3BaJah4XC+p7H4rNUy79alnKP62/BG5zTSplZCCvKE=
X-Google-Smtp-Source: AGHT+IGiYJNYY6pGna2vDisp5PVEaup6D7AXa/kJEizKbmM+NJsAinOKqe71+1YtwveQ5KvI2qGGtQ==
X-Received: by 2002:a17:903:2347:b0:295:6e0:7b0d with SMTP id d9443c01a7336-2a2f2a3fca5mr126882655ad.56.1766517113483;
        Tue, 23 Dec 2025 11:11:53 -0800 (PST)
Received: from localhost.localdomain ([2409:40c2:1052:c28c:d56c:4c53:fd22:65f7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c8a8e3sm132680325ad.41.2025.12.23.11.11.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Dec 2025 11:11:53 -0800 (PST)
From: Tejas Chaudhari <tejaschaudhari038@gmail.com>
To: linux-staging@lists.linux.dev
Cc: linux-fbdev@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	Tejas Chaudhari <tejaschaudhari038@gmail.com>
Subject: [PATCH] staging: sm750fb: make g_fbmode array fully const
Date: Wed, 24 Dec 2025 00:41:41 +0530
Message-Id: <20251223191141.14206-1-tejaschaudhari038@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a checkpatch warning by marking the g_fbmode array itself
as const, since its contents are not modified.

No functional changes.

Signed-off-by: Tejas Chaudhari <tejaschaudhari038@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fecd7457e..15b5de33b 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
-- 
2.39.5 (Apple Git-154)


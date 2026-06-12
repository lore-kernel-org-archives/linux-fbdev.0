Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCB3812D2
	for <linux-fbdev@vger.kernel.org>; Fri, 12 Jun 2026 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302013; cv=none; b=dGdfqNWf97Een/mi8b+QJfL5aeRrLp/F1mdLzpmtdJzN/RBQvrWaSbPBntOXEucSQivGr+monnW9ywNGZJnO+lgvKSoQtYobLfocNSZ31n2u7cIwqLNSnqShoa1B4VGF/kfb9PngNvADnhqeRbEIY1SbhY3AA0GBxt/8XihcJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302013; c=relaxed/simple;
	bh=nUZ5Dy/C6YW0aNXrQ9AwkXLylyrntzx3ImVgYrWE9Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=peUYmtgo+8iLJ1wYpjkw228zAF4DAWgQsHjK8xah0koidWs6mohndFklHJOPqCyzdtd/1Do9OHtr86lQYkVreB1DV41mqkscUjx6lyE4p7dLeWkH+QJVokarE/YwQpEY2zMZ48E9r67ffLocn1fT5RIrzVDkUySfX6FDl8NAAGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/Fpj4aL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/Fpj4aL"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-372b4330deeso1040461a91.0
        for <linux-fbdev@vger.kernel.org>; Fri, 12 Jun 2026 15:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781302011; x=1781906811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HZjhBdOQiqk5Y/TB4HTh3RZS+UoX6hlqSIr7w511LvE=;
        b=B/Fpj4aLG67mPu9nNr1ehI8l1v0WGs5FYIqhLjteAEUDgzi3Ht+qtP9hulLDlPoYWM
         wISe/CmyQTROXtfIcYJmaL43sXWKyZ3GZkx0v6n4pEqjUVXFyqYwVdHUY3Sbm/cnjBkz
         zADx/EY7g5CvQnbnnzO0yTchXNEe0oTXJSIYEOCjr8vhnEfSRJeDlSo+jDq9wASnvNPX
         Ja+XPOZ5PrTzKmDAc3VDuki/Bau9yMNhsu87cqCHv3LsNg1SYuZ+9hTW6Uyx69nFaVaK
         m4MVSyrwna5WiRka9nZDtCeu8bTpI4yXOpKUpnJWgJuaM2fKk4Mxx7c/OSiHrtfQetUK
         KbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781302011; x=1781906811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZjhBdOQiqk5Y/TB4HTh3RZS+UoX6hlqSIr7w511LvE=;
        b=g230oKgUS4Rdv7OF8ItJlZ2c9D3hAr8/5w5WvFDs4oGfTBHK15XEC64VvySV3dM/uc
         nQ//wrD4NkwKsj7CdcAsS9JRqyb9aydCt11CY4lc7lDxvigWj3aGGrdh05UYkUBxJbZ+
         X7j2J8ba3bgrrpoZOxhGU0YrJ5VEv/JSaxGP+p6yaBFMM8SLHzL+ecrjbcaVWK9LgbRi
         F4MXE2Nm8EAgsH3PBBRXpHdJKVEWG7BRalCXGLsLz3ltN43ZyPzTTQNznAYbXUTnD/A8
         hKoKTgKd2fojJHol9gNaJsFPg6l2Ql/2YVhcEg6Xd5JwxsDGDK1EcJaPPphITeL3POrk
         v0cg==
X-Forwarded-Encrypted: i=1; AFNElJ/VHSc3KJ5jvp4a3SQcvcxM2KwbBVEPVNDHot/F21PD3rXoelhHhFmPK3VxCnf/UfM+9xdHMbxYqy3i5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL4qW1vHPhl2EUEP6F8JhZW/kjqR5f3PbbmEXajynnddT9gXQS
	l7vi204ioARtrZXeZLJHzQLgJdBoxSLauthuG4c+RGgVVN0mKaclNPJm
X-Gm-Gg: Acq92OHpVDRoFcdaqF+jg1wpvXKRhw+eZ6J2s2uJidxkVUweh7EEzAUXDYznCoXnQYn
	7wHJ5dR2z1NB71xIzYhCX0s4fQKZm6DwDI40M+n8x2HHFxjLnrBVULh5NO6NNDBC6gCYJBKnuvt
	yIgsVrT6+jkOeevLZfKdd/9nJAt6Gu8Urwuo5g0gLSlC/KoFUCfI2ZyCcdFn2ShWn0uQmIyX5cV
	DG5tgD5Jbs+ULDtxjQh/F27ukVrlvbemm/DTgpcA/1WJ/vWMv/7Zwy84yGDdlhlcX8VC/2GxsSB
	FfVYc7vQiRP07lHPyVg2qudnXZGjc4JzLNZ31gmVY/2N2v4U3F1qn+ps73gYDTMWCJ3kBPFaclf
	PuxzsRmwyVY4Th8DI6wUwOD5FbbVk8CblZHq2DX+xmfeI0gRRUh4hbys4t/3TpOVp72I/bGCfEy
	m9vSJ9P8VXjqOQeHC9pQGBdfU80WtNWCU3Sh3Ijcrgn2KOd/D5Xom9saP2OYSkkfxFJ/93LZ5lh
	CA9oIJsICQ=
X-Received: by 2002:a17:90b:2dca:b0:36a:6ac2:8bc8 with SMTP id 98e67ed59e1d1-37c2bcef7dfmr1071667a91.14.1781302010945;
        Fri, 12 Jun 2026 15:06:50 -0700 (PDT)
Received: from bloom (S010680dac2bce256.cg.shawcable.net. [174.0.186.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a2678375fsm3797237a91.17.2026.06.12.15.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 15:06:50 -0700 (PDT)
From: Jack Lee <skunkolee@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jack Lee <skunkolee@gmail.com>
Subject: [PATCH] staging: sm750fb: fix const pointer array declaration
Date: Fri, 12 Jun 2026 16:06:46 -0600
Message-ID: <20260612220646.61461-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

g_fbmode should be declared as static const char * const to prevent
modification of the array pointer itself.

Signed-off-by: Jack Lee <skunkolee@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 9f3e3d37e82a..19c3da654a43 100644
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
2.54.0


Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437BA14EC73
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Feb 2026 02:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769999592; cv=none; b=jo3Aq2hyBW9uQUrqDxQqaWPXndGS4ZnI8YVT7MDwJgvEohrWKXKHXGtWTccDbvcqQYZmUG7PnuoNFsXqNFwCTiPkbd2eMaLP6LHhSaVaI8zztxlfbinwI/I3wkppov/bzlbEnyP9GwcedELLJ4VfYFrUZR2NncnCCE/cxA7I1gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769999592; c=relaxed/simple;
	bh=SNs76Ynvdngqzwaa0kRkOvxuI1a48yY5O+elvS10IQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UyZ986ZdsU8sFQmzVO/mEDx4AF1diVe0DiKpYGbzNwSQOwwXij5qNUdmtH10kxDj0yOkQZacQnjsuXqbwpHnOm6aU5mYbpN3T8aF/G7khFg51DKHcOBIlaoLHXVMK8Pws8hHmRmryVy2Q5Xk1PVdhG0L/SGgaTxohtDFmefQiDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaDZjb9F; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaDZjb9F"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8230c33f477so1662322b3a.2
        for <linux-fbdev@vger.kernel.org>; Sun, 01 Feb 2026 18:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769999590; x=1770604390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mP6Nulix8NKuK5cDhAk8p60ccGqEHCnwELx4DpyID/k=;
        b=GaDZjb9F4FxVvRXDgxuJ4QHjkHNddxk+dFaOQLDM9zaxwxWWXWrjH5uAW5BDt3grXk
         0qxKmYd6trEQ+7yP3XYidon17NFqFSr6VXESkI9hCuZZkpm0QYjrh1JBKnlwxn2tJYca
         AGgWRfjsYRPUm537T8+J7/82ZB9HZhNCHhNarL8wTcDerAlN1ZYJCJ30m2m0dWlbV8w0
         iLZb69ekm8fXf+csXDPPtvLBuZiy1RhOqj1cWpAZH6rtoPW2ilQBLpKxYyhWpoCbXsN3
         omWCPlsneJxBta311eKKxumbjJ6qw7TQY/myIBCPc5ooMmC0/j6VKbADM3hMpIyON4+2
         IKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769999590; x=1770604390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mP6Nulix8NKuK5cDhAk8p60ccGqEHCnwELx4DpyID/k=;
        b=Lif6GK+UHNQ817vXjEpWqlqvrwo1+nYMCbmqmWnkvXaDgsg4CPSXW57gnySXy2DLZS
         DvUtcCkEs4TLH3kTVj5+0UtPIp0rXz41selUPuT1xdouwFuaHtlRUWyTnYBLshmNt/Ii
         sEKp5L9/uSnBsRainLOzWEJXbT7V8Z5Rlv8Vw33pcGw1c4CRf8l1G7h/KBeh0ZH0AJ39
         Ze7c7Mo+JdlXNWMEz8xYzO/+X0mzvptC2+aN4kYSl+ZBpcspOXo9Vw1+YHPDemsIbDNE
         ZOwCy1LBnujo46FN/Mw2yUg8gNXQVISry5KAuRugQeUBg+jRcP8Mk7cPzAGF7F6OL0qd
         o+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCX+ClILh/Fa8cYiLwQHpqMX3s11Pz+C5HdO1/jmN1WRug5hnZsE05zDZED+4ojwe+RVKEZSW9Z0P6i1/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhBQplFbCOPCLL3p39xIKPNS5KoLhqvAQHkvudOWWHHQmhxr51
	bSH6ZKwl+fHmQu8XFi0RAZeSijOvpqXoabdrEd2D83e/zJjgM/1q1O6a
X-Gm-Gg: AZuq6aJdDlIY1cpS/l21ZmnvWnCGAFqpT17GtSRsUi4oaKrkWrjV14n5WS1O+XyOr5d
	Ubn0uVJLLZP7/HikRtRSogyleYRVkdxEfabRsjBiGjcrakuOBKwISwCaZWLCiVG35olJpL+lxlG
	mppP45IIpS0pFQ39dD89lyNbu2/wQtcZEv07vQSMjm+Kmlh7lVTDut7JvMW5SIbFiB+GhW0mUPv
	QCpWIzcgZly+4yfvGYquzuPKWNmPsVHdj7pTD1gfdQSUOWeza1hOHpoXJyBKnAXc/3EY6EWv71y
	qKvahs0b1wTm80n8/yn3btg33sZOuKEaZNf12obhs8DQFlVyrcMSnAnv6bg32R2wQ2Hmw2R9din
	RylDPLxnzSUAST7KSqgm/1Av3cDRhdGUJUgm4J/8n6SFeyAewtkM5kG+Ztig15/qITvr7oD58pM
	4PSn0jOlDypv9ReUiKArwuPlfubAhH0DP8SRaV3WvtR+/z4DfAYkk0UGYZFeAvtrfW
X-Received: by 2002:a05:6a21:398a:b0:34e:be9b:b67f with SMTP id adf61e73a8af0-392e010991fmr10891346637.49.1769999590510;
        Sun, 01 Feb 2026 18:33:10 -0800 (PST)
Received: from localhost.localdomain ([192.9.168.136])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c22459sm13605605b3a.48.2026.02.01.18.33.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Feb 2026 18:33:09 -0800 (PST)
From: James <supernitsuasnowpee@gmail.com>
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	gregkh@linuxfoundation.org,
	James <supernitsuasnowpee@gmail.com>
Subject: [PATCH] staging: sm750fb: make g_fbmode array const
Date: Mon,  2 Feb 2026 13:32:53 +1100
Message-ID: <20260202023253.67552-1-supernitsuasnowpee@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing const qualifier to g_fbmode array to resolve a
checkpatch warning. No functional change intended.

Signed-off-by: James <supernitsuasnowpee@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fecd7457e615..15b5de33b8d9 100644
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
2.52.0


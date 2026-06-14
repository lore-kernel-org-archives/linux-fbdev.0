Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592129898B
	for <linux-fbdev@vger.kernel.org>; Sun, 14 Jun 2026 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781468173; cv=none; b=sbG3zFTYr1GDrhjcdQbVj18L41bSKs7J/tyqKk4z6RsNnA3UYoQQcdgbXD6thdTDLbLHNM3d+8TYJS0iaHV/wcCz2zu0vfx2YmA6aWm6cuRsvtaxkTekbH1NfDES1sCupmn2p7jSZXoznj7hms+fuLMqvbYd9wqfnFZt/U8Z0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781468173; c=relaxed/simple;
	bh=odnJMk2Iur9EW+NLveIiI2DGWoiKIbQQn3/cwmGFwWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+q9I2WA/8RhY3W4MoL+z8uX4ZFtKHyd20MZJJ46tYJHADE95XHuMS2EhApyOxAvI5rNWlFp5xbT3PJJ/fkElmsB6CfMasq9DWa/Zai8z/7FqF/0aTS1PlEPga+BWg56n7NfsLL9ngSShDCdcfCvgQP8XlwNj6Uz7EW/FbqVpSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfdOHuii; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfdOHuii"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ced8f44da0so31609896d6.2
        for <linux-fbdev@vger.kernel.org>; Sun, 14 Jun 2026 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781468171; x=1782072971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7MKHApoD4FmbO7LLQOWnCTjAAZ+14mTiiY6a3gJWdwY=;
        b=JfdOHuiigF8+1b4977ZYl2glYDGaPlOZLe8Aj3WtxY3R5MT3/SxXifXgcYFLV8NCFW
         WO7wCx+f40Y40IwOjCruBPFySnzaWVmxf1zuofPTh70Lbh310b+cWPTdh4j4rIMHto9e
         qKiWJ9Nvyb7MyDVJqaCczlyzh20PdMuluWAfb1Y7vKVwhvhLAZm20u/UlgAY9FGguGAa
         jsGwSM13geWeDRlS4KzoQroO/UDh8CQtzfAnb/eo5ew6yL4eNLzCzz8xJ+Y1JdEf0sa4
         bih0YgxGKPmzHhLUPgumewb/8pVzwLtaBrl+slKPlUOcxDA8n/bIkCKzUENLS+zzNwpP
         zQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781468171; x=1782072971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MKHApoD4FmbO7LLQOWnCTjAAZ+14mTiiY6a3gJWdwY=;
        b=ljpDYDFkOZox0jBSaLtjDuzo326WAmXHpTh/WAhc42G99zcF48ZnbLOI4KaP0iFq2L
         4vJvVwGwpYsN/fU/bTm3mrD5HLgGsX+SeHHRhGxojaoh9ZHBW2H9/ewafPXrDaYhV+1+
         G3bPH2JUx21CHXKo1EIMLy6W/4rZdvKrdrDG5TG/Ru28okQdyl+W4KWpVCwBTxo8H1hM
         M7v8+E1QjSmF6in2+Rr3bamFjzwrcNVTK8JDLL7DqltBaR0aRfqWpFP6FIeinxShVxgw
         /Z4SSNou1mZTTF9D3nD/CCUkNqg3Sc3bXAo4MD3NeTMs4T2Rt8wcA0AEvxLVDL51Ea5e
         k+bw==
X-Forwarded-Encrypted: i=1; AFNElJ+yVooqYH6c64TCFwKLNIjkR//mnHOSPp0vr8xo65I61JHrfMEy1ob3L/ieOKUIBrjGp/2/dOs2ZnDwlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyygkRf9zQ0vkV+NSMwLzPYCsHDCu68OssUm6IGoUv19R196NQ8
	r1uQQGx+3OyD/NeBwklLIyzZc2wIe4xGCLfGIHVFWkhYZZ2BwKYntC7x
X-Gm-Gg: Acq92OGe/bkMFHVdqQipTzHT+8jM0NY46YLil5r+hJlw1TkLcqYm9INoaR7s5b2vM59
	4BHdHrjWAZ+hqoVfy/PejQ9Ge9Ln63Wwv2d6kiZcc5iLUJezfbKfVJ1XwlF5P2biXfhibeJMPUy
	lYI7FLreVSE9bifFX4KZwmVZ9oCO7DkK9EX9lFVFDrpXaVTfvXFFZeGpUT4o8njvu6SAG/EclRg
	yfSoZ16mJ19lUQivpXGCppVpQ9VBKbcZQCYIassnWxxGFX6wZa440gtQVao36r7kE6uU+qGGNnj
	MA5pWdjs9FiolN0uhRbCODIU0h0kKNLOTNox9hZUp2H56WeUSjAZ8sthPoZaunF1BRQAZgMX6V8
	az6RPCFlo6fXjJFcUziZZD0ZM2YnDtpTRnBw1zmooFQHiEzY80pXIMhNmq69mXuCzR6qXV55JsQ
	kz25fdRVXIjzn+IndlICuxdRndpIxXx5K1o/WD4IokwD7h
X-Received: by 2002:ad4:5bc6:0:b0:8ce:abea:4723 with SMTP id 6a1803df08f44-8d32f599636mr195018916d6.40.1781468171377;
        Sun, 14 Jun 2026 13:16:11 -0700 (PDT)
Received: from localhost.localdomain ([38.174.6.30])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d304f3e55fsm90190706d6.39.2026.06.14.13.16.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 13:16:10 -0700 (PDT)
From: Keefe Reeves <reeveskeefe@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: abdun.nihaal@gmail.com,
	error27@gmail.com,
	chintanlike@gmail.com,
	namcao@linutronix.de,
	niejianglei2021@163.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Keefe Reeves <reeveskeefe@gmail.com>
Subject: [PATCH v2] staging: fbtft: use %pe for backlight errors
Date: Sun, 14 Jun 2026 17:15:51 -0300
Message-ID: <20260614201551.20542-1-reeveskeefe@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coccinelle found two places where backlight registration errors are
printed by passing PTR_ERR() to dev_err().

Use %pe instead so the error pointer can be printed directly. This keeps
the behavior the same and just makes the error printing cleaner.

Signed-off-by: Keefe Reeves <reeveskeefe@gmail.com>
---
Changes in v2:
- Use reachable Gmail address for author and Signed-off-by.

 drivers/staging/fbtft/fb_ssd1351.c | 4 ++--
 drivers/staging/fbtft/fbtft-core.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index 6736b09b2f45..b6cb60f20b11 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -218,8 +218,8 @@ static void register_onboard_backlight(struct fbtft_par *par)
 				       &bl_props);
 	if (IS_ERR(bd)) {
 		dev_err(par->info->device,
-			"cannot register backlight device (%ld)\n",
-			PTR_ERR(bd));
+			"cannot register backlight device (%pe)\n",
+			bd);
 		return;
 	}
 	par->info->bl_dev = bd;
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 3da42c8ca6e3..b6a846ada3e0 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -187,8 +187,8 @@ void fbtft_register_backlight(struct fbtft_par *par)
 				       &fbtft_bl_ops, &bl_props);
 	if (IS_ERR(bd)) {
 		dev_err(par->info->device,
-			"cannot register backlight device (%ld)\n",
-			PTR_ERR(bd));
+			"cannot register backlight device (%pe)\n",
+			bd);
 		return;
 	}
 	par->info->bl_dev = bd;
-- 
2.54.0


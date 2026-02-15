Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E32529DB9A
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771163939; cv=none; b=JIcmzhDScvQl0YHcWse9cAxyzhhLOxViMK73cAtNK/yXRfQNr04WNTDL9YyYl7hoxWZhbn4SzBFu3DXyjM5sD6hUC4VyU2+y7KWeJe+5sR45AF8098De6aKrI/rnBFE1xJz9L/gj+XhTGIFWv07FKQC/Co7t+seNg1x03/tMu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771163939; c=relaxed/simple;
	bh=/32w9PvZgcOs3+X7N8oELcxM04YQkhM/L2MiPZZxpNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IB6H8v6W/ScCsgg82CVO2ZlwcPvm1UyNCh60yalLlajpuFbWhNKS/xJ11/n2fgGhniMYmclX7XijEPn7RUfj3I2ODQAzX4Zhmkc8RgTbmxFbIOZhLtHVvaopXxE8b37/DaCVooRxO/EtP6Bc89+cpHtmppyy4KtOXQVdHJhyI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RvKo5kMO; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RvKo5kMO"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48374014a77so18954405e9.3
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 05:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771163937; x=1771768737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87Z0X132XhQ0qIp2UdTelILbwyGX1bUUxXRUUNesvoY=;
        b=RvKo5kMOodhKM1iA9+ibWdQrWQPAiRj53ib1o9I6ZUXYSCRgUGgBGX4mwqKFHjNynR
         SL0LbuLTNvF7Sdy88K60iAghTKzBaDCES7vmLZ0CJ33idEBkOI6xFy/BRl8LyZpPdanu
         qp9H9x66HmDhTnJaJ9UKINxL6nAL6p+CcqAPOdbsWWsaoTuVMNamlzaJ/nvloC29hevY
         RlLx4UYiyaSci92avTrAbq6it9YNvQfCvkJLqeqkEPFmS1BWOxqGnOiaRydHy1soqQ/c
         mz+DQLBAnq+6bd65xOjEgVUOdoqIuC45/wYvsxfL1Evcmscx1c4t67+UOnbtAaIBwaSU
         buBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771163937; x=1771768737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=87Z0X132XhQ0qIp2UdTelILbwyGX1bUUxXRUUNesvoY=;
        b=b9NSODes75mvqpPHlbVJGVH8YY9K+GaheCZQai/JtlN4jtMxmw0vxNM7p1cd8Pu+yb
         dS50Gy/4whYlsr4yXi721JT9z7gzc1F6P+ORrz6OHcQm8IJYUTMSHIWocTms8Uf5PO6U
         rCKVOR5k7e+hx1ZsSgqI2LboWQJQzfkTtltYkKuig2DsEMZEfvDJiIufZ1MJ6vuqFjEX
         C5u/+MuwFX69ObEhTHYg95LXEGuWv5mlVLKPyHNB4f6/vdPsxwbWaiTvVNJizPBaL/HB
         XV/BmP8WLnbkJvQRvEYZT8WNQOX8BuE+22rshg8tRdH3ONL7anC2gPeWYkoYS6iyRTSN
         C08w==
X-Forwarded-Encrypted: i=1; AJvYcCUlZBNrYzqZGQCCk6uCWEAtOotPV4UI466J5javlKgUhf/WYxsHYMXwQA0kjdIHd7mwEYi71jEBCjdMTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdo9RSsWJfhjbchPPzrbBolcHnOrTzpK9XrTEMMv9fkVZhQypX
	xp1CNWbKmvsJdUscVeWMU1zpyUuzvUaWPic+sawtuguWRiPravbl/+aSWVGvv2RGZPo=
X-Gm-Gg: AZuq6aJ4VDy4JEYBC6QiQatepjboU9H5xvFJSABM6/BFa04qwFBZj1IBKN9CGQhgOax
	AIzP/5AWg+G6vLO64wUKxVwGnAJVJkarGSvJrn8QRGqkx681MASEfNTlej1l07MeEmYwsriawQj
	yRhwvjnoD/8bOuzje+QcgI0YuXqk4TVga6rn8V7+zOG/ZmEarfdAh++7J9pN15LPqIlV9aJxZ+a
	PACSMUAmuP6HaOH1SMw65h1+q/q6u+PgxZD1iS/lukgSNtPtORBrw3jf711uDmM6vZKeyCTq1//
	vwbb38hgBtniiaCmgksph40l6wGCsdITHjk488fxZLRI3+NOqNUAjlAt5f8Z0EEpqt/eIreDLIn
	yHkjw57o8Zw4jn0+IXA1msj2zfhWiy9tWLz41/2mZOA7A93DQ6Td5cMDphTto2/pC4Huiovpy47
	hnVc0fsFlVKO416/uAE5fmEmNSDDzM
X-Received: by 2002:a05:600c:3f0c:b0:47d:5e02:14e5 with SMTP id 5b1f17b1804b1-483739ffa1emr139206625e9.5.1771163936672;
        Sun, 15 Feb 2026 05:58:56 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48370a41be2sm104270675e9.1.2026.02.15.05.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 05:58:56 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v4 2/7] fbdev: au1100fb: Mark several local functions as static
Date: Sun, 15 Feb 2026 14:58:29 +0100
Message-ID:  <927329dfdcf1afab17f70280c965302ff2d78782.1771163316.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771163316.git.u.kleine-koenig@baylibre.com>
References: <cover.1771163316.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2951; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=/32w9PvZgcOs3+X7N8oELcxM04YQkhM/L2MiPZZxpNU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpkdEJ/rWuZgCU2dfdQu/j8D+QG0hlVfj4t/J72 0mKTbLqgliJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaZHRCQAKCRCPgPtYfRL+ TvQkB/9a0iRSh+6t2Lj1M6gqJHTHmACyzy0cpN+aH/okkpVO5f6epCEQdclcEBqoKePVL4KRHPP PYzCpnXmqLVFxu7yVtx9U/a3fxP98iYmRHVS6F1yg5ZR7uG5/oqDzadlxjKDbLvL6UGvIu6Jhc2 a75hbHTsqpIJiQhUZSNgvLufe90TAgekoGsAGTErV7XmMAsF8Pgbr5epOl4Z/jp/iySc4Agxih3 DIpfPuhZoyiaePiqg4qvH+mCCx/nAX35YRNSX1oKWdkAQln8nGnAuBX2A0rws5lgjm+HG8EloBY 2ynmrAWR/ykYuFeFtIKSKuSBPR34OtMcC2T1jXQM+xlNgxkf
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This fixes several (fatal) compiler warnings à la

	drivers/video/fbdev/au1100fb.c:530:6: error: no previous prototype for ‘au1100fb_drv_remove’ [-Werror=missing-prototypes]
	  523 | void au1100fb_drv_remove(struct platform_device *dev)
	      |      ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/au1100fb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 7bc224a8455c..b1da51683de7 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -120,7 +120,7 @@ static int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
  * Set hardware with var settings. This will enable the controller with a specific
  * mode, normally validated with the fb_check_var method
 	 */
-int au1100fb_setmode(struct au1100fb_device *fbdev)
+static int au1100fb_setmode(struct au1100fb_device *fbdev)
 {
 	struct fb_info *info;
 	u32 words;
@@ -219,7 +219,7 @@ int au1100fb_setmode(struct au1100fb_device *fbdev)
 /* fb_setcolreg
  * Set color in LCD palette.
  */
-int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue, unsigned transp, struct fb_info *fbi)
+static int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue, unsigned transp, struct fb_info *fbi)
 {
 	struct au1100fb_device *fbdev;
 	u32 *palette;
@@ -278,7 +278,7 @@ int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned
 /* fb_pan_display
  * Pan display in x and/or y as specified
  */
-int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
+static int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
 {
 	struct au1100fb_device *fbdev;
 	int dy;
@@ -325,7 +325,7 @@ int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
  * Map video memory in user space. We don't use the generic fb_mmap method mainly
  * to allow the use of the TLB streaming flag (CCA=6)
  */
-int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
+static int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 {
 	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
 
@@ -517,7 +517,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	return -ENODEV;
 }
 
-void au1100fb_drv_remove(struct platform_device *dev)
+static void au1100fb_drv_remove(struct platform_device *dev)
 {
 	struct au1100fb_device *fbdev = NULL;
 
@@ -557,7 +557,7 @@ static int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 	return 0;
 }
 
-int au1100fb_drv_resume(struct platform_device *dev)
+static int au1100fb_drv_resume(struct platform_device *dev)
 {
 	struct au1100fb_device *fbdev = platform_get_drvdata(dev);
 	int ret;
-- 
2.47.3


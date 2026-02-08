Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AD32D6E4B
	for <linux-fbdev@vger.kernel.org>; Sun,  8 Feb 2026 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770573509; cv=none; b=D2RaIcMtm3+hTSiCVuo3G0mIC3kwZOlhl77qqxIzuDFry4GFuF3xbOEfQTo9SENIideOOoOmrSm5OFgfKhJBdacKQKzQCWcYqMs+zDMpCmtqq4Woyjy6vV5owg14BF0ofNb90quMBeKiqtDrluNxTvL+GotxxWXkOaMoPzbAmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770573509; c=relaxed/simple;
	bh=/32w9PvZgcOs3+X7N8oELcxM04YQkhM/L2MiPZZxpNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEtJt0YQNPTLQMhfL9Vs5kVdwNAj2DzQknCSFn3agr96KS1J8pVa+J5r28axJ9xvJfhYyBCFrasYQSOyinrAN+NukG2V72YMlBYq2+jFPsnFSWZEhSwHxfh4FpAGoerNJ+jgSHx3WC9LMgWdAdEnjpgTYPUQnSqG2v+XyBUItgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fWOKfe2p; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fWOKfe2p"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4359a316d89so2895592f8f.0
        for <linux-fbdev@vger.kernel.org>; Sun, 08 Feb 2026 09:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770573507; x=1771178307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87Z0X132XhQ0qIp2UdTelILbwyGX1bUUxXRUUNesvoY=;
        b=fWOKfe2pyxvsuI0hVH66Napvu3qqnBgR3/h4/BeqnQMSP4pbT785NbLA8tXstfllf3
         +aAeBpJsU22uQi6oYa4+4aTcd4lnR97lBLtr8+FCQn+PxASO9c6OYaVHQP/o0oMgRaUz
         xgmgnxFdQnGEziVH3SgCHaUzUdID9HDUw57Kii6hyfQJnyElkO6CpC1F53ZuVtTpQ5JU
         WiGSnCcWcKcuudO467IZFH8cmlBAH057N8DUYSNgbLxj7T1AHrJYcP2XG+va8wVgIoAT
         2QqIk/6fL7HFOKsrDDktENetlX4ZgEzqqBu2Yx5fAEtfn2TbHXlPYDxa65GUyCwyJk3l
         jHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770573507; x=1771178307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=87Z0X132XhQ0qIp2UdTelILbwyGX1bUUxXRUUNesvoY=;
        b=W8Qt+5l+r1p6nP/UUluZARlGAC6Y9b+tdxuZGakWV8ZY8mr8yUomLYb+8lPm6uf5HH
         Et+sCHWfZvmPt8k+JcLWWkbrjbmiCIO6MoRBEEumRs6Ay77gyyMZGDsHO1MHkf0bKzCh
         S/lETZ9fJLRAQP6pBiUpqqGfI6e3fynjoUKH7peiI9TW1mtpenVSB2N0g+YJRcUAMwoA
         l3oqMPruQOgyd2s2LGFuN1viakYs7nKYwPk4DTwNHF9eDYuKpcbvrgsP4xMdECKoQb4n
         9PH9Bws19RvAvoW6sCkU6Rdcj7fGFHM/S8YZ+jkCqMX5fVqxi5LxeVJvzMT2Mg22VzcT
         P4kw==
X-Forwarded-Encrypted: i=1; AJvYcCVsKQ8PB+2CkzgYv00Z1I91Bd5JrxVU4b6KyN9kmhpB82t9/nNl1Svtf+NiY9RhHN0SlNNmE6u1ASw7xA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym0bk0Hvkj5494mHsOgrgWs05qvQwEyFe0G2hc76ZgYDVMUSzw
	+bvieCefIFpqLB4rhV8OJi1LNW7GoTZ/B7XcJsElAuNZrkS2/LeCkX/xReGNddYkH8Ca+9gFXj2
	KjEICBqs=
X-Gm-Gg: AZuq6aIxM7pLQ7dVzvfM8da2RGaYZA403r/TH5kcUb8NX1Lu14e5TLvqy80zm59Hm0M
	lRWkK75F3+IiijeCgjuqFcw2VCgP84DdUvKHmM/DbOy4Ld++d+DBh2xmq3CU74jAP+9rrjykIl7
	yoSnjvVniMswARWMPUatxZZAZZ/Y2d2Dh7A4DTLMIgODmRgoP+6GMwFFUhyRiDGQpF+LOXpaiG8
	ACTTmDdgao4Td51KvKWpWW1bPa16Ms8U0lw+Pv25gdlqIq4WDugSo6oRxo5uDTdulhTg9si5vRU
	BAPjLA9Kgwq8LWwVR9ibE9JgRqoeMHBVsuZcgzmykkETCt9bZ097dINR1Q8ERzzkKV5/OlA5oOu
	x6gi7UPW+aHRb05kzot1Ew0W+fbWlK1pPZWjpcI1w73/cetxJyvkaUeB1aEMZ8N24YhG3b5AaC6
	hNWCXMioH+D4ov72u2
X-Received: by 2002:a5d:5f82:0:b0:433:1d30:44c with SMTP id ffacd0b85a97d-4362937b4camr13453988f8f.43.1770573507447;
        Sun, 08 Feb 2026 09:58:27 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-436296bd211sm22057822f8f.13.2026.02.08.09.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:58:27 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 2/6] fbdev: au1100fb: Mark several local functions as static
Date: Sun,  8 Feb 2026 18:57:59 +0100
Message-ID:  <99f569d892e2015f9291aeba1273b4d9816556e1.1770572936.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770572936.git.u.kleine-koenig@baylibre.com>
References: <cover.1770572936.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2951; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=/32w9PvZgcOs3+X7N8oELcxM04YQkhM/L2MiPZZxpNU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpiM6sGjTOKHA4/1efCqoAKcD3y3JAEZWENrZXN 494eYmTojeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaYjOrAAKCRCPgPtYfRL+ ThTLCACzxwlMEsfgyLfbaThm4of2FvLnbbCHIEgY3HLJigtEmBp7szWMtVvTcEiNfv5faK3XYyJ qvpLzuWpZFnV5QhmO3MC+jAaO/Dpkg1UI+V7cgfLV7EvjkK1Hi6viXQ0SJSSLF/234JayE6Qa5B sWgZvok8CLDvoGr2ksoBJe/ogljSkvclr2178vKJKZ90djKcaHC+OXj7V+Yl2yGQB1Qk+TA3OrP d9OUqQ5ylfL85WGxaqO/UT43cRjRUbNMYbUlox6vE/mZRPhjKzG2dNrlvaXve8R2MwTXFdGgINz 0B5nGh+w93+R7FpnINAolzCWnnMowt8pFQ3kh/B7ZVCaMwM6
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


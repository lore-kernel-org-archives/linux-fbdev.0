Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ECE3ED115
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206765; cv=none; b=KT4pQKbwfPthpwxVZse3NgmUbflDxl6zymHdkENDMqaIm4nBCX26oD7w5qEpaGXOZbVNgITmxUDWV9iPUgIk/J3VW/MbDJoIpO58m3fJlH/HZkzGFVZ4mBWq0r3jnHG/3FOkBvR482ITIIgPsRXggyoCrDkZXGi2slkLtkNbTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206765; c=relaxed/simple;
	bh=oSOQ1qqB2JidY7/rJ3ObHNdfZRoRO3hxs/JuZ4tPmfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+s+TQRy2ov4dVcJEl3xQVQYKYPadrLhJ9YdMx/jccYu4AGq9ZsJ7RTMdrfyNLIH0OxYqI5usx7qSaorVgyzxnHU+b58jf1cNBT9Ow9RDV63np1Tx9RaTnJh410IHTkXnds5CyN3SHc6MrNFN9DWtUiltchGw4GDJRn/TSI1+sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKJPUFnw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKJPUFnw"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8eafb515aeso41036166b.1
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 04:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770206764; x=1770811564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxN2zf2qIjBp1ThVJ6buFrEw2Y/sACcP5vWdi5FjtTs=;
        b=cKJPUFnwAlbLzXj1fsg3ebjM9A75jvmbAhUHev5nwX2Gb2kxDNxn83LT/gatPT+OJD
         kMxQfsKNsJlXmCu6eFmVb4FLe994MQLdVCGFJ1GDQ0gOux9aJIhWHCaQLf0/yEqeV4tb
         21mSNb7q9HdEIfdJYeOCM9uZcad0s84GViWRDndPe1JNyjPEsVwDCAY6VvgFr5/ffNsB
         lCYsTcXSKP1YUD8g0Gcz6SgCi7LjLUT7MtH5Yow6BZM4i1rfwT6i18IVz/JH7oVUrvli
         KHxsVSWHxXJCEakhWXgyqjTLR2w1BzngpR3+xYXY4qz0R8umsu6L+3uTT5HhjD+hLIpb
         XGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770206764; x=1770811564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KxN2zf2qIjBp1ThVJ6buFrEw2Y/sACcP5vWdi5FjtTs=;
        b=xQ7DlW3JeQ4HYXm/nVwM03sdALWd3mGIzuo73UlnkRLAqqs2rA0PtOpUjY7rUkmBTk
         aUFs73LBIaRJt2APfbe12bdA3+9mzW+pUIrMC2js8meCBUk/zZ/3b62mWSZbbaVpI4lb
         CX/RK86gWN2NbRKnN5Jl3TrLgnOO4+2nVXP9Jn3Lg9KVy2FJ5st+PvNO/YbtcIBqIlKU
         ujg9CECE0mDsBeFuy0fBSOP8BLBl/9vo8Sx5bwCK1osZqBgltQEcTYuVA3rtbCN1uE7f
         o0XdUxnRY3g7QliMgzzGobTuDRo9bevDRu0Ck6oEBbchfGbPFsTcOl8bJQ6g45a6k4cw
         WABw==
X-Gm-Message-State: AOJu0YyNNkseAYJdwaSc95tqtQHUT3XvFY4p/BovS4tsC4hdF8K+xz9F
	8XZ0bmI05icIGqDC9AA4uuwqVWNhhP8YICDPwHLllUGQbN2f38HGxlem
X-Gm-Gg: AZuq6aIrZ3GF/L59g4pErwzc36LrZbKs75+Q/80brM2c0Ly56tSV6D115eUbGMLiBIO
	4EMY6FglWo5UJbqPypGQOTScn1QYDzNX4gQddZbR6t/aTH9hmp4usi3RYg9KbmPAYEd+bYGoZK4
	12RMc09p6RQZgdMHSZChFonz+9QYU6DtS3L/9lPS/J91j0+/sRchF8Ol5iWcHAfHV6As573EbOV
	aDCLZuRndN+2xxNAYfu7HfyNlcrtX57s0VNrTJZ5NoLmR7ReNuOr8BfUt/RQaWfTM5+VwxF/EYC
	zXHOKblrjiMbpDCA/X4//OUntyHbXzvk4SJuliyAZbTAH3tGKx/KTWPzTWXgQX5ukKh40Z4Z6Vy
	y5/4GepMVm22UfPa+wW3vV8Vm8XiSoV8RmKm6h9tezbv4mmkqMo0lWa1r56cmL5fyOX0XxwrP6c
	A2d/AYovg6UXVegIFeHqRGMTxR2PdeomjGApAk96KERgsBa5Fa54CzpMYssEJsu+F4BUtTe3Dhc
	QIvo3Qk94XR+YFd4HwZL+9tD0S05brsIoJMYdlQXluQzywRQmcD+3VX6tM=
X-Received: by 2002:a17:907:3ea8:b0:b83:1327:920d with SMTP id a640c23a62f3a-b8e9ec9179dmr202964266b.0.1770206763624;
        Wed, 04 Feb 2026 04:06:03 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.od237066db22328bb-tp.internal (216.79.91.34.bc.googleusercontent.com. [34.91.79.216])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fcd8be3sm117979666b.10.2026.02.04.04.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:06:03 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH v3 2/5] staging: sm750fb: use strcmp() for exact option matching
Date: Wed,  4 Feb 2026 12:05:59 +0000
Message-ID: <20260204120602.6715-2-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204120602.6715-1-iprintercanon@gmail.com>
References: <20260204120602.6715-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strncmp(opt, "...", strlen("...")) with strcmp() in option
parsing functions. Options from strsep() are complete null-terminated
tokens, so prefix matching via strncmp() could cause false positives
for options like "noaccelXYZ" matching "noaccel".

Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 4c6e84c03..bd2d4a290 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -937,21 +937,21 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
 		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
 
-		if (!strncmp(opt, "swap", strlen("swap"))) {
+		if (!strcmp(opt, "swap")) {
 			swap = 1;
-		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
+		} else if (!strcmp(opt, "nocrt")) {
 			sm750_dev->nocrt = 1;
-		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
+		} else if (!strcmp(opt, "36bit")) {
 			sm750_dev->pnltype = sm750_doubleTFT;
-		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
+		} else if (!strcmp(opt, "18bit")) {
 			sm750_dev->pnltype = sm750_dualTFT;
-		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
+		} else if (!strcmp(opt, "24bit")) {
 			sm750_dev->pnltype = sm750_24TFT;
-		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
+		} else if (!strcmp(opt, "nohwc0")) {
 			g_hwcursor &= ~0x1;
-		} else if (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
+		} else if (!strcmp(opt, "nohwc1")) {
 			g_hwcursor &= ~0x2;
-		} else if (!strncmp(opt, "nohwc", strlen("nohwc"))) {
+		} else if (!strcmp(opt, "nohwc")) {
 			g_hwcursor = 0;
 		} else {
 			if (!g_fbmode[0]) {
@@ -1156,11 +1156,11 @@ static int __init lynxfb_setup(char *options)
 	 */
 	while ((opt = strsep(&options, ":")) != NULL) {
 		/* options that mean for any lynx chips are configured here */
-		if (!strncmp(opt, "noaccel", strlen("noaccel"))) {
+		if (!strcmp(opt, "noaccel")) {
 			g_noaccel = 1;
-		} else if (!strncmp(opt, "nomtrr", strlen("nomtrr"))) {
+		} else if (!strcmp(opt, "nomtrr")) {
 			g_nomtrr = 1;
-		} else if (!strncmp(opt, "dual", strlen("dual"))) {
+		} else if (!strcmp(opt, "dual")) {
 			g_dualview = 1;
 		} else {
 			memcpy(tmp, opt, strlen(opt));
-- 
2.43.0


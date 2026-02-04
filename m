Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B43D413B
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200140; cv=none; b=rEsHO/GYEInPc+uOo3VI9dFYQmCcH9t7r02J80FZULk+jT1JO5xrAIMF/ggbUWvrZAZfAVodDXQFegP7D62++SoStLh20QxfHvf+V5RKlbZtbgwfX9JJ9Rj+BYpbAa+LA7Syt/d5OTgwgGGnYf3wQkGfQfMzUnn7HdjjHYQza7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200140; c=relaxed/simple;
	bh=NJMipCWPPkbj4WJnOqnxKMKjoUwaGTR3HXIqrY4PdKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8Kex4eWnFZzavSFCaJxtaboAflVER0JgfxruwSYNQsnUSXlHlXSrsVh5+l/jQ6zlZ+2CZT7X7Exxo/Hd/G6WQii7vrtGlZit2Qpklsiwl9IufpMAGkvPXKXCk50DS+RRQ12FNRChoVrROEjp3Nasjf2I+JVJekPkNm4CnQjbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VETZpJqq; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VETZpJqq"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-658034ce0e3so10435233a12.3
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 02:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770200139; x=1770804939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqepZHcW5XTj/gQ8gyyG9cWC23UM/f9Mcrtff0UNsoU=;
        b=VETZpJqqcaLMdXktzYrwfokyg26qchnppmTz851cc7PWY4+pr3kcw+5XbClrRSjKo8
         Q1/s+0DrIQpg8E9eB2J3KHrj4gdyMqUDeojw1cLlKeTxeBKIbxD05bdwlkEPVutQgwAO
         qczR1WL2bQZDp5ZTo1BAu67Mp/SFiucxVHaqRfG6rLI//07qP0ZGdjork4agtp1X/9c8
         IPM79jLJk5pL03sTPzXvneXuOy5106Nk5zJfO+c1TNqq8HI8bbPbtdeuOUzlLJHv7XIB
         8Qrz481lB0sY2431uGtO+DQgojKh3U08xj6X3lhdP4QK1DcWhNFUDerhV5Bu5xohnvQC
         eQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770200139; x=1770804939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kqepZHcW5XTj/gQ8gyyG9cWC23UM/f9Mcrtff0UNsoU=;
        b=SiOQLqA4cxWefebPX83MnULxhBrxe+aFK1eQM0jP9jLXle1s+3nVTd6BN2oSODSgkq
         Ulj4P4kNMFZFjJOzlfN2VAylwU9NeY3E4F2hcokM8rwkj6o7/qFrxm+b0XnO+CoHnwZq
         o0tfBGaYeeZlu/yQy6zG3PIoV7y0qmtfIfKpEisa6FRPwyfbPqxFX0iZmzhQ738OjV75
         nxGloMYmixkdXMO6dinF25uOS9g4yxugOSSwdQ8Uwg/7DuQgEJMRAk7XHCN/vtpHfHYt
         rrhp1i/cQQH/CzmLiboBsxTJylhwdJR7n4pes4wiMdqVQdNy6J7b2kIanT9S8gTCURgC
         76jw==
X-Gm-Message-State: AOJu0Yy+0EM7tHMItB6v5yDGB7qNHloDd3Q6/V3PouVAocvKa+f1csDO
	o9dj06JDXX3H2Y7cUtfoJP2ZnL9N+6BaYAzbmKXFb1iRbshZbFAbt5xn
X-Gm-Gg: AZuq6aITOG8bA0fqXDWoAud5okQmZUr2+X52sS5qqLCnMgFt/FsYCqJjHHXRnJh5E+v
	GbpHO9knJ3+hdNAC7m4vX5gp4SXpRoWoKR/EEFD2P7YksIl1cILhfGoh9TS3RG1GN0xRVd6IaSq
	AjqgVw5ZCdirANJ1gff9u9gRnTJkqWMwvf+Q+idl2PpD4cMRUI/hoM6zL7msMroLJQFv1bjBAdX
	OCpcOzbcBnMUSDzW+/TCzyvQpIvJyZAaFRLU3VmN01Yv4+ezwwRkl00jsTEnZW490Xdx6FoYa1m
	RIkG7wMygrCXxtrnaAjr5W0XsSrxsT/gupI3oJTTr8m3/o8hwOBWKEOB5MHFizwFaK82aK4eL5S
	x9UzmuO9ugTXmTGgTbqBZpXKN/sMsh9pjbXNibXAZ6gqfHM2N6OAX66rQMLLG+Nn5GCO9HhpbiG
	MWk5P2p7Z2nrq721a5M3Vr4Z/6FirIzgTILOpImhs+rlWeT9z6rJY6PRn9xWk6ty9/mrlN8EoHN
	qu7W9xtQeptFTmEKr6ySBDMnvSNi2ZKmz+T1HDP+Ty+7tJaf6c4PzHZfHWzJw==
X-Received: by 2002:a17:906:f582:b0:b8a:f91e:283b with SMTP id a640c23a62f3a-b8e9f32c168mr163757766b.60.1770200138359;
        Wed, 04 Feb 2026 02:15:38 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-b.c.od237066db22328bb-tp.internal (181.183.90.34.bc.googleusercontent.com. [34.90.183.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fef0e17sm106440366b.33.2026.02.04.02.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 02:15:37 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH v2 2/4] staging: sm750fb: use strcmp() for exact option matching
Date: Wed,  4 Feb 2026 10:15:34 +0000
Message-ID: <20260204101536.3311-2-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204101536.3311-1-iprintercanon@gmail.com>
References: <20260204101536.3311-1-iprintercanon@gmail.com>
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

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 0eacb522d..73d78f893 100644
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
 			size_t opt_len = strlen(opt);
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795268375;
	b=XvKqSDjeT7V15wFpVwywjXk8goNxJ1/6ubGvNkZH9jHX9oAjw5S930lucxWOY78iPs0n
	 4WZTy/3IuQ+5iPGZWTVMPPVQMJAeZcyeYq9WzwCZrDoZ/vxPCQTmJoj6dSl4amubuc1Ra
	 Hcj1pAmse/LdT58+Jan4GaNhyn502AwiVXGuhrOAk8Azn/4MNbpnC3d4qTqy8u2UGtjp1
	 fwaXXly2+znBBgxlwem4Z53byGaE2GJehakXQRgSmLLVnAB+9ox+9dPrvrjds8mqEmFyi
	 GnxmfAiG+4ds+NcG+ueN46kcnE3GrspFRaOHmraD02m66/Gx5LxlYets5eFn5fW7zAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795268375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jpAB7bN4jOX4zDM3zWu+BqiTANE8OqvGyHkfG0EgWp8=;
	b=FP7e/XQMUw3OXrXSmA7Hb8GIoTgPB+5UiqUr4QDukUQGNC+Ec5upj2ComKImsY9yi96D
	 AQz2ReOnqLb2s4JlcGZVHmnVlZGs8X+odQy9VIuyzonmDxxhK/zXaFAVpY6K58xnw2AC4
	 LdQl62aX0HqDIYJGtxceFE0uq//bGk7N1NdwtBY3O9yY59iy+TSxSz7mRME5KyCzPzmw8
	 t0e1d6wdmtguLB8/O9C7X4y86Xf8ECRU50a+idHukVEq83g1fPURuHFLG8JmZ2CigFPw/
	 VgpeHEb33y5PR5PkH2pKryqX67qxRdt2jyGze59C9DB+aFVfCblX5t2QRNLL+uSqBIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x0GmXMpc;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE37606A32C
	for <linux-fbdev@vger.kernel.org>; Sat, 21 Nov 2026 13:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EE37606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x0GmXMpc
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f01f296937so14856215ad.3
        for <linux-fbdev@vger.kernel.org>; Sat, 21 Nov 2026 05:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795268374; x=1795873174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jpAB7bN4jOX4zDM3zWu+BqiTANE8OqvGyHkfG0EgWp8=;
        b=x0GmXMpcJGEGUgPPs38gakwdA6J6Z0yLES82zLYAFZLqsbI/lndHmKNXRzl/mvoskn
         XKlNKB+5kMzOTrRf6SM1je6hFibJUyQ4CBKY1OrWOpFHh0uVsiehpwzlbwC6ZpR0FapB
         a9Wiyz0iwaw0PQa67CPgPMv1wpd2wbSKX8D0Sf9QXzwur2fJj8AdAj/n5oH3jvUjCAB+
         lUL7doeJadhWhrDsV7LUeXgr9H6M0Il8DnFZ9xynGi6WUcendggG/Z6WP8pU8YlDYQgt
         /KAoFs8ASbifr0GK4SteOXLxN1kX2EGyrEe+zfHYAgcIv6TtUi7tNEmW37akNyRLEPEB
         wI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795268374; x=1795873174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jpAB7bN4jOX4zDM3zWu+BqiTANE8OqvGyHkfG0EgWp8=;
        b=PrucQVgKp7oqE9bdxegUho5QN2Gy287Nqe3Pc4YNw2JT6u9spC/ZAJmOVvcnuWjTOJ
         uwyFHgjGnHbD4qaVUesRW2zJg0ncRxy2KrSWK9upXG/D8y7FCc9nKhXZXUW2cJkgMgwh
         4uptnMdBwuFWaeFp+tozJtK1+cKbF5QFiSkmJahdaOgROko8zoQtgSLifoULvOnjHoJ3
         Mo0OQ3eea9ArD/R6KXQva7plVJsL0KlbjeD7+jhV3yn56OBaN9MHKqGsnzZFvYJNLedj
         zw8R5/iTjwWePpZRHFLv/g5xt37JyjhVBc/US8ipuUtPUsJjnqbTBjECfTXQYwpernkL
         qivg==
X-Gm-Message-State: APuU4Z8PJCJFvTKMwfipvGXYI9mSoZRQIUYdu13hK9DobeHS1Ap7zN8U
	pNNEPCIxhektpFYxznmhk5Jzu9U9hUMUE6XIn5xQVXMc/OnllXfbWJui
X-Gm-Gg: AZFdTZe/xdi6xCDzb64ofadnEqCiD2L65RQVJPEuSwhkZpcfbiuhialYgi2WjQwupQ7
	nqlIqmEG/BUZjjP5tDqD57ATIJLxOOhnf814xcxzp3iciTnKZ8l3qkVK2PBwTJdzcIbwIktONwE
	MFCgpQsJH11AJkFMIRIS1Cf8G7TWkOm9E5twfiJ4C6aaOnzwwltLf78Wug75Sj4dHOdUZQUdjjN
	NsOwYyyofjaps5C+3eUJ3LQ3uD1InGfPwOfM7lru7bMpc7aNDPXa/3AyqDLbyQ0vJC+fkBijiUe
	GoW1KQnr/fWLOeD0QzIl3dJ+Te6yxwlMnOEqAQMoND0toldR74bfjqOOq+q7kb9qt02dTVrulRK
	7ghTt2LwM2LSpM39Otun85WEJl3z55Qmp8JHh59m9/7m/SwR+vRgTPD7fuwtzthRMIM9dE6AsRm
	1vfeDjx3uTv0wNPReOcLoeSg4dLUGwOs7Wp28/ZwGDEuGrOuwP7adNEjsl/Umzv7NRd6E5hlHs6
	Jn8fcwFA0Wkl2jpDWfzmr+UKccA8mQB3zkwjR0dShNgDzu5pZBVVJPuT74PGhCwsfTQxYjevsB3
	DGxVvL8V3Uj34lOACP8EeJ5BNd75rg091BsGOA0=
X-Received: by 2002:a17:903:98b:b0:2df:aed3:2ac0 with SMTP id d9443c01a7336-2f03f1cf5ccmr67862115ad.10.1795268373920;
        Sat, 21 Nov 2026 05:39:33 -0800 (PST)
Received: from omarchy ([14.139.177.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0de00asm26621375ad.35.2026.11.21.05.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 05:39:33 -0800 (PST)
From: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vaibhav Chahar <vaibhav.chahar26@gmail.com>
Subject: [PATCH] staging: sm750fb: Use str_has_prefix instead of strncmp()
Date: Sat, 21 Nov 2026 19:08:43 +0530
Message-ID: <20261121133843.127718-1-vaibhav.chahar26@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using str_has_prefix() is cleaner and more readable than using
strncmp() with strlen(). Also avoiding the possibility of errors due to
mismatched string lengths.

Signed-off-by: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 99d410e18..658e93b27 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -854,21 +854,21 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
 		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
 
-		if (!strncmp(opt, "swap", strlen("swap"))) {
+		if (str_has_prefix(opt, "swap")) {
 			swap = 1;
-		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
+		} else if (str_has_prefix(opt, "nocrt")) {
 			sm750_dev->nocrt = 1;
-		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
+		} else if (str_has_prefix(opt, "36bit")) {
 			sm750_dev->pnltype = SM750_DOUBLE_TFT;
-		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
+		} else if (str_has_prefix(opt, "18bit")) {
 			sm750_dev->pnltype = SM750_DUAL_TFT;
-		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
+		} else if (str_has_prefix(opt, "24bit")) {
 			sm750_dev->pnltype = SM750_24TFT;
-		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
+		} else if (str_has_prefix(opt, "nohwc0")) {
 			g_hwcursor &= ~0x1;
-		} else if (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
+		} else if (str_has_prefix(opt, "nohwc1")) {
 			g_hwcursor &= ~0x2;
-		} else if (!strncmp(opt, "nohwc", strlen("nohwc"))) {
+		} else if (str_has_prefix(opt, "nohwc")) {
 			g_hwcursor = 0;
 		} else {
 			if (!g_fbmode[0]) {
@@ -1073,11 +1073,11 @@ static int __init lynxfb_setup(char *options)
 	 */
 	while ((opt = strsep(&options, ":")) != NULL) {
 		/* options that mean for any lynx chips are configured here */
-		if (!strncmp(opt, "noaccel", strlen("noaccel"))) {
+		if (str_has_prefix(opt, "noaccel")) {
 			g_noaccel = 1;
-		} else if (!strncmp(opt, "nomtrr", strlen("nomtrr"))) {
+		} else if (str_has_prefix(opt, "nomtrr")) {
 			g_nomtrr = 1;
-		} else if (!strncmp(opt, "dual", strlen("dual"))) {
+		} else if (str_has_prefix(opt, "dual")) {
 			g_dualview = 1;
 		} else {
 			strcat(tmp, opt);
-- 
2.56.0


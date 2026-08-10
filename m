Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24093D955C
	for <linux-fbdev@vger.kernel.org>; Mon, 10 Aug 2026 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364361; cv=none; b=JrLoibwThL4JL1IC525nrp0mopfnOvGuBk0yBC6yUWO9yPjMdqQBe+qoeM6LsvKwq7IfpJFTMEDisqovbEBGf6pHX8FXHgvEG4rrRcqQmVfoqqMHtGWe2gdMKTKUXyHJH8EAmGwLJCWEXZ4J/zeI0XCv1IlnFWqQnvybIeNnrxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364361; c=relaxed/simple;
	bh=2PsvimWgoyGw4StDRSRVThkKzmIspBGR2qLe4BWt8vA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tLSFNZ/WYaylRJAia78lRQz4hZb+ENNkjdSiddEiMrr25PETNgNg+eGXBRM8Y4Q8T9DKPXwdPq60RfzGn19nnnmBu8Uzo/PvaLel4hT3OQj4AyPYcvECAos23clnLH8vIFsQPgA8OalGmLStJJmWQ0HY6fmpeIaayF1T9tiBibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqG+xHDl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqG+xHDl"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-848743155bcso494400b3a.0
        for <linux-fbdev@vger.kernel.org>; Mon, 10 Aug 2026 05:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786364359; x=1786969159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N5+dxmrF42+92BXej+kvrBe+Oy4NpEKJDlFbxvsp1bc=;
        b=RqG+xHDlTsGOVPYay/BjshjYjgay5upqV1rugUVVx6U793LCpGOAoGwqJ+In3EzfNZ
         zZOketq7n7YNrm0Zu4bxHo/WSs0a39JC7d3HPFPNqSPvnOqnor94Xw84PNOKjk5fsO3W
         cQYDCfa5kuEiGuHnkGuTg5ba/7dzypPkiiUDBAbF13+3GZBHOf/RNOm37PiVu8CDpJgj
         Ofz04o5751Eppy/jcRgy8ZHnNQ4bzxVvW4f6zHo88yFAx9/jzy1MXdTTmQEc90RzZ+hR
         GoGzDBJpE9ny+sfUzg1oV/dYkp00C4gf+FpkyuhSG7/Kqtwfp501aPb2QuPytTNgwviO
         S48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786364359; x=1786969159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N5+dxmrF42+92BXej+kvrBe+Oy4NpEKJDlFbxvsp1bc=;
        b=PXuDCMOealycaZB7IYsFOCBw2JjWGw1c5fcx/dyvTwgnQxPu7LOJT4GmMNDA6H2BYT
         mSJ5oih8n2EIUOF1wImveqRREGT4dodamzhZvO45kveMNEm6f35sTEWclYQR2GjAc3VU
         8niUZG73jLtS8IjmdaLA1A0H8M+oPAPFDJ1+WFzfktWpwX1HLuH4nsjDakzr0JcHe4TE
         o3V8raDC/vLXBpMYRd82mS7oaQVxxbt17S9wQvNxYajaH7h77RxtJfYl0+xk/JtEIUgT
         R66thR7EKu9nEkaczycbSUfAbIXOOA3PezduJ8uBAAdd9A3S8s9sA5rClccAvyECQ5Z3
         hJqg==
X-Gm-Message-State: AOJu0YzY6lTKutlg8CqSlCSDa2IY7FouC2zC6JXCZNvBhMOET7nWSjUD
	1Et9R5asopaOzatPt3d6oCzqxN60YW6fRF+pCsZOpPaUVEPjDoo0R1I/t64/Uw==
X-Gm-Gg: AR+sD13N9cl5JAoxGhviAxjOXP8KNBzHbLIh1E6Wh7PNXAhdAMc6Jc7hTlkx/womkf/
	WoVDNKoAHIWVaIalbOgwnk7KcD3G0r06a0jVIXG5Xt+OjSzb47ue9U8sTcPHF9XViEkKKFFur+D
	60mlgsRdlP2FpEKHRX1ET+IwPcSPIPAwZBukdROpIe3osO7T/ufwbmDiejn1eB9C6yEZdu9IhzK
	9Ea71EGvJngUilSLAqBJnvA5bNWeQML16kbtkyCkFk4j0BPXavMHHoEcJtOcUZ76Cpq8PnnBnav
	1A2nkErBtkCQRGPiS112Reuwgv/7XLGrH5y+k+isyNye1VM5hlFUswMgR6UrmXuBWPFE+qnWXCD
	TvIRdXXsHmrjENuxTP5S8NGSdlonDZLHhyDdtuuXOk7mkDEzFtb2XFgywgxdIxJzkuwrdfKeyR3
	sdfPmgSocsA9NSgWUjQxsY02SW+hMPmvBcQzqBXHCUgw38MP+b3RYLauosxy5P/guXWcgu4knhq
	pA=
X-Received: by 2002:a05:6a00:3cc5:b0:847:8dec:1427 with SMTP id d2e1a72fcca58-84f4fd9f647mr31055016b3a.8.1786364359090;
        Mon, 10 Aug 2026 05:19:19 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84f5a3a18a5sm3800788b3a.8.2026.08.10.05.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 05:19:18 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: FlorianSchandinat@gmx.de,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH] video: fbdev: via: refactor deprecated strcpy
Date: Mon, 10 Aug 2026 12:19:08 +0000
Message-ID: <20260810121908.31307-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated and unbounded strcpy() function with the safer
strscpy() alternative when setting up the framebuffer fixed screen
information [1][2].

The destination buffer `fix->id` is a fixed-size character array of
16 bytes. The source `viafb_name` is currently a static global string
literal ("Via"), which safely fits the destination and poses no active
overflow risk.

However, replacing strcpy() with strscpy() aligns this driver with
the ongoing kernel-wide security initiative to eliminate unbounded
string copies, hardening the code against future modifications.

This is a proactive API cleanup and there is no functional
performance or truncation risk since `viafb_name` safely fits inside
the 16-byte struct constraints.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Link: https://github.com/KSPP/linux/issues/88 [2]

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
 drivers/video/fbdev/via/viafbdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 80f95dac32c8..925b56830fdd 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -144,7 +144,7 @@ static void viafb_setup_fixinfo(struct fb_fix_screeninfo *fix,
 	struct viafb_par *viaparinfo)
 {
 	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	strcpy(fix->id, viafb_name);
+	strscpy(fix->id, viafb_name, sizeof(fix->id));
 
 	fix->smem_start = viaparinfo->fbmem;
 	fix->smem_len = viaparinfo->fbmem_free;
-- 
2.43.0


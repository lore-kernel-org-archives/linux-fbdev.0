Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6924503F
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Mar 2026 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772889536; cv=none; b=KzhEjSkM5QGeCQALA+al2EhVb7yX1LmMwSFfacXx77pdEu+8KKqxUo3GZo4nDTO+Mx44CBVCKwUJYw576cuiOpoOXy3Eur0+0b4eUzHrLTCSJIhor7zgDc3/YFRQJaRMIPHarIva5tlbHNF9UwbnH9d+qY07ZKSOFOpJqSzd3Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772889536; c=relaxed/simple;
	bh=hkXX8UMVs5gOmJO/acVCBm5Mzl0wMV+WSRuqxZtzrMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/qKJgtGlMwg0gUxdi7jx/TphM25zGHTcekGZsO+/7a5dtSAsh5GIthJXCuSYvaq30BlhTw97qi3OYbF9RzB7C6JhsAnw3VrZrNajRKCMUV60pwy/lG6t/+O8yWpemJ9B8TuqxMC3fpaR0n+tLOx5GMw9arltzMb72gUW/H2xF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGTkC14K; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGTkC14K"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a126c8aab9so4140409e87.0
        for <linux-fbdev@vger.kernel.org>; Sat, 07 Mar 2026 05:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772889533; x=1773494333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GENIDdbhLqqtmXufDBxHin8/Bg743Jxvmh5sOfdPZ6s=;
        b=hGTkC14K5esCPHKXd1jP98t0bZ6xlOP7TRLK8j9gDl5mWU+lowKojNiJPbCSJMGddR
         cewxg7aR5it8fgGOeDdbNKgpXSxfAmj0+3KNGEggajNeergi8venXnUwCNHn8mY2e8fn
         711ylX1QGr3cHxIWERnExemDMPoMZxeRqNiWs1Y33Ibz08AAnmKD8Bj5/XG8TqS01veC
         67CDAL1nWiF3teTm6eIRMZL4RV53hgKvzBDSNUqrjt1DI/AhYW3qmBFwI+qpKsLn+3uH
         +dDTK0pLqzjUHvEzm8R8iQMET8+hDvTCEx6174625p+a2UlVtiCISVysxZzkRtMYIx0l
         93qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772889533; x=1773494333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GENIDdbhLqqtmXufDBxHin8/Bg743Jxvmh5sOfdPZ6s=;
        b=ZQfiV2SWF6UxLq5qTNQJ7besGomKZtPGa3h573gxiiVMHdYSm8UZl++miHZBuLQ/6r
         BLW1S7n+RaUAuVsVL5w1T54w9r0ZBJhM0PTUMCu9ECGkYL9Ufa31EwGQ/rV83jfCct3m
         Ts1wfmCvduGyIKu9gIAw4aWvLF9N2lGNz2JtPaGBn94RGeHkT6V7XuI1iYLiu6bqIX+5
         5Ixk9MX8mkcssU/eAWD5EEEOyNzzM9lpcTlEFtPR3eim+XRq8gUJbXz5isvBJK3fmJ86
         vyw0aatH9hFsgRTm2Yo1Un0bxIH7SD46H9J6Oo/sdd3lVPy2zoUMu9dyPDgKMAEqb/tY
         e3hg==
X-Gm-Message-State: AOJu0YwJYWktB6JD6md1GpPO303Lp0a7nMXPR+kPOsplArOCPUTegXBO
	ghAUM8LslUIhJPcPBh3gihO00Apk5mgaW7s65lSvo9pZH1+QirUq+xzAaK9kLQ==
X-Gm-Gg: ATEYQzzpCy04OaaHcHDdi46hL+1DgT6gXDav11+CXs2h0kzlmAJ6qEZM+xz5VpllxCW
	PKjk/BAzD32wiU+rJozHay/B2zXIYqDAfM7V+gPqiTlD3CSyaM9mn/slzB+t7WWBn0oHG3KL84Q
	kTaWCkB7ZB+SORy/lyMwYSpBWarEUSRnM7IW4JfUF4lJa82XJ0M+mCmViLzb1p4oPyZErjxkieC
	AiYfrznetnT8lG2hFlDLWaZoFWQ31GLqhsTjEEPSEADh/6y41d96mwv2j5HyEeaMyyHfDEzH8lT
	4R0S4KsUv3l5/wJFm2GGsrZP1TsjKjyM8XFTm+mN9sAxXzVj+754kNnAUiReVIRLznPGemB+5NS
	lKU01XE6nTP1Bjot8+W3eAjsI4vt0HT4MvqBNKoKsJRd/xIkTsDbsMyhGVoNSEKHkg3ykOHusb5
	sJCm2Ybvpwh7kYKCGOV5eqf71B2PakIGmhctvYP4nqdfQ4rQ8KpLhKUoqk+vG0Ls9tkvXrGIMFj
	w==
X-Received: by 2002:a05:6512:130e:b0:5a1:3ebd:d53c with SMTP id 2adb3069b0e04-5a13ebdd9bamr1557339e87.13.1772889532769;
        Sat, 07 Mar 2026 05:18:52 -0800 (PST)
Received: from T6NXCV08J99224A.lan (81-237-238-191-no600.tbcn.telia.com. [81.237.238.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d02b860sm940707e87.29.2026.03.07.05.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 05:18:51 -0800 (PST)
From: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Subject: [PATCH] staging: sm750fb: add missing const qualifier to char pointer array
Date: Sat,  7 Mar 2026 14:18:33 +0100
Message-ID: <20260307131833.1138-1-rayfraytech@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing 'const' qualifier to g_fbmode pointer array declaration
to make both the pointers and the strings they point to immutable.

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index dec1f6b88a7d..08d4979c6755 100644
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
2.43.0


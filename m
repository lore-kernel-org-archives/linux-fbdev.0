Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60943C1986
	for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782371656; cv=none; b=elKoxIie5hL0t3JQVS1sh7uFdJu+cA1Qo3mWNRmGU4Hh2pbODCEFVfIg18AsCPhWURqyQZdU1ZLmU2ebiheKfenSR+7Rh3SOQoS+ryIN3baj0kB36B7zj9pzbwTPQiiTQDB8YZkfwl4j4cdmjKVxSQ9BcrvC25JvND0yUpk24NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782371656; c=relaxed/simple;
	bh=Ia4RiXS03fNUqUgeYq+bf5XDNWlaNgZTlVC3fmTNuog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=emqG7mZcCs0wOwHU3f1KGlkNpMMiaAbIcNgTODaWXY1UpoJNzJH8kO5Il+MOvwa8FvCUbQBworAZTjxZnAH5QGvnvaDG3V3vSXhOOOEd6MYJTqk3lCTzr8wF/TTlMi17t+suydSViUOObnQtI9v89w0ub+P8bAZCuSTSRwDv6Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+5gzrpI; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+5gzrpI"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30c52f96f60so3649101eec.1
        for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782371654; x=1782976454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tbErHUfzMZ5CyKFjAOUkSxCPxb9UPhRmSccdsVpeOug=;
        b=l+5gzrpID5lDLHKQkI6fY00EL0YZcouc/UzNVjMfzQF9tTD8me9UbszV25E3tnCfxZ
         rJE+a+X0FxdC04RZQGSWbRjlQGPZBR68qOnfe7018tycswA9qtI2wIpFP+ugMw+Iang5
         B2a4eULm3dSACjFtv11lZ9EGyFEp35HgMJ075c+duSEkwLPFnBeg/CXTJG8Rgg6I9ymG
         zcf8m4As/opwq6osnncwhHfKsPbNOVcbZXnG8feKd/YmPaglgROHDwiKmByrWsiTvDbv
         TQULeuI2d15/ydQUQ3AjVB56p3OPJdukWk8++6sz4wA6gnUJXlwJlZD+w6gmI1Aq/NuT
         zmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782371654; x=1782976454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbErHUfzMZ5CyKFjAOUkSxCPxb9UPhRmSccdsVpeOug=;
        b=hUTfCOKNnFNORO1op55BxecLpWFZOoEsJIro9UqsB91+f+EsnCzX+JY5mLDiggQK0T
         AI61Q+cVkuNa3qq/CbNiPpF5FzDU0y6yMGOecI5iquj5aCgjeU7YFBTXKacxzuebSxoB
         EaSyJJZdjnSKmUkMdkI7cQQo+WQxI0zCyKtfP7A1bE3yUC9TEFAQMZFqpV9rXZ4Em4TW
         UBBMC13SF2KlfphTJYEgvzTOxbzXgV0si91Tt3SCXR6GTA8yvR/lXzfSZRtQ4Oz0hAqE
         oL+IvvmDJagxwDiM9qrQ8GWxkokH43Qhr7d14OQnwhk6xzC0BP0AOrRtqfDzC3APFcBe
         u92w==
X-Forwarded-Encrypted: i=1; AHgh+Rqy6xkg0K5tYqbs0QRgAzeS+gLzqw2Z56l6CFHVEDloJJO+wGk1dFJ1myDnDlyl3tFW0Sged6phYzsykg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXu/4e0ZoYLdkzjFW11oDTU92FCz32yUbEgwkEeL7VWs5obq7i
	d53Jf4YQ2xRHSZTf+CCOqeCrP2oU090zDQCH/emwrqTzrzc84eXKTQtQ
X-Gm-Gg: AfdE7ckCcNgkTvQzp14yFcnA24HZzf9zrVu3trX+VY1tKR4mJygvHTNFEMtPBDNU5x4
	334P6LGEnhhXRYvP/uJumq1HsfFWddarYUrx/fMZWAJdghMSh+ktLjP/aFoiHy94jzOuQWxBPkr
	WGoHlm11iFPrMzF92kO3uppxYGjz0HbCnkTURfgj9YB1Hzi3OmREV33YFIRJhdSzQ8yy5mge5qo
	Q+0pAW0Vv1urhE77CpMCv8FQj4CEXDI+CR7x/QzRRD1U8BES/e1OtlcKbxGr8MggmdI3PVWcj9v
	Q37mAWCP6SU7HRmEwgfS1BU4GoeRxneomkT4w2sWmXWKzk0qSMa9i57B8RxB0ktmhh/12bYDFeW
	QHbV3e1KJxhpBp7hOxkBvF/gec+GxiSfCeJ2tPNLPrj/k9r6LcUgRWcVDnQi346YmL6xJTK7xDC
	E0hiobjbd6iCEOrNlFbrslxUFv2JIAKMC4/A==
X-Received: by 2002:a05:7300:f691:b0:30c:528f:edcd with SMTP id 5a478bee46e88-30c84d9ba1cmr1978509eec.27.1782371653766;
        Thu, 25 Jun 2026 00:14:13 -0700 (PDT)
Received: from 10-86-27-11.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1a80sm5353401eec.18.2026.06.25.00.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 00:14:13 -0700 (PDT)
From: suryasaimadhu <suryasaimadhu369@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: [PATCH] staging: sm750fb: fix const pointer declaration
Date: Thu, 25 Jun 2026 15:13:48 +0800
Message-ID: <20260625071348.132880-1-suryasaimadhu369@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make g_fbmode a constant pointer array by adding const qualifier
after the asterisk, as recommended by checkpatch.

Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e08..8f533f3b1 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -21,7 +21,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel __ro_after_init;
 static int g_nomtrr __ro_after_init;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview __ro_after_init;
-- 
2.47.3


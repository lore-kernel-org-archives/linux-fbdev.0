Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2E71E520A;
	Tue, 18 Feb 2025 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905161; cv=none; b=PsmMedkklooCVXNuvodFyJGy7h5ZrcdCaC0fQfSYO2ZmnPF1rmVA2vAbbPXa5M9LM21KKQIz6TEoYXE2JqoCwsxM1u+h/x59o400f7BFNb9PVQ8e4XnQoht7s7EcPZUGBO3W2YzYVkqompUcrAAXMbpCGNnMwfyR5cee3C+KR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905161; c=relaxed/simple;
	bh=Aeag+chLYaQL7zp5R9dHdYB2etdftGzOtxe+UyXNsug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slbfx5WADiRFHc7351CGGXG3+Bz/U7RThCRarVobhBRpdNDTWlGE6HQBXggMdkJfSjxHAQm2P4b7LzgrO7hjB5za+lT5atGHVEztW2Ol27KMzOa/ybPF6anXD8Ci8PRhwFzp519Zp8VuEDF8xxWJPBTQ3tzs+sUQG0bZDG18/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9LtLX9L; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9LtLX9L"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220e6028214so101546845ad.0;
        Tue, 18 Feb 2025 10:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739905159; x=1740509959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfIQ73UMIa0oDIpRWuwUrmGQYfAsXCHaqQxm4bBOgQE=;
        b=R9LtLX9Lw7baV4BbxFhJOi7oCe0YPwLciLiuGIAGnamFLGI0P/FUt87PE40NoI3SYY
         qXcEI/iJy2rNOQR26w1t08COWIBCHmirH0+ySFy1p3oHeXjuNMpsy40z58eb06jlaYFp
         VtcNKpNM3uGWgINRDaDZsxhKfhJZynnUU95tND/pjx3RKFn7IUCztkMkREoILOPMbgr1
         WoJuf6aqGbwcZC01J41d1JIuNqQyuuO54aJ7xO2I0E9RZ9/C5xDV1t2V23r+JKO6ySWy
         rUJarp4lMlUs+MhCdLrZNBm1Vhtyr08FKSxbRNXVTvbTC1L8TPSwqf61kCk+VcRrABUB
         lVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905159; x=1740509959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfIQ73UMIa0oDIpRWuwUrmGQYfAsXCHaqQxm4bBOgQE=;
        b=Sm9wgYXYYvpT85Y14hdCAGvnGXo+oXndfNz7EnCeIXcpSm5LWeZnzXFKHQXUO7cxhm
         CUbvayAYYnR9ky1Wvcu684Jv0fLNW63NgDcsYAAbbyn7cQxKZENnh0ITa5Y/NM8toIcO
         +PWGUHQJ5TxqFG99m4KQ6V6/t1ZeBzAn0WnTqVf/MeRKswSzuk2eIuTdcXCdEfXZ9wU1
         F+iajlkFq0w08akI9gUvSd56aMZ56SnqrR8TeFyRMKBhYMMwoIc+SbsfQlzAtLac7gVF
         WF7hIAr42T/cnyjoXbrOT1pkoxk4sjbeT+cZRqGOCNv1BMlRthIzzjg/egCqtAryPptQ
         CgYw==
X-Forwarded-Encrypted: i=1; AJvYcCV2TlSp+8r+wMP4xuu25EdhG1EwckaZxmh+AuIuEzkBUSZlEGiISTSrLysVPOf8v93qlj9Y0mqSWhJ6xMmm@vger.kernel.org, AJvYcCVHzF4uIObSYTEgC2Kw+1o7GApTkCMaCFPM56KYWmECYeGsAbYt/yx0wtIW68Qv5SVJyv78hUUhIVqFuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3s6sl//+9IQeH3fv4k0qi+JSSN6t5ZbOtoYdnxIJi4Na/E3W
	xtXs9BMTe2/fccbwLgkXipSWQy7QHc6U+hglvsidvjkx8zKcSDv3
X-Gm-Gg: ASbGncvv3zuXp/pAK41EtJgS8pEMM+D3fpfygTOvbeKvWqZZRRgsUCKaXXGYdJoNfKI
	hsdLMz6Jfm+l1nLjDRBUFvebBk7ZqL2F/JD7kZjyy9pEy+hQwvs8a5iBAQ0EbD1/2tYLj2W3Ziu
	RDNP3enLAXK1NG8EAPka9zGgwaU8wEc0RRCqw32rpgr94W/yOgjXBfb9nljSlg99aGtdk7Apa61
	5fsWHSYsPfetTx6TGVwkMGGa8SohPGkqe/ERfBu0/dzFG999ubfuZPTST939XR+78FOb94R9mfD
	5YU7fH3jETURl7aBxvA6HFDmWx8/Sw5V
X-Google-Smtp-Source: AGHT+IFpJc379LGLQcwcKfsxcizKtjfZmOQV3MxzuAoCjiOHXBb7g0F1ZbafhajE2fdvG53aUZ2jsw==
X-Received: by 2002:a05:6a21:6e47:b0:1e0:d1c3:97d1 with SMTP id adf61e73a8af0-1ee8cc03463mr30274362637.29.1739905159059;
        Tue, 18 Feb 2025 10:59:19 -0800 (PST)
Received: from localhost.localdomain ([36.255.84.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73276f20c30sm4903499b3a.21.2025.02.18.10.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:59:18 -0800 (PST)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH 2/2] staging: sm750fb: Make g_fbmode truly constant
Date: Wed, 19 Feb 2025 00:27:49 +0530
Message-ID: <20250218185749.22144-4-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218185749.22144-3-madhurkumar004@gmail.com>
References: <20250218185749.22144-3-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index cab879ab58bd..2cce27effc46 100644
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
2.48.1


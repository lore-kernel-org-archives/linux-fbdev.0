Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D108E2FFDF4
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Feb 2026 23:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160083; cv=none; b=ZRIoLuPalgLZbDQTfBI0P8drOBL8EeB4vezi75exIV1vpq2VQKF6E7n8m3OZD7+UZb8NPCPWsWkALltoZTz7hzxu9d9J1eOZj2i8EHjTGLGNvalbfZdf2R+YMROco+uNPjUkzD6hsg54t20X4rYk2NX/VTYkbD/o6FGWHzvx+uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160083; c=relaxed/simple;
	bh=jVsaqFD+d8LNN2vVetFEUNyX22dXbwsz0QkKZ7O/2Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nk+fEqvlruSUgYIaMrdQerVWbwJ840hypfN1CBOgE2RPlXNgF9MQuqpP/dj9LP6n0u1zJNzzZV9GGGU5J0B0NhzeI76dsAAJIWKg4RiEnXvEPKjJGYEOAeJwBX/cgV0R8Zx/Z6ufvZ197WPGx3qSGINaVem6ZeCIKH1Xfq0BFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3XJxgbc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3XJxgbc"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b884a84e655so907491366b.0
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Feb 2026 15:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770160080; x=1770764880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9LC2rgy8FruKnAUghqfggKkncBhJB/4kXDB4TXvEw/Y=;
        b=N3XJxgbc9UDSEGrRpfamaUYYCNsamA3coFNgUvbrdqKauv/WQ9I3zA3LQ8JpmkcG9x
         VQPbgToGUYDAcn5ZCYd1aB30sWO8MetFalPw9Jxt8Slw9QKniv0ds3ouNIQFHKRKpCHH
         Eorpa84gXt6JszkbIqWM1Y08pF/roB1UqzzOZQ93/EHkyuBK6KwRzan90Xve1gXDFvIQ
         1EcOYp48LlCAxK2AXDlOyiZKlD2TPPB7++j3qWEGOQFxZ+DBCnlfarN7CZ8k1peP1oT1
         NLd6z1up7OSLPWE/cMfI8zeturtXEqeRF60+ocsoJJmahw6Q31tfvFYf0FWhqTRT6xrQ
         rcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770160080; x=1770764880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LC2rgy8FruKnAUghqfggKkncBhJB/4kXDB4TXvEw/Y=;
        b=GLc43mGVD+OiVsLmqaAgb+4+TeC5VnTN4clgSODWVF1dQjxjkzF3tW7JtJlWjBmUzx
         Sa0YvIWjrJa2ew2XYNC35bJwysFkd63m0hQrY8oJwNrfvPGxsNY+LKtxBfWVqYaEYX5h
         qXdJfRFPtOBZTZgTzJA64m9UsBV/J6BGNN86aQHLNQFCVHwn39PcEgvL3v5X+4znl9fl
         BS2OqmV/wxAFpSpq3yodAEAvzGNOKQGLPV/fBeCtstQtvkxbL+yytxPqsfjfXR8uahCa
         l7y0/0ppbePy2YBSdUcdomiV+Y40KWE6WDRU8QSnxzkc/+lbQisPOV8PraRxhGkSNjIm
         ogeQ==
X-Gm-Message-State: AOJu0Yy7+Vh2DQehH8nzrRsqpsFcSGrqivXK+Hz+tsyVaxzuAPT6mjAv
	oFRTT/kRx05kuopmPMwuMHz+kNsJHZVDKSuwlaH9mBkm3Uj6kzAb/RlVlEE2BsKjG0Rs+MJO
X-Gm-Gg: AZuq6aI0sJz3uwWy2Zx/bdrOEfID2Gxk68+DPSuXfrr9Ca8peYgFs2LusI10MgNuDzg
	9Jwg+5PXK/7C2aC1yIYOaYrogbOJmGMvL14ufCV2AWGNRHyYQMN+48i3SYxSx4Xm8jO+gzTMzqs
	OAvGvM5s8T4umUuFoeefhj4vEPjT/aZrpplZk7E+J4bvkFJ6TXSajFPHJchVpkko1lOYufoptF7
	nfojzXDX9aEMqPP9+NqGMKHP31lQbFHJ3YgbiyNDJMFOvFXAybNkpFTQEzHVDWc78pCPQoiIaFL
	bfIJ3OPjOiI70W+zYTGwiuKAu6sZEKaaIIdY6D0BRc9yXSzMlfPCyRBRkLSWtECuyVvdh2+KNjZ
	JO1N/V0TN4NrC9dbh/bA5vmNvHC0r3JGOTNj2k6iT7P1+X5jC+Uh6BPY6qSYaZJhNAB/2XAA1at
	55y/jg5HTMfWBAvzpYBVPPXTCdZBSlyVgPT5h/w+5HPwtCuIbT5Nv3bs51UZDesY9luoM9q0uNw
	Gt4ophZ5DyE0eB3IoGZdz/F7c2VF8oolFjy2u3pIee7xTenJd3dO1F9VtKM1c0HmD2Fyg==
X-Received: by 2002:a17:907:60d2:b0:b87:d09c:1825 with SMTP id a640c23a62f3a-b8e9f14c447mr73686566b.13.1770160079802;
        Tue, 03 Feb 2026 15:07:59 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-b.c.od237066db22328bb-tp.internal (33.242.13.34.bc.googleusercontent.com. [34.13.242.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea0021b3bsm38486566b.49.2026.02.03.15.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 15:07:59 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH 1/4] staging: sm750fb: replace strcat() with memcpy() in lynxfb_setup()
Date: Tue,  3 Feb 2026 23:07:55 +0000
Message-ID: <20260203230758.3056-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated strcat() with memcpy() in option parsing. The
destination buffer is allocated with kzalloc (zero-filled) and the
write position is tracked via pointer, making the null-terminator
scan in strcat() redundant and potentially unsafe.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fecd7457e..4c6e84c03 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1163,7 +1163,7 @@ static int __init lynxfb_setup(char *options)
 		} else if (!strncmp(opt, "dual", strlen("dual"))) {
 			g_dualview = 1;
 		} else {
-			strcat(tmp, opt);
+			memcpy(tmp, opt, strlen(opt));
 			tmp += strlen(opt);
 			if (options)
 				*tmp++ = ':';
-- 
2.43.0


Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4D1DDC1E;
	Wed, 25 Jun 2025 04:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750827340; cv=none; b=iziWlpAK9jbdFsPrYDX3WhsZDzUDrPeEvIdHOwrVZTvlK5sxemPEH60IpSUNjF7I8Fn+TdQzcZGrZFfklgzp7CFLoTkf57mFqXL82oXwxSX2yH1JUar0/vMVSJmqxqdFt0uov0A+SAt9e5HvN3fHiUJ5bL7Pepwcs55Kid/2cvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750827340; c=relaxed/simple;
	bh=KSjhtsYtDPWq5P0JewRLIYDc5syrJxdWyOswWFMIj2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOI3cWeXV9Izmn0kCcnbHFjuMe1mCuIZvf2rhUqoM/YREX667UbIaTtYNxVeCPoDEY3A8OS8v40vq8NN40FyHQsCHFicPDEabVW6VrPGdP/8IzAAdq5//i2C83afSnQHg3VDdXmhjqMwzvaIsaaHBujtJozBg8ahZ9IIG+HEDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH3wQvUc; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH3wQvUc"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c3d06de3so7019335b3a.0;
        Tue, 24 Jun 2025 21:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750827338; x=1751432138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UO6NTPCPP/dvAMAtqZiOjPibwhoAo2anGboFbitGK6M=;
        b=UH3wQvUcpx2YmKFRBdBZdWOoe/iPC+nnEz9k2FiqXLRolvm0m+5oiCgKijahEWXizP
         cnacAHno9gdreVH8FWSmKNrmfalol6UQaifE79kUk7MHEXJQpsXbFfdM75pC72hOdunt
         XGyC2MZKW3wuxtEj08fctgW9l2u9MLKrnxIjGRCi7Q/zvnjeBU2hmyV/bVg4oGbLNXO3
         ofXewI940dBESbokos7q7Pe345Mh8kM88bdLAPwiIQJlNs12UZpTRAyWNLG2J/Wt6CNy
         76sz0WHnn0DOynLQ6oCwsarfq6fQBchrWrLXaFGR7Nmy6t8rWkadkUZK/Xfn9hCPaLP6
         Nc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750827338; x=1751432138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UO6NTPCPP/dvAMAtqZiOjPibwhoAo2anGboFbitGK6M=;
        b=GXb9eciq7ehaANlK1oxns1Zn37/oq/zWFyFmMgV9RCzuUW9esVld4vo6mbsoWUfLo9
         aJPRurrqyiup64WjYMYOx84b4uKlPZ+saOS34hzwmU+7Rcw5IA9EpH45RkkUR+OPcQVH
         yMQDok3EMS/I2bQFeaFGggsHh9QByJhDu/v42BbJuTJfKA4esyPRUKwsLm06eYtT8mVS
         f0WY22JcI9My+GTWo8AyG5/HttSfyxQeLUUc74mfs8OrZ4xii0z3LQMTuM/2ZlnBmRuP
         ekm4RHEBzsklVYbF+a2zuJjFyw39CziDKr0Mj0mimC+z1eeqkMnl9Sfswc39YI/llxDh
         6kYw==
X-Forwarded-Encrypted: i=1; AJvYcCVxRVCm4ievrwA867n2uo3VSrLx1ycUp6TQEmGBOOVyySc1E5hDH0R8+4KpV3AHjS0aSrD3aTLlk3zXNA==@vger.kernel.org, AJvYcCXtRmHYMubVn1nUvNHKu1wanrpduTTKWHjMY/ptLTuTMlZ/5C3ury/32R37wgwwg5jVfBZQYfnYu5lNqHxR@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwx5l2hieeRJlBTVCPB3BiSk57+Nyl7eKB44JhVrjVXOtZhA6
	Y+n6H5iwYfXVvIc0xHE+GHqAKemyG7bHHYiD5q2Z9DdpNVi5tRn7NMa3
X-Gm-Gg: ASbGncs2Fv091dWqWB+oD0V/p6KYJXlLhxIbj5JopTWhfxRmEfMuZwmNl8llnfNBIgE
	7oiRXpItU7anpspEpe2lpkLxLkBCNO2aKcrfpRXz30hS5VaSsaIgDzMWvLVg/EwX6QFYklxoBxr
	tuIjKVx6ciMhG9i7AsrJrdyd5pDOsrJFDFfD9fFXxZkrY1FC4ebRsRYrAbautK9OLeaCmSz3AkP
	7WhzWrw9g3+Er1K9rq11njxY8ZGfp7R1jCNIyWs33Eyw0r2/OvJ9Ll6u3Ivv52UQPtk+D6x2sqX
	f5sM9upr9u8PqroWPMLcWvDd13K6AA9QvL4ojovFPRv0oXkYp6MLSMtA52PijlJeEBz9Hp4AbOZ
	mB+MUxZy6/rNtOGhzcA==
X-Google-Smtp-Source: AGHT+IFLbqpz8txyiEyP4O5dWK2HN68bf3Px02AjjgY6ny0rLjNSLfBKIcKav5NxVJRGNqxZfpE+Uw==
X-Received: by 2002:a05:6a00:2195:b0:736:2a73:6756 with SMTP id d2e1a72fcca58-74ad45e6b34mr2574345b3a.21.1750827337903;
        Tue, 24 Jun 2025 21:55:37 -0700 (PDT)
Received: from archlinux.worldlink.com.np ([2400:1a00:3b42:5d1:1d64:4a49:adde:630d])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-749b5e21120sm3610679b3a.43.2025.06.24.21.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 21:55:37 -0700 (PDT)
From: Pratibimba Khadka <pratibimbakhadka@gmail.com>
To: sudipm.mukherjee@gmail.com
Cc: Pratibimba Khadka <pratibimbakhadka@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org (open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER),
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] staging: sm750fb: Mark g_fbmode as a pointer to const pointer
Date: Wed, 25 Jun 2025 10:40:26 +0545
Message-ID: <20250625045526.82758-1-pratibimbakhadka@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a checkpatch warning:
WARNING: static const char * array should probably be static const char * const

The array `g_fbmode` contains constant string pointers that are not supposed to be modified. By declaring it as `const char * const`, both the string literals and the pointers themselves are protected from accidental modification, which improves code safety and clarity.

Signed-off-by: Pratibimba Khadka <pratibimbakhadka@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 1d929aca3..d3bce107f 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char *const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
-- 
2.50.0


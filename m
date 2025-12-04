Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1B825DB1A
	for <linux-fbdev@vger.kernel.org>; Thu,  4 Dec 2025 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860506; cv=none; b=ChqvLrWD9h+NsVW2q4jR37WBWLXVNA8K4bVzNpttcdHz4N909amiUHBW4m69W3dh6K3wi7R15qh/7Zgs7IkS0WUjSXRi6C2uVCadGlQYEP71SW+B6+pUOr7cRSdkPyKzkAnirf8gOmJfs9mSqljBQ7SyHo919ke8agHhUDgx6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860506; c=relaxed/simple;
	bh=dRPFUVBTP1zpukb+JhI6LnO7y/jjwCnNcwxyPNz3Ntc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XpgKRNN/zJE23esFgSeDxepqfdWWbWI/yvv6PNr9EFExS1YsJtf8fRVRQJvgkarTB3g4e3tuEf0bXYUZtbhk5AaStdFnPZ+C0CV83qhfKwoxfxgme4zVLLdVFvdf/cTw93vYDEYna5GSp/4RMPLPotLY0fJiX20Phx/wdkNeXKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQSx8Ha/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQSx8Ha/"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-343ea89896eso913767a91.2
        for <linux-fbdev@vger.kernel.org>; Thu, 04 Dec 2025 07:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764860505; x=1765465305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DW8v7DW6yQeogEEtYfiP42HqoFREpZw6xuPE1MYVj4M=;
        b=cQSx8Ha/+6QXkPlXiQYMcG+ePzuS/MCOZ64dJ42ErpJBBHrpTMYZmciYWyeYyax+3X
         F0KZyrVtLut6cJsq6moeLd2wFPmF5csHyh0dRB7CKWPdX1Dj0MbDHSh0hjhJ3RACJE0h
         LZC0YJZrffEAE5NvbL3DXjE3ink6EHkpbaD69DR9uRA9eV65b74Ggmg4muMB4OL7L2QP
         /eBS+0RCnCBT/bKLP0yTnNjkH3C7zEx2SNyR4qx0zZiXLLuhl60+X6tQte2OmJkqbyEo
         Oil8cZCN2Vt9HGGjpG33KuLlM8fSkfILZrvEBjYNIZAIa2g8/bjC8f/TS1Hqa+DQUwtZ
         0n2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764860505; x=1765465305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW8v7DW6yQeogEEtYfiP42HqoFREpZw6xuPE1MYVj4M=;
        b=lwuZGYOCIBF+ZA2TDUHlOKWdaOvZIq2PUKYL1IwkhYS8YCqrikHaI5Ub5z28z72O3x
         aG0/7ASLVmfTDHT9/DMpgS14v7EnON7J+omZpt8oeWljY92pKMZo0fUah4JeXPKUqrJF
         3sRldAiyXr0dH7HmMpE6K9sjVJlYnKK95rVskDp8ib+SF0ieNKrmrRS+Te5tJnzQij0C
         x4DCl5Nb+6jR8BFmr4KwigG+EoQNqZeh+8stQ1HP7jeNUvjOWJwDS8/qY9RnodnWYHaZ
         1IgdOAgafwDGkHuSVmreoZLfo2mJ8H5/Ou0gGNCJy04d9eJUwKrAlyZVhPHbkBMEM6VQ
         Y3ww==
X-Gm-Message-State: AOJu0YyGrdJDk2/EmX7UlQwLicyO8fGS6ZDbz/BUrbqVwQQzxJAu+5hs
	Qazn3fV/Zbq8uKAg/GhrXav7FxGLa4D77KZWLSNfrraWXqGMDaMZEwKS
X-Gm-Gg: ASbGncsqCggdhsiz4cYo2kWb/8eTOHbqSxBdX5zwNzYLIaB3psulfzmJ/5sdzksNPDa
	oJuAGJdePALzVNT/SncEJdx3ke6Q7nhG7YF9KEw+Uykf3N+CliqFDAMvDAWaNAuBUzfocClhYI/
	8nRbDtF4kdIDJiZNGrmmzmrBCeVJS87DX9UCTDk2EA7k/YlttTQ9Ajren29NGqIJGBXFYZ/cBrr
	FsITzjtHxBLr/SWYsU5ZZWnyxEYLp5CaWX43HO/j3Im5zndGfrBC8G5QMTa0sfm+uzJaCpTYmue
	ss0ivXtGQoim+Ou3ebWUoIx1wPpBiWPY0EmakCTobxaHYz/wgjC3RCiOK6TvmaEkoEIQ7Q4p0D+
	EktWKKzDrpbee5u6B4knE+34cCgPKICSdfeI/zc45mGe+LzC6iZSxMbCdZpWFbKPwg86aX6ACLX
	A4lvzTmIeIdt0HhtZ5XqFkCGd8XnEOLZhVu0CjH2wGDdcRDSdOXIsh
X-Google-Smtp-Source: AGHT+IHgRMuz5a6ZG+U2TTogSANcKnvcXgKJkNaITbT+aeWK7j8M6ROpFCS4SD4HvmKwzxlcm6GQbg==
X-Received: by 2002:a17:90b:3e45:b0:343:6611:f21 with SMTP id 98e67ed59e1d1-349125ac880mr6023964a91.1.1764860504446;
        Thu, 04 Dec 2025 07:01:44 -0800 (PST)
Received: from fedora.tailfd33a8.ts.net ([119.161.98.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf68155047asm2142009a12.7.2025.12.04.07.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 07:01:43 -0800 (PST)
From: Karthikeya <garagakarthikeya2007@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Karthikeya <garagakarthikeya2007@gmail.com>
Subject: [PATCH] staging: sm750fb: Fix alignment in sm750_hw_cursor_set_size call
Date: Thu,  4 Dec 2025 20:31:26 +0530
Message-ID: <20251204150127.10844-1-garagakarthikeya2007@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align the arguments of the sm750_hw_cursor_set_size function call
with the opening parenthesis.

This fixes a checkpatch.pl CHECK warning:
'Alignment should match open parenthesis'

Signed-off-by: Karthikeya <garagakarthikeya2007@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 3659af7e5..9740f2705 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -121,8 +121,8 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	sm750_hw_cursor_disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
 		sm750_hw_cursor_set_size(cursor,
-					fbcursor->image.width,
-					fbcursor->image.height);
+					 fbcursor->image.width,
+					 fbcursor->image.height);
 
 	if (fbcursor->set & FB_CUR_SETPOS)
 		sm750_hw_cursor_set_pos(cursor,
-- 
2.52.0


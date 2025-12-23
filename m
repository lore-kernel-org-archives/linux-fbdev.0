Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A78F349B10
	for <linux-fbdev@vger.kernel.org>; Tue, 23 Dec 2025 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766516407; cv=none; b=TMYP9q5bxJoFPAfltC4Lw6bPVzhBYbriSCcWNpbAAFJLNexLHYTsMcTzMpcKl4KdYJGbaoSnkjpT9oWCg8Oo0ie5hL3ulmoLQUYYhxNwk6//U6Vzarkn6zupyeHKyWAi7yTjCPAd3QaVaBAATGCrZIrlY4Bw89pot34eiFhaavE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766516407; c=relaxed/simple;
	bh=0Y88mplztIxM7HXKshrFYXfqzTchd2WEF2D5dxep1s8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yp7od+Bks4Xk3LAagglf6DY86BaJFa3PiUvStmS+VNEwrll8murFLcMt5oErb2jgB13xMh33w/ffro7jftWaABWkMw1y9C98ZLRj9Jan/efIPoOM6Oho+3ZUPUJ6J15Wpje5sUGpBZtt6ftVPMQFreUM+UNYPPX6zJjt+Fdmsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KinabQE9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KinabQE9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0d5c365ceso66747105ad.3
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Dec 2025 11:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766516403; x=1767121203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jBtO4dndspPVV4A9wtVY7GwksvV1hpeoiNFJc4zK5Q=;
        b=KinabQE9nwD/R0C3S7vg6Izx0p+gjduSrIz1zxa+QMCY7qqX8K15bKP2s6Bivm364M
         tji4daXyCaCsYXcbJK8EcG99/uCnjQxVN8xap7gRcvnK2RJ7Yqv6FKcP/SDhoyWg1GPU
         bR/do1u3asphkHBj/dZXB90jp2bje+GtntRmgbjuaBnjn8jxPBWS+Or/L3R0mU/dAJPH
         YUwiAl32TIE5lwQv3XRQaKUwRM0Trdh7KzyVUublcdNEA41dxAwfIp9M60UvqZBNiUAQ
         LYG2pQNJN0fTa9NrGWKBj8MrBjlwzFCDLCmfNKLKN2TZ5S/pqaDMNK7otrEywwlmlpti
         DCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766516403; x=1767121203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jBtO4dndspPVV4A9wtVY7GwksvV1hpeoiNFJc4zK5Q=;
        b=rHsi755n7EgjjcLsr/CXSBfwxh2zWi9chS9KZmC5xL6li7R3UGqkKgLoSNe5bqrn2i
         uo2Ar6AZsk7R2AlMTLvWmnqpadelYeHyzHxGUzvXy0F0kkBvyxIkn3o+lTq9BGbWxthF
         mtGc+T0WlMl21LO37A8yXcbqIDD7g/eDsukrCOy5obT9pxUHZmMKF4IDUNfkUEc4B4PO
         J+NX/u+OinlnToxfTkyUaUAymNs/Wp2q9pVl/HS95W8uaOY52stOenkc9UsZkFzGzPiG
         rSL59t0xNprMwPdDn/652cS5sWc/Tm6JQtvw/fNea8FX+EliM+pjcSpqki2cULhg1zDO
         rszQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYJtBbc/qTt6VxnJQrHCgWcVYn1xi3KqJV7xnU9ddSlUsazOZDflNvzXH4K4a0YHD+kMzZr1c6BFmDBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXdGKGqhSSwX2gqqOX4q6iaE51tREc6dJ7I8h54Mg6mKT7LAfG
	LJsBhTHD2Hawfqc9tdglsuFg3tMnS9doi3sqXRi6Mi6bTfolKwuH50Wl
X-Gm-Gg: AY/fxX74vb27nXR+YINkxZuWU9nM9009inKNcrG00CyEpN1d8QoLZzFL2yu8LtEUgXb
	Yjo9GdRjlZuBAyamh0SLuMMG6DJQ6jjoVSkgAtv/XINm283z7PSbBXDIPP1BDPox/H+Va68d6Mr
	827xt9WWrkGhd5mUuZY5ZiyVDSxZrk72U0+a65AithK7XCif/qkVeBLZkWBF81p8bRmdqc/6zl7
	Yuf4BznqWL9Xh0ACBL5+mZ0hxc4ywjVm5mFUN7Jubby5SJabZSMjl0kKOko//nMdGC2m17h8YTq
	CQSTwPHsSlgoOgARcOsFQdKhEAoNoaOAgce7/97kX7MVkl7UCNZSTpWo1xOev1IREzY0e4WjKc+
	y41ZH66sWGvxeVPtoJPOZYOsZw7jh0lFYxRjg03E3hjpKFJuiTFjq5BNYqcYPqni9yj9LSEOqdq
	TcXUvqYCMMGAQPD2NZF5ui26siF+XpXhYV7vrgA6QpkkXqnzQ9e5p8Dj4=
X-Google-Smtp-Source: AGHT+IE7jfEB8WE9Di5kUUN3m+9BJnxw1dEA/zZLfCeFxaE4nVXyo/8F8TLSXBu/nrwFR+4JHbVQ/w==
X-Received: by 2002:a17:903:248:b0:2a2:f465:1271 with SMTP id d9443c01a7336-2a2f46512famr118389975ad.44.1766516403432;
        Tue, 23 Dec 2025 11:00:03 -0800 (PST)
Received: from localhost.localdomain ([2409:40c2:1052:c28c:d56c:4c53:fd22:65f7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbdasm135320905ad.65.2025.12.23.11.00.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Dec 2025 11:00:03 -0800 (PST)
From: Tejas Chaudhari <tejaschaudhari038@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	Tejas Chaudhari <tejaschaudhari038@gmail.com>
Subject: [PATCH] staging: sm750fb: improve clarity in TODO file
Date: Wed, 24 Dec 2025 00:29:50 +0530
Message-Id: <20251223185950.12328-1-tejaschaudhari038@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve wording and consistency in the sm750fb TODO file
by clarifying references to checkpatch.pl and improving
sentence readability.

No functional changes.

Signed-off-by: Tejas Chaudhari <tejaschaudhari038@gmail.com>
---
 drivers/staging/sm750fb/TODO | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/TODO b/drivers/staging/sm750fb/TODO
index 7ce632d04..56ffd9b36 100644
--- a/drivers/staging/sm750fb/TODO
+++ b/drivers/staging/sm750fb/TODO
@@ -1,8 +1,8 @@
 TODO:
-- lots of checkpatch cleanup
+- lots of checkpatch.pl cleanup
 - use kernel coding style
 - refine the code and remove unused code
-- Implement hardware acceleration for imageblit if image->depth > 1
+- Implement hardware acceleration for imageblit when image->depth > 1
 - must be ported to the atomic kms framework in the drm subsystem (which will
   give you a basic fbdev driver for free)
 
-- 
2.39.5 (Apple Git-154)


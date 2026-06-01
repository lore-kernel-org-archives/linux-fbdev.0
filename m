Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81853359A81
	for <linux-fbdev@vger.kernel.org>; Mon,  1 Jun 2026 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780343227; cv=none; b=bjZKKjPpBUwV2Utk8dTceazAyaslVbTfsuGxZqKt12qfhPzo9Cif8FixqX0rMan8N4aRrDbZm/Et47GCPl98hnv9DiJPpQNA2WcKkQyPiEVklo3l2YtNN7xpB4dncr5gqr/+8dYzZgBXIwJHU/Qu7hmQ68o1Z+MNiM3Lyjk9zzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780343227; c=relaxed/simple;
	bh=M16nz1qb1nkOkk8U27EY1VaByNCLIjEENT79INbLNnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ea04xFmC+/cK9+EF0i78rnM5WLzSrjz8pFQy1sG6Q1Lnoy30mIoTfP2tRBdtmCFornOula6oGalXspfMaDmewtKC51W5yTRAJ6NUNW0gunPltsNsfbNMRA/EPqfs/v0WkrGfTR24GoYCFt+UYDtbf8aOiCceNhPdczIkxml7ykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZR1NzU2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZR1NzU2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so80274085e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 01 Jun 2026 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780343225; x=1780948025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LAHPjEOPJLBbaq5NjMaRW8Wr9IuufyCksNsjf8BBwYw=;
        b=PZR1NzU2i0n6hTCq+mcU48IXoZAdiYqxRSqS4APgEhRTgYR5FuhtIungJtnC3+90lK
         49z5fdyszXE4zzCT0Rvzi2ivrIskc947MN//HeMNNAqQCzBeuKIaQmkwH5t242hcl4B6
         8TKLDBbmpAzPuoMpt2or+GM+c6gsXB9H8YHmS7lFBbryv/MIgzByMJSFNamCOetbiOul
         bqya7PUaTmSKD3MFiQkZfyiADXI7NlCC2lmRlQfwKNmW/fdljaUVYkQWI1rJclpyW+lf
         4GYZX1MIHWZ5swgis7w6rUfSmAX+N6OUqRXpHy8HyEh+jcQVK3CNv9w/bKkmlzodrD7D
         KEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780343225; x=1780948025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAHPjEOPJLBbaq5NjMaRW8Wr9IuufyCksNsjf8BBwYw=;
        b=NBrtEMJH8ZakJ7KZGzqUbYgMRegbAMNDLTgCfeAUbUSmDyXYa0JToKeDpykXi9knUK
         HVZgFdnW++l2fJYSFWCmwopKemov4/aZDBRt3mZfMhXazgAc7ZIbvjwxRPVaxGYkLxs8
         nf3bZimjOWcxY67KU5ozpALhoSpaOawpwUypLGEF+D31GwaBxBHmGANN34tl+rL/aL/p
         O+QomvFoKTU2u65rdfVxFDddA3F7ha89bwnTVSTyLKfInevw51FfS1W/m85M+DMDmQhx
         SpkpClhwWYdKxlbOFOsNYwlKXA2RD04CZICNNm1JI1LwGzkYkdzbVvz+UX81P99IbSRc
         ptZQ==
X-Gm-Message-State: AOJu0YyIgaBlML5puz8WI7mQ0yns8Ms3J3dpAaRJ90lrCzM8K7Ocdwv2
	zfzB/w5pgX0ZC13+sgN+SAeU2TWkOVglRNGEcmmGj+hTkLi2w3SISuzP
X-Gm-Gg: Acq92OG2vXYL1vVDVfmybtAHU+vpwL866o7UdNCNJW8nKuTwAvkFHkbgYg1vHF32rBp
	Ql5r0H5tds/vNmh/KfOuWVaZ521FqHz86PP65W+tZ4F1rAmh/teC+8ix39IIgqdub18GJZeaUhZ
	1yJim1as3YIX2SRAJA28jT0PuFNB4rhlXk6Nt48kpZfGcOXKlBtPBxBFY3f1m65vBPvN7s30+Jv
	hvo4wPW6vbShWHlZ8Z724GmsLf9JsB+Fw4+vqAyY/vgswqZsexScrlcx4yuB+WbQZBNsolPDdVB
	JzkSJ1ZaIkCYNNndA6q1zgJfoYjwByPOjU2DJVBjK6gMSbUmx7RRmW6R7AB4QXJqhG8SmX7GV2S
	lhWlawLKj1DzEBII+JTGtToJiQXERpq3z0qtd1lcWnFfBZ2rAPyi+rXdrcV221R2vNRYLO2D16V
	wNZCJ2Xp8dfY2TnBACKSj++MsKFcVq5GabQ+AU5PZtUQ4u8zF6WhJjnV3y5XM9QTCxKY0=
X-Received: by 2002:a05:600d:640f:10b0:489:2005:b36e with SMTP id 5b1f17b1804b1-490a2941d4emr170704985e9.19.1780343224596;
        Mon, 01 Jun 2026 12:47:04 -0700 (PDT)
Received: from eduardo79silva (ad96e068c.dsl.de.colt.net. [217.110.6.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b7d6bsm28802972f8f.10.2026.06.01.12.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:47:04 -0700 (PDT)
From: Eduardo Silva <eduardo4silva@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	Eduardo Silva <eduardo4silva@gmail.com>
Subject: [PATCH] fbdev: grvga: Fix CLUT register address offset in comment
Date: Mon,  1 Jun 2026 21:46:44 +0200
Message-ID: <20260601194644.275346-1-eduardo4silva@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment does not match the actual address offset. According
to the GRLIB IP Library Reference Manual (p. 2119), the CLUT register
is at offset 0x28, not the value stated in the comment.

Signed-off-by: Eduardo Silva <eduardo4silva@gmail.com>
---
 drivers/video/fbdev/grvga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/grvga.c b/drivers/video/fbdev/grvga.c
index de8ab817d406..a6594bcd74e8 100644
--- a/drivers/video/fbdev/grvga.c
+++ b/drivers/video/fbdev/grvga.c
@@ -33,7 +33,7 @@ struct grvga_regs {
 	u32 line_length;	/* 0x10 */
 	u32 fb_pos;		/* 0x14 */
 	u32 clk_vector[4];	/* 0x18 */
-	u32 clut;	        /* 0x20 */
+	u32 clut;	        /* 0x28 */
 };
 
 struct grvga_par {
-- 
2.54.0


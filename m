Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F2F3B42CA
	for <linux-fbdev@vger.kernel.org>; Wed, 24 Jun 2026 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782344395; cv=none; b=B3BSIHm2CPS6EBsNhoJR8DLjAla7W36IixRLTu5KX+kjFkzAevm0N0Irt/dJE8ceHHC6YNUC8yIyU8vzq7SGIWAFJhXtjeL3fdrLCqItMyNNU73/vNsTOeEDPChtvxohTlvswtfNzIa4KW1EGSm9/bYxZG9i3SvwwmI6WlGEKyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782344395; c=relaxed/simple;
	bh=dPiYU21UICloo2GT1gPYMEzu2mw9yuDwrGH4FU1wZpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5WdG8wgMs4nTfQK7i6+cf4Sr6QdzPeZSwCKgH1qtBYyI1H7XjYuGgN3ho+c5/Ci7Ohp5QOZW8tnn610+WKQFeCA34hKFjdm3oIHjM3xSCk/qOcm91Mf3Ba0mk21tzDipROKrC80ZxI4mcahOaZjaZz5UHmSnzSuCjE/FIKOz8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/x3QDIS; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/x3QDIS"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-44758ab7c60so1051229fac.2
        for <linux-fbdev@vger.kernel.org>; Wed, 24 Jun 2026 16:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782344394; x=1782949194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M0ftl5od1sc4CqUX3S8ttDYIWwf50BvLVRjkQU/mG/4=;
        b=D/x3QDISLoIgzDuy03K20etnTBqKM/AJh6twJXMsnpDvdPXJunLCWQ2fTr+SiH2AJA
         ELvk3kY0hH9mlBF1OHOv7Fx8Ow8OOFs0dRo7o2GRINxj4BnD1kzFssQFzzJX1qsRgoXw
         0yY+aTn8RuM56iDL/BT7hXHRzXU/JTRIkiLJmxaq7lMS+HKsn/jeum/My79zeSNZoF5E
         PnVpZT0GyXf1AjRNgMY+vs+6ycbtHj1pgu9a2BkgfI6RpA4FSMu5yHTnz/kpUU4QD7o1
         gh3Qw6ZDzQ8q/zLMkbok0KlfOIanjzpmsY1Q7i2z0/lZhzlAhOZVzZYcl8qSt0BmUWpE
         B8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782344394; x=1782949194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0ftl5od1sc4CqUX3S8ttDYIWwf50BvLVRjkQU/mG/4=;
        b=Wmf8Etwc0hj9Bk1V/vF7wf3kQPz835OvRMbE5FBQ+wyQS3Z8yqYez3vzyMX+gj/RTL
         hKDqZLmQYwpOT1NXhlXsI/Vc4c4oBqDXSC0s7KizJfKLVq4+nFVwjfJ7Viu0BJ2nXqv6
         e76DKFmHM9VlWQ6oUWhner848szAKunNhy6LB5PpzvnAJy1aO4xwBrm+17gGfYs8a/yP
         OMl07SKom2qCu52SNEcjA8rlrTocMZXIiiE+pEYre035ys8Uy4+MOeZPrgVIyaCcIMUG
         QO+wyeeWfKn4WuFZZKoIZQscFEBsSZt9hC7sWB+ngbPFuSPwxrQ3yXzRTXDG3X3RGLCl
         OFQA==
X-Gm-Message-State: AOJu0Yw+vF/jTW9NnW3SbU1wTr5+LJ8YJ2/qNBdKR6Bh/5j5JPs08dQ8
	1JvjnJeM2Bx0J7QxSwF/Gj0e8GWLZ/kBx4iwGpizYJmSXsyWmfkYI+aj
X-Gm-Gg: AfdE7cmrD6SeClBTeRU23ZaoTYS/Acnr/bnfOI8EA/faJuQs08G5+aSEm3amBBnQ74g
	MheUs7Y9TMFl/Xvlj3YR+NsbLEQjQvRCMzVdo+vlb8UJx/xyeFEJHBQhoV8VXHDBcOr0yNmV7jQ
	vfb4xqUiQBI7c5OvOxFA8+gBkRfLEeKI7RdyZsKHaGnnIrSIvK8Eyw+4lTkMQ+gUYffvcTyEe/r
	vTpxMUtWjhZ40yyV5ckJxcJtuwDCs6TEBD3LYmBKkazMWb8NGMOTbTNcVxDhtMVZJRRnsq7DHt8
	XRmxSrWOpylLCx1yf0Ct9xaB92goH9qdQE6ySc9tEPdjdcNlMkF9Jpb+LN5t0SDlbtM0jmE8yLR
	oAd/QFLUmpHd/VCkHvH6QyqwD1/vOokKWR769jnI8CmtYpuYgdYiSube5ffW0265HHoccLocqJ/
	p7aCITDYV434tnSULZMDx0nF4SpbS1tALMnUeLcOqr2+/a68nXNCqlJGgE9kTGin6Gy+ydq3KtU
	Q==
X-Received: by 2002:a05:6871:a842:b0:447:a1f2:f01d with SMTP id 586e51a60fabf-4481196e859mr82114fac.5.1782344393704;
        Wed, 24 Jun 2026 16:39:53 -0700 (PDT)
Received: from ShravyaPC.. (r74-192-25-180.bcstcmta01.clsttx.tl.dh.suddenlink.net. [74.192.25.180])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472eccfa68sm10637006fac.5.2026.06.24.16.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 16:39:52 -0700 (PDT)
From: Shravya <shravy112@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shravya <shravy112@gmail.com>
Subject: [PATCH] staging: sm750fb: make g_fbmode array const pointer const
Date: Wed, 24 Jun 2026 18:39:07 -0500
Message-ID: <20260624233907.67886-1-shravy112@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the const qualifier to the g_fbmode array pointers to make
the entire structure read-only. This resolves a checkpatch warning
and allows the compiler to put the data into the read-only segment.

Signed-off-by: Shravya <shravy112@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c..8f533f3b1b42 100644
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
2.43.0


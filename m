Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA4396560
	for <linux-fbdev@vger.kernel.org>; Sat, 25 Jul 2026 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970493; cv=none; b=DBPT3ke03zOS8rr6pFAKjCz4tQ4EC2yBR5uANZnAICTtjIp74IOZ3jjplWtxaNw7EDBfMJFz/lSWcBa4bNqI+xIriDioq0E3kquiNEyrO5OuwaWme5EWtDrmWE/CxGPg2MUwHu7/q6E6PFdpT5ugeBXspxm/AyaftlEwDfUYuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970493; c=relaxed/simple;
	bh=KxHoVKT+TYBFpNxZl1pnAv0TCcwh76xyAHIqQ9FzO34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJc91IfP0/e2O3JGdjiKX6xWms3JwawVZzMMdLXJKO/AMQiUpa5VIck432gnXPGNzVaSwbDUkC5q07ZEm4V/eHsXYJRqwJ7X/mRVuNk3emouOu9AagPwhLBpevTIo4RTx8q85HHv/ebxIflvWG7+2c5+5urHqYacHmKPp85muUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j01sTibK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j01sTibK"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8484f229529so823373b3a.2
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jul 2026 02:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784970491; x=1785575291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/dhpaHA58wTtBJFoLpIdqnrVEV4rKMcURpQAdaZKTc4=;
        b=j01sTibKJIIUS/cO3r/IJdAFX0G5EY69pxsuJ6e6IEEGW+/Ob/F1BGJ+CREx+p/hDQ
         cPH82Jx9du5NaV7EnZcU8swn/3bVSnGxMZGaHA3kMNCeyLfjoArX4Qdds+puyeksYKJf
         P/+NNthQzyTgdKGXdI5bbdYvms/Ev9PfRDCA8eRHR7uCUNBlkzlHkLCtgAV3WQAXUQZx
         iWB8iniY94mo9Qb6UEs6xupXlANZTIgW7Ko+WRiGBX/M1MplRQFp4rcLoojVvq9xqGol
         x7WzVC1hYw2JfDlwkymLVE/R4RhEYZ01Z36MIZ7SxJuznKl1Lfq/dska9j0YDYzX1c+Y
         eIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784970491; x=1785575291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/dhpaHA58wTtBJFoLpIdqnrVEV4rKMcURpQAdaZKTc4=;
        b=aJzydPA5HEjAvEU90caXMPUHqN2ApENVd8SBFHIC2HiLJuRo3Go1Cnrk5q+3UzGu95
         p4VCAHY9m4XSD9Z5AY/eNM9p1VD43VJVfv3dECHSeGKyJbZgr8KrsQcqNKYVdjVMebt5
         FBYbqTqa3cSlZiYxUq25LIn0TCHoK/Dq7bMjqhAyOFB+tkM4fJqmh3YpuBsyUDA2zBlY
         MylNQLxRsoL7TF//FFJ1HaOt/zefsnXQ5NPN15fS17vDMXmXMVzM+yy4DfW1dUU/t7mp
         57W+E2ZAibX7jWq0cGDkMZrhRAs4LNDdpBLvspGg06LHQwXp/MY6uxlnDc3Me/2v/3fe
         Z/Pw==
X-Gm-Message-State: AOJu0YwdG/R9j7a8Da9oEJMNbW/HQ3Y1d51AQ1KsxBhL5jMo9kAPVoyn
	B8oxsxKT7m4HIJQSgs8LZLld3N3fYc1QwhTdRgBbJsR4ntWJmHQTlw08fVbvNRE8
X-Gm-Gg: AR+sD115ICmVIryoFx4k/xRrTbqAx4htvnCufXYnFUglHsM27wz1oRlldrqSGJ454Ov
	RqgiQUv5zizPIcvu2U+EWmjiF99gSCPsliUDeBCL5sIQLxcCSbh/9wMDIBJTJgSxEkiT6HKFb4r
	3Y/21oveV/8n0AtS3QpAjFu1mOJ2H7zBH+Y3wWVOH3uBVwU/s5Q5OGihJlz4MOs7zXdyeDGFLs9
	a8ru7MPh90a751JMzQ+V41iPHFPkN1v9vayI/VELCIlcGmMnWb+ep8owLUhhZci2O9QHUbgcOQk
	X4hB6zQ9ga0BiHCGWgPFjigxTDCt4TStXANrYu9TxqHEIVVbQcmiv0PiYOHkLymizFweS7ic3So
	fz+1UA8yJdWYiYUW0ypB9I+j+gBbb5haJPFq2Xs1FhUWQJHB2XpvQ4uu/vbucmYzmzGYpMnULyI
	Qbgg==
X-Received: by 2002:a05:6a21:4784:b0:3c3:990b:2292 with SMTP id adf61e73a8af0-3c67dfe6723mr1497205637.57.1784970491169;
        Sat, 25 Jul 2026 02:08:11 -0700 (PDT)
Received: from PC.. ([103.172.209.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc447f6bsm9198169eec.12.2026.07.25.02.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 02:08:10 -0700 (PDT)
From: Mohit Mishra <mishraloopmohit@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mohit Mishra <mishraloopmohit@gmail.com>
Subject: [PATCH v2 2/2] staging: sm750fb: Remove unused function sm750_enable_dma
Date: Sat, 25 Jul 2026 14:37:49 +0530
Message-ID: <20260725090750.113598-2-mishraloopmohit@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725090750.113598-1-mishraloopmohit@gmail.com>
References: <20260725090750.113598-1-mishraloopmohit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function sm750_enable_dma is defined in ddk750_power.c and declared
in ddk750_power.h, but it is not called anywhere in the driver.

Remove the unused definition and declaration.

This addresses the first task in the drivers/staging/sm750fb/TODO list:
"- refine the code and remove unused code".

Signed-off-by: Mohit Mishra <mishraloopmohit@gmail.com>
---
v2: Remove double blank line flagged by checkpatch -f (Dan Carpenter).

 drivers/staging/sm750fb/ddk750_power.c | 14 --------------
 drivers/staging/sm750fb/ddk750_power.h |  5 -----
 2 files changed, 19 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index 36fde3bcf1b7..59ded1163052 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -89,20 +89,6 @@ void sm750_enable_2d_engine(unsigned int enable)
 	sm750_set_current_gate(gate);
 }
 
-void sm750_enable_dma(unsigned int enable)
-{
-	u32 gate;
-
-	/* Enable DMA Gate */
-	gate = peek32(CURRENT_GATE);
-	if (enable)
-		gate |= CURRENT_GATE_DMA;
-	else
-		gate &= ~CURRENT_GATE_DMA;
-
-	sm750_set_current_gate(gate);
-}
-
 /*
  * This function enable/disable the GPIO Engine
  */
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index 1c4f054d7276..0c4ab2120385 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -23,11 +23,6 @@ void sm750_set_current_gate(unsigned int gate);
  */
 void sm750_enable_2d_engine(unsigned int enable);
 
-/*
- * This function enable/disable the DMA Engine
- */
-void sm750_enable_dma(unsigned int enable);
-
 /*
  * This function enable/disable the GPIO Engine
  */
-- 
2.43.0


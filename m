Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DD0522681
	for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790117605; cv=none; b=UacGsmXScOdPfcAoNI4yEyT8GGlt+s9Iu5llYSa7OKkwQJkMjWQnlzdqyToHqhxx52DQOIVt1Yjs1Ig259LMpOFmXpbUg4je+6OxSxnuxPl2n4WquJ3X+DjEQFyE39KP2K4TR1A1MzzDqM/VfqmiiPCBhzfXhp1lvm2H2iPoNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790117605; c=relaxed/simple;
	bh=REPZkL1thDeVzHCspF0PHUx7OtBPKunpJ9Mv1lOEFOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yqtxh/tYoBIK7ljst+7c0Y7A2o4L7sFyTTgTGQ0HD5nxQQTZYAltT27OnBlPznGymCWoqiqRDaJVyvZEUIyQ5cf9kZXhJOPOa7odFWzXqqViR+UyZ2J7URmhisznfPOvAel5P+KPQDBcuzJdalF3OCfuUfUggqBhAfeLPwpNnkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/2pnnZr; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/2pnnZr"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccbd478cso250816fac.0
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 15:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790117597; x=1790722397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GdRvNmdqEASsHQpM6tI7sJS6Hgv3J1YdSsDajcpZjZY=;
        b=p/2pnnZrvOpzuCFbX20buIc4/Ox7GFkW5SUErBAAYyrJB7LsIAkXl5hLbatsd7ag73
         C7NbV4TIdIw54tlynmm/Zee9k7N4fswmfEzybeVUT+lvzGnRiP6XJUfOa7UwhioQ3irD
         YdoLhwSQ2pUJIE5EyXCzAfML6OsXvauSKy5Iq++GnbjQXc/ncHnsYsbQinpDyfBjVLb9
         PPUaOjq5zw7G8IjxPvXD64lel7L4ST+WNOieX+cH802/w0d5iIPwLgOCsw0r6LSc3Aad
         SRb4KJXOTvqOjjr62xlRRo7AtsQsRg0tpz6o6yofhDaRWszG6wedarrIDIkc0QZgCzyY
         Zs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790117597; x=1790722397;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GdRvNmdqEASsHQpM6tI7sJS6Hgv3J1YdSsDajcpZjZY=;
        b=z9Hg/0/pVxORVXWXLXwxFuow378fXSsbNg2WdK4C6xdKf6xCgZRaU1YHwF1zeAd+O3
         E4hToHxZj0xOSLDyYENoVk/xzGs8tFYyDNANnpjCAlP+3T2CLSqDmlxYpXaL4kmj0Llt
         p54PpyM4wbT1vXpFSMBIXSMlSfE68OfZ8QgmVBB9ZKX35nJUO+vUaF5BVgMp7hexgmVM
         lwT77rF/2ysv47JD+jGR0CCzYeRH4V76jpCSll3O8Mx/RbT/bPfP3FmEeLbcHl76lACE
         b143u6bw2rFRptUUzURvGbMxViB3KnaNdcOspRLI2VPkk6Tx2IvpQZOKMCN4Ab+6hnig
         Xg5A==
X-Gm-Message-State: AFuF++nGuoUxl8AuVQzaoi9EY5/zYuYF9/cGSHFrtKh+96CgSfdsyb0I
	g8fsLGRm821puF0OSEnwJ9wvw75kf2VTxlTeVXfwCxkokg1NHlAA3+fh
X-Gm-Gg: AYBFou2zNDrZ06Nn6qh+ssQlwoZXikFNTOR9r9S0cMFNG6iv1hCGqJEd2yhdoEn6vfI
	SCK48Qj3X2158gbVIaVkc28A/QhxX6uxW3VCf/sLO+qsAf5pEvd9TD/nDrb1tflTDg56/ApF0Qo
	a0dToBdiBNnhBct6BYt00ZLzMyrgYZbIxA/ZxDBU4rS4+1gwg/fN9luLqOWO7Lr6PzEpNChS3y9
	DHvkJgX7fIWfXdWEurtwMeA1/35rNSX5JtOh+0s/LSkm61eIxw0Aq1Vhycvu5zdvQeExPKNi0Yq
	goiPgIZmoTb6akNx18J9UfN28lpm8v7FTaWsKNxJsyZwUq4/CpaKUB0oS3nknGsBHcfo6xoNfwb
	MNrFSs1B4EVWW/RNQ7WOVWRDtNOCOTB6iUeZWIS7VFiFlenMMVQxyqON+uyEbzkX+rI3jw61pQ2
	PD7cM+dlgbPdOGGTd02OPopfHFImo2/6JcRL+PWuvukAB6pdaWCl0Xz9L/6k6txeRFfI5TvvkBO
	36pVD7mK6TcLt3HDE7VErnB
X-Received: by 2002:a05:6870:658d:b0:47d:7ee6:98da with SMTP id 586e51a60fabf-490891d5ca1mr994227fac.8.1790117597104;
        Tue, 22 Sep 2026 15:53:17 -0700 (PDT)
Received: from Arch ([201.110.78.131])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4908e66112asm869709fac.9.2026.09.22.15.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:53:16 -0700 (PDT)
From: =?UTF-8?q?I=C3=B1aki=20Sobera=20Sotomayor?= <inakisobera8@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?I=C3=B1aki=20Sobera=20Sotomayor?= <inakisobera8@gmail.com>
Subject: [PATCH] staging: sm750fb: mark g_fbmode as const
Date: Tue, 22 Sep 2026 16:55:01 -0600
Message-ID: <20260922225501.1792665-1-inakisobera8@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The g_fbmode array of pointers is only used during module initialization
to parse display options and is never modified. Marking both the pointers
and the array const allows the compiler to place it in .rodata, which
avoids accidental modifications and cleans up a checkpatch warning.

Signed-off-by: Iñaki Sobera Sotomayor <inakisobera8@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8b93bfeb2..c3f391cdd 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -12,7 +12,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel __ro_after_init;
 static int g_nomtrr __ro_after_init;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview __ro_after_init;
-- 
2.55.0


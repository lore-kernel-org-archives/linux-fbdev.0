Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20476298CAB
	for <linux-fbdev@vger.kernel.org>; Sun, 31 May 2026 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236217; cv=none; b=PR0PeLlruNHpOoPBDz880TS6PKJiyxFyR8wq8Jfvqk1Nx8i8gzirjM1byiKxKGLX1shYGnVcOBLt/1WI944QQpRQKvxwZfYgDM2sWpUi4mgbPXq+ZTbcWCL2tsjtMcsU7yNbB/fpeKWMt1LbPtx/ZsHLWy3HPpW8oQxhOnjAObU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236217; c=relaxed/simple;
	bh=6KxXEU4mM4Etl4EqYEr6dcFBIew34rXPGITTvbtaPVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UV2RBTkGnGB7zgKIpyfTBS8G4WC7Pa/KlLBHdV5AuQwpqDCk4XlslbU/w97EBBcC65XG6YgzUSP6AnwO4io8VWV8f1/kLsEreW0Rc/I75J78GRjZLpUopYh+nCDBY5rwSI9SxBFYs1ORH3SuJlPhsF/8WduiyuP60UppENmjlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gbo4U12o; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnbBwGwe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gbo4U12o";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnbBwGwe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780236215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oXRHDWuf7kdsdZ+4dW4PM86Io+i5QtdP1dIiEDt0g1c=;
	b=Gbo4U12ozvjN5631d+8vuEcs1K6QrmdGdqKlnP2YaVYU9i/Vfm5PbIaMe8H+D5FzBc5DV3
	cPUI7lDu7gDxt4iqHbo2KYu2sbbfaw6N5BulWV1mIqSUjmEc6PDeO7VXiGbq0gGQ7ddhZ9
	n5riMSYCjOcAkU+I2bJwpeodW73gD+Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-gpM25ldpPPe0pWSKeyE5Nw-1; Sun, 31 May 2026 10:03:33 -0400
X-MC-Unique: gpM25ldpPPe0pWSKeyE5Nw-1
X-Mimecast-MFC-AGG-ID: gpM25ldpPPe0pWSKeyE5Nw_1780236213
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-914aa174c3aso1681854485a.2
        for <linux-fbdev@vger.kernel.org>; Sun, 31 May 2026 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780236213; x=1780841013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oXRHDWuf7kdsdZ+4dW4PM86Io+i5QtdP1dIiEDt0g1c=;
        b=SnbBwGwech0hsYmnDRbtZVqTJNiZBh2j5lAyLQMUeo9pm02eRDC+eIylCBPrMHMEnJ
         3hYA4nMc6w7YQyu3xHJODejYhimTIEsz6Q22qozG9n07dIJqzJGzI2dNjMiD9l1//yb6
         y2e8y2HQk9aveqLxWx1ttdKvZNZgfOvk2XrrB+UEvaaimrUVUIG0szjba8hBh987up9g
         Nn2oEAB46AUg2V8Q5CRRTkyxutNY04IfnsK8kiiW2ucFd4j7f2Q3UPPGnBVMCaLGpeI6
         +5+jTZFA8SkD/FSIr6k8nyd4ytw/49QITT25uFT0uKeD8J9ZiUS5zGC2cxgJpZNJVkU8
         j0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780236213; x=1780841013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXRHDWuf7kdsdZ+4dW4PM86Io+i5QtdP1dIiEDt0g1c=;
        b=hPrQ1WR2VShT31/SrZGCt7VpYyooDScRpBUDPDEKYOWOStAKIW70qpPbWXa6Vngfln
         t7xWkKh1mitDi29nCksXKElWlTzWc5yhktCEqB98fpDc9q6Y5n+DfnbSyz8Sy6AU8no/
         kCJqzNAsDI8SBNIeXQI0bPb5WTDYZUC1dyU4km3lzZT44VbwIpvjvPhDHsl96v7HCVOx
         lMUQ/tEUHHd/R5Pg1P3zSZ1WNPMdCiLmZxY/lChVs7UJzOsakNtrUfTj4Pm1jal5t07u
         4dkTfvLBiVnqdh4r1YviPwE+SZHXbOo3QKhkzU65Kh/8Z/QyLWRLvhTsfKydaEGCWuGh
         jSAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ziVcWaG0c9QLMiXp9OnSVwFodu3CtVZeV2calMazTxaTw4CNkgxhio8Ed5hqPHPqrUMmdC+RAUMq55A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ZbzqFvJux1vnSVaG7F1ABLwh/JTDm7XlE1eqZhQJwbyTGtze
	r5hQrlxTjTbGkjxCTam1AlsMp9VpLOKn6rJy6rx5bzR2pTzJ8UcfKtCdeprti32ujwjyy/7vwYs
	Oc2f9kADDNLTNO1PKf0u78Y1BllnTCCIFa82K7Iza1Ib7Dyb6pE5h1VEcSoMitCdH
X-Gm-Gg: Acq92OG1Kpn19OzXNvsio7FxSqCEwppefob4uhd9YtLHLDhQcqxO8mY05FawfnYiYKY
	RUb6+lG1hbEbZ+TVIxvZ0Fm7oXaSJlloiDEK4XSOBlV2jWSoxBI267XpVY72BB6IBNKPNFX5vMk
	8HxmSJT8ilRcOS2PAlnyzJSsNqcuVf2F2u7VGJBeFv9Q7Rsad4qfgytAkrfQrd3YgOcvlUYeM1m
	EDw505G2xh6YIDzm0/Nyzd1MCUXZT6kFjf7zgfVvw8+818iBR658JB9zCEeMEYu8M42O6oUJq8F
	KfLjuAxKER4fqNTtkugJi+eR/e+2IvF3G7a8akVB0YflAhyk5rdyDMK5A/LwBRYnhjV769+2Bd0
	KT+PFWDYZ6rY/Q5evhC664tqDDA2bxx2GZZ8rC46Q50qh3A==
X-Received: by 2002:a05:620a:458f:b0:911:9e67:44cb with SMTP id af79cd13be357-9153d9f5e56mr1146957685a.38.1780236213062;
        Sun, 31 May 2026 07:03:33 -0700 (PDT)
X-Received: by 2002:a05:620a:458f:b0:911:9e67:44cb with SMTP id af79cd13be357-9153d9f5e56mr1146953685a.38.1780236212601;
        Sun, 31 May 2026 07:03:32 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153249a5fbsm799732285a.20.2026.05.31.07.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 07:03:31 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-omap@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v1] docs: omap/dss: Fix stale modedb.c path
Date: Sun, 31 May 2026 17:03:22 +0300
Message-ID: <20260531140325.4115024-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The modedb.c file was moved from drivers/video/ to
drivers/video/fbdev/core/. Update the reference.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/arch/arm/omap/dss.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/arm/omap/dss.rst b/Documentation/arch/arm/omap/dss.rst
index a40c4d9c717a..9d39679235a3 100644
--- a/Documentation/arch/arm/omap/dss.rst
+++ b/Documentation/arch/arm/omap/dss.rst
@@ -314,7 +314,7 @@ Kernel boot arguments
 
 omapfb.mode=<display>:<mode>[,...]
 	- Default video mode for specified displays. For example,
-	  "dvi:800x400MR-24@60".  See drivers/video/modedb.c.
+	  "dvi:800x400MR-24@60".  See drivers/video/fbdev/core/modedb.c.
 	  There are also two special modes: "pal" and "ntsc" that
 	  can be used to tv out.
 
-- 
2.53.0


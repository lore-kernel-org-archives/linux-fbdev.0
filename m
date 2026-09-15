Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89BF2EB0F
	for <linux-fbdev@vger.kernel.org>; Tue, 15 Sep 2026 00:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789432729; cv=none; b=jo71PkQHmSWoXbcaw3tWzGkObFzzFRNwRwemdv9GqU9h+jUmiJAmd2yXcTk603yevnuyNgsTBSiow676/ATjds6XYkJV95O+Y+ZzZHdfZAt1fr62VqNbRFIvr9cnOI4te0UZGNxxl6o+vKcw4lAs/g4tMeivOnFnIcg6qsDLCBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789432729; c=relaxed/simple;
	bh=BuLaE65NQ9rrIR9C05ul8QhLWBqr+NJQ6N3lBPZiaD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EnO2NbmELUc/jTQwCkvF5tNea2ppJHw42V7Jxmj2GlupWeuJZuuvGitUgMICvbqTsyuCvkX3mwsvdgvzMUVxUQkbenRSdOz+jUeSD0KVns5n7pYLd+kir6kF/ToQ04pgMZIXuchK0aBiAI1/0V/i//FfZi4+2yo5/+fEIAgFcYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2kReCan; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2kReCan"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-939b5ded99dso390139585a.2
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 17:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789432726; x=1790037526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CB0/Ut2q4k6domqU+GFMH7n96krlT2PxA2EBOCoxQxI=;
        b=B2kReCanmIf2GovD6npMm99pPlABNXNmEsT80e+qcEd5T58h52IrDNrcqrvivHSbwG
         rjz2TXk/xGWHf9iFq11fkRiead3u0ftLH5cR66K/qdJpb+F5jSM7roMl2hHvc3dCvTQa
         ronFLgrv9seRY5vAEAXWUKZ4hTOYxd6o5Bkf409QGm5Yd5Q7eQAo/adfRqQlU+I9k0oq
         sHIzpRyFadgl/H3po1uowSO00nBOdXm9FFRJmzZQxtBKgEqWLstGqd6hYtcmeZyKjV0j
         ZVawRqKGVVcA+va4jBee9FhRzCvmZSI+6eNXEg5cLfasKbgQo7CUsNB2qXWYWPKwb6oP
         2MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789432726; x=1790037526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CB0/Ut2q4k6domqU+GFMH7n96krlT2PxA2EBOCoxQxI=;
        b=IaA1IYZsDgfY9QP/XuevnuDVGq1LL0RPZGOWEFyIZnVlmNKF2KpR7zqpc7YEArqpIk
         N3i8mWlRrk93RreNTEjo3EKMAolEDxmnhttLJ45qWjdCw7BNO7oBTZ7Ej4vPupG3/zmw
         CdQL8cjeBVIyjOdkdB7t3OQIy3ESdeQZzvGO+AoI1pPiOMUAD1uwtfHwN6mYCoLX1W0k
         IJOkUa4lfCf0ysmb+2eWj+jesKomzXfCJVDptqHwp7RacNMirxSpYbjpP6d5hAxQSG+8
         9esBKffxbHvT//vYrzcXakGWenboI/p0p2zIi8MBrDN0+CdvecdiMtd6gNbxtV7Oe5e8
         qn0g==
X-Gm-Message-State: AFuF++nZmnmQhTcxuWLoDamT+oPxbRh5tTuTf1jIktwniSuxRt0zrhng
	/AciI9KMQzl/R9PqJretOQhEtnClGYl/kHgCh4Aq/Mi/GxYphyRzzr4s+biSmSE=
X-Gm-Gg: AYBFou0c7CpgTQO8Ew0WbmIdfj5GajZOzt4tOBN4XVgPk4sV+R2dToyUZyQkCeUhvKx
	6CzRkKmTqJ/ymYke05R26+KYDUWSUv2jOYvKq0Q3zos3g9tKeB4zvjEAKE7MfdiejS4TI/mIYxG
	At3ztuDLeFTU3JpHussSiPdUucX5V1SZt3BzAE7keHBPkYsSuCujvLtS/NBS2utg37DYuJeahS6
	WiHZ+ZqMeOJ55GDT5VFnXNx7buSs2fkNoFaKovB6pByeN0R+kow2l1AmiqXSSDBqXOEZrThbmLi
	x+WY+0x5xHzxBdNYipX2EyjPvEDM5lsK1K5gx4BOLeVW2IQzvE0/sNqrjinLwsJCb3utrRBN4v8
	4NTbvo3MXxOQrclD8wMwM8TQ55GVf0GWgzVP54Imos4NmVj9nbBadYsD4nLbThTAy5SJ1gp+Di3
	upW5/pIaV3WYTT/2Up6z4lwwV+zNoDzO/9lrDG4Lxf7ml1cgrJm3xbWWE//gbCknsEFQ/D/+zkk
	A3kfjy2fh18rn76Twa/HjGZ9uTAk1APF1i+t9P58mZ9at3AvGykSFeFTYlUgjoCRxcDHbHt6/eD
	qB5WUCRcyFCUvDnvUY8my05He9KM7T0Z78WGXSYtUhJ/+US2cEOPKMB2ZVy23lUqSeVGjDNT4Nz
	fa60p
X-Received: by 2002:a05:620a:890e:b0:939:710:536c with SMTP id af79cd13be357-93a29a11d43mr657586485a.43.1789432726516;
        Mon, 14 Sep 2026 17:38:46 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a2db5f257sm247664885a.17.2026.09.14.17.38.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 17:38:45 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: gxt4500: Release WC setup on probe failure
Date: Mon, 14 Sep 2026 20:38:34 -0400
Message-ID: <20260915003834.49715-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gxt4500_probe() adds a write-combining range before allocating the cmap
and registering the framebuffer. If a later step fails, the range is
not released. Add the missing cleanup before unmapping the framebuffer,
matching the successful remove path.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 38fc4d45fae5 ("gxt4500: Use arch_phys_wc_* for framebuffer")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/fbdev/gxt4500.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/gxt4500.c b/drivers/video/fbdev/gxt4500.c
--- a/drivers/video/fbdev/gxt4500.c
+++ b/drivers/video/fbdev/gxt4500.c
@@ -719,6 +719,7 @@ static int gxt4500_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
  err_free_cmap:
 	fb_dealloc_cmap(&info->cmap);
  err_unmap_all:
+	arch_phys_wc_del(par->wc_cookie);
 	iounmap(info->screen_base);
  err_unmap_regs:
 	iounmap(par->regs);
-- 
2.51.0

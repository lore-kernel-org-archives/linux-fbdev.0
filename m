Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CCE13C9C4
	for <linux-fbdev@vger.kernel.org>; Mon, 20 Apr 2026 05:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776662372; cv=none; b=IWov4vBT/08upTumaXWFiNNb8fJ9fXxni+g3pXLW8/lihaLBdDNiPlrxIGDynjiH27Ic+/R+NtbRuTRH4BFOcDcJ1tfKGssDjA4bQMifuQtsKB9Iff9uj9iTapNchfNSRjRTBo5kdmcU25BdjOOmhljpKqeeJ2JYHaOKS1oZPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776662372; c=relaxed/simple;
	bh=8kg6S8DHulB7fNhWP6eFQ6wLGKro9ckhhdhLO6BIo24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/ixebk+EfNOpY28ciUHSMfXap6HLVBCtxGaAhqYc2VRI4UNbSy/hMhP2msjR/QBaPYgr9IbxYU2ab1NrmNqlWXWTIO+SPTHlRfcHm7usmo63rVZvVKpXBLYU1fB6j6eFkw6+g7NAjlnSg4irHOhImKR47ABR+ZlDV3ONS/+BMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noEHpEYQ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noEHpEYQ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cfd122d78fso426144185a.3
        for <linux-fbdev@vger.kernel.org>; Sun, 19 Apr 2026 22:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776662369; x=1777267169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVBsgs/Wk3x8UxkibJW5Haz8zZ0ewkla2R+/4mLmWr8=;
        b=noEHpEYQsNSyox39H81xVN2gdmBhds0+C6WYPl+Z6HLNFSc57C7CFxneAMUfgPyiwJ
         2mvEnlFQ7UoQlm9Fu6MMPAMC8fXOo197CFhs7dE18hjQIbOeZkGixZfytfWp2VbOCiP7
         F++cxXQK3up1L2ufyfBj7ZyaOChEWhebBKmwDgdeIHQunraKfgC0w+kpCfoi0uow5TuZ
         QzM4cwFEDymrJ0VhXFz2j9lnEearryQFR+XlYmGpXwDm9D24/DzFFR16qFyK/uX5OlwL
         yklpQoVFAVvdYhyk3W8FUCBTEkF7M4zyAj2ii75KL5o6iddwvijeMxg4qMrw8Sbe8kFx
         dJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776662369; x=1777267169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVBsgs/Wk3x8UxkibJW5Haz8zZ0ewkla2R+/4mLmWr8=;
        b=ZT7L7wMmWUoe9Cw5Ec4tDxAS8V1aKZa6DmKlpe8T3Vdrs4mXM+mN+9iL1z+KOzIAsb
         ax5laGu/NjW+yLsiVkkeEHYi0g/n/D/okdLNDEhF5j2qOo1c9ZHff8BwDufntBVo1fmG
         KpUULcXAZceAhbgsF9PfLuUgBNEbiRzAHsiF41WbNbQNdllKJAZ/uN2DngbXNChlnKL0
         M7SSlcNC3O50mUatRAQKQ7f7FZi58KvY3OnAPRey0opzRCkYRANn0X5akRbgQ7LMEGq5
         cfzB0Ekdm0pkRQTxKd7zNfdxijNwaYyCK2Mtg+FYQVACgEIWkg7wAMNFRjq0N8ZraH5C
         m/Gw==
X-Forwarded-Encrypted: i=1; AFNElJ+v8XFlv7kqAQE1A6fHd8gV/wa7EeUFAiRqMwO3LY9e8QaDFHBX4UH4EjRMuqlfXRUaAaEPQRdk5l4yPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJe3C9WA0neNm8he44f6o2kStqR6/dJstoa7j9UOE+amnq4KYR
	Ct+56YNOegkV6DJeGG6V4ubUavCvCnUuA+SQS/0hO38DgYw97YSTTxQr
X-Gm-Gg: AeBDietxtl5Q0GaD4K/mi6mxsxSr/YVTIm/kwqunWrHJpqgD+jA8bf4hIgARMvDmBWh
	1dBfr2qUoay0lGwgad2zoyiA8jr/mTw+AjBwXIb8n3q1ftmSAIlXhP+4R8M5CbDajjs/gdsLNJe
	OVuezknxrOUG7k27EmLoEytZoD/SKT1TM1+CCLk+aAAuQnUM+83oG4zlEY2AEiEtrCps0s4Iv60
	GRrYp/eEmMGviQp8+79ZoVRO1kxT51Ral4BLsQHmGwVd8A64LzMw+mxZ4w0Ak0R0bvVnxgg75pB
	kbyoySdz3Niz7edlsyIC3q2LkHFa1qlxtVj2ewMSZb6B8lzOLz6tdYhR8ziHRImLHLQ1h4FTaJX
	quZMMyWPU8etTbOxgd2f/STy0P14FDkwqt8UsIuBSaPtbxnjkjD1XvXepSYrpSMu1u5peJY+x03
	Pkfc3YdhfDkUifmvRHOnLPkQkaKO0h66LCYxSiNbD/xxrun1akRz6RKV/Y7BQ=
X-Received: by 2002:a05:620a:2913:b0:8cd:94f9:1bb1 with SMTP id af79cd13be357-8e79010e10emr1688870285a.27.1776662368751;
        Sun, 19 Apr 2026 22:19:28 -0700 (PDT)
Received: from localhost.localdomain ([165.85.38.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d99c3c17sm726161485a.45.2026.04.19.22.19.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Apr 2026 22:19:28 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Antonino Daplas <adaplas@gmail.com>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Taegyu Kim <tmk5904@psu.edu>,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] fbdev: savage: fix probe-path EDID cleanup leaks
Date: Mon, 20 Apr 2026 01:19:26 -0400
Message-ID: <20260420051926.28276-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_FB_SAVAGE_I2C is enabled, savagefb_probe() can build both an
EDID-derived monspecs.modedb and a modelist from it before later
failing.

The normal success path frees monspecs.modedb after the initial mode
selection, but the probe error path only deletes the I2C busses and
misses the EDID-derived allocations.

Free both the modelist and monspecs.modedb on the failed: unwind path.

Co-developed-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/video/fbdev/savage/savagefb_driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index ac41f8f37589f..c2f79357c8da0 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -2322,6 +2322,8 @@ static int savagefb_probe(struct pci_dev *dev, const struct pci_device_id *id)
  failed:
 #ifdef CONFIG_FB_SAVAGE_I2C
 	savagefb_delete_i2c_busses(info);
+	fb_destroy_modelist(&info->modelist);
+	fb_destroy_modedb(info->monspecs.modedb);
 #endif
 	fb_alloc_cmap(&info->cmap, 0, 0);
 	savage_unmap_video(info);
-- 
2.50.1 (Apple Git-155)


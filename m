Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1498A17BA2
	for <linux-fbdev@vger.kernel.org>; Sun,  7 Dec 2025 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765092416; cv=none; b=Y/RsgQeeg8RVWB2wFp/DpCjJZ0eBUWtpukr9qGiHxQ/OUzC56p+ka9QCtTaFZxOhFCxTdX1YwiTnA0KZUqWBlqhQ6EM4jQzaFnkmp6Ho2WCwcILKQl33/yMTAJWtlO1LKdWwhJz6mrEjF4vmIhyOZiKuKBgvgxX9/9TgKnn/maM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765092416; c=relaxed/simple;
	bh=fckAhuubTKdSBsK2F15HzWXj7qefxnBiIDefELE4Skw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFs01/TFNWfCiD10LWY+6rtMtBdP9QFzYDjAFM+YTdOgAK6CrH2KYkv7RGt9n16jzPbJeFpxpwdRUtdAQY8bg4YjmEfvTI9a1zqCbl1y0naJAEetiAi8umCODMo6I38A4btq0uZySn6Z1L6qv7yEsWfo0AueSPIZH8Y0MiEc7Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/AwJVlt; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/AwJVlt"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297dd95ffe4so31430655ad.3
        for <linux-fbdev@vger.kernel.org>; Sat, 06 Dec 2025 23:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765092414; x=1765697214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tEK2eF1M99CkbnJ4lJKZbSTlkLnJNDGKuxnzg8A0N00=;
        b=Z/AwJVlt7wq5NIwWY9hvhrC3pZKm/ptN8wpeuo7qO/q+j0kQl3S3DgYV3dYV1TzdKd
         BEWE7ypnnAsrzYFH6X9Z1H4cPvspE4GdsQtn7iY9IAVB2ERH6FMfGwzUQsMhAjdZ0jBB
         fKAZnxINeS6yVa9+BIDzmHWwMfk8+oePmdbZHcEGdWD6MgrKpOuy6litUXHNOSxBDWPV
         4IsgcUPPPtxWMTAOJbWIP9YN7X+fnOMR30yJwYRU/0U5agpyDixncfPhaROxmqkcio7d
         T+KXE+L+jVTrTP8BGsO/tjI+Jttj7993IKxfWxsv+TjPiUz/ezB2y1FEqFQzJWAF7xlO
         3cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765092414; x=1765697214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEK2eF1M99CkbnJ4lJKZbSTlkLnJNDGKuxnzg8A0N00=;
        b=ic+OxqNP6OAtrUckW++yxqH4qxttsaw0VTVg7AbLsPO7H0MflHB8itDL0oghlX+uJY
         joVSPjdFVfgKx3/o/8fW9SPQGhBDOGVaQkDTq5e7PeHX9Sxz2VVp5gqztfvwdV0YIywb
         vHZQWBP6urvyplZTjSWgrIgvI73TNdRCywcTuzrhxqVoQ/Vixzu1WtYjbtVQKtQ4SdgL
         rtPTcwsXlGNLtU2BWc5/HC448MoUPvz/9wompFx4mpUZLvbeQ7jKa3eSxk3MoMmbfMWN
         SsUEVmWJE6oOLNHNF0VkvXaGD7v2WqVG3j0xULsJrH+aKQ+Tn1l/XvqF5Da2qWK56CTB
         N7og==
X-Forwarded-Encrypted: i=1; AJvYcCXqPsMotfENe+p/2IyAADnNgLI0RI+Zq0OHyMdRjZUVKK6jfjKHXZYqrm9NvzY2SntulejqBCef+Wvqkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6xv06ZYp0kBr/Uh95ifH2rO85D8OyieW4U+WHhin+ApKI3iU
	O+6rlMVqZafy5zfI5ygswnjXOMvx4OrYFLris89U2pCpbAn7xyJOX5Vh
X-Gm-Gg: ASbGncsb7lBau/rMe40lT3he8m8X+JSAOBUEDU8pfOz6dh6KV4mp+dcAmX6STtVu5UP
	AyTP1qUmYosRXmSFJgT+P0VN3sbkpKLIbEXV8ipKm87R3ZIFeYTZWRDY1n9QojLsnAkh6o+WzZh
	xFMsApsByRVzf29kDAO2o1lfvOy0iInfgHDULK82p6Oeb4N77/gP06+beX1rqEHeCmka9akWZ4/
	IwdgCX6lYnviRCevKul26KMy0dOTH2Kt7e3vtCi7njq+GIc6yDspZ8POIr+RLf0EEwFxvoqEusv
	vH7++haKY5gGViWQ2rUt8TgQpwPNeB74ufMD32mfpkG0SHhhlu/2E802Lpg9LNIhqG1LvKj4Ya7
	a1lLGhJDqioahe/lOPqLPGugfRMPnFHFH0RyeOxtzrYlPnCPGG0yO0BtPXJnB0BcHQst56jTgFn
	1/U+WKd6FbgA==
X-Google-Smtp-Source: AGHT+IFZ1X99wA8hRN/ZGpHPSkBafJxesyhbybcnYCATbgOcM4F6190itrl1yOrpl2KdPdZRHijNHA==
X-Received: by 2002:a17:903:2381:b0:299:fc47:d7d7 with SMTP id d9443c01a7336-29df579eb2emr38062925ad.3.1765092414366;
        Sat, 06 Dec 2025 23:26:54 -0800 (PST)
Received: from lgs.. ([101.76.246.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaabf8asm90338325ad.85.2025.12.06.23.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 23:26:53 -0800 (PST)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Antonino Daplas <adaplas@gmail.com>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] riva/fbdev: fix divide error in nv3_arb()
Date: Sun,  7 Dec 2025 15:25:32 +0800
Message-ID: <20251207072532.518547-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A userspace program can trigger the RIVA NV3 arbitration code by
calling the FBIOPUT_VSCREENINFO ioctl on /dev/fb*. When doing so,
the driver recomputes FIFO arbitration parameters in nv3_arb(), using
state->mclk_khz (derived from the PRAMDAC MCLK PLL) as a divisor
without validating it first.

In a normal setup, state->mclk_khz is provided by the real hardware
and is non-zero. However, an attacker can construct a malicious or
misconfigured device (e.g. a crafted/emulated PCI device) that exposes
a bogus PLL configuration, causing state->mclk_khz to become zero.
Once nv3_get_param() calls nv3_arb(), the division by state->mclk_khz in
the gns calculation causes a divide error and crashes the kernel.

Fix this by checking whether state->mclk_khz is zero and bailing out before doing the division.

The following log reveals it:

rivafb: setting virtual Y resolution to 2184
divide error: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 2187 Comm: syz-executor.0 Not tainted 5.18.0-rc1+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:nv3_arb drivers/video/fbdev/riva/riva_hw.c:439 [inline]
RIP: 0010:nv3_get_param+0x3ab/0x13b0 drivers/video/fbdev/riva/riva_hw.c:546
Code: c1 e8 03 42 0f b6 14 38 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 b7 0e 00 00 41 8b 46 18 01 d8 69 c0 40 42 0f 00 99 <41> f7 fc 48 63 c8 4c 89 e8 48 c1 e8 03 42 0f b6 14 38 4c 89 e8 83
RSP: 0018:ffff888013b2f318 EFLAGS: 00010206
RAX: 0000000001d905c0 RBX: 0000000000000016 RCX: 0000000000040000
RDX: 0000000000000000 RSI: 0000000000000080 RDI: ffff888013b2f6f0
RBP: 0000000000000002 R08: ffffffff82226288 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888013b2f4d8 R14: ffff888013b2f6d8 R15: dffffc0000000000
Call Trace:
  nv3CalcArbitration.constprop.0+0x255/0x460 drivers/video/fbdev/riva/riva_hw.c:603
  nv3UpdateArbitrationSettings drivers/video/fbdev/riva/riva_hw.c:637 [inline]
  CalcStateExt+0x447/0x1b90 drivers/video/fbdev/riva/riva_hw.c:1246
  riva_load_video_mode+0x8a9/0xea0 drivers/video/fbdev/riva/fbdev.c:779
  rivafb_set_par+0xc0/0x5f0 drivers/video/fbdev/riva/fbdev.c:1196
  fb_set_var+0x604/0xeb0 drivers/video/fbdev/core/fbmem.c:1033
  do_fb_ioctl+0x234/0x670 drivers/video/fbdev/core/fbmem.c:1109
  fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1188
  __x64_sys_ioctl+0x122/0x190 fs/ioctl.c:856

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/video/fbdev/riva/riva_hw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/riva/riva_hw.c b/drivers/video/fbdev/riva/riva_hw.c
index 8b829b720064..d70c6c4d28e8 100644
--- a/drivers/video/fbdev/riva/riva_hw.c
+++ b/drivers/video/fbdev/riva/riva_hw.c
@@ -436,6 +436,9 @@ static char nv3_arb(nv3_fifo_info * res_info, nv3_sim_state * state,  nv3_arb_in
     vmisses = 2;
     eburst_size = state->memory_width * 1;
     mburst_size = 32;
+	if (!state->mclk_khz)
+		return (0);
+
     gns = 1000000 * (gmisses*state->mem_page_miss + state->mem_latency)/state->mclk_khz;
     ainfo->by_gfacc = gns*ainfo->gdrain_rate/1000000;
     ainfo->wcmocc = 0;
-- 
2.43.0


Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6352D6E4B
	for <linux-fbdev@vger.kernel.org>; Sun,  8 Feb 2026 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770573505; cv=none; b=MyEwdoHSv699xsyb2e1mFN33NInlHYqi+rgRPOcdGc1cI9VHAvdleiIq38DfXH04NFFK75rlv6jP1k6gChDlcVNOgQeTQqrhT5pRMd2TUkt78DH6SN+dRF7bVlqG15wApwWR18Mfj4pHj1U4V+rD6zrISNcsgXznBPHkoex5yCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770573505; c=relaxed/simple;
	bh=W2NuPR6ntya68Cnkaanj4tYTUVC5lDpyIcGnbNzU+tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ip0fkWdawlUXOdcfWralctaEybM9J6c9zyfRjFnPCuuLcHABUz6L0KDGe2E1ALGWo8HJF73XNEb9lNdDld05/4+rVorG/9QVOrVL8H1aB2hLmKQZyu/Uccw+zOogsqrd27Pof6BVARWykWENKCXlu2W0HI2R4QpQWBz32eVC3rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0/1Ej+bg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0/1Ej+bg"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so51976285e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 08 Feb 2026 09:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770573503; x=1771178303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xgsxpv+tOpJi9iPb3qv9iUCwN4SjO4ejQcThYO75yB4=;
        b=0/1Ej+bgNWm/r4fIbv9Fwbbr9rOD8IgW9qrLeBB7rzWrpdV6uRrTLjcCG9VEsyU+zn
         8QhUwm9iOENsyyovRRHBCV7dFo9YBlUtaTNWEnkWvnC6N4fc2qNLPLl1LjoOkOkrTMOx
         niD2xvcBSAyHKVJX4cd+LP2jC3AaFL6G6fIFlDGZmvxk8b4UG8Yl8cGyS1wSPhTPvPR+
         Gum6T8pdWLcRn5Gib1/WdkY90feGoOm5V4enF7XcjkKJdrDEfzCDIP/sbUA/Kc0ymWuS
         TGEbRs4h9eIuHLrwvlBBSe7Du7J6H2+wqd+Py6SDFCCN/n64+L9J2bcNIRDGPmdEI0DY
         6j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770573503; x=1771178303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xgsxpv+tOpJi9iPb3qv9iUCwN4SjO4ejQcThYO75yB4=;
        b=gWMCJQQ3LnWULkY/myM0IKzCwxsAl5TAvITykVYe3PjHmCMY2uCAWaVCN7gFHILERj
         7AWeS16/LGZFz5MikdkNlONztmEPot1eoQJSzRy0vrvBN4HR2Mhf0F80VfDReAgL/k1h
         uMlE0kmtqeuhcqPkUwdT/hAiWcAqkAsTFuR7ADt9Banq67OWJvXFcnO3/HV48zhRqwNf
         m+T+aouhP7+LqBsrKJrraMwayX2VyioMtJOid1F9Z8k6uy/+/mWkDRV3VkCo2guOpjDf
         AJL0kji+jIh/IlcXl5KI9IXG85mfRdYvWCIAQ3VT/XFWjCBai03z6VKMgBQl5Bk20Uiz
         JKGw==
X-Forwarded-Encrypted: i=1; AJvYcCXhySu6pc1XVtTCoRh/PtVJa69MrDMlqIIorxzwUvzaEhSxQfzf+RD0qx3NQp361qxfvj+PMBPBBJVdqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9e3NqAuFgJ8GnK5UzBh8hAZeB6n+YHPu3I3V/MYnTFkReijU8
	hPzme235Kpm1I85og8ErkP2gHLMwsGT0a0oQAbfg1PsByN/Sz9RT2oVOcsvcd/o+MEFkVyBDqF4
	1daI8
X-Gm-Gg: AZuq6aLWAQrNziDyGEapzPtSsRhAEfZ5GvxEuUmRickHYvcMpG68UNe2ow3ZR5WaMnQ
	OLVlY04sQqLe+BVHpP2FT7H5bjC+jkQDMGwNYuyeBQX7LyQ0rK6uguyHkV8Y/15M/XW3Lrf6Kcq
	aULUNMdJAq/ziN3Kh6vzXwtumHshWDH5AjvjRwhRXMfGq7e3Kk85pPaxvqehVJo+whin6WQVXtx
	wiviDoWX2r6FAY3fj74fhRzFMMW/dtbMFIAqCKLmUpsXwHX5HDC3fMczWnyMVMe5T+yGKrMtQ+r
	qxBH5MeQeVFGENDyFWtH4oU8hRO9ogdIHwB1h2ohq08+xO1SdExF3BSMx3zGufXcEDwGjcExTnG
	xOS7XtnHFK3d+eu+fJszhFokx0EmSxZzH86CP1t+YAU5c3A8bfvYHQHptZlAwVWzK71BmA8bBmt
	CusogDxr+bcGQWXB/v
X-Received: by 2002:a05:600c:3553:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-483201dc49emr121113255e9.1.1770573503040;
        Sun, 08 Feb 2026 09:58:23 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4831d0b5b31sm244992875e9.4.2026.02.08.09.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:58:22 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/6] fbdev: au1100fb: support COMPILE_TEST and fix multi-device support
Date: Sun,  8 Feb 2026 18:57:57 +0100
Message-ID: <cover.1770572936.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=W2NuPR6ntya68Cnkaanj4tYTUVC5lDpyIcGnbNzU+tM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpiM6nZD7qhp+RL3FOLivwJlKWpXGSMkMfprYse 0hghgfZlhuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaYjOpwAKCRCPgPtYfRL+ TsLOB/9hYrADUnPDJUoNXepwg98D4XLi1LqcVvylr6jgtwNYUoTub2/Bf1H43C3Fb2AaUBsJ6dg xAOAoc9DWm79lyqidG25hbwS0dvK7Pkk4lrk1/Mlr/YLAE8+v2FaBRExH+eaFMh5DqdqIwiOyGV m46BaTvZVHGaeyBBIpLs/Qe5CAPww0l0Xc84wyqSi1nPgVktiLyhSZv0b4O9nEoDmtGHNQyFYzq 7C9rm4Qwwhqsiz828wPQgFN9z3qMtQCBDoc3sPIGuayE7fm4SQbd79kNQql7gs8amA86KHhbD+x MrhlH1ilMjtokYg+W/yCMeRNblSyuSGKm8zq5h6Mgh8O5UKz
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

changes since
v2 that is available at
https://lore.kernel.org/linux-fbdev/cover.1770483674.git.u.kleine-koenig@baylibre.com:

 - Remove fbregs again
 - Added a few more %d -> %zu conversions that were hidden for the
   compiler by print_dbg() being a noop, but Helge noticed anyhow.
 - patches #4 and #6 are new. #6 was used instead of defining DEBUG to 1
   for compile testing, that uncovered the additional issue fixed in
   patch #4.

Uwe Kleine-König (6):
  fbdev: au1100fb: Don't store device specific data in global variables
  fbdev: au1100fb: Mark several local functions as static
  fbdev: au1100fb: Use %zu to printk a value of type size_t
  fbdev: au1100fb: Use %pad to printk a value of type dma_addr_t
  fbdev: au1100fb: Make driver compilable on non-mips platforms
  fbdev: au1100fb: Replace custom printk wrappers by pr_*

 drivers/video/fbdev/Kconfig    |   3 +-
 drivers/video/fbdev/au1100fb.c | 130 +++++++++++++++++----------------
 drivers/video/fbdev/au1100fb.h |  17 ++---
 3 files changed, 73 insertions(+), 77 deletions(-)

base-commit: 0636e6205beed850d985276dc56fd73d785bea5c
-- 
2.47.3


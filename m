Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D734C808;
	Wed, 12 Nov 2025 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975398; cv=none; b=QM5L6MV824tcXCVE+JbyriitSgPceetvHsHLfoOKEIB5pS2LptzVxiKu2qONx9oagXb6sh5iO1ZDeV7FKIL1o/Vo/tufuw3x0/OE42vDQZWo8/BE8FD0KZEn55us4+uAbZ+uF/CQtHHWVUdZt+FylV+XIhab3Hx2jm+Yx/tOvz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975398; c=relaxed/simple;
	bh=hvW5MfhbFDSN99ebzzoa8i+LHa0rM/rFbGQQNSkbOCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TT9G4h8rIZtO0BjpuxGVPB40blgtQWqV4k7aeLJRemmabG4/yd/8i+Hq2R2eJ4TOobUWfFOONMqkwFc0/9NPv631zkDQo1a0uTna34yFB9H9oBEJceAL3FtOJ7fW4O2RIEP62UBJutZDDCYCGoFMFFcNx2Og4DlVNnDRONt5z0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGYZNJB1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGYZNJB1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762975396; x=1794511396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hvW5MfhbFDSN99ebzzoa8i+LHa0rM/rFbGQQNSkbOCQ=;
  b=KGYZNJB1UBqxuc9hnfMN8lMtB9esQYdsZkYx9y/HZSrnfsnY8IYHk0cw
   v+64cpfJoaQ4YKEqHyA4LwMy+RpQQboAs0WY8rnRNmC0VlgOB6IP7QwXG
   dUBxNOcF7EUvcrejQZNVVuXA5AYad1FAftxFCUtEJKXA0bCuWExv00kTY
   /7FW/w2Jl8D8dEX6Hz/iBrez+pv4YjVoSV3jVsqkjBL6VFslNPkUDVdMW
   PkuiDvg4kG3UmcLHVNJm/3Lg80olvcivnkU+HbeFhr8T/uIboLLgi9Mmn
   aLIJdoPkTu6R0J7b4KIxh697NQ5xtzni+2ReCD4n8SUR7jnL43bxCakU5
   g==;
X-CSE-ConnectionGUID: 0ZGFfscQTjytZ4pRuPTFFg==
X-CSE-MsgGUID: 5lkApSccQ36QskVl97cqAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82679553"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="82679553"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 11:23:16 -0800
X-CSE-ConnectionGUID: ln9UcHszSp2t5l0oEMVd5A==
X-CSE-MsgGUID: gF/zBEGaSbqlZU7D/KDfnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189578289"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 12 Nov 2025 11:23:14 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id DD35095; Wed, 12 Nov 2025 20:23:12 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Abdun Nihaal <abdun.nihaal@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jianglei Nie <niejianglei2021@163.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] staging: fbtft: core: fix potential memory leak in fbtft_probe_common()
Date: Wed, 12 Nov 2025 20:22:07 +0100
Message-ID: <20251112192235.2088654-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianglei Nie <niejianglei2021@163.com>

fbtft_probe_common() allocates a memory chunk for "info" with
fbtft_framebuffer_alloc(). When "display->buswidth == 0" is true, the
function returns without releasing the "info", which will lead to a
memory leak.

Fix it by calling fbtft_framebuffer_release() when "display->buswidth
== 0" is true.

Fixes: c296d5f9957c ("staging: fbtft: core support")
Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: fixed in accordance with Andy's review

 drivers/staging/fbtft/fbtft-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 9e7b84071174..8a5ccc8ae0a1 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -1171,8 +1171,8 @@ int fbtft_probe_common(struct fbtft_display *display,
 	par->pdev = pdev;
 
 	if (display->buswidth == 0) {
-		dev_err(dev, "buswidth is not set\n");
-		return -EINVAL;
+		ret = dev_err_probe(dev, -EINVAL, "buswidth is not set\n");
+		goto out_release;
 	}
 
 	/* write register functions */
-- 
2.50.1


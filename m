Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DEF1F5838;
	Thu, 24 Apr 2025 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495819; cv=none; b=B0aFvi7R+R7IK/2xgESwaJ1SSrJI499LoSJqd7+96TiuwtRdnWYAx/NeJ81JghAReK9SoFjk+Vq5UTRkYcJQgoB3wSmd5ajzn2In5K7LMk2N5jbgbeTeOfbEe5a3gPHQiFMEb6O2WWCuo3AZRF1ZFDBs666PVEdGgsNbXI93c70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495819; c=relaxed/simple;
	bh=Pka1TihqqENohML/m9+LvmBVBPz6iWRC7JscbAmLv8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p6Mzz9HgGk+TVFtaTE8WIXKkwvM882rA9LKoSK5DCvCmNd6rbGPO7eng+92MtK0fPXH+yriIyYY3zcm7koT5jywhg3Ttx6xvAZZU92405JlFmp+/TlqTYIXJDkC63w5UN1bGfk/2QdXcjzFyWqXyuftq3sspbh41iC5hzjIkr/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcZP5OKV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcZP5OKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745495818; x=1777031818;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pka1TihqqENohML/m9+LvmBVBPz6iWRC7JscbAmLv8c=;
  b=EcZP5OKVjz0JW6vQRU7pg5ZAp2FVQ+oZ40I7NtR9BYGfvFZMfBj0NVy6
   TPFqZxyGVLLDM07hxEdSPJMBA257QIOGlhKkt1d5aTSGVLlCcapM5q+rn
   bugpP9HNPt1q7Rln8xOnzR7rX6H3W79wXr/pXDp6xiQ0j91b0KXwxwVsf
   DT0FyZkmtgf4lHSDL8/2PTxFid1Vo8SUcuwC+xmiXO/a8+aeL0rFi9toe
   X838XbxL1rrmKIvi04/piEqPYWpogU+C09pMhpv4mvfOW5a8biJe6Qs+u
   +kVeATV2zOAMm7Y3/p9s0e4K8vqhcFFEzjJZm9y/DPHmB9sBN1UbR9Cgn
   w==;
X-CSE-ConnectionGUID: X0AeqgglSTWgPE/UXfk0Pg==
X-CSE-MsgGUID: 1HYJWpOaRry5zZ9evG5D1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="34741045"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="34741045"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 04:56:56 -0700
X-CSE-ConnectionGUID: IDo3JUZ6RcidTPOCx71IMA==
X-CSE-MsgGUID: AZvtWOwUQ2OotH8IgPz5gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="132332660"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 24 Apr 2025 04:56:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3E4C81AC; Thu, 24 Apr 2025 14:56:53 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH v1 1/1] atyfb: Remove unused PCI vendor ID
Date: Thu, 24 Apr 2025 14:56:52 +0300
Message-ID: <20250424115652.2451062-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The custom definition of PCI vendor ID in video/mach64.h is unused.
Remove it. Note, that the proper one is available in pci_ids.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/video/mach64.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/video/mach64.h b/include/video/mach64.h
index d96e3c189634..f1709f7c8421 100644
--- a/include/video/mach64.h
+++ b/include/video/mach64.h
@@ -934,9 +934,6 @@
 #define MEM_BNDRY_EN		0x00040000
 
 #define ONE_MB			0x100000
-/* ATI PCI constants */
-#define PCI_ATI_VENDOR_ID	0x1002
-
 
 /* CNFG_CHIP_ID register constants */
 #define CFG_CHIP_TYPE		0x0000FFFF
-- 
2.47.2


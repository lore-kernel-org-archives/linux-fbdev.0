Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227DB285050
	for <linux-fbdev@vger.kernel.org>; Mon,  8 Dec 2025 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218460; cv=none; b=bzd4hfgUJq80D45kNoRPko1HUK/weIbfaXjaiylpY/p1ytzbZKB0eGXx/96se3cJ7abFQ03412zHWZGUAxGHUMFc73KyuEd29kJO1EnEIrx8rP3/EbYxife6Mad3nWgoJdbRJjdccp33UVSb7s+Vl8JMjValppoSnr7ykJbHXz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218460; c=relaxed/simple;
	bh=W1ZXOT3hNZJb6E/5NbQJ/DcPJqLVuLRf6vJkSTtXdX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7TEnAtda2yvEGsWIj9CGj3X+NjGpMIeHNG2CzMeXS5QZ66ZwkkHR2SAHXaXYLD0+Jcts8gIP9cvoHffb7CX69ODIzv/JjvAtbIQq/zfEiKzyKwfweJuRiUhd1GCeano86Hd2fSkpPY++GIxGifnXWYte7+d2nbKCc7UUE6kWsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RN1+/AZd; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RN1+/AZd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765218459; x=1796754459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W1ZXOT3hNZJb6E/5NbQJ/DcPJqLVuLRf6vJkSTtXdX8=;
  b=RN1+/AZdnGBYcD7ubYLkQFk5LWU0CRx7FXkvUT7fnsWxPGaDgUdbJx6x
   2eFu/i0wtvb4el4SOCh/mQ1dr/D0WhAXaS0P9vJ4GVjtMzkyFacEYOFSb
   4HMs5kZsrA9Q5y6y76+5R0oJbdjXaSVnJ2CfK9NN7tA/JlkQzqqaFSTKP
   HmNzEKgJNQ1xfnJ0mSJxtCbQnWMjjpKe/RYfpCK+1xcCBGbAy52ky46WN
   hbfJ0ZMz3XtZlMKBwZ/QYeF0BB7w2va/GHGmA5XS4hhm/Nyy5nvIsjBGL
   OorynfXnU9ZcRfbCD12bEleUMx5Km8Qvhl/XUpK2TM+TLDm+kMGE4U+mQ
   Q==;
X-CSE-ConnectionGUID: 7p20PMuVQFCRxKXmyNR1Ng==
X-CSE-MsgGUID: pj0zSZk+QZK87aNB+h8jMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67129566"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="67129566"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 10:27:38 -0800
X-CSE-ConnectionGUID: K3Kxe0ayTcuUhj0/3+JLhw==
X-CSE-MsgGUID: 8wqRL96lQcSJ9mcooBIg9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="196014503"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 10:27:36 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 14/19] video/vga: Add VGA_IS0_R
Date: Mon,  8 Dec 2025 20:26:32 +0200
Message-ID: <20251208182637.334-15-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251208182637.334-1-ville.syrjala@linux.intel.com>
References: <20251208182637.334-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Add a proper name for the "Input status register 0" IO address.
Currently we have some code that does read addressed using the
aliasing VGA_MSR_W define, making it unclear what register we're
actually reading.

Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 include/video/vga.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/video/vga.h b/include/video/vga.h
index 468764d6727a..d83c5f153253 100644
--- a/include/video/vga.h
+++ b/include/video/vga.h
@@ -46,6 +46,7 @@
 #define VGA_MIS_R   	0x3CC	/* Misc Output Read Register */
 #define VGA_MIS_W   	0x3C2	/* Misc Output Write Register */
 #define VGA_FTC_R	0x3CA	/* Feature Control Read Register */
+#define VGA_IS0_R	0x3C2	/* Input Status Register 0 */
 #define VGA_IS1_RC  	0x3DA	/* Input Status Register 1 - color emulation */
 #define VGA_IS1_RM  	0x3BA	/* Input Status Register 1 - mono emulation */
 #define VGA_PEL_D   	0x3C9	/* PEL Data Register */
@@ -485,3 +486,4 @@ static inline void vga_mm_wattr (void __iomem *regbase, unsigned char reg, unsig
 }
 
 #endif /* __linux_video_vga_h__ */
+?
-- 
2.51.2


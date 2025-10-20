Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DD824DD17;
	Mon, 20 Oct 2025 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965589; cv=none; b=TFl0ECKHv6ypoG0YWLaSkTMxyZcAon7PM+S1wYkGlOkTcx69cMW31caNdUpCGGLTB7SvCZHdbXXaLlo4VISkGNV8DAT699cEs2HT+Udfyy9pLGfT5SA/lj8++FOFL/GeeIJU6YE5vYksOV639bS3pbACXqCMLkCqP8iVk4mO9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965589; c=relaxed/simple;
	bh=wAI0xMkSnbhaSLTqgomUxHh2ZZalda3QNhhiLBoAQgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VIIN0guhjQMoH0Dg1/yCLX6GUBA0y0UBtRf8yCyy5JXj0gB9qwFdFhzbaeXzCkeafeWP0MHi24FLzzxAv6RFdLJa4/3647wJmAPmOgk3oSG7Q9zTCYTS33igjb39W5QNCozzlbPLsiuLb4LxpQL0CGoyb3g2Ae4RdQst7zEFqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUxq3ede; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUxq3ede"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760965587; x=1792501587;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wAI0xMkSnbhaSLTqgomUxHh2ZZalda3QNhhiLBoAQgI=;
  b=aUxq3edeRNAiYfzGnjCIPNJocVleiV2U92xXwFtAr6bjphM/ttvd4qRO
   fOwLc2MJqP8h4IUt9VW4DlccO38/BsXCRk1FXlhERYsck1TFSK3dS08fl
   T7vsK8L3+ablt93YqZI6/bDVuCdUlCP60FPFGmma9eM470+Ni4IwU3DHd
   +aK8m0LatK8BZtLRDocrOYy9cQgppMHzkhkf6p++cUW8VMxzGe/HzN0o1
   Udq/9llY/b1P1x+EM5mQ02thMe2xLY7bM8QARxNBuB5M6qVkWxi9y5Axe
   t/DeRUzXnHdcaViMOyTN8GW5HbE3eFkyCuHrGKUg5V9itZNmCwIUMzF1b
   w==;
X-CSE-ConnectionGUID: 6eHXMC+1Sk6YBjzrnG5Suw==
X-CSE-MsgGUID: ns2Ibpp2Q+OSoIuDXKTEVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73684702"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="73684702"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 06:06:26 -0700
X-CSE-ConnectionGUID: 1WMr52nHQFe+l2MAr15/QQ==
X-CSE-MsgGUID: DHmPvODTREu8wI8w65VIxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="187583943"
Received: from b580.bj.intel.com ([10.238.152.130])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 06:06:23 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Zsolt Kajtar <soci@c64.rulez.org>
Cc: Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Junjie Cao <junjie.cao@intel.com>,
	syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
Subject: [PATCH v2] fbdev: bitblit: bound-check glyph index in bit_putcs*
Date: Mon, 20 Oct 2025 21:47:01 +0800
Message-ID: <20251020134701.84082-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bit_putcs_aligned()/unaligned() derived the glyph pointer from the
character value masked by 0xff/0x1ff, which may exceed the actual font's
glyph count and read past the end of the built-in font array.
Clamp the index to the actual glyph count before computing the address.

This fixes a global out-of-bounds read reported by syzbot.

Reported-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
Tested-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
v1: https://lore.kernel.org/linux-fbdev/5d237d1a-a528-4205-a4d8-71709134f1e1@suse.de/
v1 -> v2:
 - Fix indentation and add blank line after declarations with the .pl helper
 - No functional changes

 drivers/video/fbdev/core/bitblit.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 9d2e59796c3e..085ffb44c51a 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -79,12 +79,16 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				     struct fb_image *image, u8 *buf, u8 *dst)
 {
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+	unsigned int charcnt = vc->vc_font.charcount;
 	u32 idx = vc->vc_font.width >> 3;
 	u8 *src;
 
 	while (cnt--) {
-		src = vc->vc_font.data + (scr_readw(s++)&
-					  charmask)*cellsize;
+		u16 ch = scr_readw(s++) & charmask;
+
+		if (ch >= charcnt)
+			ch = 0;
+		src = vc->vc_font.data + (unsigned int)ch * cellsize;
 
 		if (attr) {
 			update_attr(buf, src, attr, vc);
@@ -112,14 +116,18 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
 				       u8 *dst)
 {
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+	unsigned int charcnt = vc->vc_font.charcount;
 	u32 shift_low = 0, mod = vc->vc_font.width % 8;
 	u32 shift_high = 8;
 	u32 idx = vc->vc_font.width >> 3;
 	u8 *src;
 
 	while (cnt--) {
-		src = vc->vc_font.data + (scr_readw(s++)&
-					  charmask)*cellsize;
+		u16 ch = scr_readw(s++) & charmask;
+
+		if (ch >= charcnt)
+			ch = 0;
+		src = vc->vc_font.data + (unsigned int)ch * cellsize;
 
 		if (attr) {
 			update_attr(buf, src, attr, vc);
-- 
2.48.1


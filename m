Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9BC29D260;
	Sun, 19 Oct 2025 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760889244; cv=none; b=f8agTGtJqyoXoePvAjwVl51dMQfE2sv8N93V/0xnCaExTR7PtnJ7fh+QcFK0GS7ouYy0lA92x2cUBc+PynceWSbbpWpYZpNra65hd4VqJgSmVCbtLT/Ru95X6l2An+Gt9H57W76E7T4js66b3hOwHrytoYfNwhDZagZlBSmFuA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760889244; c=relaxed/simple;
	bh=Y5PN7GETpS9idJ617+SVI/czLHfb0EdEQ3+7TWAzs2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNH3oc5NOlzJAXTHXpouwOO5RRozXa6OX3iKT5X1ur/9lOlLZNilbFXBwEda+qkYsCKfmTfcQhT+TQkziLQ9im5m6pz5WHBEFF0VpI3xZ/yeJA6xZAuvHJ1/zr7b+ljVZmrmMry5+T+R92oHjoM0ANHn6DD8MkxS27UUl3lY/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fl1QefPF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fl1QefPF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760889242; x=1792425242;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y5PN7GETpS9idJ617+SVI/czLHfb0EdEQ3+7TWAzs2g=;
  b=Fl1QefPFXAmvOiNBwDuDTAgr4DHn1AyDu9WPT5A+m4IJitNXLLBjZ5oa
   mePnruxZft0pSukPFt7AP89NH3nIbJi+Z6txhaW0upPTHzWhu9LLNaAJt
   QcriHvbMaqXora354F0cTskpA1ysnvogCB8UdKZRUlT4DNJ+EZGQQ+QXk
   Imu9SAZ4E8bvk36oJKvKxciU/8yjPiQ5gi8Ot3CI+bbmdaHkphKrZagkX
   bA5E9nQOJ+iTXuxlQQdg7JgAGk7JbjaDhOfP+wfcjhNWaWokRtsU8Ob6R
   5k9izv2E038o9Ln8D6gOdvBFY6vnjHmqxSS5YQFSQClkAUDQRhUMt0tBG
   g==;
X-CSE-ConnectionGUID: 33z55P/7RC2j4a9sCLqyCw==
X-CSE-MsgGUID: vbOBHTwjT1muoQWCzYBqIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="62239129"
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="62239129"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 08:54:01 -0700
X-CSE-ConnectionGUID: /I3oDpP5Rh6VrkNMutR1iw==
X-CSE-MsgGUID: BEz4SnD1QVSNszj/RQDlDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="182979301"
Received: from b580.bj.intel.com ([10.238.152.130])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 08:53:58 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Zsolt Kajtar <soci@c64.rulez.org>
Cc: Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Junjie Cao <junjie.cao@intel.com>,
	syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
Subject: [PATCH] fbdev: bitblit: bound-check glyph index in bit_putcs*
Date: Mon, 20 Oct 2025 07:53:31 +0800
Message-ID: <20251019235331.1243671-1-junjie.cao@intel.com>
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
 drivers/video/fbdev/core/bitblit.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index a9ec7f488522..710883831826 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -79,12 +79,15 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
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
+	if (ch >= charcnt)
+		ch = 0;
+	src = vc->vc_font.data + (unsigned int)ch * cellsize;
 
 		if (attr) {
 			update_attr(buf, src, attr, vc);
@@ -112,14 +115,17 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
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
+	if (ch >= charcnt)
+		ch = 0;
+	src = vc->vc_font.data + (unsigned int)ch * cellsize;
 
 		if (attr) {
 			update_attr(buf, src, attr, vc);
-- 
2.48.1


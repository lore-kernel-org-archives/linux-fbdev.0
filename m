Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D820DD64;
	Thu, 27 Mar 2025 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069695; cv=none; b=MD+hrF6CD+DXxu062a/OzcQ+LolUzyUlBrhm6wNoSSaCph/L/B4T7XzHUKIvS2Q5Uho+SrP/S2cE5PzkkGEUmPfvJ6Xm3Km40JO1Kg/3VNoRU6LyliCXGhlBfhmQEwoP7a0+6L0rueEYq6Hi4I2RA2l2MmNRBi9yfcAEllo3BhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069695; c=relaxed/simple;
	bh=pgI8gXBei/XNkeEYc0bn3IgQ90Gj7blDgaIoeHja1Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwOnSh2qBjHF/V2KhvbbiKHvf3iCoGxkpCWHUgwuGubqktYF2e1P41XB3QGNZIydfL2/JiFbXDlztMsu6AxK3zyag3wYMR00vHX0BG68CsVvfCgH5plX3XbklJu/R59vh1g+1A6EZYrM4pS5JOvJ9ot58EXTNrSwBpcQZjoJPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=mGszbYpj; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="mGszbYpj"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1743069687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHLOBT3idkFgvXNfDI3YEo7317l4Nl2O9zMCAnRi99A=;
	b=mGszbYpj2K9Vh0CF1hIrPcsW7W/IVtKUzYXFFwYUsJh+5+FeSpElBHENDfuzKXhql1p9+A
	hD2QEep9xllE9+UnTztpT+2/QCBj8Hbi/Hx/3CpAOmbmjLnaKhCcQFNmhbZQ6P/7o4lz5W
	WWtbdUcnEN5joJ6396r7valD+k+PbMA=
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@intel.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 1/1] fbdev: atyfb: Fix buffer overflow
Date: Thu, 27 Mar 2025 13:01:24 +0300
Message-ID: <20250327100126.12585-2-arefev@swemel.ru>
In-Reply-To: <20250327100126.12585-1-arefev@swemel.ru>
References: <20250327100126.12585-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value LCD_MISC_CNTL is used in the 'aty_st_lcd()' function to
calculate an index for accessing an array element of size 9.
This may cause a buffer overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/video/fbdev/aty/atyfb_base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 210fd3ac18a4..93eb5eb6042b 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -149,6 +149,8 @@ static const u32 lt_lcd_regs[] = {
 void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
 {
 	if (M64_HAS(LT_LCD_REGS)) {
+		if ((u32)index >= ARRAY_SIZE(lt_lcd_regs))
+			return;
 		aty_st_le32(lt_lcd_regs[index], val, par);
 	} else {
 		unsigned long temp;
@@ -164,6 +166,8 @@ void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
 u32 aty_ld_lcd(int index, const struct atyfb_par *par)
 {
 	if (M64_HAS(LT_LCD_REGS)) {
+		if ((u32)index >= ARRAY_SIZE(lt_lcd_regs))
+			return 0;
 		return aty_ld_le32(lt_lcd_regs[index], par);
 	} else {
 		unsigned long temp;
-- 
2.43.0


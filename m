Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0B17D899
	for <linux-fbdev@vger.kernel.org>; Wed, 12 Jun 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199690; cv=none; b=i/ISM7aEJX/+EX+WN4vPR4piETNH511HBV+YYXUtCz08oaJ46r1nOdnnTe+MbgP+N/Gq7WtLuB1hxSqtffW8eQGbSmW36fVXeF2OYIJCnWZRiDzuC3nZKGeTMKAWHpPf+NaxrxRlwGM9Qsplq1w5eXnTI5mUYGl4ThGslD3gFkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199690; c=relaxed/simple;
	bh=CnPobtnE+Wb5WRYgbTH3tSYYFBD6ULiUlMynyKZIOP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HyDqCPhnuvsByFH8UAtf1P9JMpQXL4NFa0GiyDFQcuAZjC0pBnyt4nDiFrfO+UxqRomOJBOilYdW1fNmH8SOkilfNGH0hbx/peyju1hywJXJC42v00paElPperUYfSeht34VfZK152VdpNRFXuKTVuz4M9BPrYYe6fDfjBhH/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:170b:1b4a:247:a009])
	by andre.telenet-ops.be with bizsmtp
	id adhK2C0073axqkY01dhKtR; Wed, 12 Jun 2024 15:41:20 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sHOD0-008cdj-7Y;
	Wed, 12 Jun 2024 15:41:19 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sHOE3-00EaMZ-A5;
	Wed, 12 Jun 2024 15:41:19 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Helge Deller <deller@gmx.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] video/logo: Make logo data const again
Date: Wed, 12 Jun 2024 15:41:17 +0200
Message-Id: <1ea18c51dd1c029e3c50bfb082f5942b58b7360c.1718199543.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As gcc-4.1 is no longer supported, the logo data can be made const
again.  Hence revert commit 15e3252464432a29 ("fbdev: work around old
compiler bug").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/video/logo/pnmtologo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/logo/pnmtologo.c b/drivers/video/logo/pnmtologo.c
index 8080c4d9c4a23fbb..28d9f0b907a99a05 100644
--- a/drivers/video/logo/pnmtologo.c
+++ b/drivers/video/logo/pnmtologo.c
@@ -238,7 +238,7 @@ static void write_header(void)
 	fprintf(out, " *  Linux logo %s\n", logoname);
 	fputs(" */\n\n", out);
 	fputs("#include <linux/linux_logo.h>\n\n", out);
-	fprintf(out, "static unsigned char %s_data[] __initdata = {\n",
+	fprintf(out, "static const unsigned char %s_data[] __initconst = {\n",
 		logoname);
 }
 
@@ -375,7 +375,7 @@ static void write_logo_clut224(void)
 	fputs("\n};\n\n", out);
 
 	/* write logo clut */
-	fprintf(out, "static unsigned char %s_clut[] __initdata = {\n",
+	fprintf(out, "static const unsigned char %s_clut[] __initconst = {\n",
 		logoname);
 	write_hex_cnt = 0;
 	for (i = 0; i < logo_clutsize; i++) {
-- 
2.34.1


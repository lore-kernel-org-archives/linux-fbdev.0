Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SObVE2TC"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9A71734
	for <linux-fbdev@vger.kernel.org>; Tue,  5 Dec 2023 15:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SEYrcEs9MxnuTOU1kwL+n0OPPR/LYIWzA9eTewrMYPY=; b=SObVE2TCBYHgbbmFjoJeNCGm9G
	BZ24lj5KLBeeuSJxFwhACG1jROd/LhngIXfyubzMNcBJfsuUF4yQ3vEBQ0zQGoEa4xLtox29en7iU
	o1Rs9vobmt7Gd2IVeRKOOa5AL5bYea8wdjCh6ZTf1IaSpKqFbU3aYLCupWG+nbQ6du08dgV9C7/kl
	Cr5Y2JklH1RclinuMHYATN3ui8Z7kZtGKnHvrRDT4Ti7a5uztnOFWYtZRNk/NDB1NBTlzYF92NQxY
	PAcBLiNelsT56HDYWIHuqXw/zuVtr4eeCTg0Mgn2lT3wShEceYEHpyRGu2xY4I3ZZj/mtnXmc9fc1
	xYNYaPgw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rAecD-008ay2-0J;
	Tue, 05 Dec 2023 23:14:19 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
	Helge Deller <deller@gmx.de>,
	linux-nvidia@lists.surfsouth.com,
	linux-fbdev@vger.kernel.org
Subject: [PATCH] fbdev: hgafb: fix kernel-doc comments
Date: Tue,  5 Dec 2023 15:14:08 -0800
Message-ID: <20231205231408.1234-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings found when using "W=1".

hgafb.c:370: warning: No description found for return value of 'hgafb_open'
hgafb.c:384: warning: No description found for return value of 'hgafb_release'
hgafb.c:406: warning: No description found for return value of 'hgafb_setcolreg'
hgafb.c:425: warning: No description found for return value of 'hgafb_pan_display'
hgafb.c:425: warning: expecting prototype for hga_pan_display(). Prototype was for hgafb_pan_display() instead
hgafb.c:455: warning: No description found for return value of 'hgafb_blank'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-nvidia@lists.surfsouth.com
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/hgafb.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff -- a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
--- a/drivers/video/fbdev/hgafb.c
+++ b/drivers/video/fbdev/hgafb.c
@@ -364,6 +364,8 @@ error:
  *	hgafb_open - open the framebuffer device
  *	@info: pointer to fb_info object containing info for current hga board
  *	@init: open by console system or userland.
+ *
+ *	Returns: %0
  */
 
 static int hgafb_open(struct fb_info *info, int init)
@@ -378,6 +380,8 @@ static int hgafb_open(struct fb_info *in
  *	hgafb_release - open the framebuffer device
  *	@info: pointer to fb_info object containing info for current hga board
  *	@init: open by console system or userland.
+ *
+ *	Returns: %0
  */
 
 static int hgafb_release(struct fb_info *info, int init)
@@ -399,6 +403,8 @@ static int hgafb_release(struct fb_info
  *	This callback function is used to set the color registers of a HGA
  *	board. Since we have only two fixed colors only @regno is checked.
  *	A zero is returned on success and 1 for failure.
+ *
+ *	Returns: %0
  */
 
 static int hgafb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
@@ -410,14 +416,15 @@ static int hgafb_setcolreg(u_int regno,
 }
 
 /**
- *	hga_pan_display - pan or wrap the display
+ *	hgafb_pan_display - pan or wrap the display
  *	@var:contains new xoffset, yoffset and vmode values
  *	@info:pointer to fb_info object containing info for current hga board
  *
  *	This function looks only at xoffset, yoffset and the %FB_VMODE_YWRAP
  *	flag in @var. If input parameters are correct it calls hga_pan() to
  *	program the hardware. @info->var is updated to the new values.
- *	A zero is returned on success and %-EINVAL for failure.
+ *
+ *	Returns: %0 on success or %-EINVAL for failure.
  */
 
 static int hgafb_pan_display(struct fb_var_screeninfo *var,
@@ -449,6 +456,8 @@ static int hgafb_pan_display(struct fb_v
  *		@blank_mode == 2 means suspend vsync,
  *		@blank_mode == 3 means suspend hsync,
  *		@blank_mode == 4 means powerdown.
+ *
+ * Returns: %0
  */
 
 static int hgafb_blank(int blank_mode, struct fb_info *info)

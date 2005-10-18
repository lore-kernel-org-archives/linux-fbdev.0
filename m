From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 9/17] pm2fb: Manual configuration of timings for Elsa Winner
 2000 Office
Date: Tue, 18 Oct 2005 17:19:27 +0800
Message-ID: <4354BE1F.6030608@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERyIj-0000d5-9v
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:43:13 -0700
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ERyIh-0000dG-Tl
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:43:13 -0700
Received: by zproxy.gmail.com with SMTP id 14so1395707nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 13:43:11 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Peter 'p2' De Schrijver <p2@mind.be>

From: Peter 'p2' De Schrijver <p2@mind.be>

Attached is a small patch which configures the correct memory clock and
timings on the Elsa Winner 2000 Office pm2 based card. This is necessary
when the card is used on a platform which does not support PC style BIOS
initialization.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 pm2fb.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+)


diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -1120,6 +1120,22 @@ static int __devinit pm2fb_probe(struct 
 		default_par->mem_control, default_par->boot_address,
 		default_par->mem_config);
 
+	if(default_par->mem_control == 0 &&
+		default_par->boot_address == 0x31 &&
+		default_par->mem_config == 0x259fffff &&
+		pdev->subsystem_vendor == 0x1048 &&
+		pdev->subsystem_device == 0x0a31) {
+		DPRINTK("subsystem_vendor: %04x, subsystem_device: %04x\n",
+			pdev->subsystem_vendor, pdev->subsystem_device);
+		DPRINTK("We have not been initialized by VGA BIOS "
+			"and are running on an Elsa Winner 2000 Office\n");
+		DPRINTK("Initializing card timings manually...\n");
+		default_par->mem_control=0;
+		default_par->boot_address=0x20;
+		default_par->mem_config=0xe6002021;
+		default_par->memclock=100000;
+	}
+
 	/* Now work out how big lfb is going to be. */
 	switch(default_par->mem_config & PM2F_MEM_CONFIG_RAM_MASK) {
 	case PM2F_MEM_BANKS_1:




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

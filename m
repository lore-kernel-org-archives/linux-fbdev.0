From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/16] asiliantfb: Driver cleanups
Date: Mon, 28 Nov 2005 23:20:16 +0800
Message-ID: <438B2030.1050200@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhGnC-00023d-Kg
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:29:54 -0800
Received: from zproxy.gmail.com ([64.233.162.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhGnC-0001SK-D3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:29:54 -0800
Received: by zproxy.gmail.com with SMTP id r28so881625nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 17:29:54 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, apc@agelectronics.co.uk

- allocate just enough space for the pseudo_palette

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/asiliantfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/asiliantfb.c b/drivers/video/asiliantfb.c
index c64de59..69f7554 100644
--- a/drivers/video/asiliantfb.c
+++ b/drivers/video/asiliantfb.c
@@ -549,7 +549,7 @@ asiliantfb_pci_init(struct pci_dev *dp, 
 	if (!request_mem_region(addr, size, "asiliantfb"))
 		return -EBUSY;
 
-	p = framebuffer_alloc(sizeof(u32) * 256, &dp->dev);
+	p = framebuffer_alloc(sizeof(u32) * 16, &dp->dev);
 	if (!p)	{
 		release_mem_region(addr, size);
 		return -ENOMEM;



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

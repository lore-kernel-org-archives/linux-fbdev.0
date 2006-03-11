From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 11/18] nvidiafb: Remove NULL check
Date: Sat, 11 Mar 2006 09:50:52 +0800
Message-ID: <44122CFC.1040901@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHtNg-0002XB-5y
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:58:56 -0800
Received: from pproxy.gmail.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHtNf-0003lQ-TL
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:58:56 -0800
Received: by pproxy.gmail.com with SMTP id z59so419612pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Mar 2006 17:58:53 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Remove unnecessary NULL check.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/nvidia/nv_i2c.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
index bd9eca0..1edb1c4 100644
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -218,8 +218,7 @@ int nvidia_probe_i2c_connector(struct fb
 		}
 	}
 
-	if (out_edid)
-		*out_edid = edid;
+	*out_edid = edid;
 
 	return (edid) ? 0 : 1;
 }




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

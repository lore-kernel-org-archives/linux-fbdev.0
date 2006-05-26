From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 2.6.17-rc4-mm3] intelfb int option parsing fix
Date: Fri, 26 May 2006 09:40:58 -0400
Message-ID: <BD3E63BE-993E-4953-9FCF-0E3BED9347DE@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FjcYs-0006wi-Qg
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 May 2006 06:41:06 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FjcYs-00053y-Mq
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 May 2006 06:41:06 -0700
Received: from mail6.sea5.speakeasy.net ([69.17.117.8])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FjcYl-0004el-1d
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 May 2006 06:41:03 -0700
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
Content-Type: text/plain; charset="us-ascii"; delsp="yes"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, Dave Airlie <airlied@skynet.ie>, Sylvain Meyer <sylvain.meyer@worldonline.fr>

Hi all,

Passing along a patch that fixes integer option parsing in the  
intelfb driver.  The only option this really affects is the vram option.

regards,
dennis

---
From: Eric Hustvedt <ehustvedt@cecropia.com>

Fix integer option parsing in the intelfb driver. The macro wasn't
accounting for the equal sign past the option name. As a result,
the vram option always returned 0.

Signed-off-by: Eric Hustvedt <ehustvedt@cecropia.com>
Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

--

intelfbdrv.c |    2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17-rc4-mmpatches/drivers/video/intelfb/intelfbdrv.c	 
2006-05-24 11:26:40.000000000 -0600
+++ linux-2.6.17-rc4-stolen/drivers/video/intelfb/intelfbdrv.c	 
2006-05-25 14:21:37.000000000 -0600
@@ -264,7 +265,7 @@ MODULE_PARM_DESC(mode,
#ifndef MODULE
#define OPT_EQUAL(opt, name) (!strncmp(opt, name, strlen(name)))
-#define OPT_INTVAL(opt, name) simple_strtoul(opt + strlen(name),  
NULL, 0)
+#define OPT_INTVAL(opt, name) simple_strtoul(opt + strlen(name) + 1,  
NULL, 0)
#define OPT_STRVAL(opt, name) (opt + strlen(name))
static __inline__ char *



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642

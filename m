From: akpm@osdl.org
Subject: [patch 2/3] sis warning fix
Date: Wed, 09 Feb 2005 22:33:11 -0800
Message-ID: <200502100633.j1A6XDl31950@mail.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cz7t6-0006H5-TM
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Feb 2005 22:33:16 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cz7t5-0005CE-CU
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Feb 2005 22:33:16 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@osdl.org



drivers/video/sis/sis_main.c: In function `sisfb_compat_ioctl':
drivers/video/sis/sis_main.c:2204: warning: implicit declaration of function `lock_kernel'

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/video/sis/sis_main.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/video/sis/sis_main.c~sis-warning-fix drivers/video/sis/sis_main.c
--- 25/drivers/video/sis/sis_main.c~sis-warning-fix	2005-02-09 22:32:41.000000000 -0800
+++ 25-akpm/drivers/video/sis/sis_main.c	2005-02-09 22:33:08.000000000 -0800
@@ -49,6 +49,7 @@
 #include <linux/fb.h>
 #include <linux/console.h>
 #include <linux/selection.h>
+#include <linux/smp_lock.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/pci.h>
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

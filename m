From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH] sis: fix sparse warnings
Date: Wed, 16 Feb 2005 17:14:55 -0800
Message-ID: <20050216171455.196cb116.rddunlap@osdl.org>
References: <20050216164142.4f30b90a.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1aFu-0006CS-8b
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 17:14:58 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D1aFs-0004EF-Ob
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 17:14:58 -0800
In-Reply-To: <20050216164142.4f30b90a.rddunlap@osdl.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: thomas@winischhofer.net, adaplas@pol.net, akpm <akpm@osdl.org>

Seeing that Andrew just posted a patch to correct the ioctl
return type, only the include for linux/smp_lock.h is missing.
(Thanks for the message, Thomas.)



sis_main.c needs linux/smp_lock.h;

drivers/video/sis/sis_main.c:2204:2: warning: undefined identifier 'lock_kernel'
drivers/video/sis/sis_main.c:2206:2: warning: undefined identifier 'unlock_kernel'
drivers/video/sis/sis_main.c:2204: warning: implicit declaration of function `lock_kernel'
drivers/video/sis/sis_main.c:2206: warning: implicit declaration of function `unlock_kernel'

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/sis/sis_main.c |    1 +
 1 files changed, 1 insertion(+)

diff -Naurp ./drivers/video/sis/sis_main.c~video_sis_includes ./drivers/video/sis/sis_main.c
--- ./drivers/video/sis/sis_main.c~video_sis_includes	2005-02-15 13:48:46.145337888 -0800
+++ ./drivers/video/sis/sis_main.c	2005-02-15 21:25:40.381740480 -0800
@@ -39,6 +39,7 @@
 #include <linux/moduleparam.h>
 #endif
 #include <linux/kernel.h>
+#include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/string.h>



---


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

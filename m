From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/video/intelfb/: fix a warning
Date: Sat, 12 Mar 2005 18:30:02 +0100
Message-ID: <20050312173002.GG3814@stusta.de>
References: <20050312034222.12a264c4.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAARH-0008Uc-IY
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 09:30:11 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5] helo=mailout.stusta.mhn.de)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DAARF-0003mO-Ff
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 09:30:11 -0800
Content-Disposition: inline
In-Reply-To: <20050312034222.12a264c4.akpm@osdl.org>
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
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, adaplas@pol.net
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

It seems I'm at least partially guilty for the following warning coming 
from Linus' tree:

<--  snip  -->

...
  CC [M]  drivers/video/intelfb/intelfbdrv.o
drivers/video/intelfb/intelfbdrv.h:31: warning: 'intelfb_setup' declared `static' but never defined
...

<--  snip  -->


The fix is simple.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm3-full/drivers/video/intelfb/intelfbdrv.h.old	2005-03-12 17:51:06.000000000 +0100
+++ linux-2.6.11-mm3-full/drivers/video/intelfb/intelfbdrv.h	2005-03-12 17:51:20.000000000 +0100
@@ -28,7 +28,6 @@
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-static int __init intelfb_setup(char *options);
 static void __devinit get_initial_mode(struct intelfb_info *dinfo);
 static void update_dinfo(struct intelfb_info *dinfo,
 			 struct fb_var_screeninfo *var);



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Loading/Unloading console driver causes segfault
Date: 07 May 2003 18:42:44 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <42031.1385686093$1052329825@news.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from nimbus19.internetters.co.uk ([209.61.216.65])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19DSwR-0008LX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 May 2003 10:42:55 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,

I've been testing a console driver recently which has involved a lot of
loading/unloading. Although I get away with it sometimes it usually
segfaults on the second load of the console driver. The bit that seems a
little suspect to me is the line in console.c:

    vc_cons[i].d->vc_sw->con_deinit(vc_cons[i].d);

Surely if there is no active console driver it should skip. There is a
test earlier that should skip:

    if(!vc_cons[i].d || !vc_cons[i].d->vc_sw)
    	continue;

But as far as I can tell because give_up_console doesn't clear out the
vc_cons[i].d->vc_sw pointer it can be pointing at garbage. Am I missing
anything or is this patch garbage?

[alex@cambridge char]$ diff -u
../../../linux-2.4.20.ref/drivers/char/console.c console.c
--- ../../../linux-2.4.20.ref/drivers/char/console.c.ref2002-11-28
23:53:12.000000000 +0000
+++ console.c   2003-05-07 18:35:52.000000000 +0100
@@ -2598,8 +2598,11 @@
        int i;
  
        for(i = 0; i < MAX_NR_CONSOLES; i++)
-               if (con_driver_map[i] == csw)
-                       con_driver_map[i] = NULL;
+           if (con_driver_map[i] == csw) {
+               con_driver_map[i] = NULL;
+               if(vc_cons[i].d)
+                   vc_cons[i].d->vc_sw=NULL;
+           }
 }
  
 #endif


-- 
Alex, homepage: http://www.bennee.com/~alex/

Loan-department manager:  "There isn't any fine print.  At these
interest rates, we don't need it."



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

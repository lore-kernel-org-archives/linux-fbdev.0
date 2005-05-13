From: patrick mcmanus <mcmanus@ducksong.com>
Subject: unpriv'd 2.6.12-rc4 oops reading /sys/module/intelfb/parameters/*
Date: Fri, 13 May 2005 10:43:34 -0400
Message-ID: <1115995414.5648.64.camel@mcmanus.datapower.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DWbMi-0002xf-67
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 May 2005 07:42:12 -0700
Received: from [66.238.194.189] (helo=datapower.ducksong.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DWbMh-0004yM-2i
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 May 2005 07:42:12 -0700
Received: from [127.0.0.1] (mcmanus.datapower.com [127.0.0.1])
	by datapower.ducksong.com (8.12.10/8.12.10) with ESMTP id j4DEhYZL005876
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 13 May 2005 10:43:35 -0400
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

Hi All,

On Nov 16 2004 a change to intelfbdrv.c was commited (as part of 0.9.2
it looks like) that added __initdata to all of the module param
variables that seems to create the opportunity for an oops.

I've recently been chasing an OOPS
(http://marc.theaimsgroup.com/?l=linux-kernel&m=111552250920370&w=2) I
created by reading every file on the /sys file system and I've traced it
back to this code in the intelfbdrv. Though I had root privs in my
initial problem report, it turns out they are un-necessary to generate
the oops - all you've got to do is "cat
/sys/module/intelfb/parameters/mode" enough times and eventually it will
oops.

This is because sysfs automatically exports all module_param
declarations to the sysfs file system.. which means those variables can
be dynamically evaluated at any later time, which of course means
marking them __initdata is a bad idea ;).. when they happen to be char
*'s it is an especially bad idea ;).

Applying the patch below clears up the OOPS for me.

Signed-off-by: Patrick McManus <mcmanus@ducksong.com>

Index: drivers/video/intelfb/intelfbdrv.c
===================================================================
--- b44e6db42c986f858d2487a6a41ee0cbdd2cf670/drivers/video/intelfb/intelfbdrv.c  (mode:100644 sha1:549e229392604359f46ed629d916b4ea89674226)
+++ uncommitted/drivers/video/intelfb/intelfbdrv.c  (mode:100644)
@@ -228,17 +228,17 @@
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DEVICE_TABLE(pci, intelfb_pci_table);
 
-static int accel        __initdata = 1;
-static int vram         __initdata = 4;
-static int hwcursor     __initdata = 1;
-static int mtrr         __initdata = 1;
-static int fixed        __initdata = 0;
-static int noinit       __initdata = 0;
-static int noregister   __initdata = 0;
-static int probeonly    __initdata = 0;
-static int idonly       __initdata = 0;
-static int bailearly    __initdata = 0;
-static char *mode       __initdata = NULL;
+static int accel        = 1;
+static int vram         = 4;
+static int hwcursor     = 1;
+static int mtrr         = 1;
+static int fixed        = 0;
+static int noinit       = 0;
+static int noregister   = 0;
+static int probeonly    = 0;
+static int idonly       = 0;
+static int bailearly    = 0;
+static char *mode       = NULL;
 
 module_param(accel, bool, S_IRUGO);
 MODULE_PARM_DESC(accel, "Enable console acceleration");






-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click

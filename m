From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?=
 <yoshfuji@wide.ad.jp>
Subject: Re: 2.5.70-bk1 compilation error
Date: Wed, 28 May 2003 02:57:51 +0900 (JST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030528.025751.65947567.yoshfuji@wide.ad.jp>
References: <Pine.GSO.4.53.0305271949510.10781@pitsa.pld.ttu.ee>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from yue.hongo.wide.ad.jp ([203.178.139.94])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19KihM-0003ni-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 27 May 2003 10:57:20 -0700
In-Reply-To: <Pine.GSO.4.53.0305271949510.10781@pitsa.pld.ttu.ee>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: Text/Plain; charset="us-ascii"
To: siim@pld.ttu.ee, davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

In article <Pine.GSO.4.53.0305271949510.10781@pitsa.pld.ttu.ee> (at Tue, 27 May 2003 19:55:42 +0300 (EET DST)), Siim Vahtre <siim@pld.ttu.ee> says:

>   CC [M]  drivers/video/i810/i810_main.o
> In file included from drivers/video/i810/i810_main.c:56:
> drivers/video/i810/i810.h:206: error: parse error before "agp_memory"

Index: linux25-LINUS/drivers/video/i810/i810.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/drivers/video/i810/i810.h,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 i810.h
--- linux25-LINUS/drivers/video/i810/i810.h	17 Apr 2003 18:13:36 -0000	1.1.1.4
+++ linux25-LINUS/drivers/video/i810/i810.h	27 May 2003 17:48:49 -0000
@@ -203,8 +203,8 @@
 #define LOCKUP                      8
 
 struct gtt_data {
-	agp_memory *i810_fb_memory;
-	agp_memory *i810_cursor_memory;
+	struct agp_memory *i810_fb_memory;
+	struct agp_memory *i810_cursor_memory;
 };
 
 struct mode_registers {
Index: linux25-LINUS/drivers/video/sis/sis_main.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/drivers/video/sis/sis_main.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 sis_main.c
--- linux25-LINUS/drivers/video/sis/sis_main.c	6 May 2003 12:43:02 -0000	1.1.1.4
+++ linux25-LINUS/drivers/video/sis/sis_main.c	27 May 2003 17:48:50 -0000
@@ -2868,8 +2868,8 @@
 	unsigned long *write_port = 0;
 	SIS_CMDTYPE    cmd_type;
 #ifndef AGPOFF
-	agp_kern_info  *agp_info;
-	agp_memory     *agp;
+	struct agp_kern_info  *agp_info;
+	struct agp_memory     *agp;
 	u32            agp_phys;
 #endif
 #endif

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge

From: Guido Guenther <agx@sigxcpu.org>
Subject: fix module_param in rivafb
Date: Sat, 20 Nov 2004 01:46:04 +0100
Message-ID: <20041120004604.GA5321@bogon.ms20.nix>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CVJQE-0000Ib-Oh
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 16:48:14 -0800
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CVJQD-0005OZ-Np
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 16:48:14 -0800
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Tony,
third argument in module_param is the sysfs permission not a default
value. This fixes things for rivafb in 2.6.10-rc2:
Signed-Off-By: Guido Guenther <agx@sigxcpu.org>

--- linux-2.6.10-rc2.orig/drivers/video/riva/fbdev.c	2004-11-17 17:33:53.000000000 +0100
+++ linux-2.6.10-rc2/drivers/video/riva/fbdev.c	2004-11-20 01:38:47.017282552 +0100
@@ -2183,9 +2195,9 @@
 
 module_param(noaccel, bool, 0);
 MODULE_PARM_DESC(noaccel, "bool: disable acceleration");
-module_param(flatpanel, int, -1);
+module_param(flatpanel, int, 0);
 MODULE_PARM_DESC(flatpanel, "Enables experimental flat panel support for some chipsets. (0 or 1=enabled) (default=0)");
-module_param(forceCRTC, int, -1);
+module_param(forceCRTC, int, 0);
 MODULE_PARM_DESC(forceCRTC, "Forces usage of a particular CRTC in case autodetection fails. (0 or 1) (default=autodetect)");
 #ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);

Cheers,
 -- Guido


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

From: Magnus Damm <magnus.damm@gmail.com>
Subject: Fwd: [PATCH] aty128fb: MODULE_PARM_DESC
Date: Fri, 31 Dec 2004 00:12:54 +0100
Message-ID: <aec7e5c30412301512779977df@mail.gmail.com>
References: <aec7e5c3041212071828d36f00@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_521_32084343.1104448374484"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ck9Td-0000db-Jl
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Dec 2004 15:13:05 -0800
Received: from wproxy.gmail.com ([64.233.184.206])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Ck9TY-0005aG-VN
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Dec 2004 15:13:05 -0800
Received: by wproxy.gmail.com with SMTP id 40so79596wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Dec 2004 15:12:54 -0800 (PST)
In-Reply-To: <aec7e5c3041212071828d36f00@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

------=_Part_521_32084343.1104448374484
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

This patch never got picked up on lkml...

/ magnus


---------- Forwarded message ----------
From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 12 Dec 2004 16:18:26 +0100
Subject: [PATCH] aty128fb: MODULE_PARM_DESC
To: linux-kernel@vger.kernel.org


Heya,

Wrong parameter names are used with MODULE_PARM_DESC in aty128fb.

/ magnus

------=_Part_521_32084343.1104448374484
Content-Type: application/octet-stream; 
	name=linux-2.6.10-rc3-aty128fb_parm_desc.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.6.10-rc3-aty128fb_parm_desc.patch"

--- linux-2.6.10-rc3/drivers/video/aty/aty128fb.c	2004-12-03 15:00:54.000000000 +0100
+++ linux-2.6.10-rc3-aty128fb_parm_desc/drivers/video/aty/aty128fb.c	2004-12-12 15:56:49.817961600 +0100
@@ -2464,10 +2464,10 @@
 MODULE_DESCRIPTION("FBDev driver for ATI Rage128 / Pro cards");
 MODULE_LICENSE("GPL");
 module_param(mode_option, charp, 0);
-MODULE_PARM_DESC(mode, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
+MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
 #ifdef CONFIG_MTRR
 module_param_named(nomtrr, mtrr, invbool, 0);
-MODULE_PARM_DESC(mtrr, "bool: Disable MTRR support (0 or 1=disabled) (default=0)");
+MODULE_PARM_DESC(nomtrr, "bool: Disable MTRR support (0 or 1=disabled) (default=0)");
 #endif
 #endif
 

------=_Part_521_32084343.1104448374484--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

From: Boris Bezlaj <boris@gajba.net>
Subject: [PATCH] imsttfb 2.5.x
Date: Sat, 12 Apr 2003 13:19:45 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030412111945.GA537@gajba.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.g-kabel.si ([193.189.173.117])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 194J37-0005HR-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Apr 2003 04:19:58 -0700
Received: from kista.g-kabel.com ([212.118.89.49])
	by mail.g-kabel.si (8.12.5/8.12.5) with ESMTP id h3CDSEsZ018715
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Apr 2003 12:28:15 -0100
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

In 2.5.67 imsttfb locks the system when it's time to scrool the text.
Patch below fixes that. Otherwise everything seems to work as in 2.4

--- linux/drivers/video/ORIG_imsttfb.c  2003-04-09 15:11:46.000000000 +0200
+++ linux/drivers/video/imsttfb.c       2003-04-11 16:44:07.000000000 +0200
@@ -409,7 +409,7 @@
 static inline u32 read_reg_le32(volatile u32 *base, int regindex)
 {
 #ifdef __powerpc__
-       in_le32((volatile u32 *) (base + regindex));
+       return in_le32((volatile u32 *) (base + regindex));
 #else
        return readl(base + regindex);
 #endif

-- 

  Boris


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com

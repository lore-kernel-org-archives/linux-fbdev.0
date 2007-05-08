From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH] arkfb: Fix compile error if
	CONFIG_MTRR=n
Date: Tue, 8 May 2007 19:04:21 +0200
Message-ID: <20070508170420.GB27666@localhost.localdomain>
References: <463C9A29.4010505@gmail.com>
	<20070507233102.3ed6c42d.akpm@linux-foundation.org>
	<46406C89.50702@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlT79-0001aY-Kd for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 10:04:43 -0700
Received: from smtp1.kolej.mff.cuni.cz ([195.113.24.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HlT77-0004kL-Vm
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 10:04:39 -0700
Content-Disposition: inline
In-Reply-To: <46406C89.50702@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, May 08, 2007 at 08:26:49PM +0800, Antonino A. Daplas wrote:
> Fix compile error if CONFIG_MTRR=n

Thanks for fixes, I am sorry i didn't test it enough.
There is one related bugfix:

Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>

diff -uprN -X linux-2.6.21-rc7-mm2/Documentation/dontdiff linux-2.6.21-rc7-mm2/drivers/video/arkfb.c linux-2.6.21-rc7-mm2-dev-fix/drivers/video/arkfb.c
--- linux-2.6.21-rc7-mm2/drivers/video/arkfb.c	2007-05-08 18:47:08.000000000 +0200
+++ linux-2.6.21-rc7-mm2-dev-fix/drivers/video/arkfb.c	2007-05-08 18:34:13.000000000 +0200
@@ -122,7 +122,7 @@ MODULE_PARM_DESC(mtrr, "Enable write-com
 static int threshold = 4;
 
 module_param(threshold, int, 0644);
-MODULE_PARM_DESC(mtrr, "FIFO threshold");
+MODULE_PARM_DESC(threshold, "FIFO threshold");
 
 
 /* ------------------------------------------------------------------------- */


-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

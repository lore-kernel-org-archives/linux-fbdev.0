From: Antonino Daplas <adaplas@pol.net>
Subject: Re: cat /dev/fb1 produces kernel bug
Date: 24 Feb 2003 05:34:24 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046035982.1308.74.camel@localhost.localdomain>
References: <Pine.SOL.4.31.0302231958260.28624-100000@pitsa.pld.ttu.ee>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18n3kw-0005Ly-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 23 Feb 2003 13:33:54 -0800
In-Reply-To: <Pine.SOL.4.31.0302231958260.28624-100000@pitsa.pld.ttu.ee>
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
To: Siim Vahtre <siim@pld.ttu.ee>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>

On Mon, 2003-02-24 at 02:07, Siim Vahtre wrote:

> Call Trace:
>  [<c020e678>] kobject_register+0x58/0x70
>  [<c021a58b>] bus_add_driver+0x5b/0xe0
>  [<c021a9df>] driver_register+0x2f/0x40
>  [<c017a8e3>] create_proc_entry+0x83/0xd0
>  [<c021170b>] pci_register_driver+0x4b/0x60
>  [<c010507f>] init+0x3f/0x160
>  [<c0105040>] init+0x0/0x160
>  [<c010726d>] kernel_thread_helper+0x5/0x18
> 

For a quick fix, try this:

diff -Naur linux-2.5.61/drivers/video/riva/fbdev.c linux/drivers/video/riva/fbdev.c
--- linux-2.5.61/drivers/video/riva/fbdev.c	2003-02-16 00:49:23.000000000 +0000
+++ linux/drivers/video/riva/fbdev.c	2003-02-23 21:30:50.000000000 +0000
@@ -1961,12 +1961,10 @@
 
 int __init rivafb_init(void)
 {
-	int err;
-	err = pci_module_init(&rivafb_driver);
-	if (err)
-		return err;
-	pci_register_driver(&rivafb_driver);
-	return 0;
+	if (pci_register_driver(&rivafb_driver) > 0) 
+		return 0;
+	pci_unregister_driver(&rivafb_driver);
+	return -ENODEV;
 }
 

Or Try James' patch...
http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

...and Geert's "Logo Updates" which he just sent recently.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge

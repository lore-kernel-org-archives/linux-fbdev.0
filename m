From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.12-rc3 compile failure in tgafb.c
Date: Thu, 21 Apr 2005 22:43:54 +0200
Message-ID: <20050421204354.GF3828@stusta.de>
References: <20050421185034.GS607@vega.lnet.lut.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DOiWt-0008Lz-Ox
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Apr 2005 13:44:07 -0700
Received: from emailhub.stusta.mhn.de ([141.84.69.5] helo=mailout.stusta.mhn.de)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DOiWq-0006U6-2W
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Apr 2005 13:44:07 -0700
Content-Disposition: inline
In-Reply-To: <20050421185034.GS607@vega.lnet.lut.fi>
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
To: Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, rth@twiddle.net, adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

On Thu, Apr 21, 2005 at 09:50:34PM +0300, Tomi Lapinlampi wrote:
> 
> Hi,
> 
> 2.6.12-rc3 compile fails in drivers/video/tgafb.c
> 
> The system is an Alphastation 600 5/266, system variant Alcor,
> running Debian Sarge, gcc version 3.3.5 (Debian 1:3.3.5-8)
> 
> Btw, the tgafb hasn't really worked on this hardware since 2.6.8.1.
> I'll be able to run more tests after this one compiles :)
> 
> Regards,
> 
> Tomi
> 
> % make
>   CHK     include/linux/version.h
> make[1]: `arch/alpha/kernel/asm-offsets.s' is up to date.
>   CHK     include/asm-alpha/asm_offsets.h
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
>   CC      drivers/video/tgafb.o
> drivers/video/tgafb.c:85: error: `tgafb_pci_unregister' undeclared here (not in a function)
> drivers/video/tgafb.c:85: error: initializer element is not constant
> drivers/video/tgafb.c:85: error: (near initialization for `tgafb_driver.remove')
> make[2]: *** [drivers/video/tgafb.o] Error 1
> make[1]: *** [drivers/video] Error 2
> make: *** [drivers] Error 2
>...

The untested patch below should fix this compile error.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm3-full/drivers/video/tgafb.c.old	2005-04-21 22:38:42.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/video/tgafb.c	2005-04-21 22:39:36.000000000 +0200
@@ -45,9 +45,7 @@
 static void tgafb_copyarea(struct fb_info *, const struct fb_copyarea *);
 
 static int tgafb_pci_register(struct pci_dev *, const struct pci_device_id *);
-#ifdef MODULE
 static void tgafb_pci_unregister(struct pci_dev *);
-#endif
 
 static const char *mode_option = "640x480@60";
 
@@ -1484,7 +1482,6 @@
 	return ret;
 }
 
-#ifdef MODULE
 static void __exit
 tgafb_pci_unregister(struct pci_dev *pdev)
 {
@@ -1500,6 +1497,7 @@
 	kfree(info);
 }
 
+#ifdef MODULE
 static void __exit
 tgafb_exit(void)
 {



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

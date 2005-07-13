From: Jon Smirl <jonsmirl@gmail.com>
Subject: Third repost: unregister_chrdev.patch
Date: Wed, 13 Jul 2005 18:23:39 -0400
Message-ID: <9e473391050713152335e72ab2@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dspeq-0005un-AC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Jul 2005 15:24:48 -0700
Received: from wproxy.gmail.com ([64.233.184.200])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1Dspep-00024r-3e
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Jul 2005 15:24:48 -0700
Received: by wproxy.gmail.com with SMTP id i7so292296wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 13 Jul 2005 15:24:40 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Can we get this into the kernel?

--
Jon Smirl
jonsmirl@gmail.com

#fbdev is missing unregister_chrdev() on unload
#Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1164,6 +1164,7 @@ static void __exit
 fbmem_exit(void)
 {
       class_destroy(fb_class);
+       unregister_chrdev(FB_MAJOR, "fb");
 }

 module_exit(fbmem_exit);


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar

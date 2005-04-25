From: Jon Smirl <jonsmirl@gmail.com>
Subject: fbmem.c is missing unregister_chrdev()
Date: Mon, 25 Apr 2005 01:36:08 -0400
Message-ID: <9e4733910504242236391fb099@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPwGX-00032z-Kj
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 22:36:17 -0700
Received: from wproxy.gmail.com ([64.233.184.204])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DPwGV-0008MJ-42
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 22:36:17 -0700
Received: by wproxy.gmail.com with SMTP id 69so1156575wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 24 Apr 2005 22:36:08 -0700 (PDT)
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

=3D=3D=3D=3D=3D fbmem.c 1.160 vs edited =3D=3D=3D=3D=3D
--- 1.160/drivers/video/fbmem.c 2005-03-31 06:06:52 -05:00
+++ edited/fbmem.c      2005-04-25 01:33:57 -04:00
@@ -1211,6 +1211,7 @@
 fbmem_exit(void)
 {
        class_simple_destroy(fb_class);
+       unregister_chrdev(FB_MAJOR, "fb");
 }

 module_exit(fbmem_exit);

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

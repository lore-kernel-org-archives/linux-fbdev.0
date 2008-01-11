From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 1/2] ps3fb: prevent use after free of
	fb_info
Date: Fri, 11 Jan 2008 14:27:10 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801111426110.12536@vixen.sonytel.be>
References: <Pine.LNX.4.64.0801111417450.12038@vixen.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-891518858-1200058030=:12536"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JDJut-0004jF-Vo for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Jan 2008 05:27:24 -0800
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JDJut-0003X7-Ae
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Jan 2008 05:27:23 -0800
In-Reply-To: <Pine.LNX.4.64.0801111417450.12038@vixen.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Jeremy Kerr <jk@ozlabs.org>, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-891518858-1200058030=:12536
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Jeremy Kerr <jk@ozlabs.org>

In ps3fb_shutdown, freeing the framebuffer will cause fb_info (in
dev->core.driver_data) to be free()ed, which we potentially access
from the ps3fbd kthread.

This change frees the framebuffer after stopping the ps3fbd kthread.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -1234,12 +1234,6 @@ static int ps3fb_shutdown(struct ps3_sys
 	ps3fb_flip_ctl(0, &ps3fb);	/* flip off */
 	ps3fb.dinfo->irq.mask =3D 0;
=20
-	if (info) {
-		unregister_framebuffer(info);
-		fb_dealloc_cmap(&info->cmap);
-		framebuffer_release(info);
-	}
-
 	ps3av_register_flip_ctl(NULL, NULL);
 	if (ps3fb.task) {
 		struct task_struct *task =3D ps3fb.task;
@@ -1250,6 +1244,12 @@ static int ps3fb_shutdown(struct ps3_sys
 		free_irq(ps3fb.irq_no, &dev->core);
 		ps3_irq_plug_destroy(ps3fb.irq_no);
 	}
+	if (info) {
+		unregister_framebuffer(info);
+		fb_dealloc_cmap(&info->cmap);
+		framebuffer_release(info);
+		info =3D dev->core.driver_data =3D NULL;
+	}
 	iounmap((u8 __iomem *)ps3fb.dinfo);
=20
 	status =3D lv1_gpu_context_free(ps3fb.context_handle);

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village =C2=B7 Da Vincilaan 7-D1 =C2=B7 B-1935 Zaventem =C2=
=B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

Sony Network and Software Technology Center Europe
A division of Sony Service Centre (Europe) N.V.
Registered office: Technologielaan 7 =C2=B7 B-1840 Londerzeel =C2=B7 Belg=
ium
VAT BE 0413.825.160 =C2=B7 RPR Brussels
Fortis Bank Zaventem =C2=B7 Swift GEBABEBB08A =C2=B7 IBAN BE3900138235861=
9
---584349381-891518858-1200058030=:12536
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
---584349381-891518858-1200058030=:12536
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584349381-891518858-1200058030=:12536--

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Fix possible leak in fbcon code. (fwd)
Date: Thu, 2 Sep 2004 11:45:12 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0409021144550.5627@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C2o9f-0001hO-1h
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Sep 2004 02:45:19 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C2o9e-0006yI-6P
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Sep 2004 02:45:18 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Dave Jones <davej@redhat.com>

---------- Forwarded message ----------
Date: Wed, 1 Sep 2004 16:51:22 +0100
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix possible leak in fbcon code.

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/video/console/fbcon.c linux-2.6/drivers/video/console/fbcon.c
--- bk-linus/drivers/video/console/fbcon.c	2004-08-24 00:02:40.000000000 +0100
+++ linux-2.6/drivers/video/console/fbcon.c	2004-09-01 13:31:12.000000000 +0100
@@ -983,6 +983,7 @@ static void fbcon_init(struct vc_data *v
 			vc->vc_y += logo_lines;
 			vc->vc_pos += logo_lines * vc->vc_size_row;
 			kfree(save);
+			save = NULL;
 		}
 		if (logo_lines > vc->vc_bottom) {
 			logo_shown = -1;
@@ -1004,6 +1005,8 @@ static void fbcon_init(struct vc_data *v
 			softback_top = 0;
 		}
 	}
+	if (save)
+		kfree(save);
 }

 static void fbcon_deinit(struct vc_data *vc)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click

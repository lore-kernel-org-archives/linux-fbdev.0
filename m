From: syrjala@sci.fi
Subject: [PATCH 1/5] matroxfb: Remove an unused wait queue entry
Date: Tue,  1 Nov 2005 00:12:20 +0200 (EET)
Message-ID: <20051031221220.4A38E2EB@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWhtE-0004Ra-M6
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Oct 2005 14:12:28 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EWhtC-0000Nz-4X
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Oct 2005 14:12:28 -0800
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
MIME-Version: 1.0
Content-Type: text; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: vandrove@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net

wait_event_event_interruptible() uses a private wait queue entry so=20
there's no need for the caller to initialize one.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
---

 matroxfb_base.c |    2 --
 1 file changed, 2 deletions(-)

diff -uprN linux-2.6.14-0/drivers/video/matrox/matroxfb_base.c linux-2.6.14=
-1/drivers/video/matrox/matroxfb_base.c
--- linux-2.6.14-0/drivers/video/matrox/matroxfb_base.c	2005-10-28 03:02:08=
.000000000 +0300
+++ linux-2.6.14-1/drivers/video/matrox/matroxfb_base.c	2005-10-31 17:44:11=
.000000000 +0200
@@ -264,7 +264,6 @@ static void matroxfb_disable_irq(WPMINFO
 }
=20
 int matroxfb_wait_for_sync(WPMINFO u_int32_t crtc) {
-	wait_queue_t __wait;
 	struct matrox_vsync *vs;
 	unsigned int cnt;
 	int ret;
@@ -286,7 +285,6 @@ int matroxfb_wait_for_sync(WPMINFO u_int
 	if (ret) {
 		return ret;
 	}
-        init_waitqueue_entry(&__wait, current);
=20
 	cnt =3D vs->cnt;
 	ret =3D wait_event_interruptible_timeout(vs->wait, cnt !=3D vs->cnt, HZ/1=
0);



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information

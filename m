From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: excessive atyfb debug messages in 2.6.11
Date: Sun, 13 Mar 2005 17:03:10 +0100
Message-ID: <200503131703.10436.alex.kern@gmx.de>
References: <Pine.LNX.4.21.0503111206270.32544-100000@hal.pp.fishpool.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+QGNCozUnrNDjeq"
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAVxm-0001jI-Ip
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 08:29:10 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DAVxk-0003Ag-Uk
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 08:29:10 -0800
In-Reply-To: <Pine.LNX.4.21.0503111206270.32544-100000@hal.pp.fishpool.fi>
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
To: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net
Cc: =?iso-8859-1?q?Martin-=C9ric?= Racine <q-funk@iki.fi>

--Boundary-00=_+QGNCozUnrNDjeq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag, 11. M=E4rz 2005 11:18 schrieb Martin-=C9ric Racine:
> I keep on getting the following both directly to the console and to
> several logs (debug, kern.log, messages, syslog), every time I switch
> virtual console (this particular exerpt from syslog):
It seems to be unneeded last time. Driver is pretty stable.

Signed-off-by: Alexander Kern <alex.kern@gmx.de>

--Boundary-00=_+QGNCozUnrNDjeq
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="atyfb_undef_debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="atyfb_undef_debug.patch"

--- drivers/video/aty/atyfb_base.c.orig	2005-03-13 16:46:45.000000000 +0100
+++ drivers/video/aty/atyfb_base.c	2005-03-13 16:51:40.776418368 +0100
@@ -100,8 +100,8 @@
 /*
  * Debug flags.
  */
-/*#undef DEBUG*/
-#define DEBUG
+#undef DEBUG
+/*#define DEBUG*/
 
 /* Make sure n * PAGE_SIZE is protected at end of Aperture for GUI-regs */
 /*  - must be large enough to catch all GUI-Regs   */

--Boundary-00=_+QGNCozUnrNDjeq--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH] Re: atyfb h/vsync polarity
Date: Sun, 31 Jul 2005 01:07:15 +0200
Message-ID: <200507310107.16442.alex.kern@gmx.de>
References: <20050622140842.GV20191@midgar.lan.raphnet.net> <200507221206.44358.adaplas@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kgA7C3dZhH1uuCz"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dz0Qa-0002ye-Jt
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 16:07:36 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1Dz0QX-0007Bk-Lz
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 16:07:36 -0700
In-Reply-To: <200507221206.44358.adaplas@gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net, akpm@osdl.org
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Raphael Assenat <raph@raphnet.net>

--Boundary-00=_kgA7C3dZhH1uuCz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag, 22. Juli 2005 06:06 schrieb Antonino A. Daplas:
> On Wednesday 22 June 2005 22:08, Raphael Assenat wrote:
> > Hi,
> > I am a Linux Sparc64 user, and recently I decided to switch from 2.4
> > kernel series to 2.6 series. Everything worked well, but I had trouble
> > getting the framebuffer console to work.
> >
> > In openboot, my monitor worked perfectly. But as soon as Linux
> > configured the framebuffer, my monitor would loose sync. I compared the
> > output given by fbset on the working configuration (2.4 kernel) and the
> > non-working configuration (2.6.12 kernel). Every setting was identical,
> > except that the output on 2.4 had 'hsync high'. I tried 'fbset -hsync
> > high', but the screen still did not sync, and fbset still did not report
> > 'hsync high', as if the setting was ignored.
> >
> > After digging a little bit, I found this in
> > drivers/video/aty/atyfb_base.c:
> >
> > if(vdisplay < 400) {
> > 		h_sync_pol =3D 1;
> > 		v_sync_pol =3D 0;
> > } else if(vdisplay < 480) {
> > 		h_sync_pol =3D 0;
> > 		v_sync_pol =3D 1;
> > } else if(vdisplay < 768) {
> > 		h_sync_pol =3D 0;
> > 		v_sync_pol =3D 0;
> > } else {
> > 		h_sync_pol =3D 1;
> > 		v_sync_pol =3D 1;
> > }
>
> I also believe that the above code is not needed.  The appropriate
> sync signals are already correctly set (hopefully) from the entries
> in the mode database, kernel or user.
>
> Also, if I remember the VGA standards correctly, hsync and vsync
> should be high if vyres > 400.
>
> Tony

Signed-off-by: Alexander Kern <alex.kern@gmx.de>

=2D-=20

Best Wishes
Mit freundlichen Gr=FC=DFen

Alex Kern

--Boundary-00=_kgA7C3dZhH1uuCz
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="remove-unneeded-code.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="remove-unneeded-code.patch"

--- linux-2.6.12/drivers/video/aty/atyfb_base.c.orig	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/drivers/video/aty/atyfb_base.c	2005-07-31 01:01:47.000000000 +0200
@@ -911,20 +911,6 @@
 		vdisplay  = par->lcd_height;
 #endif
 
-	if(vdisplay < 400) {
-		h_sync_pol = 1;
-		v_sync_pol = 0;
-	} else if(vdisplay < 480) {
-		h_sync_pol = 0;
-		v_sync_pol = 1;
-	} else if(vdisplay < 768) {
-		h_sync_pol = 0;
-		v_sync_pol = 0;
-	} else {
-		h_sync_pol = 1;
-		v_sync_pol = 1;
-	}
-
 	v_disp--;
 	v_sync_strt--;
 	v_sync_end--;

--Boundary-00=_kgA7C3dZhH1uuCz--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click

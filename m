From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH] inivisible cursor on vesafb
Date: 19 Aug 2002 09:10:03 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1029719436.597.13.camel@daplas>
References: <20020818230541.GA1680@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-qlQ7BPGQuQMz7qKnZb6o"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17gavI-0007OP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 18 Aug 2002 18:01:37 -0700
Received: from [202.70.99.51] (AP-202-70-99-51.compass.com.ph [202.70.99.51])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id JAA41490
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Aug 2002 09:01:31 +0800 (PHT)
	(envelope-from adaplas@pol.net)
In-Reply-To: <20020818230541.GA1680@ppc.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>


--=-qlQ7BPGQuQMz7qKnZb6o
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2002-08-19 at 07:05, Petr Vandrovec wrote:
> Hi Linus,
> 
> Since vesafb was converted to the (strange) cfb* interface, it uses random
> colors for the cursor, making cursor invisible when console uses black foreground
> (f.e. Midnight Commander does that). Problem is common to all fbdevs which
> use fbcon-accel interface.
> 
> This change tries to restore old behavior which existed before cfb* came in.
> Unfortunately due to region.color semantic it is not possible to completely
> restore previous behavior - 
> + for truecolor cfbfillrect always consults current palette, so we do not 
>   have "always invert" constant available, and so we do inversion with palette
>   color 15 (it is light white, ~0, by default)
> + for directcolor it assumes that display has at least 4 bits per color.
> + for pseudocolor it works as old code worked.
> 

I think it has been agreed that all color entries in fbcon-accel should
always be an index to the pseudopalette regardless of the visuals.  So a
more consistent change is to have cfbfillrect look up the color from the
pseudopalette assuming that the driver correctly loaded the value to the
pseudopalette.



--=-qlQ7BPGQuQMz7qKnZb6o
Content-Disposition: attachment; filename=directcolor.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=directcolor.diff; charset=ISO-8859-1

--- cfbfillrect.c-orig	Mon Aug 19 00:46:03 2002
+++ cfbfillrect.c	Mon Aug 19 00:48:31 2002
@@ -52,7 +52,8 @@
 	start_index =3D ((unsigned long) dst1 & (bpl - 1));
 	end_index =3D ((unsigned long) (dst1 + n) & (bpl - 1));
=20
-	if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR)
+	if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||=20
+	    p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR  )
 		fg =3D fgcolor =3D ((u32 *) (p->pseudo_palette))[rect->color];
 	else
 		fg =3D fgcolor =3D rect->color;

--=-qlQ7BPGQuQMz7qKnZb6o--



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=3Dsourceforge1&refcode1=3Dvs3390

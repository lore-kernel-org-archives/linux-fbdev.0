From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: frame buffer -- 1024x768 logo --  Kernel Panic (fwd)
Date: Tue, 25 Jun 2002 02:57:30 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0206250257180.20000-101000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="----_=_NextPart_000_01C21BD6.780B8BA8"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17MeeM-0006Ys-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Jun 2002 17:57:42 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id CAA21808
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Jun 2002 02:57:29 +0200 (MET DST)
Content-ID: <Pine.GSO.4.21.0206250257181.20000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

------_=_NextPart_000_01C21BD6.780B8BA8
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.21.0206250257182.20000@vervain.sonytel.be>

---------- Forwarded message ----------
Date: Mon, 24 Jun 2002 16:25:47 -0700
From: Dan Boals <Dan_Boals@Phoenix.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: frame buffer -- 1024x768 logo --  Kernel Panic

Not exactly sure who to email this to so,  to whomever cares -

	hopefully this isn't old news, I tried a 1024x768 logo and got a
kernel panic.   

	I traced it down to one line of code in /drivers/video/fbcon.c

	Attached is a patch file that seems to fix the problem.  I am not
sure if this fix is absolutely correct.

	NOTE: The patch does NOT include changing the LOGO_W and LOGO_H
lines to 1024 and 768,  nor does it include a linux_logo.h file with a
1024x768 logo.


Daniel Boals
Principal Engineer
Phoenix Technologies, ltd.



------_=_NextPart_000_01C21BD6.780B8BA8
Content-Type: APPLICATION/OCTET-STREAM; NAME="fbcon.patch"
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.GSO.4.21.0206250257183.20000@vervain.sonytel.be>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="fbcon.patch"

--- RH73_KERNEL/drivers/video/fbcon.c	Mon Jun 24 16:00:12 2002=0A=
+++ RH73_KERNEL.bak/drivers/video/fbcon.c	Mon Jun 24 15:26:18 2002=0A=
@@ -688,21 +688,22 @@=0A=
     	    	scr_memcpyw(r + step, r, conp->vc_size_row);=0A=
     	    	r -=3D old_cols;=0A=
     	    }=0A=
     	    if (!save) {=0A=
 	    	conp->vc_y +=3D logo_lines;=0A=
     		conp->vc_pos +=3D logo_lines * conp->vc_size_row;=0A=
     	    }=0A=
     	}=0A=
     	scr_memsetw((unsigned short *)conp->vc_origin,=0A=
 		    conp->vc_video_erase_char, =0A=
-		    conp->vc_size_row * logo_lines);=0A=
+		    old_cols * logo_lines);=0A=
+	=0A=
     }=0A=
     =0A=
     /*=0A=
      *  ++guenther: console.c:vc_allocate() relies on initializing=0A=
      *  vc_{cols,rows}, but we must not set those if we are only=0A=
      *  resizing the console.=0A=
      */=0A=
     if (init) {=0A=
 	conp->vc_cols =3D nr_cols;=0A=
 	conp->vc_rows =3D nr_rows;=0A=

------_=_NextPart_000_01C21BD6.780B8BA8--


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/

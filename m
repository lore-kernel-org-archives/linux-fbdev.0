From: =?iso-8859-1?Q?Andr=E9_Stierenberg?= <stierenberg@gmx.de>
Subject: Mirrored and shiftet fonts and logos
Date: Sat, 14 Dec 2002 20:53:32 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <004501c2a3ab$015a5eb0$ee3c078b@nb1>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18NIPr-0006j3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 14 Dec 2002 11:57:39 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

Hello,

i=B4m using the framebuffer driver pxafb for my board using the pxa process=
or
(Accelent IDP). I have a 4 bit monocrom display. when I run the framebuffer
I have some problems. The text in the console it in some way shifted. The
two parts of the font are switched. The first 4 pixels are at dest+2 and the
last 4 pixels at dest+0. And both parts are mirrored. Now I have done the
following in fbcon_cfb4.c in function fbcon_cfb4_putcs:

  for (rows =3D fontheight(p), dest =3D dest0; rows-- ; dest +=3D bytes) {
      fb_writew((nibbletab_cfb4[rv(*cdat) >> 4] & eorx) ^ bgx, dest+2);
      fb_writew((nibbletab_cfb4[rv(*cdat++) & 0xf] & eorx) ^ bgx, dest+0);
  }


The function rv will reverse the bit order (bit 1 is bit 8, bit 2 is bit 7..
etc.).
And i have swaped the destination offset.
Now the characters are printed correctly. And in the linux logo, the
pinguin, something is also wrong. It seems the some pixels are mirrored too
whereas other pixels are correct.

What could this be and in what way can i fix the problem?

Andre




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility=20
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

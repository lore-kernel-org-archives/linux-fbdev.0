From: =?ISO-8859-1?Q?Andr=E9_Stierenberg?= <stierenberg@gmx.de>
Subject: Mirrored characters
Date: Wed, 04 Dec 2002 17:37:52 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3DEE2F60.1090804@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18JcTz-0005gP-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Wed, 04 Dec 2002 08:34:43 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Linux-fbdev-devel@lists.sourceforge.net

Hello,

i have some problems with a framebuffer. I=B4m using a PXA Processor and=20
using a moncrom display.

If I want to write something the charakters are mirrored and isn=B4t=20
displayed correctly, only parts. My display runs at bpp=3D4. If I swap the =

  definitions at the beginning of fbcon-cfb4.c for the ENDIANS the=20
characters are display correctly, but the contrast between the backgrund=20
and the charakters are not good. What can I do?

Andre



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET=20
comprehensive development tool, built to increase your=20
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en

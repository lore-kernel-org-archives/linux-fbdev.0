From: biatx@portugalmail.com
Subject: Issues with radeonfb (new) in widescreen displays
Date: Wed, 23 Jun 2004 01:06:11 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1087949171.40d8c97373b9e@webmail.portugalmail.pt>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BcvHd-0004xM-6i
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Jun 2004 17:06:33 -0700
Received: from galadriel.portugalmail.pt ([195.245.179.73])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BcvHc-0007hx-LZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Jun 2004 17:06:32 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Hi!=20
I'm having a problem on a HP NX7000 laptop (the same as Compaq X1000)
which has a mobility radeon 9000 (identified and marketed by HP as Radeon=
 9200
because of its clock rates) and a Samsung LCD with 1680x1050 (WSXGA+) as =
its
native resolution.

After booting up the system with a 1680x1050 radeonfb (only possible by e=
diting

drivers/video/aty/radeon_base.c=20

and commenting out the=20

radeon_map_ROM(rinfo, pdev);

everything appears fine, except when Xorg launches using the 'radeon'
driver and loads the GNOME environment. After that, if I switch back to a=
 vt
with eg. Ctrl+Alt+F1 my console will show up some garbled lines with gree=
n
pixels mostly, in the bottom, in the area never used because of the conso=
le font
size (as the font size isn't a multiple of the screen height, there's a l=
ittle
area in the bottom of the screen that is "wasted" and never used).=20
Weird thing is when I logout and the GDM prompt for login shows up, if I =
switch
to console with eg. Ctrl+Alt+F1 again, the screen is perfect with no garb=
led
lines in the bottom or anything out of its place :)

I'm currently using X.org server from gentoo linux with 'radeon' driver (=
package
x11-base/xorg-x11-6.7.0 ) and kernel 2.6.7 (i have tried linux-2.6.7-bk2 =
too
with no success regarding my particular issue) booted with command line:=20
"root=3D/dev/hda4" only. I don't pass any video=3Dradeonfb option because=
 at least
with the old driver the only way to get a 1680x1050 framebuffer was witho=
ut any
options in the kernel command line.

I'd really appreciate if someone could come up with a solution or patch,
otherwise i'll have to fallback to the more limited and buggy old radeonf=
b
driver that doesn't exhibit this behaviour when interacting with X.

Thanks!

Carlos Silva

__________________________________________________________
Continua a preferir gastar mais? Adira =E0 liga=E7=E3o Portugalmail.
http://acesso.portugalmail.pt/compare


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

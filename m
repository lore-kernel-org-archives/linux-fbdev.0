From: Michael Kaufmann <kaufmann@sohard.de>
Subject: Mirrored Display?
Date: Fri, 13 Dec 2002 17:33:42 -0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200212131733.42340.kaufmann@sohard.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [212.123.118.25] (helo=proxy.sohard.de)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Msmm-0006OJ-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Fri, 13 Dec 2002 08:35:37 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux-fbdev-devel@lists.sourceforge.net

Hello,

i would like to use a mono LCD with a framebuffer driver.

I've modified existing drivers, and after a lot of work i now have a clea=
r
picture on my display. Unfortunately, the complete picture is mirrored.
The Bootlogo is top/right instead of top/left and the ascii output starts=
 from=20
right to left.=20

Where is the right place to modify this behaviour?=20
I'm also looking for a possibility to rotate the picture.
Because my videocontroller can emulate 15 grayscales, i'm useing 4bpp.

It would be very nice, if someone can guide me in the right direction.

Thanks in advance!
Michael=20




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

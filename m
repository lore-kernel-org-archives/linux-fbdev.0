From: "Julien Lebot" <lesnip3r@hotmail.com>
Subject: PXA270 framebuffer
Date: Thu, 07 Jun 2007 15:22:27 +0400
Message-ID: <BAY112-F36C82E4DE08DC1A472621A83260@phx.gbl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HwG4c-0005uS-9b for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 04:22:38 -0700
Received: from bay0-omc2-s6.bay0.hotmail.com ([65.54.246.142])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HwG4a-0006s0-TM
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 04:22:38 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I'm currently developping on the Gumstix verdex platform and I noticed that =

the PXA270 processor includes a support for smartpanel screen in its =

framebuffer.

I've already written a small "driver" which is just a prototype to test if =

the LCD panel was working but it's far from being something really useful. =

(display only a picture, call some hardware functions of the LCD (rotate =

...) and exit)
Also it's not using the PXA270 framebuffer at all, the communication =

protocol is handled in software which is pretty slow (about 1sec to display =

the picture).

Since the PXA270 uses the pxafb driver I wonder is there is any plan to add =

the support for smart panels.
I thought about modifying the driver so that parameters can be passed at =

boot time specifying if it is a smart-panel or a "regular" LCD along with =

other video parameters.
In the driver I understand that it is needed to set up the framebuffer =

registers, then enabling the framebuffer and passing the data/command =

through the DMA channel 6 using some kind of scheduling function.
Well so far all my attempts did not lead to something viable :D

I've also tried to write a framebuffer driver from vfb and fbskeleton for =

this kind of screen but I'm a real newbie at kernel programming, thus =

leading to nothing at the moment.
I've posted on the linux-kernel mailing list and got some useful answers =

about kernel programming and the framebuffer itself, though I think this =

mailing list is more appropriate.

Any idea / help would be really appreciated,
Julien.

_________________________________________________________________
MSN Messenger: appels gratuits de PC =E0 PC ! =

http://www.msn.fr/newhotmail/Default.asp?Ath=3Df


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

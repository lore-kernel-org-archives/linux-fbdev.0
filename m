From: Jaap van den Handel <jaap@quest-innovations.com>
Subject: Kernel panic by write to console while switching consoles.
Date: Thu, 29 Jul 2004 17:57:26 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1091116646.41091e66f1b3c@webmail.quest-innovations.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqDHf-0000vK-G7
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Jul 2004 08:57:31 -0700
Received: from pluto.isd-holland.nl ([62.221.254.24])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BqDHe-0005cM-Rd
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Jul 2004 08:57:31 -0700
Received: from quest-innovations.nl (62-221-244-197.dsl.fiberworld.nl [62.221.244.197])
	by pluto.isd-holland.nl (Postfix) with ESMTP id 1B3B72FC395
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 29 Jul 2004 17:57:27 +0200 (CEST)
Received: (from apache@localhost)
	by quest-innovations.nl (8.11.6/8.11.6) id i6TFvRP09756
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Jul 2004 17:57:27 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Hi all,=20

The framebuffer driver for our vga device is working.
But when we tried to boot with the console directing to it, it crashed.
We are running linux 2.4.20 on an embedded MIPS @ 175MHz with a terminal=20
attached to a serial port. When we specify "console=3Dtty0" the console i=
s=20
switched from the serial console to the framebuffer console when our=20
framebuffer driver is loaded.

we found that while switching the console, it is not disabled. The consol=
e is=20
switched and before it is fully initialzed, something is already printing=
 text=20
to it.

when we disabled the console during a switch by setting=20
"printable =3D 0;" at the beginning of "take_over_console.c" in drivers/c=
har.
at the end of "take_over_console" we set it back to 1.

after this we were able to boot and see the pinguin logo with a cursor.
since it is not possible to attach a keyboard we tried=20
"echo some text > /dev/tty0" and "some text" does appear at the framebuff=
er=20
console :-).

Did we miss a setting to disable writes to the console while initializing=
 our=20
driver?
Is it a bug which only comes forward in combination with a serial console=
 or=20
relative slow cpu's?

Greetings,
Jaap van den Handel




Confidentiality Note:
This e-mail and any attachments are confidential and the information here=
in
is property of Quest Innovations B.V.. If you are not the intended recipi=
ent(s) of this e-mail,you are hereby notified that any dissemination, dis=
tribution,=20
copying, use of or reliance upon the information contained within this e-=
mail=20
or attachments is unauthorized and strictly prohibited. If you have recei=
ved
this e-mail in error, please notify us immediately by returning it to the
sender and delete this copy from your system.

Quest Innovations B.V.


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com

From: Jaap van den Handel <jaap@quest-innovations.com>
Subject: /dev/fb device files are not created.
Date: Sat, 26 Jun 2004 12:58:25 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1088247505.40dd56d1e5047@webmail.quest-innovations.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BeB0K-0007dM-Im
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 26 Jun 2004 04:05:52 -0700
Received: from otto.isd-holland.nl ([62.221.254.21])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BeB0K-0005Mf-6X
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 26 Jun 2004 04:05:52 -0700
Received: from quest-innovations.nl (62-221-244-197.dsl.fiberworld.nl [62.221.244.197])
	by otto.isd-holland.nl (Postfix) with ESMTP id B52B336409D
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 26 Jun 2004 13:05:48 +0200 (CEST)
Received: (from apache@localhost)
	by quest-innovations.nl (8.11.6/8.11.6) id i5QAwQu03558
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 26 Jun 2004 12:58:26 +0200
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

Hi,=20

I'm still working on the frame buffer driver for the vga solution my comp=
any =20
has developed. I created a test program which prints the memory addresses=
.

When I tried to run the test program I found out that suddenly
the /dev/fb* files are not created anymore when the driver registers itse=
lf.

when I create the files manually, the vfb.o and our own driver both seem =
to=20
return address 0x00000003 I think this cannot be ok.

Is there somebody who knows what the problem might be?

Thanks in advance
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
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

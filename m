From: Jaap van den Handel <jaap@quest-innovations.com>
Subject: Cannot write to framebuffer device
Date: Wed, 23 Jun 2004 14:43:54 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1087994634.40d97b0a6d65e@webmail.quest-innovations.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bd7DI-0001Qj-BK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 05:50:52 -0700
Received: from pluto.isd-holland.nl ([62.221.254.24])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Bd7DH-0001BF-UJ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 05:50:52 -0700
Received: from quest-innovations.nl (62-221-244-197.dsl.fiberworld.nl [62.221.244.197])
	by pluto.isd-holland.nl (Postfix) with ESMTP id 34FF62F02BB
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 23 Jun 2004 14:50:51 +0200 (CEST)
Received: (from apache@localhost)
	by quest-innovations.nl (8.11.6/8.11.6) id i5NChsc09649
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 14:43:54 +0200
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

I am writing a framebuffer device driver for a vga solution my company=20
has developed. I used vfb.c as an example.

The driver loads ok, but when I try  cat /dev/zero > /dev/fb1
I get "No space left on device" and the screen does not turn black.

I use fb1 because on fb0, the vfb driver is loaded so I can load / unload=
=20
our own driver (it says that it is busy when loaded as fb0)



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

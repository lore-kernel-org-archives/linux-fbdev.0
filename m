From: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: how to activate X with famebuffer
Date: Mon, 27 Sep 2004 10:45:25 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811107F50@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBnou-00035h-Hr
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Sep 2004 22:13:04 -0700
Received: from [202.125.86.130] (helo=ns2.astrainfonets.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CBnoq-0007gj-0j
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Sep 2004 22:13:04 -0700
Content-class: urn:content-classes:message
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
To: linux-fbdev-devel@lists.sourceforge.net, otto.wyss@orpatec.ch

Hello otto,

The question I am asking may the simplest of this field, but I found it =
no where.
Pls help.

How to activate X with framebuffer.

I am working with the following configuration:-
* Red Hat Linux 7.3=20
* Kernel 2.4.18-3=20
* Nvidia Riva TNT card=20
* Rivafb driver=20
* XFree86 4.2.0=20
=A0
My edited the XF86Confoig file as follows( related sections only):-

Section "device"
	Identifier "linix fb"
	Driver "rivafb"	# Is rivafb the right keyword for rivafb.o module?
	BoardName "Unknown"
EndSection

Section "Screen"
	Identifier "Screen0"
	Device "linux fb"
	Monitor "COMPAQ S510"
	DefaultDepth 8
	Subsection "Display"
		Depth 8
	EndSubSection=20
EndSection

Is rivafb the right keyword for rivafb.o module?
Is it the driver name(module name) that we should keep in the Driver =
part of Device section?

If I startx afterb modprobing the rivafb, it results in errors.
# startx=20

(EE) Fialed to load module "rivafb" ( module does not exist, 0)
(EE) No devices detected.

Please help me in this regard. I have spend good enough time on this and =
its I high time get it done.

Is it so easy a question? Just becos I didn't find any info about in the =
internet and no body replies for question.

Aim Behind all this :=20
To debug the rivafb driver when it being called or used by X server( =
XF86 ).

Regards,
Mukund jampala


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php

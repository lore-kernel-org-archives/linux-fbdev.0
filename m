From: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: RE: how to activate X with famebuffer
Date: Mon, 27 Sep 2004 14:58:50 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811107FC2@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBrm8-0004hn-AP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Sep 2004 02:26:28 -0700
Received: from [202.125.86.130] (helo=ns2.astrainfonets.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CBrm5-0004lN-Py
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Sep 2004 02:26:28 -0700
Received: from mail.esn.co.in ([202.125.80.34])
	by ns2.astrainfonets.net (8.12.8p1/8.12.8) with ESMTP id i8R9LeUE025317
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 27 Sep 2004 09:21:40 GMT
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net


Hello,
Thanks for responding.


> > How to activate X with framebuffer.
>=20
> I am not much of an expert, but I see noone is answering...
> First of all, you must be sure that the framebuffer level is
> working. What does  /proc/fb contain? There should be one or more
> line. For example, mine has
>=20
> 0 ATI Radeon Yd

Yes, u r right.
cat /proc/fb says
0 RIVA_VTNT2

>
> which means that I have one framebuffer unit available.
>=20
> Then, have a look at man fbdev. Specifically, the Driver line in your
> device section should be
>=20
> Driver "fbdev"
This statement will load the default framebuffer driver which comes with
XFree86 package. Xorg also provides a GENERIC framebuffer driver i.e.
fbdev.
This works on my system. I have no probelsm with this.
But my requirement is to activate X on rivafb (Nvidia CARD SPECIFIC
DRIVER) module.

>=20
> There should be another way. Set
>=20
> Driver "nv"
I think, saying so in XF86Config file will not activate X based on the
framebuffer driver. This works on my system even when I have not loaded
the rivafb (Nvidia card specific driver) module.
Even if the rivafb module is loaded, it is not invoked at startx (debug
message are not appearing ). I think, this edition of XF86Config file
will activate a normal video driver but not framebuffer driver.

> (for nvidia cards, including riva ones) and set
>=20
> Option "UseFBDev" "on"
>=20
I don't why to use this? If u know please provide with the info
> I have no clear idea about what the difference is. Anyway, Have a look
> at man nv and man fbdevhw.
>=20
> ALL THIS IS PURELY THEORETICAL from my point of view!! You need to
> experiment a bit.
>=20
> Carlo




Please suggest me how to activate X so that it uses rivafb (card
specific fb driver )module.

Thanks a lot for being the first one to help.

Regards,
Mukund jampala



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php

From: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: RE: how to test framebuffer driver
Date: Fri, 10 Sep 2004 10:31:14 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811107534@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5dm5-0002Hs-U6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Sep 2004 22:16:41 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1C5dll-0000rF-Dp
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Sep 2004 22:16:32 -0700
Received: from [202.125.86.130] (helo=ns2.astrainfonets.net)
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1C5dVQ-0005Tq-UH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Sep 2004 21:59:32 -0700
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
Cc: otto.wyss@orpatec.ch


> "Mukund JB." wrote:
> >
> > Can I write an application by directly opening my fb device and
> > performing operations like read/write/ioctl on it.
> >
> Yes you can, see here
>
"http://cvs.sourceforge.net/viewcvs.py/wyodesktop/wyoDesktop/checkdfb/sr
c/
> app.cpp?view=3Dmarkup"
> or here
> "http://cvs.sourceforge.net/viewcvs.py/linux-
> fbdev/fbtest/main.c?view=3Dmarkup".
> You are welcomed to enhance either test or even write your own. Best
if
> you look at this thread as well
>
"http://sourceforge.net/mailarchive/forum.php?thread_id=3D5445188&forum_i=
d
=3D2
> 357".
>=20
> O. Wyss

Are these applications running on the X server or do they run directly
on Framebuffer driver.

Being a driver writer I don't want to take the pain of developing such
an application. So, if I just develop a frame buffer driver and run
these applications by D/W them, will it work or shall I have to do any
application level changes.

Have the Application API's that access the driver have changed from
kernel to kernel.

How will the functions defined in fb_ops structure being called. r these
callback functions. If so, how can I identify the Application level call
for each of these call backs.

Thanks a lot to the Linux community for ur continuous support,
Mukund jampala.=20
=20


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php

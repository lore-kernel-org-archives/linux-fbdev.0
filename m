From: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: RE: how to activate X with famebuffer
Date: Tue, 28 Sep 2004 11:11:37 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811107FFD@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CCAhx-0003Q4-7O
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Sep 2004 22:39:25 -0700
Received: from [202.125.86.130] (helo=ns2.astrainfonets.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CCAhr-0007Vh-IH
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Sep 2004 22:39:25 -0700
Received: from mail.esn.co.in ([202.125.80.34])
	by ns2.astrainfonets.net (8.12.8p1/8.12.8) with ESMTP id i8S5YTUE002348
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 28 Sep 2004 05:34:30 GMT
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

> > I get the error message saying :-
> > (EE) Screen(s) found, but none have a usable configuration.
>=20
> <cut>
>=20
> > Section "Screen"
> > 	Identifier "Screen0"
> > 	Device "Linux Frame Buffer"
> > 	Monitor "COMPAQ S510"
> > 	DefaultDepth 8
> > 	Subsection "Display"
> > 		Depth 8
> > 	#	Modes "1024x768"
> > 	EndSubSection
> > EndSection
>=20
> Why did you comment out the "modes" line??
I am defining the mode in the lilo.conf file.
Can u suggest how to acticate X so that it works on rivafb framebuffer
driver.

>=20
> Carlo

Regards,
Mukund jampala


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php

From: Robert Schwebel <robert@schwebel.de>
Subject: Including fb.h from userspace
Date: Wed, 28 Jan 2004 11:41:13 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040128104112.GM23652@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aln8J-0007ic-Td
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Jan 2004 02:41:19 -0800
Received: from amalthea.dnx.de ([193.108.181.146] ident=mail)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Aln8J-0007mK-Gy
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Jan 2004 02:41:19 -0800
Received: from metis.pengutronix.de ([213.252.143.165]:32907)
	by amalthea.dnx.de with asmtp (Exim 4.24)
	id 1Aln8D-0005fR-Ru
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Jan 2004 11:41:13 +0100
Received: from ganymed.pengutronix.de ([213.252.143.162] ident=mail)
	by metis.pengutronix.de with esmtp (Exim 3.36 #1 (Debian))
	id 1Aln8D-0000Sx-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Jan 2004 11:41:13 +0100
Received: from robert by ganymed.pengutronix.de with local (Exim 3.36 #1 (Debian))
	id 1Aln8D-0006Hi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Jan 2004 11:41:13 +0100
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

I'm trying to compile the XFree86-4.3.99.10 framebuffer driver with
Linux-2.6.1. It breaks because the driver includes the kernel's fb.h
which includes other stuff which seems not to be userland clean.=20

What's the "right" way or variant to include fb.h from userland?=20

Robert
--=20
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstra=DFe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

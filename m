From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Subject: rotation
Date: Tue, 01 Jul 2008 12:26:39 +0200
Message-ID: <486A065F.7070607@cetrtapot.si>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDd7X-0008Ag-6Y for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Jul 2008 03:29:59 -0700
Received: from n1.cetrtapot.si ([89.212.80.162])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KDd7V-0003kd-Oc
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Jul 2008 03:29:59 -0700
Received: from localhost (localhost.dmz.cetrtapot.si [127.0.0.1])
	by n1.cetrtapot.si (Postfix) with ESMTP id BF36ABE76
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue,  1 Jul 2008 12:29:48 +0200 (CEST)
Received: from n1.cetrtapot.si ([127.0.0.1])
	by localhost (n1.dmz.cetrtapot.si [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vTj6rirXU+p8
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue,  1 Jul 2008 12:29:46 +0200 (CEST)
Received: from [172.31.65.135] (inside.kranj.cetrtapot.si [192.168.66.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by n1.cetrtapot.si (Postfix) with ESMTP id 251A0BE27
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue,  1 Jul 2008 12:29:46 +0200 (CEST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

Hello,

We have a 320x240 color TFT LCD display attached to EPSON s1d13706 chip. Cu=
rrently the display does not need rotating, but with the new LCD panel that=
 replaced the old one a rotation of 180 degrees needs to be applied. We hav=
e our own framebuffer driver - similar to drivers/video/s1d13xxxfb.c but wi=
th some additional stuff for our architecture (cris).

The question arises where is the best place to implement this rotation?

I reckon it is the kernel, since all userspace need to use framebuffer tran=
sparently.
We don't use the fbcon at all so fbcon rotation is not an option. I've spot=
ted fb_rotate field in struct fb_ops with the deprecated comment (seen in s=
keletonfb.c). I guess this is not an option too..

Then I guess I'm left with (re-)implementing the fb_mmap/fb_read/fb_write/f=
b_fillrect/fb_copyarea/fb_imageblit ?!?!

Any comments?

Best regards,
Hinko

-- =

=C8ETRTA POT, d.o.o., Kranj
Planina 3
4000 Kranj
Slovenia, Europe
Tel. +386 (0) 4 280 66 03
E-mail: hinko.kocevar@cetrtapot.si
Http: www.cetrtapot.si


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php

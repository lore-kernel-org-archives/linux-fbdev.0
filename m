From: Rolf Offermanns <rolf.offermanns@gmx.net>
Subject: color map vs. pseudo-palette vs. RAMDAC registers
Date: Mon, 24 Oct 2005 09:48:50 +0200
Message-ID: <200510240948.50185.rolf.offermanns@gmx.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ETx4m-0000sy-3T
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 00:49:00 -0700
Received: from mail.sysgo.com ([62.8.134.5])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ETx4k-0001he-Eb
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 00:49:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id EF4A8FB877
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Oct 2005 09:48:50 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id DD724FB877
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Oct 2005 09:48:50 +0200 (CEST)
Received: from kolab.sysgo.com (rof.sysgo.com [172.22.10.10])
	by donald.sysgo.com (Postfix) with ESMTP id E98251AE865
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Oct 2005 09:48:48 +0200 (CEST)
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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

Hi All,
I tried to understand the skeletonfb driver code, and I am confused by some=
=20
comments in it:

I do not understand what the color map and pseudo palette stuff is used for.

=46rom the c file:
=2D-------------------------------------------------------------------
Pseudocolor:
* cmap is not used
* DAC[X] is programmed to (red, green, blue)
=2D-------------------------------------------------------------------
Does that mean, I do not need to allocate a color map, if my driver would o=
nly=20
support pseudocolor visual? Is pseudocolor always used for 8bpp or are ther=
e=20
situations where 16bpp pseudocolor makes sense?

=2D------------------------------------------------------------------------=
=2D---
Truecolor:
     *    does not use RAMDAC (usually has 3 of them).
     *    var->{color}.offset contains start of bitfield
     *    var->{color}.length contains length of bitfield
     *    cmap is programmed to (red << red.offset) |=20
				(green << green.offset) |
    				(blue << blue.offset) |=20
				(transp << transp.offset)
     *    RAMDAC does not exist
=2D------------------------------------------------------------------------=
=2D---
Now I am lost:
=2D> does not use RAMDAC.=20
I understand this. It states the same in my chip reference. But what means=
=20
"usually has 3 of them" in this context?

=2D> cmap is programmed to...
In the code that follows this comment, not the cmap is programmed, but the=
=20
pseudo palette.
1. Why do I need a pseudo palette and where does its size 16 comes from?
2. What do I need a color map for?

=2D> RAMDAC does not exist <-> "usually has 3 of them"
???

Please shed some light on me.

Thanks,
Rolf



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information

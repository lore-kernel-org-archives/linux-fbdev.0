From: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: how to test framebuffer driver
Date: Wed, 8 Sep 2004 16:09:53 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348111073FB@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4zpn-0003YG-0r
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 03:37:51 -0700
Received: from [202.125.86.130] (helo=ns2.astrainfonets.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C4zpl-0000RT-LL
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 03:37:50 -0700
Received: from mail.esn.co.in ([202.125.80.34])
	by ns2.astrainfonets.net (8.12.8p1/8.12.8) with ESMTP id i88AXPUE001160
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 8 Sep 2004 10:33:27 GMT
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

Hello all,

my task is to write frame buffer driver.
can someone provide me some material for - how to remove the existing
framebuffer driver and place mine when testing it. Is these any other
way i can test my framebuffer driver.

Are there any applications which can directly run on framebuffer driver
other than X server.
If yes, what r they and how can I test my framebuffer driver using them.
If no, how can I test the fb driver using X server.

Please send all notes, corrections and additions to me regarding the
framebuffer drivers.

Can I write an application by directly opening my fb device and
performing operations like read/write/ioctl on it.

					OR

Are there any functions for the following list of fb_ops function
pointer.
I mean when they will be called. r there any system calls for calling
them.

=20
regards,
mukund jampala



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click

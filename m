From: "Queisser, Andrew (C++ rules)" <andrew.queisser@hp.com>
Subject: "Remote" frambuffer - is it possible?
Date: Thu, 15 Jul 2004 09:37:04 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <F7D7691C9511064FA92D5891E144AECB1D539F@cacexc06.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bl9EQ-0005OV-LB
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Jul 2004 09:37:14 -0700
Received: from zcamail03.zca.compaq.com ([161.114.32.103])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bl9EQ-0005HN-D2
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Jul 2004 09:37:14 -0700
Received: from cacexg11.americas.cpqcorp.net (cacexg11.americas.cpqcorp.net [16.92.1.50])
	by zcamail03.zca.compaq.com (Postfix) with ESMTP id C3965D7EB
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Jul 2004 09:37:05 -0700 (PDT)
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
To: "Linux-Fbdev-Devel (E-mail)" <linux-fbdev-devel@lists.sourceforge.net>

We're planning to hook up an ARM running Linux to=20
a DSP that has a video (NTSC) output. We'd like to
develop a framebuffer driver that displays on the TV.
However, there's no shared memory between the ARM
and the DSP so we're planning on using I/O to move
data between the two processors. Questions:

- Does something like this exist? I'd like to look at some
source to gauge the complexity.

- Can we know when to shovel the data from the ARM
to the DSP? (Similar question asked in another thread,
I'll follow that too)

- Is there a "null" framebuffer driver which simply provides
the interface to apps but doesn't actually do anything
with the pixels? Seems like that would be a good place
to start. If not, which simple driver should I look at to
get an in-depth understanding of how this stuff works?

Thanks much,
Andrew Queisser



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click

From: Manish RATHI <manish.rathi@st.com>
Subject: query (critical problem)
Date: Thu, 15 Jul 2004 17:40:14 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <004a01c46a64$af896ef0$7c04b40a@dlh.st.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bl54L-0008SX-45
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Jul 2004 05:10:33 -0700
Received: from beta.dmz-eu.st.com ([164.129.1.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1Bl54J-0003ww-H8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Jul 2004 05:10:31 -0700
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 29981DC43
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Jul 2004 12:10:20 +0000 (GMT)
Received: from zeta.dmz-eu.st.com (localhost [127.0.0.1])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C074512301
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Jul 2004 12:10:19 +0000 (UTC)
Received: from mail2.dlh.st.com (mail2.dlh.st.com [138.198.194.103])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5679EF446
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Jul 2004 12:10:17 +0000 (GMT)
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

Hi,
I've ported linux on our chip using  linux kernel 2.4.20. On chip we =
have a display interface on which epson panel is attached. We've written =
a display driver using framebuffer driver as a upper layer.

Problem with this driver is that due to framebuffer concept we don't =
know when data is updated in framebuffer as this is done by application.

So we don't know when to transfer data from framebuffer to panel memory. =
how a driver can know this trigger.

B'coz of this we have only one option left that is always transfer data=20
to dif panel from fraembuffer irrespective of any trigger.

This will create power problem.

As i understand microwindows/qt or any graphics package call open, mmap =
from framebuffer. Whenever it draw a line it doesn't call any driver =
interface.

Is there any solution?
Is there any standard interface of application with driver which tell=20
that data is to be updated from frmebuffer to panel memory?

Thanks


Regards
Manish



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click

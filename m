From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Subject: write() to zero length framebuffer -- bug report
Date: Tue, 13 Dec 2005 14:33:36 -0000
Message-ID: <35786B99AB3FDC45A8215724617919736D918C@gbrwgceumf01.eu.xerox.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmBFE-000748-S6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 06:35:08 -0800
Received: from wvmler2.mail.xerox.com ([13.8.138.217])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1EmBFC-00005g-W6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 06:35:08 -0800
Received: from wvmlir2.mail.xerox.com (wvmlir2.mail.xerox.com [13.147.8.222])
	by wvmler2.mail.xerox.com (8.13.4/8.13.1) with ESMTP id jBDEZ3To017384
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 Dec 2005 06:35:03 -0800
Received: from wvmlir2.mail.xerox.com (localhost [127.0.0.1])
	by wvmlir2.mail.xerox.com (8.13.4/8.13.1) with ESMTP id jBDEYac2031640
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 Dec 2005 06:34:36 -0800
Received: from usa7061gw02.na.xerox.net (usa7061gw02.na.xerox.net [13.151.32.4])
	by wvmlir2.mail.xerox.com (8.13.4/8.13.1) with ESMTP id jBDEYahD031615
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 Dec 2005 06:34:36 -0800
Content-class: urn:content-classes:message
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

In the vanilla 2.4.20 kernel version of fbmem.c, the function
fb_write() returns zero if the framebuffer size (fix.smem_size)
is zero, instead of -ENOSPC. This causes a normal user program
to loop forever.

Looking at the code for vanilla 2.6.10 and 2.6.11, the situation
is complicated by the new info.screen_size and kmalloc-ing a
buffer, but the bug is still there.

Clive


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

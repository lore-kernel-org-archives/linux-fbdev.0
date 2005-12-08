From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Subject: Frame swapping
Date: Thu, 8 Dec 2005 15:24:03 -0000
Message-ID: <35786B99AB3FDC45A8215724617919736D9180@gbrwgceumf01.eu.xerox.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkNdv-0002Fz-30
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 07:25:11 -0800
Received: from wvmler1.mail.xerox.com ([13.8.138.216])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1EkNds-00047f-8g
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 07:25:11 -0800
Received: from wvmlir1.mail.xerox.com (wvmlir1.mail.xerox.com [13.147.8.221])
	by wvmler1.mail.xerox.com (8.13.4/8.13.1) with ESMTP id jB8FP2fe008221
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 8 Dec 2005 07:25:02 -0800
Received: from wvmlir1.mail.xerox.com (localhost [127.0.0.1])
	by wvmlir1.mail.xerox.com (8.13.4/8.13.1) with ESMTP id jB8FOpGF018090
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 8 Dec 2005 07:24:51 -0800
Received: from usa7061gw02.na.xerox.net (usa7061gw02.na.xerox.net [13.151.32.4])
	by wvmlir1.mail.xerox.com (8.13.4/8.13.1) with ESMTP id jB8FOoR8018075
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 8 Dec 2005 07:24:51 -0800
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

How is frame swapping done, using the mechanisms provided
by FB (in 2.4 and 2.6)?
Can anyone point me to any good code examples in the
existing FB device drivers?

["Frame swapping" or "video page flipping" is switching
to an alternate framebuffer memory area during the
vertical blank period. This is a common technique to
achieve animation or a single clean change of picture.]

Thanks,
Clive


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

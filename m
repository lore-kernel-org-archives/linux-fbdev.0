From: Boris Bezlaj <boris@gajba.net>
Subject: vertical stripes under OpenFirmware and offb
Date: Fri, 28 Mar 2003 12:05:28 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030328110528.GA2403@gajba.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.g-kabel.si ([193.189.173.117] helo=localhost.localdomain)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yrg8-0007rs-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Mar 2003 03:05:44 -0800
Received: from kista.g-kabel.com ([212.118.89.28])
	by localhost.localdomain (8.12.5/8.12.5) with ESMTP id h2SCaLKQ015828
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Mar 2003 12:36:21 GMT
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hello,

could anyone explain what kind of misconfiguration of framebuffer in OpenFirmware
or in general would cause the vertical stripes effect? White stripes, width about the
same as the width of characters and some garbage pixels between lines on black background.
If the white stripes would stick together, the screen with letters would look in order.

AFAIK, OF doesn't initialize the video card (IMS TT 128mb8) and i get the same under
offb driver(unless i use the hacked version of imsttfb).

In what should i look into to fix that? I have the documentation for TVP3030 ramdac.

-- 

  Boris


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en

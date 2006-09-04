From: "David Klempner" <klempner@imsanet.org>
Subject: fbcon can call fb_set_logo after boot
Date: Sun, 3 Sep 2006 22:34:35 -0500 (CDT)
Message-ID: <46559.24.14.83.75.1157340875.squirrel@mail.imsanet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GK5EL-0001yj-IW for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Sep 2006 20:34:37 -0700
Received: from imsanet.org ([63.223.46.122])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GK5EL-00024a-8L
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Sep 2006 20:34:38 -0700
Received: from localhost (unknown [127.0.0.1])
	by imsanet.org (Postfix) with ESMTP id 4935312004CE
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon,  4 Sep 2006 03:34:35 +0000 (UTC)
Received: from imsanet.org ([127.0.0.1])
	by localhost (imsanet.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HSlJz4wO5qXV
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun,  3 Sep 2006 22:34:35 -0500 (CDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

It would appear that the first time fbcon fbcon_takeover()'s a
framebuffer, it displays the logo on that buffer. The problem is, the
logo data is __initdata, and the first framebuffer might be from a
module loaded after the kernel frees __init stuff.

I believe this has only oops'ed on me once thusfar in the dozens of
times I've loaded the driver I'm working on, but it should probably be
fixed. I'd do it myself, but I don't yet grok the fbcon code enough to
see the best fix...

-- 
David Klempner

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

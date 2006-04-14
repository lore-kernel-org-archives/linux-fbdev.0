From: Richard Purdie <rpurdie@rpsys.net>
Subject: Behaviour change of /dev/fb0?
Date: Fri, 14 Apr 2006 11:16:08 +0100
Message-ID: <1145009768.6179.7.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FULLf-0004mY-AV
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 03:16:19 -0700
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FULLd-0002z5-Mn
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 03:16:19 -0700
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
Cc: linux-kernel@vger.kernel.org

Ignoring whether this is a good idea or not, under 2.6.15 you could run

dd if=/dev/zero of=/dev/fb0

which would clear the framebuffer. It would end up saying "dd: /dev/fb0:
No space left on device".

Under 2.6.16 (and a recent git kernel), the same command clears the
screen but then hangs. Was the change in behaviour intentional? 

I've noticed this on a couple of ARM based Zaurus handhelds under both
w100fb and pxafb.

Richard



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

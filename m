From: Zack Smith <fbui@comcast.net>
Subject: fbcon bug?
Date: Sun, 13 Nov 2005 21:24:36 -0500
Message-ID: <4377F564.6000704@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbU1W-00027Z-3w
	for Linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Nov 2005 18:24:46 -0800
Received: from sccrmhc14.comcast.net ([204.127.202.59])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EbU1T-0006Lv-Rl
	for Linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Nov 2005 18:24:46 -0800
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linux-fbdev-devel@lists.sourceforge.net

Hi all,

I've noticed that 2.6.14, when a console switch occurs going
from a console that is KD_TEXT to one that is KD_GRAPHICS,
fbcon doesn't seem to immediately shut down the cursor. It appears
to draw or undraw the cursor at least once before it disables
cursor activity due to graphics mode.

Does anybody know if this bug has been corrected in 14.1 or .2,
or if anyone would mind if I go in and fix it?

Thanks,
Zack Smith




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

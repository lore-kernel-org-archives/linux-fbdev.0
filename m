From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: console resize working
Date: Mon, 29 Dec 2003 18:04:34 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1072681474.812.12.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Aaraq-0006cr-Um
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 28 Dec 2003 23:13:36 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AarSs-0004y2-8F
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 28 Dec 2003 23:05:22 -0800
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
To: John Zielinski <grim@undead.cc>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi !

I have console resize working properly finally (and not trashing
over memory like mad after I closed a bunch of races in the VT
code itself) in my tree.

Right now, that relies on the low-level fbdev doing some kind of
mode validation and implementing FB_ACTIVATE_FIND though. Sucks a
bit but I'll fix fbdev's. No other way to do that properly imho.
Only my new radeonfb implements that for now (and it's only tested
on flat panels so far, where I allow almost any mode when I have a
scaler).

Comments welcome.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

From: John Zielinski <grim@undead.cc>
Subject: Changing modes with fbset
Date: Wed, 10 Dec 2003 02:03:08 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FD6C52C.7090906@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATyNW-00083X-2k
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Dec 2003 23:03:22 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1ATyNV-0001xy-Q1
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Dec 2003 23:03:21 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net

I've downloaded fbutils from the CVS and fixed up the source so that 
they work (for the most part).  It reads the modedb and finds the mode I 
requested on the command line.  But when it tries to switch my monitor 
looses sync and the machine hangs.  I did a var.Print instead of the 
var.Set and the values look OK.  Anyone have any ideas?

John




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

From: John Zielinski <grim@undead.cc>
Subject: Radeonfb hsync fudge factor?
Date: Tue, 23 Dec 2003 18:43:17 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FE8D315.1000904@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYwBd-0007vp-06
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 15:43:37 -0800
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AYwBc-0005Dy-L9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 15:43:36 -0800
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

What's the hsync fudge factor used for?

I noticed that the left edged of my screen moved a bit when I was 
switching between 32/16/8 bpp modes and tracked it down to this.

John

p.s.  I have this urge to giggle every time I type in the words "fudge 
factor" for some reason.  :)




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

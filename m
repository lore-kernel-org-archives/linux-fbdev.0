From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: New radeonfb 0.2.0 (take 2)
Date: Tue, 09 Sep 2003 17:22:41 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1063120961.647.3.camel@gaston>
References: <20030909145202.47914.qmail@web14909.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wkKQ-0006N6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 08:22:50 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19wkKN-0003dL-R9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 08:22:48 -0700
In-Reply-To: <20030909145202.47914.qmail@web14909.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Kronos <kronos@kronoz.cjb.net>

On Tue, 2003-09-09 at 16:52, Jon Smirl wrote:
> I meant make it into two separate device drivers, not just split the files. 
> Then the user could load base+DRI, base+FB or base+FB+DRI. This would minimize
> the RAM footprint and let the DRI people avoid the problem of mapping the
> framebuffer into kernel space.

Well, what would base do then ? You can only set modes etc... by beeing
an fbdev, and if you are an fbdev you have to map something for fbcon...

What would 'base' be without all of this ? just the PCI probing ?

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

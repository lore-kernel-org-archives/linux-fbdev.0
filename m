From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: cfb_* / fbcon vs. 64 bits
Date: Wed, 05 Nov 2003 17:01:19 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1068012079.707.140.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AHGkB-00033t-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 04 Nov 2003 22:02:15 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AHGkB-0008VA-5D
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Nov 2003 22:02:15 -0800
Received: from [202.81.18.30] (helo=gaston.ozlabs.ibm.com)
	by pentafluge.infradead.org with asmtp (Exim 4.22 #5 (Red Hat Linux))
	id 1AHGlK-0000vh-GU
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Nov 2003 06:03:27 +0000
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi !

Did anybody tested a non-accelerated framebuffer device (that is one
using the cfb_* functions) on a 64 bits arch ?

Here, with radeonfb, the mode gets properly sync'ed, but I get garbage
on the first lines where the logo should be, and then other junk that
looks like some address calculations aren't done properly in the
blitting code.

Same machine, same driver, with a 32 bits kernel it works just fine.

And yes, the driver itself seem to be passing properly the 64 bits
result of ioremap, but taht could be the problem. On ppc64, ioremap
returns "weird" addresses which are token that only readx/writex
can actually understand. Maybe I should try to "munge" this a bit
first...

Ben.





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

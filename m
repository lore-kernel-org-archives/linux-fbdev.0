From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: set_par/check-var vs. fbcon
Date: Wed, 29 Oct 2003 09:19:22 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1067379561.3326.36.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEcE6-0001Wo-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 28 Oct 2003 14:22:10 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AEcCB-0000yA-HK
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 28 Oct 2003 14:20:14 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi !

I'm having a problem getting proper semantics for set_par/check_var
calls with 2.6 in radeonfb.

So far, I assumed they would be called with a complete structure
containing mode timings etc... though check_var() would eventually
fail if not supported and/or slightly "adapt" the var.

That is the behaviour that is needed for things like MacOnLinux
(or even XFree on top of fbdev) to work properly.

However, when stty is used, the fbcon code will call these with
a var which is the current one with only the size changed. That
is it asks for a mode with a different size, but the timings of
the previous one. This doesn't work properly with radeonfb, and
I wonder if there is one fbdev that has this working properly
at all...

For such thing, we need to pick a full mode (timings included)
that matches the new size... So the semantics expected by the
call issued from fbcon are more like "pick a mode that has this
size", though the timings in there are a "hint" to eventually
pick a mode that has the same vfreq... 

I wonder... maybe we shall set a specific flag when doing that
set_var call from fbcon to trigger the intended mecanism. Or
should we have all check_var()/set_par() calls in drivers
implement a mecanism by default ? That would prevent userland
from using the ioctl to change the timings precisely though...

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

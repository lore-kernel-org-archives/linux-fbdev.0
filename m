From: James Simmons <jsimmons@infradead.org>
Subject: Framebuffer cursor updates.
Date: Wed, 2 Apr 2003 19:56:32 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0304021137570.7983-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 190nQ3-0007IR-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Apr 2003 10:57:08 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Hi folks!!!

  I have a new patch to fix the cursor problems. This patch Is a massive 
rewrite of the cursor handling code. I have tested it on two machines. The 
VBL irq code in fbcon.c should be moved to there respected drivers. Please 
review and test. 

Please note a change happened to the cursor api that breaks the i810 and 
NVIDIA framebuffers. A patch will be created for them very soon. Tose 
patches will be part of the next pull to linus.

P.S
   The framebuffer had 3 major issues. One was the cursor. This should fix 
the final issues with it. Yes I know that we are still using a spinlock in 
fb_get_buffer_offset but that would mean surgery to the upper layer 
console for the blank timer handlers. Yuck!!! That might still have to be 
done.
   The second issue is handling monitor limits and finding what modes are 
supported by a video card. I just recieved a nice patch from Tony for 
this. I plan to test it and pass it along after the cursor fixes.
   The 3rd issue is tilebliting. Some hardware can cache the font images 
in hardware and then just index that image by a handle. I will work on 
this next while tony works on EDID support. 

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/

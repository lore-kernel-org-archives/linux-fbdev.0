From: James Simmons <jsimmons@infradead.org>
Subject: Re: neofb problem with console mode early in
 boot and after X is started
Date: Wed, 2 Apr 2003 23:09:21 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304022305170.3919-100000@phoenix.infradead.org>
References: <1049061225.2658.49.camel@joelm.2y.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 190qQd-0008U6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Apr 2003 14:09:56 -0800
In-Reply-To: <1049061225.2658.49.camel@joelm.2y.net>
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
To: Joel Metelius <jome0008@hotmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


> Problem appears both in 2.5.66 and when applying the patch fbdev.diff.gz
> as of 31/3.
> 
> 1. The penguin is only green lines.

No color image support yet. I need to fix that. Easy fix.

> 2. After X is started the console font rendering is currupted and the
> letters take up 2 times its width and 2 times its height by only setting
> top left pixel in a 2x2 pixel square (the other 3 pixels are black).
> This makes the console unusable since the letters and lines are drawn
> 50% on top of each other.

??? I will have to test the neofb driver for this. I have this card.

> 3. vga=0x305 that works in 2.4 kernel only makes the screen blank and
> boot hangs.

vga=... works only with the vesafb driver. You need to use the modedb 
command line. See Documentation/fb/modedb.txt for details.

> More specific:
> 
> After GRUB splash only 25% of the screen is used (80x25).

Okay. That is strange. Might be related to the VESA vga= issue.

> The choose resolution question is displayed (vga=ask).
> I press [SPACE] and boot continues.
> After a while the resolution is switched to 100% (128x48) and before
> entering runlevel 5 the console is OK.

You are telling the BIOS to set the resolution and then the native driver 
takes over and fixes the problem.

> After X (gdm) is started, switching to console mode makes the problem
> described above appear.

> Sometimes the boot hangs after:

That is sound card problems. 



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/

From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 12 Mar 2003 04:07:53 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047407816.1013.182.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303111628240.23668-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sq5T-0005E4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 12:10:59 -0800
In-Reply-To: <Pine.LNX.4.44.0303111628240.23668-100000@phoenix.infradead.org>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-12 at 00:29, James Simmons wrote:
> 
> > So, I think fbcon should also detect if the previous console is not
> > fbcon (ie previous con > last_fbvc || previous con < first_fbvc), and if
> > it isn't, force an fb_set_par.
> 
> This whole idea of mapping a specific VC to a specific piece of hardware 
> is just plain dumb and overly complex. The new console system will 
> allocate a set of 16 console to each independent VT.
> 

Well, you have info->currcon, fg_console etc...  No mapping is done,
fbcon will just keep track of the tty's it's currently switched to (vt.c
does it, and so does fbcon_switch), and fbcon will just look if the vc
has a valid PID (which means a process installed its own vc) and
therefore not trust it to completely preserve the graphics state.

Note that X does something like this to protect itself.  When switch
from console to X, it refreshes its own registers.

I think you may need some support for this.  Several have already
reported that switching from X to a console results in a corrupted
display which can be cleared by doing an fbset. 

The choices are:

1. refresh the registers at every switch - slowest but guarantees
hardware state is always preserved 
 
2. do not refresh unless var changed - fasted but can result in
corruption/crash if registers were changed behind the back of fbdev

3. selective refresh - do not refresh if switching between "trusted"
consoles, refresh if switching from "untrusted" consoles.

4. Find a method to detect if the registers were changed behind the back
of fbdev.

Tony 



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en

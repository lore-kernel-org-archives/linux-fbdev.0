From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Tue, 11 Mar 2003 21:56:58 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E6E4D9A.7060003@winischhofer.net>
References: <Pine.LNX.4.44.0303111628240.23668-100000@phoenix.infradead.org> <1047407816.1013.182.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18] helo=home.winischhofer.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sqnR-000894-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 12:56:26 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino Daplas wrote:
> Well, you have info->currcon, fg_console etc...  No mapping is done,
> fbcon will just keep track of the tty's it's currently switched to (vt.c
> does it, and so does fbcon_switch), and fbcon will just look if the vc
> has a valid PID (which means a process installed its own vc) and
> therefore not trust it to completely preserve the graphics state.
> 
> Note that X does something like this to protect itself.  When switch
> from console to X, it refreshes its own registers.

Which does not neccessarily mean that the framebuffer driver must do the 
same, resulting in two mode switches. Not really healthy for LCD panels.

The current implementation (as with James' latest patch) does not show 
any problems with this, even when switching back to a console with a 
different resolution than the one X was started under. Then again, maybe 
that's just due to a all too well working sis driver combination :)

> I think you may need some support for this.  Several have already
> reported that switching from X to a console results in a corrupted
> display which can be cleared by doing an fbset. 
> 
> The choices are:
> 
> 1. refresh the registers at every switch - slowest but guarantees
> hardware state is always preserved 

Bad. Takes long time, especially on LCD displays which always need a 
little delay for backlight and sync stability reasons.

> 2. do not refresh unless var changed - fasted but can result in
> corruption/crash if registers were changed behind the back of fbdev

I think one can rely on tidyness of applications changing the registers. 
Like X does.

> 3. selective refresh - do not refresh if switching between "trusted"
> consoles, refresh if switching from "untrusted" consoles.
> 
> 4. Find a method to detect if the registers were changed behind the back
> of fbdev.

Very time taking on some hardware (such as ... erm... SiS) with more 
than 100 registers for graphic mode setup.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net          *** http://www.winischhofer.net



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en

From: Marcelo Pacheco <marcelo@macp.eti.br>
Subject: Re: [BK fbdev updates]
Date: Sun, 12 Jan 2003 22:15:34 -0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E220526.4040802@macp.eti.br>
References: <Pine.LNX.4.33.0301111623070.8368-100000@maxwell.earthlink.net> <20030112150744.GH14017@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from inova101.correio.tnext.com.br ([200.222.67.101] helo=leia-out.correio.tnext.com.br)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XsHA-0002xH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 Jan 2003 16:16:25 -0800
In-Reply-To: <20030112150744.GH14017@suse.de>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

>
>
>James,
>
>2.5 still doesn't work on my vaio (I think I told you about this 3-4
>months ago) with the neofb. It just crashes with a black screen. If you
>don't have any clues what the problem is, I can hook the machine up to a
>serial console and see if anything interesting pops up. Using vesafb
>does make it boot, however the screen stays pitch black until X loads...
>
I have 2 machines that are running 2.5.56 beatifully, except for fbcon 
and ISDN.
The laptop runs ATI radeon - when I attempt to boot with radeonfb+fbcon 
statically linked it wraps the pixels as if the driver is using 1410 
pixels per row while the hardware only has 1400
The desktop has a Vodoo 3500 AGP - when I attempt to boot with 
3dfxfb+fbcon statically it freezes early in the boot, probably right 
when the fb stuff starts.
I'm running 2.5.56 on both, so any tests, on any further info, just let 
me know.
I'm not on the list, so please CC me on any replies.

Marcelo Pacheco




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com

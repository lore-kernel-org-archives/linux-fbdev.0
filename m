From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: set_par/check-var vs. fbcon
Date: Wed, 29 Oct 2003 10:37:03 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0310291035480.10663-100000@waterleaf.sonytel.be>
References: <1067379561.3326.36.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEmlT-0002cn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 01:37:19 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AEmlS-0001gi-Np
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Oct 2003 01:37:18 -0800
In-Reply-To: <1067379561.3326.36.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 29 Oct 2003, Benjamin Herrenschmidt wrote:
> I'm having a problem getting proper semantics for set_par/check_var
> calls with 2.6 in radeonfb.
> 
> So far, I assumed they would be called with a complete structure
> containing mode timings etc... though check_var() would eventually
> fail if not supported and/or slightly "adapt" the var.
> 
> That is the behaviour that is needed for things like MacOnLinux
> (or even XFree on top of fbdev) to work properly.
> 
> However, when stty is used, the fbcon code will call these with
> a var which is the current one with only the size changed. That
> is it asks for a mode with a different size, but the timings of
> the previous one. This doesn't work properly with radeonfb, and
> I wonder if there is one fbdev that has this working properly
> at all...
> 
> For such thing, we need to pick a full mode (timings included)
> that matches the new size... So the semantics expected by the
> call issued from fbcon are more like "pick a mode that has this
> size", though the timings in there are a "hint" to eventually
> pick a mode that has the same vfreq... 
> 
> I wonder... maybe we shall set a specific flag when doing that
> set_var call from fbcon to trigger the intended mecanism. Or
> should we have all check_var()/set_par() calls in drivers
> implement a mecanism by default ? That would prevent userland
> from using the ioctl to change the timings precisely though...

Can't fbcon/stty create a var for the specified resolution from the
modedb/gttf?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

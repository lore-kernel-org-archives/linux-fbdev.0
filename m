From: James Simmons <jsimmons@infradead.org>
Subject: Re: set_par/check-var vs. fbcon
Date: Wed, 29 Oct 2003 22:39:24 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310292220340.21040-100000@phoenix.infradead.org>
References: <1067465383.27088.25.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEyyO-0002Wn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 14:39:28 -0800
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AEyyO-0000Tm-80
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Oct 2003 14:39:28 -0800
In-Reply-To: <1067465383.27088.25.camel@gaston>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > Can't fbcon/stty create a var for the specified resolution from the
> > modedb/gttf?
> 
> Actually, I'd prefer my driver to create a var from the width/height/freq,
> especially since I've brought in EDID stuff, as my driver is the one who
> knows what modes are really useable on the monitor. Or maybe, create an
> "official" way for the driver to expose the modedb it created to fbcon...
> 
> This is even more true with iMacs & their fixed -hfreq monitor. I've not
> 'fixed' that yet, but ultimately, the driver will have a specific modedb
> as well for the display.

   We have the ability to create a var based on height, width and another 
variable. When we lack EDID data we use the GTF formulas. The function for
this is fb_get_mode in fbmon.c. Now when we do have EDID info we use the function. 
For this we have fb_get_monitor_limits. 
   The monitor info is very important. It is used to validate or invalidate a mode.  
The next set of functions that are important are:

fb_validate_mode		-> Used in all cases. Validates a var.
fb_create_modedb
fb_destroy_modedb






-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

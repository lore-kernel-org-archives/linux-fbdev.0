From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: set_par/check-var vs. fbcon
Date: Thu, 30 Oct 2003 09:09:44 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1067465383.27088.25.camel@gaston>
References: <Pine.GSO.4.21.0310291035480.10663-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEyWJ-0004kF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 14:10:27 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AEyWI-0008Aw-PX
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Oct 2003 14:10:27 -0800
In-Reply-To: <Pine.GSO.4.21.0310291035480.10663-100000@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Can't fbcon/stty create a var for the specified resolution from the
> modedb/gttf?

Actually, I'd prefer my driver to create a var from the width/height/freq,
especially since I've brought in EDID stuff, as my driver is the one who
knows what modes are really useable on the monitor. Or maybe, create an
"official" way for the driver to expose the modedb it created to fbcon...

This is even more true with iMacs & their fixed -hfreq monitor. I've not
'fixed' that yet, but ultimately, the driver will have a specific modedb
as well for the display.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

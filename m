From: James Simmons <jsimmons@infradead.org>
Subject: Re: Feature Freeze?
Date: Tue, 11 Mar 2003 15:55:12 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303111553380.23668-100000@phoenix.infradead.org>
References: <1046910001.1227.22.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sm7C-00070w-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 07:56:31 -0800
In-Reply-To: <1046910001.1227.22.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> I have already a working fbcon module unloading code in my local copy. 
> The way it works is like this.  
> 
> 1. If take_over_console() is called with the "default" flag clear, it
> behaves as usual.  It takes only a subset of console numbers but
> "conswitchp" still points to the console driver that was loaded at boot
> time.
> 
> 2. If take_over_console() is called with the "default" flag set, it will
> replace "conswitchp", but the original value of "conswitchp" is saved.
> 
> 3.  If take_over_console() with the "default" flag set is called again,
> it will fail.  It's not logical to just overwrite "conswitchp" over and
> over again.
> 
> 4. If give_up_console() is called and if the previous
> take_over_console() did not overwrite "conswitchp", it proceeds as
> usual.
> 
> 5. If give_up_console() is called and if the previous
> take_over_console() overwrote "conswitchp", give_up_console() will also
> call take_over_console() but using the saved "conswitchp".
> 
> I can then load fbdev and fbcon as modules.  If I "rmmod fbcon", I get
> back again to vgacon/dummycon/whatever.  I can then load and unload
> different fbdev's and load fbcon at will.
> 
> If I want to load mdacon, it will still work on top of fbcon, because
> mdacon calls take_over_console() with the "default" flag cleared.
> 
> If you need to load other console drivers, then fbcon must be unloaded
> first.  This is because the rest of the console drivers call
> take_over_console() with the "default" flag set.
> 
> I can already load/unload fbcon using vga16fb, rivafb or i810fb as the
> backend at will.  Drivers that wish to allow fbcon unloading can define
> the xxxfb_release() method.  They can choose to save/restore the state
> (if they have a vga core and running as primary), or just define the
> xxfb_release method as a dummy (if no vga core or running as secondary).
> 
> What do you think?  Any suggestions to improve this (multiple console
> drivers for instance)? I would rather have the above, or disallow
> unloading, than having the whole console system freeze on me.

Send me the patch. I like to have this support. As for multiple console 
support. Well that will just be nasty. Nothing we can do about it.



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en

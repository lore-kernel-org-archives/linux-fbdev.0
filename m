From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] DDC2/I2C Support
Date: Tue, 06 Jan 2004 11:42:09 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1073349728.9503.188.camel@gaston>
References: <1068.203.177.116.211.1073313062.squirrel@webmail.po.com>
	 <1073339963.780.93.camel@gaston>  <200401060831.53054.adaplas@softhome.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdfJl-0007of-RP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:43:33 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AdfJk-0002xh-US
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:43:33 -0800
In-Reply-To: <200401060831.53054.adaplas@softhome.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> There was the patch I submitted some 8 months ago and has been in the kernel 
> since linux-2.5.x.  For X86, it will get the EDID block via VBE calls before 
> the kernel goes to protected mode.  This is used by get_EDID_from_BIOS() in 
> fbmon.c. Actual code is in boot/arch/i386/boot/video.S[store_edid]
> 
> Currently, it's always compiled in and some people reported problems with it 
> (like taking 5 minutes to boot - probably BIOS using DDC1). I just added a 
> kernel config for it so people can choose to compile it out.  However, with 
> most drivers still not having DDC/I2C support, it's an easy way of getting 
> the EDID block.

Ok, if we go that way, we also need to store somewhere the PCI ID of
the primary display for which the EDID was "captured" or we'll do
weird things with several cards. I need to know which card is the
primary one anyway in radeonfb for other reasons (I need to fallback
to the RAM image of the BIOS with some laptops for the on-board
display)...

> > Can we define a "parsed_EDID" structure or whatever we call it that
> > contains the list of modes, the monspecs, and other informations
> > obtained from the EDID all at once ? I also need the display model
> > name and vendor for example (to deal with some "fixups"). it would
> > be convenient to have one single parsing pass extracting all the
> > informations to one structure...
> >
> 
> Ok, this should not be hard.

Good ;)

> > > --------------------------------------------------------
> > >
> > > 5. [fbcon.c]: Minor fixes on the cursor and scrolling.
> >
> > That pops up something else in my mind... Shouldn't we take the console
> > sempahore when doing cursor ops in the workqueue ?
> 
> I believe so.  I'm not sure where to start though. info->fb_cursor is called 
> by at least two functons (fbcon_cursor, fb_flash_cursor), and I don't see any 
> form of locking, especially for the data in info->cursor which is constantly 
> being modified by one and read by another.

In the work queue code itself. I'll do a patch for that after testing
here. (See my other race fixes).

> > I strongly suggest that you look at what I've done for radeonfb and stty
> > in my tree with FB_ACTIVATE_FIND and my mode search algorithm....
> 
> Ok. 
> > Boot parameters are evil... we should default to the "right" way whenever
> > possible. Let's make sure we properly deal with either complete modes
> 
> Evil, yes, but for now, necessary. Until the stty fix (and the 
> FB_ACTIVATE_FIND) is accepted by James, I will need this new boot parameter. 
>  
> I'll submit a new patch (without the fbi2c code) by next week.  Still too busy 
> to work full time with fbdev.

No problem, we can always extract the good stuff from your current
one anyway :)

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

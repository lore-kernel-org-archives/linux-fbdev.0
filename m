From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] DDC2/I2C Support
Date: Tue, 06 Jan 2004 11:37:58 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1073349478.781.184.camel@gaston>
References: <1068.203.177.116.211.1073313062.squirrel@webmail.po.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdfFf-0007T2-DT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:39:19 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AdfFc-0000ck-AI
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:39:17 -0800
In-Reply-To: <1068.203.177.116.211.1073313062.squirrel@webmail.po.com>
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

(RESENT because of stupid problem with my mailer, it wouldn't reach
the list)

On Tue, 2004-01-06 at 01:31, adaplas@pol.net wrote:
> Hi all,
> 
> I had the Christmas to work a little bit more on EDID/DDC/I2C for fb
> drivers. I know they can be implemented in userspace, however, we do need
> some sane way of setting video modes since the framebuffer system is
> initialized quite early in the boot process.  Still, setting modes using
> stty is still a bit problematic.  We need a way to tell fbdev whether to
> accept or ignore the timings in fb_var_screeninfo.  These cases are
> manifested when changing resolution using stty or using fbset.

Did you look at what I did in my new raeondb ? I basically fixed all
these problems (I also reworked the way the console mode is changed
on fbset).

> Anyway, attached is a patch (gzipped) against linux-2.6.1-rc1. Sorry for
> lumping everything into one big patch since I don't have time to separate
> them into different patches.
> 
> 1. [fbi2c.c]:  Added preliminary generic DDC2/i2c support (derived from
> xf86DDC.c and xf86i2.c)
> 
> 	This is a configurable option (CONFIG_FB_I2C). 	For now, I only used
> "default" timeout values which may not work for all devices.
> 
> 	Most drivers need to implement only two functions --
> 
> 		void xxxfb_i2c_getbits(struct fb_info *info, signed long *clock, signed
> long *data)
> 		void xxxfb_i2c_putbits(struct fb_info *info, signed long clock, signed
> long data)
> 
> 	The functionality is exposed in the following:
> 
> 		unsigned char *fb_get_edid_from_ddc2(struct fb_info *info)

So you choose to get away from the linux i2c infrastructure ?

> 2. [fbmon.c]: Consolidated different ways of getting EDID with the
> following function:
> 
> 	unsigned char *fb_get_edid(struct fb_info *info, struct pci_dev *pdev,
> int what)
> 
> 		the parameter "what" can be:
> 			EDID_DDC2 - get EDID via DDC2/I2C fb_get_edid_from_ddc2()
>			EDID_ARCH - get	EDID via BIOS or OF get_EDID_from_{OF|BIOS}()

The later is very card-specific... I don't think it can be abstracted.
Also, if you look at the new radeonfb, you'll notice that the BIOS
search has actually more than one way of getting to the EDID and
may gather more than just the EDID (panel power delay, panel fixed
dividers, etc...) Also, the OF parsing code cannot easily be abstracted
as the OF driver for different type of cards do things differently.

Hrm... reading your actual patch, I see that you are actually doing
this BIOS call to get it, not parsing the BIOS image. Ok, that may
be interesting...

Also, the former need a way to tell on which port we want the EDID,
and the EDID code may need a bit more than juts that "get EDID" (look
the other bit banging done to the i2c registers in radeonfb).

I'd actually keep all that in the driver...

> 	2.a getting EDID from the BIOS is now configurable (CONFIG_EDID_BIOS)
> since some people reported problems during booting or it takes a long
> time for the process to finish.

This is about using the VESA BIOS at boot or scanning the ROM image ?

> 3. [modedb.c]: Added additional field (edid_src) to struct fb_videomode.
> 
> 	The idea came from Ben H. He suggested that the mode database built by
> fb_create_modedb() does not specify where each came from.  So
> fb_videomode.edid_src can be:

Ok. I'd rather call that more generically "flags" though...

> 	MODE_IS_UNKNOWN - defined as (0) -- all entries of modedb[] in fbmon.c
> 	MODE_IS_DETAILED -  mode came from detailed timings block of EDID.  They
> are the most preferred mode since all timings are specified in the block.
> 	MODE_IS_STANDARD - mode came from standard timings block usually in the
> form of [xres]x[yres]@refresh
> 	MODE_IS_VESA - mode is VESA standard
> 	MODE_IS_CALCULATED - mode is calculated using GTF (xres, yres, refresh).
> 	MODE_IS_FIRST - if set, mode is the first entry in the detailed timing
> block and is the preferred mode of the display.
> 
> 	Flags can be combined in different ways such as:
> 
> 	MODE_IS_STANDARD | MODE_IS_CALCULATED - ie, mode came from standard
> timing block, but mode was not found in VESA database, and instead
> calculated using GTF.

Sounds good.

> 4. [fbmon.c]: Extended struct fb_monspecs to include display information
> specified in EDID.
> 
> 	Use function
> 		void fb_get_monspecs(unsigned char *edid, struct fb_monspecs *specs)

 .../...

Can we define a "parsed_EDID" structure or whatever we call it that
contains the list of modes, the monspecs, and other informations
obtained from the EDID all at once ? I also need the display model
name and vendor for example (to deal with some "fixups"). it would
be convenient to have one single parsing pass extracting all the
informations to one structure...

> --------------------------------------------------------
> 
> 5. [fbcon.c]: Minor fixes on the cursor and scrolling.

That pops up something else in my mind... Shouldn't we take the console
sempahore when doing cursor ops in the workqueue ?

In my tree, I have moved the VT blanking code out of the timer to a
workqueue as well and fixed other VT stuffs to make sure we always
have the console semaphore when getting to fbdev's. The current
"lock-less" state of the whole thing is scary...

> 6. [RIVAFB]:
> 
> 	a. Implemented I2C/DDC2 support.  Changing video modes should be more
> robust even when using stty.

I strongly suggest that you look at what I've done for radeonfb and stty
in my tree with FB_ACTIVATE_FIND and my mode search algorithm....

> 	b. fixed various hardware cursor corruption
> 	c. fixed maximum yres_virtual.  Hardware accel engine will crash if blit
> rectangle dimensions/origin exceeds 0x7fff.
> 	d. added new boot parameter, "strictmode", to force driver to use only
> modes specified in the EDID block.

Boot parameters are evil... we should default to the "right" way whenever
possible. Let's make sure we properly deal with either complete modes
passed from userland, or just xres/yres/bpp passed by fbcon on console
resize (that is not only stty but console switch). Again, I got that
working properly with radeonfb (both stty and fbset resizing the console)
in my tree (that required some fbcon and VT changes), I really suggest you
look at this.

Ben.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

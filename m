From: "Antonino A. Daplas" <adaplas@softhome.net>
Subject: Re: [PATCH] DDC2/I2C Support
Date: Tue, 6 Jan 2004 08:31:53 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200401060831.53054.adaplas@softhome.net>
References: <1068.203.177.116.211.1073313062.squirrel@webmail.po.com> <1073339963.780.93.camel@gaston>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adf8f-0006jx-PU
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:32:05 -0800
Received: from jive.softhome.net ([66.54.152.27])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Adf8f-0006YP-Az
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:32:05 -0800
In-Reply-To: <1073339963.780.93.camel@gaston>
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
To: benh@kernel.crashing.org, adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tuesday 06 January 2004 05:59, Benjamin Herrenschmidt wrote:

>
> So you choose to get away from the linux i2c infrastructure ?

I already looked at your tree.  After some thought, I agree with both of =
you=20
(Kronos) that i2c/ddc2 should be driver specific.  I'll remove the generi=
c=20
fbi2c interface.

>
> > 2. [fbmon.c]: Consolidated different ways of getting EDID with the
> > following function:
> >
> > =09unsigned char *fb_get_edid(struct fb_info *info, struct pci_dev *p=
dev,
> > int what)
> >
> > =09=09the parameter "what" can be:
> > =09=09=09EDID_DDC2 - get EDID via DDC2/I2C fb_get_edid_from_ddc2()
> >=09=09=09EDID_ARCH - get=09EDID via BIOS or OF get_EDID_from_{OF|BIOS}=
()
>
> The later is very card-specific... I don't think it can be abstracted.
> Also, if you look at the new radeonfb, you'll notice that the BIOS
> search has actually more than one way of getting to the EDID and
> may gather more than just the EDID (panel power delay, panel fixed
> dividers, etc...) Also, the OF parsing code cannot easily be abstracted
> as the OF driver for different type of cards do things differently.
>
> Hrm... reading your actual patch, I see that you are actually doing
> this BIOS call to get it, not parsing the BIOS image. Ok, that may
> be interesting...
>

There was the patch I submitted some 8 months ago and has been in the ker=
nel=20
since linux-2.5.x.  For X86, it will get the EDID block via VBE calls bef=
ore=20
the kernel goes to protected mode.  This is used by get_EDID_from_BIOS() =
in=20
fbmon.c. Actual code is in boot/arch/i386/boot/video.S[store_edid]

Currently, it's always compiled in and some people reported problems with=
 it=20
(like taking 5 minutes to boot - probably BIOS using DDC1). I just added =
a=20
kernel config for it so people can choose to compile it out.  However, wi=
th=20
most drivers still not having DDC/I2C support, it's an easy way of gettin=
g=20
the EDID block.

> Also, the former need a way to tell on which port we want the EDID,
> and the EDID code may need a bit more than juts that "get EDID" (look
> the other bit banging done to the i2c registers in radeonfb).
>
> I'd actually keep all that in the driver...
>
> > =092.a getting EDID from the BIOS is now configurable (CONFIG_EDID_BI=
OS)
> > since some people reported problems during booting or it takes a long
> > time for the process to finish.
>
> This is about using the VESA BIOS at boot or scanning the ROM image ?

This is about getting the EDID using VBE calls while in real mode.=20

>
> > 4. [fbmon.c]: Extended struct fb_monspecs to include display informat=
ion
> > specified in EDID.
> >
> > =09Use function
> > =09=09void fb_get_monspecs(unsigned char *edid, struct fb_monspecs *s=
pecs)
>
>  .../...
>
> Can we define a "parsed_EDID" structure or whatever we call it that
> contains the list of modes, the monspecs, and other informations
> obtained from the EDID all at once ? I also need the display model
> name and vendor for example (to deal with some "fixups"). it would
> be convenient to have one single parsing pass extracting all the
> informations to one structure...
>

Ok, this should not be hard.

> > --------------------------------------------------------
> >
> > 5. [fbcon.c]: Minor fixes on the cursor and scrolling.
>
> That pops up something else in my mind... Shouldn't we take the console
> sempahore when doing cursor ops in the workqueue ?

I believe so.  I'm not sure where to start though. info->fb_cursor is cal=
led=20
by at least two functons (fbcon_cursor, fb_flash_cursor), and I don't see=
 any=20
form of locking, especially for the data in info->cursor which is constan=
tly=20
being modified by one and read by another.

>
> In my tree, I have moved the VT blanking code out of the timer to a
> workqueue as well and fixed other VT stuffs to make sure we always
> have the console semaphore when getting to fbdev's. The current
> "lock-less" state of the whole thing is scary...
>

Yes :-(.

> > 6. [RIVAFB]:
> >
> > =09a. Implemented I2C/DDC2 support.  Changing video modes should be m=
ore
> > robust even when using stty.
>
> I strongly suggest that you look at what I've done for radeonfb and stt=
y
> in my tree with FB_ACTIVATE_FIND and my mode search algorithm....

Ok.=20

>
> > =09b. fixed various hardware cursor corruption
> > =09c. fixed maximum yres_virtual.  Hardware accel engine will crash i=
f blit
> > rectangle dimensions/origin exceeds 0x7fff.
> > =09d. added new boot parameter, "strictmode", to force driver to use =
only
> > modes specified in the EDID block.
>
> Boot parameters are evil... we should default to the "right" way whenev=
er
> possible. Let's make sure we properly deal with either complete modes

Evil, yes, but for now, necessary. Until the stty fix (and the=20
FB_ACTIVATE_FIND) is accepted by James, I will need this new boot paramet=
er.=20
=20
I'll submit a new patch (without the fbi2c code) by next week.  Still too=
 busy=20
to work full time with fbdev.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

From: "Antonino A. Daplas" <adaplas@softhome.net>
Subject: Re: [PATCH] DDC2/I2C Support
Date: Tue, 6 Jan 2004 08:31:45 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200401060831.46018.adaplas@softhome.net>
References: <1068.203.177.116.211.1073313062.squirrel@webmail.po.com> <20040105171639.GA7048@dreamland.darkstar.lan>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adf8d-0006js-8f
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:32:03 -0800
Received: from jive.softhome.net ([66.54.152.27])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Adf8c-0006Nx-Qq
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:32:02 -0800
In-Reply-To: <20040105171639.GA7048@dreamland.darkstar.lan>
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
To: kronos@kronoz.cjb.net, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tuesday 06 January 2004 01:16, Kronos wrote:
> Il Mon, Jan 05, 2004 at 09:31:02AM -0500, adaplas@pol.net ha scritto:
> > 1. [fbi2c.c]:  Added preliminary generic DDC2/i2c support (derived fr=
om
> > xf86DDC.c and xf86i2.c)
> >
> > =09This is a configurable option (CONFIG_FB_I2C). =09For now, I only =
used
> > "default" timeout values which may not work for all devices.
> >
> > =09Most drivers need to implement only two functions --
> >
> > =09=09void xxxfb_i2c_getbits(struct fb_info *info, signed long *clock=
, signed
> > long *data)
> > =09=09void xxxfb_i2c_putbits(struct fb_info *info, signed long clock,=
 signed
> > long data)
>
> In fbi2c.c you are duplicating the i2c layer that's already there in th=
e
> kernel. Each driver should  have its set of function to  control SDA an=
d
> SCL and then it's only a matter of calling i2c_transfer.
>
> I wrote the i2c stuff for the new radeon driver, look here:
> bk://ppc.bkbits.net/linuxppc-2.5-benh
> (drivers/video/aty/radeon_i2c.c)

Ok.  See my reply to Ben H.

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
> > =09=09=09EDID_ARCH - get=09EDID via BIOS or OF get_EDID_from_{OF|BIOS=
}()
>
> Hum, I don't like this kind of "multiplexing". I think that EDID
> reading (if possibile) should be done inside the driver which knows how
> to do it.
>
> Also, why did you remove all the printk's? Ok, show_edid is a bit too
> verbose but it's usefull for debugging.

The first time I wrote the edid parser, show_edid() was never meant to ha=
ve=20
all that printk's :-).  It's only preliminary code in preparation for=20
extending struct fb_monspecs.  But I'll bring it back, possibly when DEBU=
G is=20
defined.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: pxafb: Is it actually working in 2.6.21?
Date: Fri, 8 Jun 2007 01:18:54 +0200
Message-ID: <200706080118.54787.hjk@linutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HwRGy-00053Z-EN for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 16:20:08 -0700
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HwRGw-00058y-OL
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 16:20:08 -0700
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-arm-kernel@lists.arm.linux.org.uk

In the last few days, I desperately tried to make pxafb work on a 2.6.21
vanilla kernel. All I got so far is some white and black blur on my display.
I asked for help on the linux-arm-kernel mailing list, but though friendly
and competent people answered my request, it still doesn't work.

So, I'd like to know if pxafb in 2.6.21 is actually working for somebody =

with a similar setup.

Here's what I've got:

- Kernel 2.6.21, gcc 4.1.0 or 3.4.1 (same behaviour)
- PXA270, TFT 800x600
- At boot time, pxafb reports no errors
- fbset -i shows the expected values
- BUT the display shows only white and black blur

Now I find mysterious things going on in pxafb_enable_controller(). The dri=
ver
calculates reasonable values for e.g. LCCR0, but they disappear soon after
they've been set. I added some pr_debug lines, the code looks like this:

static void pxafb_enable_controller(struct pxafb_info *fbi)
{
=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("pxafb: Enabling LCD controller\n");
=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("fdadr0 0x%08x\n", (unsigned int) fbi->fda=
dr0);
=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("fdadr1 0x%08x\n", (unsigned int) fbi->fda=
dr1);
=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("reg_lccr0 0x%08x\n", (unsigned int) fbi->=
reg_lccr0);
=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("reg_lccr1 0x%08x\n", (unsigned int) fbi->=
reg_lccr1);
=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("reg_lccr2 0x%08x\n", (unsigned int) fbi->=
reg_lccr2);
=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("reg_lccr3 0x%08x\n", (unsigned int) fbi->=
reg_lccr3);

=A0=A0=A0=A0=A0=A0=A0=A0/* enable LCD controller clock */
=A0=A0=A0=A0=A0=A0=A0=A0pxa_set_cken(CKEN16_LCD, 1);

=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("1.LCCR0 0x%08x\n", (unsigned int) LCCR0);
=A0=A0=A0=A0=A0=A0=A0=A0LCCR0 =3D fbi->reg_lccr0 & ~LCCR0_ENB; /* Make sure=
 it's disabled */
=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("2.LCCR0 0x%08x\n", (unsigned int) LCCR0);

=A0=A0=A0=A0=A0=A0=A0=A0/* Sequence from 11.7.10 */
=A0=A0=A0=A0=A0=A0=A0=A0LCCR3 =3D fbi->reg_lccr3;
=A0=A0=A0=A0=A0=A0=A0=A0LCCR2 =3D fbi->reg_lccr2;
=A0=A0=A0=A0=A0=A0=A0=A0LCCR1 =3D fbi->reg_lccr1;
=A0=A0=A0=A0=A0=A0=A0=A0LCCR0 =3D fbi->reg_lccr0 & ~LCCR0_ENB;
=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("LCCR0 (0x%08x) =3D 0x%08x\n", &LCCR0, (un=
signed int)LCCR0);

=A0=A0=A0=A0=A0=A0=A0=A0FDADR0 =3D fbi->fdadr0;
=A0=A0=A0=A0=A0=A0=A0=A0FDADR1 =3D fbi->fdadr1;
=A0=A0=A0=A0=A0=A0=A0=A0LCCR0 |=3D LCCR0_ENB;

=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("FDADR0 0x%08x\n", (unsigned int) FDADR0);
=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("FDADR1 0x%08x\n", (unsigned int) FDADR1);
=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("LCCR0 0x%08x\n", (unsigned int) LCCR0);
=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("LCCR1 0x%08x\n", (unsigned int) LCCR1);
=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("LCCR2 0x%08x\n", (unsigned int) LCCR2);
=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("LCCR3 0x%08x\n", (unsigned int) LCCR3);
}

At boot time, I get the following output from that code:

[ =A0 =A09.780000] pxafb: Enabling LCD controller
[ =A0 =A09.830000] fdadr0 0xa3d00fe0
[ =A0 =A09.870000] fdadr1 0xa3d00fd0
[ =A0 =A09.900000] reg_lccr0 0x003008f8
[ =A0 =A09.940000] reg_lccr1 0x5727ff1f
[ =A0 =A09.980000] reg_lccr2 0x1c010e57
[ =A0 10.020000] reg_lccr3 0x04700002
[ =A0 10.060000] 1.LCCR0 0x00000005
[ =A0 10.090000] 2.LCCR0 0x003008f8
[ =A0 10.130000] LCCR0 (0xf4000000) =3D 0x003008f8
[ =A0 10.180000] FDADR0 0x000000d1
[ =A0 10.210000] FDADR1 0x000000d1
[ =A0 10.250000] LCCR0 0x000000d1
[ =A0 10.280000] LCCR1 0x0000001f
[ =A0 10.320000] LCCR2 0x000000d1
[ =A0 10.350000] LCCR3 0x0000001f

ATM, I only looked at LCCR0 and find this strange:

- First (in "1.LCCR0..."), Bit 0 is set, meaning it's already enabled
- Then (in "2.LCCR0..."), the value is set properly
- It ends up with 0xd1 in LCCR0, which is complete crap

Russell King suggested to disassemble the code, but as I get the same =

behaviour with two very different versions of gcc, I don't really =

believe that this is the problem. Eric Miao thought it might be the
DMA controller that's not set up properly and overwrites my registers.
As this is completely independent of my board setup, it should apply
to _everybody_ using pxafb.

If I don't get this to work soon, my wife will divorce me, my bank will
cancel my account, and my dog will get lice and fleas.

So, please give a lonely hacker a helping hand and tell me what's going on.
Does it work for somebody? Anybody with similar problems?

I'll be offline for a few hours of dreamless sleep.

Thanks,
Hans


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

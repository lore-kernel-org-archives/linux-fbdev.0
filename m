From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] PXA255 LCD Driver
Date: Sat, 20 Mar 2004 09:06:07 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040320090607.A27266@flint.arm.linux.org.uk>
References: <1079607908.2175.67.camel@icampbell-debian> <Pine.LNX.4.44.0403192352580.14905-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B4cQs-00081q-Aw
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Mar 2004 01:06:18 -0800
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B4cQr-0005Dn-Fr
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Mar 2004 01:06:17 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403192352580.14905-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Sat, Mar 20, 2004 at 12:01:03AM +0000
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Ian Campbell <icampbell@arcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, Mar 20, 2004 at 12:01:03AM +0000, James Simmons wrote:
> We can have it so that we can pass in a monitor string that can be used to 
> select the proper LCD panel in the database. How does that sound?

That's still a little problematical because some hardware people put
a CPLD between the LCD controller and the LCD panel itself which
may change the characteristics.

It's fairly common to have one LCD controller appear in many different
devices (because its part of the CPU) and have the same display, yet
need different timing.

For example, see sa1100fb.c:

static struct sa1100fb_mach_info lq039q2ds54_info __initdata = {
        .pixclock       = 171521,       .bpp            = 16,
        .xres           = 320,          .yres           = 240,

        .hsync_len      = 5,            .vsync_len      = 1,
        .left_margin    = 61,           .upper_margin   = 3,
        .right_margin   = 9,            .lower_margin   = 0,

        .sync           = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,

        .lccr0          = LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
        .lccr3          = LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
};

static struct sa1100fb_mach_info h3600_info __initdata = {
        .pixclock       = 174757,       .bpp            = 16,
        .xres           = 320,          .yres           = 240,

        .hsync_len      = 3,            .vsync_len      = 3,
        .left_margin    = 12,           .upper_margin   = 10,
        .right_margin   = 17,           .lower_margin   = 1,

        .cmap_static    = 1,

        .lccr0          = LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
        .lccr3          = LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
};

Both of these are the same LCD panel (type LQ039Q2DS54) yet there are
two different sets of timing information, including the polarity of
the line and field clocks (which are equivalent to hsync and vsync.)

Also note that such panels are generally fixed resolution, though there
are a few rare exceptions where changing the colour depth is permitted.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

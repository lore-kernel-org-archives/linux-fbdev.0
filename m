From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: Bug#226973: xserver-xfree86: [glint]
 second card at wrong resolution
Date: Wed, 31 Mar 2004 10:12:45 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0403311011400.22944@waterleaf.sonytel.be>
References: <20040112121558.GA24511@iliana> <20040112215543.GB2150@scowler.net>
 <20040113074158.GF4863@iliana> <20040113154025.GA12817@scowler.net>
 <20040113160221.GA12752@iliana> <20040114211246.GA31567@scowler.net>
 <20040114211643.GA6793@iliana> <20040330153247.GB11287@scowler.net>
 <20040330165738.GC31639@lambda> <20040330230203.GA2568@scowler.net>
 <20040330230829.GA5257@lambda>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8aqE-0007bz-HH
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 Mar 2004 00:12:54 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8aqD-0003Us-W9
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 Mar 2004 00:12:54 -0800
In-Reply-To: <20040330230829.GA5257@lambda>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Clint Adams <schizo@debian.org>, 226973@bugs.debian.org, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 31 Mar 2004, Sven Luther wrote:
> On Tue, Mar 30, 2004 at 06:02:03PM -0500, Clint Adams wrote:
> > > I believe that the cloack is different for 8bpp and 16 or 24 bpp, don't
> > > remember exactly. At 8bpp, the max clock range is 230Mhz in the driver i
> > > think. You looked at it, you have the hardware, you just have become the
> > > resident expert on this issue :).
> >
> > Ahh.  I tried increasing the 32bpp number to 150MHz, and was successfully
> > able to use a mode at 135MHz.  I am confused as to why the Pixmap setting
> > affects the ramdac frequency.  Is this a mistake or am I misunderstanding
> > something?  Would it be okay to set the maximum based on depth instead
> > of bitsPerPixel, or is bitsPerPixel wrong if it's set to 32 at a plain
> > 24-bit depth?
>
> I would have to look in the specs, but i believe the ramdac is only able
> to push less pixels if those are of 16 or 32 bpp. This is the case for
> all 3Dlabs chips prior to the permedia3. Look at the part in glint_driver.c
> where these values are set. I have no explanation also, since my
> involvement was with the permedia3, so maybe ask Alan Hourihane about
> it.

If your graphics controller is limited by memory bandwidth, the maximum pixel
clock depends on the number of bits per pixels, since larger pixels mean more
memory bandwidth.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] neofb patches
Date: Thu, 22 Apr 2004 10:09:54 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404221008490.23920@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404211840040.9207-100000@phoenix.infradead.org>
 <1082574664.2344.3.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGZHe-0000Gi-CU
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 01:10:10 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGZHd-0005Wg-Q0
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 01:10:09 -0700
In-Reply-To: <1082574664.2344.3.camel@localhost.localdomain>
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
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: James Simmons <jsimmons@infradead.org>, Alex Stewart <alex@foogod.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 22 Apr 2004, Antonino A. Daplas wrote:
> On Thu, 2004-04-22 at 01:47, James Simmons wrote:
> > > neofb.3.16bit.patch     - Misc fixes for 16-bit mode
> > >
> > >   Changed the visual reported for 16-bit mode from DirectColor to TrueColor,
> > >   since we don't support changing the colormap, which means we don't really
> > >   support DirectColor.  Also changed the palette entries for to be 32 bits
> > >   wide even for 16-bit mode because this is what the logo code expects,
> > >   and appears to be the correct way of doing things.
> >
> > I haven't tried this one yet. Geert is this right?

Not sure whether your question applies to the first or the second part...

> Yes, _all_ of the generic drawing functions expect the pseudopalette to
> be always u32.

... so I'll respond to the first part: yes, truecolor means a fixed (linear)
CLUT, directcolor means a changeable CLUT.

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

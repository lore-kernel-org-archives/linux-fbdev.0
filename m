From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH]: cfb_imageblit() fix: handle
 widths not divisible by 8
Date: Wed, 15 Jan 2003 10:28:09 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301151020270.4227-100000@vervain.sonytel.be>
References: <1042596659.1101.21.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Yjrp-0003E6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Jan 2003 01:29:50 -0800
In-Reply-To: <1042596659.1101.21.camel@localhost.localdomain>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 15 Jan 2003, Antonino Daplas wrote:
> On Wed, 2003-01-15 at 08:26, James Simmons wrote:
> > Applied.
> > 
> > > c. Fix for fast_imageblit() so it always refer to mask tables in 32-bits
> > > which should make it work for 64-bit machines.
> > 
> > Ug. I rather try yo take advantge of using the full 64 bits of data to 
> > pass across the bus. What I was think is treat the 64 bit case as two 32 
> > bit cases. The 64 bit data comes in and we run the data twice at tabs[].
> > 
> Hi James,
> 
> Yes, I was trying to find a way to make fast_imageblit() be fast for all
> machine architectures.  With the patch attached, there's
> fast_imageblit32() and fast_imageblit64().  fast_imageblit32() is
> probably slower than fast_imageblit64 on 64-bit machines and, on the
> other hand, fast_imageblit64() is 20% slower on 32-bit machines, but is
> probably faster on 64-bit and higher machines.  So, the only way I can
> think of doing this on all machine architectures is to have them go
> separate paths.

Can't you merge fast_imageblit32() and fast_imageblit64() a bit more (with some
#ifdef's), and just call the result fast_imageblit()? Then the definition of
FAST_IMAGEBLIT can go away.

u32 is the same as unsigned long if BITS_PER_LONG == 32.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds




-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en

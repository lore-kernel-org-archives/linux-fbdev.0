From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: cfb_{copyarea,fillrect}()
Date: Fri, 5 Jul 2002 09:41:56 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0207050935500.23857-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0207042034540.4852-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QNjM-00046i-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 00:42:17 -0700
In-Reply-To: <Pine.LNX.4.44.0207042034540.4852-100000@www.transvirtual.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 4 Jul 2002, James Simmons wrote:
> > Other comments/notes:
> >   - Shouldn't cfb_fillrect() use the pseudo_palette in DIRECTCOLOR mode?
> 
> ??? I thought you had to go threw the DAC to get values.

Yes, but you have to do that for _each_ color component. So you have to use
pixel value (i, i, i), not (0, 0, i) (depending on the order of the components)
like the current code does.

> >   - I think the cfb_*() routines can easily be modified to work for bpp < 8,
> >     and for bpp == 24:
> 
> It doesn't work for bpp < 4 for you? It should work for those as well. Bpp

Note that I didn't try that.

> 24 is a bit more trick if we want to do word align access to the
> framebuffer.
> 
> >       o initialize src/dst indices to be bit indices instead of byte indices
> >       o remove shifts by 3
> >       o n is number of bits to copy/fill
> 
> Hm. I have to work up so psuedo code to try that idea out.

The main idea is to do an optimized bitcopy, not a bytecopy. Then it works for
all values of bpp:

    void bitcpy(unsigned long *dst, int dst_idx, unsigned long *src,
		int src_idx, int nbits);

{dst,src}_idx are bit indices (0 == MSB, 31 or 63 = LSB), nbits is the number
of bits to copy.

The same is true for fillrect, there you want an optimized bitset().

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Patch 2] Console Rotation
Date: Mon, 7 Oct 2002 22:06:13 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0210072201400.4590-100000@vervain.sonytel.be>
References: <1034018779.572.22.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17ye9S-00022Y-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Oct 2002 13:06:51 -0700
In-Reply-To: <1034018779.572.22.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On 8 Oct 2002, Antonino Daplas wrote:
> On Mon, 2002-10-07 at 04:41, Geert Uytterhoeven wrote:
> > The fillrect() for arbitrary bitdepths is in fbtest now. I also added fast
> > support for planar screens. Well, now I can start porting amifb to the accel
> > framework.
> > 
> I modified your fillrect for cfbfillrect.c.  Just added support for
> ROP_XOR.
> 
> Here's also some rudimentary benchmarks:
> 
> fill/copy a 256x256 rectangle 1000 times (8bpp):
> 
>                            old          new
> copyarea                   4.930s       5.151s
> fillrect(ROP_COPY)         0.136s       0.256s
> fillrect(ROP_XOR)          4.059s       3.903s

Yes, there is still room for optimization...

If next_line is a multiple of BYTES_PER_LONG, there's no need to recalculate
the first and last masks.
Even if next_line is not a multiple of BYTES_PER_LONG, the first and last masks
are periodic, and can be precalculated and put in a table (4 entries on 32-bit
and 8 entries on 64-bit).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

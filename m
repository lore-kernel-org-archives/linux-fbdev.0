From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [BK FBDEV] String drawing optimizations.
Date: Fri, 16 May 2003 10:24:22 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0305161018320.3722-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0305152104400.6330-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19GaX1-00077b-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 May 2003 01:25:35 -0700
In-Reply-To: <Pine.LNX.4.44.0305152104400.6330-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 15 May 2003, James Simmons wrote:
> > What about getting rid of one-char putc, implementing it in terms of
> > putcs? I'm doing it in matroxfb patches, and nobody complained yet, and
> > with current length of {fbcon,accel}_putc{s,} I was not able to find
> > measurable speed difference between putc and putc through putcs variants.
> 
> Hm. I compressed all the image drawing functions into accel_putcs which is 
> used in many places. I then placed accel_putc() into fbcon_putc(). I could 
> have accel_putcs() called in fbcon_putc(). The advantage is smaller 
> amount of code. The offset is a big more overhead plus a function call. 
> What do people think here?

putc() is almost never called, IIRC. We did our best to combine as much data as
possible and call putcs().

A quick grep showed ->con_putc() is called only in drivers/char/vt.c for:
  - Complementing the pointer position (for gpm)
  - Inserting/deleting single characters
  - Softcursor

I guess the small overhead won't have much influence here.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

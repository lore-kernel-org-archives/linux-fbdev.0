From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: fbdev changes.
Date: Mon, 14 Oct 2002 10:30:32 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0210141020550.9580-100000@vervain.sonytel.be>
References: <20021013225159.GB5348@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1810dD-0002VO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Oct 2002 01:31:20 -0700
In-Reply-To: <20021013225159.GB5348@ppc.vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 14 Oct 2002, Petr Vandrovec wrote:
> On Sun, Oct 13, 2002 at 01:27:08PM -0700, James Simmons wrote:
> > Second change!! We need a uiversal cursor api. I purposed some time ago a
> > api but nothing happend.I like to resolve this final part to remove th
> > last bit of console crude from the fbdev layer.

  [...]

> And what is meaning of image when mask is 1? For b&w cursors
> we need 0, 1, transparent and inverse.

Note that not all hardware supports inverse.
And on some hardware the cursor palette is shared with the screen palette,
that's why I had fb_fix_cursorinfo.crsr_color[12] in the original cursor API.

E.g. Amiga graphics don't have inverse. There are 8 sprites, each can have 3
colors (+ transparency). The colors are shared with the screen palette (unless
your screen has at most 16 colors):
  - sprites 0 and 1: transparent, palette[17], palette[18], palette[19]
  - sprites 2 and 3: transparent, palette[21], palette[22], palette[23]
  - sprites 4 and 5: transparent, palette[25], palette[26], palette[27]
  - sprites 6 and 7: transparent, palette[29], palette[30], palette[31]
There's also a special mode to combine an even an odd sprite to form a 15-color
(+ transparency) sprite.

Yes, it can be difficult to find a _good_ API ;-)

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

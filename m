From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: radeonfb on pegasos powerpc motherboard and
 X endianess problem
Date: Fri, 6 Jun 2003 08:02:23 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0306060801070.864-100000@vervain.sonytel.be>
References: <20030605131253.GA1238@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19OAK4-0003gt-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 05 Jun 2003 23:03:33 -0700
In-Reply-To: <20030605131253.GA1238@iliana>
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 5 Jun 2003, Sven Luther wrote:
> On Thu, Jun 05, 2003 at 02:27:23PM +0200, Benjamin Herrenschmidt wrote:
> > On Thu, 2003-06-05 at 13:58, Sven Luther wrote:
> > > Ok, so it must be another kind of problems, but then, my matrox board,
> > > which Geert (or someone else) said did run on his chrp board, did not
> > > work well for me.

Not me, as I don't have any Matrox cards (just S3 and Mach64 GT).

> > Could be a problem with how the firmware did/did not initialize it
> 
> Actually, the OF has a x86 emulator which runs the x86 bios of the
> graphic card. 

Aha, so you get VGA text mode on bootup instead of linear graphics?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.

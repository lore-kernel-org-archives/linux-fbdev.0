From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: status
Date: Sat, 23 Nov 2002 22:07:37 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0211232203340.20022-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0211221902540.5899-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0211221902540.5899-100000@phoenix.infradead.org>
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
Cc: Antonino Daplas <adaplas@pol.net>, Linux console project <linuxconsole-dev@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux/m68k <linux-m68k@lists.linux-m68k.org>

On Fri, 22 Nov 2002, James Simmons wrote:
> Geert is busy porting the Amigia driver to the new api. That means all the 
> ilbm, iplan stuff will go away :-) 

I have first code for amifb, but it doesn't work yet, due to other problems
with 2.5.x on Amiga. I hope to fix these tomorrow...

Besides, we still need someone to take care of the Atari 2-byte interleaved
bitplanes (iplan2p*), since I don't have the hardware, and am not 100% sure how
they work. But reviving 2.5.x on Atari will be even harder...

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

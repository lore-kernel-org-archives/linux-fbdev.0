From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: CRTC scanout buffer types
Date: Mon, 8 Aug 2005 10:41:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508081040130.3826@numbat.sonytel.be>
References: <9e47339105080513195dee0804@mail.gmail.com>
 <Pine.LNX.4.62.0508071135450.31010@gorilla.sonytel.be>
 <9e47339105080706414faf1e40@mail.gmail.com> <42F678BD.7030008@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <42F678BD.7030008@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: DRI developer's list <dri-devel@lists.sourceforge.net>

On Mon, 8 Aug 2005, Antonino A. Daplas wrote:
> Jon Smirl wrote:
> > How does this work, is one 24 bit color the key?
> > 32 bpp indexed+RGB 888 with color key to enable RGB888
> 
> This is directcolor. Each component is indexed.

No, directcolor is different. This is a mode that combines a pseudocolor
CLUT256 visual (but only 255 colors, because of the color key) with a truecolor
RGB888 visual.

E.g. the Matrox Millennium can do this, and IIRC at least Accelerated X
supports it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

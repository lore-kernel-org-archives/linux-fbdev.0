From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: Current discussion about the future of
 free software graphics
Date: Wed, 12 May 2004 21:00:09 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0405122058350.29476@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0405121705550.30331-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0405121705550.30331-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Ian Romanick <idr@us.ibm.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net

On Wed, 12 May 2004, James Simmons wrote:
> I understand you point of the mode switching code being huge. The embedded
> guys require really lean kernels. I have no problem making the mode switching
> code modular. I just want to avoid the above overhead.

And for an embedded device with a fixed LCD screen you can easily make the mode
setting code __init, and disallow mode changes after boot up. One device
driver, just one more kernel config option. Some code has to do the mode
setting anyway, so better keep it in one place.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3

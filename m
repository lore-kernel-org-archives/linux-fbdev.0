From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] Redesign of kernel graphics
 interface
Date: Tue, 11 May 2004 10:33:31 +0200 (MEST)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0405111032330.27719@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0405101708310.4338-100000@phoenix.infradead.org>
 <1084217590.24759.10.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <1084217590.24759.10.camel@localhost.localdomain>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Nicolas Souchu <nsouch@free.fr>, Jon Smirl <jonsmirl@yahoo.com>, DRI Devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 10 May 2004, Alan Cox wrote:
> On Llu, 2004-05-10 at 17:14, James Simmons wrote:
> > Speaking of bloat in the kernel. When will the crypto and TCP/IP stack be
> > moved to userspace. The networking code alone is over 17 megs in size.
>
> Not on my box. Nothing like it. Although to answer that question with a
> definitive example ELKS (a Linux like 8086 kernel in 64K) has IP demux
> in kernel space and tcp in user space. The v7 NCP stack also had much of
> the protocol in user space.

Sounds reasonable, since IP demux touches the hardware, and TCP not.

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

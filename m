From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: radeonfb and 2.5.66
Date: Tue, 25 Mar 2003 16:08:22 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303251607490.22126-100000@vervain.sonytel.be>
References: <1048604437.582.37.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xq3S-0005Z7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Mar 2003 07:09:35 -0800
In-Reply-To: <1048604437.582.37.camel@zion.wanadoo.fr>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Louis Garcia <louisg00@bellsouth.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On 25 Mar 2003, Benjamin Herrenschmidt wrote:
> On Tue, 2003-03-25 at 05:39, Louis Garcia wrote:
> > Does anyone know if the radeonfb in 2.5.66 supports the dvi port on my
> > radeon 7500 QW? I've compiled the driver in and appended video=radeon to
> > grub and I still get vga.
> 
> Tried video=radeon:dfp ?

video=radeonfb:dfp

(in 2.5.66, all video= driver names got the `fb' at the end).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en

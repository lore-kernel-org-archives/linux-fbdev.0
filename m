From: Louis Garcia <louisg00@bellsouth.net>
Subject: Re: radeonfb and 2.5.66
Date: 27 Mar 2003 14:04:18 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048791858.2474.3.camel@tiger>
References: <Pine.GSO.4.21.0303251607490.22126-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail210.mail.bellsouth.net ([205.152.58.150] helo=imf47bis.bellsouth.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ycfH-00074D-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Mar 2003 11:03:51 -0800
In-Reply-To: <Pine.GSO.4.21.0303251607490.22126-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

I have connected my monitor to the vga port (it supports both) and the
radeonfb works. So it has to do with the dvi port not being activated.
This problem also affects the 2.4 kernel. I really would like to get
this going.

--Lou

On Tue, 2003-03-25 at 10:08, Geert Uytterhoeven wrote:
> On 25 Mar 2003, Benjamin Herrenschmidt wrote:
> > On Tue, 2003-03-25 at 05:39, Louis Garcia wrote:
> > > Does anyone know if the radeonfb in 2.5.66 supports the dvi port on my
> > > radeon 7500 QW? I've compiled the driver in and appended video=radeon to
> > > grub and I still get vga.
> > 
> > Tried video=radeon:dfp ?
> 
> video=radeonfb:dfp
> 
> (in 2.5.66, all video= driver names got the `fb' at the end).
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en

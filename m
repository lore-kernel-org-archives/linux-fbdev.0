From: Antonio Vargas <wind@cocodriloo.com>
Subject: Re: [uml-devel] UML and fbdev
Date: Wed, 20 Aug 2003 20:58:50 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030820185850.GA509@wind.cocodriloo.com>
References: <Pine.GSO.4.21.0308131805050.11378-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 224.red-217-125-129.pooles.rima-tde.net ([217.125.129.224] helo=cocodriloo.com)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19pZ8x-00032p-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 20 Aug 2003 13:01:19 -0700
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0308131805050.11378-100000@vervain.sonytel.be>
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
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: UML Development <user-mode-linux-devel@lists.sourceforge.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Aug 13, 2003 at 06:07:29PM +0200, Geert Uytterhoeven wrote:
> 	Hi,
> 
> Are you aware of anyone working on frame buffer devices for UML?
> 
> I was thinking about creating a frame buffer device that displays as an X
> window. Making it work for user space applications can be tricky, because
> writes to the frame buffer must be trapped to update the screen (or use
> periodic update, or a combination). But it should work fine for text consoles
> (fbcon) and virtual terminals, and for debugging multi-head support.

What about using the "page was changed" bit at the page level?
Changing any byte on a framebuffer page would trigger an update
on the changed bit, and then a periodic task could read these bits
and make a list of pages to be sent over.

For an example about this technique, this was used on AmigaOS
for MacOS framebuffer emulation on shapeshifter.
 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> P.S. Please CC me, as I'm not (yet) subscribed to user-mode-linux-devel.
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
winden/network

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.


-------------------------------------------------------
This SF.net email is sponsored by Dice.com.
Did you know that Dice has over 25,000 tech jobs available today? From
careers in IT to Engineering to Tech Sales, Dice has tech jobs from the
best hiring companies. http://www.dice.com/index.epl?rel_code=104

From: Michael Kaufmann <kaufmann@sohard.de>
Subject: Re: Mirrored and shiftet fonts and logos
Date: Sun, 15 Dec 2002 15:33:23 -0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200212151533.23376.kaufmann@sohard.de>
References: <004501c2a3ab$015a5eb0$ee3c078b@nb1>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [212.123.118.25] (helo=proxy.sohard.de)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18NZre-0003Sz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 15 Dec 2002 06:35:30 -0800
In-Reply-To: <004501c2a3ab$015a5eb0$ee3c078b@nb1>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

On Saturday 14 December 2002 18:53, Andr=E9 Stierenberg wrote:

> i=B4m using the framebuffer driver pxafb for my board using the pxa pro=
cessor
> (Accelent IDP). I have a 4 bit monocrom display. when I run the framebu=
ffer
> I have some problems. The text in the console it in some way shifted. T=
he
> two parts of the font are switched. The first 4 pixels are at dest+2 an=
d
> the last 4 pixels at dest+0. And both parts are mirrored. Now I have do=
ne
> the following in fbcon_cfb4.c in function fbcon_cfb4_putcs:
>
>   for (rows =3D fontheight(p), dest =3D dest0; rows-- ; dest +=3D bytes=
) {
>       fb_writew((nibbletab_cfb4[rv(*cdat) >> 4] & eorx) ^ bgx, dest+2);
>       fb_writew((nibbletab_cfb4[rv(*cdat++) & 0xf] & eorx) ^ bgx, dest+=
0);
>   }
>
>
> The function rv will reverse the bit order (bit 1 is bit 8, bit 2 is bi=
t
> 7.. etc.).
> And i have swaped the destination offset.
> Now the characters are printed correctly. And in the linux logo, the
> pinguin, something is also wrong. It seems the some pixels are mirrored=
 too
> whereas other pixels are correct.
>
> What could this be and in what way can i fix the problem?

i had exactly the same problem, but i fixed it on the hardware side.
I changed the databus between the video controller and the LCD.
My display has a 4bit width databus, so i exchanged D0 with D3 and D1 wit=
h D2.
Now i have a clear picture (logo, font, ...).

Bye
Michael


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

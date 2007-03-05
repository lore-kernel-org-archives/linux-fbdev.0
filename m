From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Matrox G550, dual head, 1680x1050
Date: Sun, 04 Mar 2007 20:59:34 -0800
Message-ID: <45EBA3B6.3060701@vc.cvut.cz>
References: <200703021053.00955.hjk@linutronix.de>	<200703021610.58188.hjk@linutronix.de>	<20070302152414.GC907@code-monkey.de>
	<200703042247.21590.hjk@linutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HO5IT-0005q9-Be for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Mar 2007 20:59:41 -0800
Received: from mailgw.cvut.cz ([147.32.3.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HO5IS-0003qH-Um
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Mar 2007 20:59:41 -0800
In-Reply-To: <200703042247.21590.hjk@linutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: hjk@linutronix.de
Cc: Tilman Sauerbeck <tilman@code-monkey.de>, linux-fbdev-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

Hans-J=FCrgen Koch wrote:
> Am Freitag, 2. M=E4rz 2007 16:24 schrieb Tilman Sauerbeck:
> Meanwhile I doubt this explanation. Here's what fbset has to say:
> =

> $ fbset -fb /dev/fb1 --show
> =

> mode "1680x1050-60"
>     # D: 135.501 MHz, H: 65.396 kHz, V: 59.997 Hz
>     geometry 1680 1050 1680 1050 32
>     timings 7380 32 224 32 4 136 4
>     rgba 8/16,8/8,8/0,8/24
> endmode
> =

> So, even fbset thinks it's 1680x1050. But where does the distortion come =

> from???

Can you try setting vxres for second head from 1680 to 1696, or 1728? =

Maybe X look at vxres and not at framebuffer line length (what fbset -i =

reports for line length?)

If you are using mga driver for second head in X, then probably X driver =

does not know correctly what are hardware restrictions for second CRTC =

(I think they've changed between G400 and G450), asks for 1680 but gets =

1664, and this causes those diagonal lines you see.
								Petr


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV

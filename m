From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: KernelDoc "fb": New Framebuffer help text (fwd)
Date: Thu, 8 Aug 2002 14:49:50 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0208081449170.28174-101000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="----=_NextPart_000_0015_01C23EE6.831AD850"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cmjw-0000bu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 08 Aug 2002 05:50:09 -0700
Content-ID: <Pine.GSO.4.21.0208081449171.28174@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Bastian Pflieger <wb@illogical.de>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

------=_NextPart_000_0015_01C23EE6.831AD850
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.21.0208081449172.28174@vervain.sonytel.be>

---------- Forwarded message ----------
Date: Thu, 8 Aug 2002 14:18:48 +0200
From: Bastian Pflieger <wb@illogical.de>
To: geert@linux-m68k.org
Subject: KernelDoc "fb": New Framebuffer help text

Hello

I wrote a little help text to setup the SiS Framebuffer. I think
that is currently missing.

I usally activate the VESA Framebuffer, but a few days ago I bought a cheap
laptop with a SiS Chipset and I was lost how to activate the SiS
Framebuffer.

It's no indepth guide or something, just a little help to setup the
framebuffer quick.

Its my first contribution ever made, so if something wrong or not good
enough please tell me.

Greetings
Bastian Pflieger



------=_NextPart_000_0015_01C23EE6.831AD850
Content-Type: APPLICATION/OCTET-STREAM; NAME="sisfb.dat"
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.GSO.4.21.0208081449173.28174@vervain.sonytel.be>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="sisfb.dat"

SiS Framebuffer=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
This is a quick and easy setup guide for SiS first time users.=0A=
=0A=
Important note: If you intend to use the hardware acceleration =
facilities of=0A=
                the X-Server with your SiS Chipset, you must select the =
SiS=0A=
                Framebuffer.=0A=
=0A=
                The SiS X-Driver depends on this framebuffer for =
acceleration.=0A=
=0A=
=0A=
How I activate / setup the framebuffer?=0A=
---------------------------------------=0A=
=0A=
There are two important parameters you should set:=0A=
=0A=
Parameter   I Description=0A=
------------I--------------------------------------------------=0A=
mode        I Selects the resolution and depth. The value=0A=
            I format is straight forward, so I just give you=0A=
            I an example: mode=3D1024x768x32 or mode=3D800x600x16=0A=
            I=0A=
            I Say "none" if you want the default 80x25 textmode=0A=
------------I--------------------------------------------------=0A=
rate        I Selects the vertical refresh rate (Hz).=0A=
            I Example: rate=3D85 (Default is 60)=0A=
            I=0A=
            I (I must admit that I am using a TFT display and=0A=
            I  cannot verify how good this option works)=0A=
=0A=
If you compiled the driver into the kernel you must use the following =
format=0A=
for the kernel parameters: video=3Dsisfb:<parameter>:<value>=0A=
=0A=
If you use lilo you can insert, for example, the following line in your=0A=
lilo.conf:=0A=
=0A=
append=3D"video=3Dsisfb:mode:1024x768x32 video=3Dsisfb:rate:85"=0A=
=0A=
Substitute the example parameter values with your values and restart =
lilo,=0A=
so the parameters are automatically set for you every time you boot.=0A=
=0A=
There are a lot more useful parameters that may help you to setup your=0A=
SiS stuff. Instead of repeating them here, point your favourite browser=0A=
to http://www.winischhofer.net.=0A=
=0A=
=0A=
Where to find more information?=0A=
-------------------------------=0A=
=0A=
Visit Thomas Winischhofer's site: http://www.winischhofer.net=0A=
=0A=
There you find additional detailed information about the=0A=
configuration of the framebuffer and the X-Driver.=0A=
=0A=
=0A=
Personal note=0A=
-------------=0A=
=0A=
I am _not_ the author of any SiS Chipset support drivers. I wrote this=0A=
text mainly to help all SiS Fans to get the framebuffer device working=0A=
right the first time.=0A=
=0A=
--=0A=
Bastian Pflieger <wb@illogical.de>=0A=
Aug 8, 2002=0A=

------=_NextPart_000_0015_01C23EE6.831AD850--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: =?iso-8859-15?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: Matrox G550, dual head, 1680x1050
Date: Mon, 5 Mar 2007 21:02:31 +0100
Message-ID: <200703052102.31786.hjk@linutronix.de>
References: <200703021053.00955.hjk@linutronix.de>
	<200703042247.21590.hjk@linutronix.de>
	<45EBA3B6.3060701@vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOJOK-00015M-Hn for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 12:02:40 -0800
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOJOI-0006g9-R7
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 12:02:40 -0800
In-Reply-To: <45EBA3B6.3060701@vc.cvut.cz>
Content-Disposition: inline
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Tilman Sauerbeck <tilman@code-monkey.de>, linux-fbdev-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

Am Montag, 5. M=E4rz 2007 05:59 schrieb Petr Vandrovec:

>
> Can you try setting vxres for second head from 1680 to 1696, or 1728?
> Maybe X look at vxres and not at framebuffer line length (what fbset -i
> reports for line length?)
>

Here are more details:

1.) I boot my kernel (vanilla 2.6.20.1) with the following parameters:

video=3Dmatroxfb:outputs:120,pixclock:7380,xres:1680,yres:1050,upper:32,
               lower:4,left:32,right:224,hslen:136,vslen:4,depth:32

This initializes the primary head correctly. The second head is probably =

wrong, because the monitor's on screen message complains about a non-ideal =

resolution.

2.) X starts with Xinerama=3DOn, using this modeline for each monitor:

Modeline "1680x1050@60" 154.20 1680 1712 2296 2328 1050 1071 1081 1103

3.) After that, fbset -i reports this:

$ fbset -i -fb /dev/fb0

mode "1680x1050-60"
    # D: 135.501 MHz, H: 65.396 kHz, V: 59.997 Hz
    geometry 1680 1050 1696 2473 32
    timings 7380 32 224 32 4 136 4
    accel true
    rgba 8/16,8/8,8/0,8/24
endmode

Frame buffer device information:
    Name        : MATROX
    Address     : 0xd4000000
    Size        : 16777216
    Type        : PACKED PIXELS
    Visual      : TRUECOLOR
    XPanStep    : 8
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 6784
    MMIO Address: 0xd6000000
    MMIO Size   : 16384
    Accelerator : Matrox G400


$ fbset -i -fb /dev/fb1

mode "640x480-60"
    # D: 25.176 MHz, H: 31.469 kHz, V: 59.942 Hz
    geometry 640 480 640 480 32
    timings 39721 48 16 33 10 96 2
    rgba 8/16,8/8,8/0,8/24
endmode

Frame buffer device information:
    Name        : MATROX DH
    Address     : 0xd5800000
    Size        : 8388608
    Type        : PACKED PIXELS
    Visual      : TRUECOLOR
    XPanStep    : 8
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 2560
    MMIO Address: 0xd6000000
    MMIO Size   : 16384
    Accelerator : No

As you can see, the second monitor fell back to VGA resolution, but the log=
s =

tell that X thinks it successfully switched to 1680x1050. The KDE control =

center reports the same. The image on the second monitor is distorted.

4.) I then issue the following command:

$ fbset -fb /dev/fb1 -g 1680 1050 1696 1050 32 -t 7380 224 32 32 4 136 4

With that, the image on the second monitor immediately becomes clear, and I =

have a fully working xinerama configuration then.

As far as I can see, fbset is the only way to initialize the second head =

properly. Neither matroxfb nor mga do it correctly with 1680x1050.

Cheers,
Hans

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV

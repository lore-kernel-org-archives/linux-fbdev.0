From: Richard Smith <rsmith@bitworks.com>
Subject: Re: Mobility M1 refresh code problem 2.4.26?
Date: Thu, 06 May 2004 15:35:32 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <409AA194.8090609@bitworks.com>
References: <20040430150627.GB1543@sci.fi> <Pine.LNX.4.44.0404301707110.12865-100000@phoenix.infradead.org> <20040501004059.GD30285@guug.org> <409A91D6.4000508@bitworks.com> <409A98A5.2040809@telia.com>
Reply-To: RSmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLpaw-0000nr-2a
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 13:35:50 -0700
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BLpav-0004ks-Ks
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 13:35:49 -0700
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 May 2004 15:35:29 -0500
In-Reply-To: <409A98A5.2040809@telia.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: miffe-miffe@telia.com
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Mikael Eriksson wrote:

> dmesg:
> atyfb: using auxiliary register aperture
> atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
> atyfb: BIOS contains driver information table.
> atyfb: colour active matrix monitor detected: Samsung LT141X4-156
>         id=2, 1024x768 pixels, 262144 colours (LT mode)
>         supports 60 Hz refresh rates, default 60 Hz
>         LCD CRTC parameters: 15384 167 127 130 0 17 805 767 769 6
> atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz 
> XTAL, 230 MHz PLL, 83 Mhz MCLK, 125 Mhz XCLK
> 
> .config:
> CONFIG_FB_ATY=y
> # CONFIG_FB_ATY_GX is not set
> CONFIG_FB_ATY_CT=y
> CONFIG_FB_ATY_GENERIC_LCD=y
> # CONFIG_FB_ATY128 is not set
> 
> boot-param:
> video=atyfb:1024x768-32

Hmmm... I had GX set.  Unsetting and rebuilding did change things.  the 
text is almost readable but its still not quite right.

I was doing it as a module rather than at boot time but changing to the 
driver compiled in still has the same result.

My dmesg output is identical to yours.  But X still logs a differnt 
refresh rate code of 7.  What refresh rate code is in your X windows log 
file?

I'm doing a make clean;make bzImage right not to be sure its not some 
holdover of haveing GX enabled on my original build.




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3

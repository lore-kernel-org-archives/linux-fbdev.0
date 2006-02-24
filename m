From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: Re: atyfb, console, kernel 2.6.14 & Sony
 Vaio C1VE
Date: Sat, 25 Feb 2006 05:16:07 +0800
Message-ID: <43FF7797.7040403@gmail.com>
References: <83d4769a9bceb571796228cb5c7534c3@csi.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCkIn-0007D6-8i
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Feb 2006 13:16:37 -0800
Received: from wproxy.gmail.com ([64.233.184.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FCkIl-0001BN-SX
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Feb 2006 13:16:37 -0800
Received: by wproxy.gmail.com with SMTP id 71so380594wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Feb 2006 13:16:34 -0800 (PST)
In-Reply-To: <83d4769a9bceb571796228cb5c7534c3@csi.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: fractallyte@csi.com

Fractallyte wrote:
> Hi
> 
> OK, tried out the 2.6.15.4 kernel.  dmesg:
> 
>     atyfb: using auxiliary register aperture
>     atyfb: 3D RAGE Mobility P/M (Mach64 LR, PCI) [0x4c52 rev 0x64]
>     atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
>     atyfb: BIOS frequency table:
>     atyfb: PCLK_min_freq 984, PCLK_max_freq 23600, ref_freq 2950,
> ref_divider 64
>     atyfb: MCLK_pwd 4200, MCLK_max_freq 8300, XCLK_max_freq 12500,
> SCLK_freq 5000
>     atyfb: BIOS contains driver information table.
>     atyfb: colour active matrix monitor detected: Sharp
>     atyfb:        id=1, 1024x480 pixels, 262144 colours (LT mode)
>     atyfb:        supports refresh rates [60], default 60 Hz
>     atyfb:        LCD CRTC parameters: 42.8044  1024 1048 1184 1344  480
> 489 495 525
>     atyfb:                           : 23618 160 1024 24 136 30 480 9 6
>     atyfb: 8M SDRAM (1:1), 29.498928 MHz XTAL, 236 MHz PLL, 83 Mhz MCLK,
> 125 MHz XCLK
>     Console: switching to colour frame buffer device 128x30
>     atyfb: fb0: ATY Mach64 frame buffer device on PCI
> 
> It's only *seems* to be a success...  The console is correctly set to
> 128x30, however the timings are apparently not passed from the BIOS to
> the console driver.  From this point on the screen becomes unreadable
> and unusable: white blooms from the edges and spreads inward.
> 
> I'll try it out with the 2.6.16 kernel tomorrow...
> 
> Thanks for your help!

Too many Mobility's that need xclk=62.  Try booting with:

video=atyfb:xclk:62

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: matroxfb dualhead instabilities
Date: Wed, 16 Oct 2002 20:19:10 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4CA1CB42E47@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181sld-0001HI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Oct 2002 11:19:38 -0700
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
To: Javier Marcet <jmarcet@pobox.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 16 Oct 02 at 18:53, Javier Marcet wrote:
> >> One strange thing I've seen though, is that I cannot use 'fbset -depth
> >> xx' with xx other than 32 or I'll get:
> >>     'ioctl FBIOPUT_VSCREENINFO: Invalid argument'
> 
> >16bpp should work too on second head.
> 
> I can only use 32 bits. Don't ask me why.

Do you have compiled 16bpp into kernel? And if everything else
fails, what does '-depth 16 -rgba 5,6,5' or '-depth 16 -rgba 5,5,5,1'?

> >Maybe that it enables IRQ on card before installing IRQ handler.
> >In such case nobody is going to clear IRQ in mga IRQ status register,
> >and your system is processing endless stream of interrupts. Buying
> >another CPU may give you chance to debug it. Or if you'll send
> >me pointer to the patch, I can review it...
> 
> You mean the patch that gives the problem or .. what? It's the
> vsync-irq-patch on your ftp server.

Hm...

platan:~# cd ~ftp
platan:/home/ftp# find -name '*irq*'
platan:/home/ftp#

so I have to ask stupid question... where is my ftp server?

> >If mga-*-tvout, it adds support for DVI-D and TV outputs available
> >on G450/G550.
> 
> OK, I don't need that one but it's already included in -ac branch.
> Maybe Alan agrees to include the fbset-through-vt one too, even if
> Marcelo, or whoever, refused to include it.

mga-*-tvout allows 'v4lctl -c /dev/fb0 xxxx' to set brightness/contrast
on TV output. I'm not sure whether Alan merged this too or not,
as it uses v4l2 interface, which is not in the kernel yet (and as it
stands, v4l2 is not going to 2.6.x too).
 
> >Maybe I should rerun benchmarks listed in Documentation/fb/matroxfb.txt
> >also on newer hardware.
> 
> Tell me if you wanna have results from other systems.

I'll try to create some selfcontained benchmark.
 
> 00:0a.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
>     Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
>     Flags: bus master, medium devsel, latency 32, IRQ 15
>     Memory at de800000 (32-bit, non-prefetchable) [size=512]
> 
> 00:0c.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
>     Subsystem: Unknown device 0030:13eb
>     Flags: bus master, medium devsel, latency 32, IRQ 11
>     Memory at e1000000 (32-bit, prefetchable) [size=4K]
>     Capabilities: [04] #06 [0290]
> 
> 00:0c.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
>     Subsystem: Unknown device 0030:13eb
>     Flags: bus master, medium devsel, latency 32, IRQ 11
>     Memory at e0800000 (32-bit, prefetchable) [size=4K]
>     Capabilities: [04] #06 [0290]
> 
> Whereas if I remove the DVB card, the output is:
> 
> 00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
>     Subsystem: Hauppauge computer works Inc. WinTV/GO
>     Flags: bus master, medium devsel, latency 32, IRQ 15
>     Memory at e1000000 (32-bit, prefetchable) [size=4K]
>     Capabilities: [44] Vital Product Data
>     Capabilities: [4c] Power Management version 2
> 
> 00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
>     Subsystem: Hauppauge computer works Inc. WinTV/GO
>     Flags: bus master, medium devsel, latency 32, IRQ 15
>     Memory at e0800000 (32-bit, prefetchable) [size=4K]
>     Capabilities: [44] Vital Product Data
>     Capabilities: [4c] Power Management version 2

I know that you'll not believe me, but your DVB card has hardware
problem: it grounds pin DATA6 of PCI bus to zero: so it gets 04 instead
of 44 from capabilities, 0030 instead 0070 from subsystem vendor
ID... 

I cannot explain why busid changed for your Bt878: if it would move
from 0A to 02, or disappeared completely, I could understand it...
but move from 0A to 0C? Sorry...
                                                Petr
                                                 


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm

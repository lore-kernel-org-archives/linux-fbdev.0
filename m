From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Fw: [2.6.10-bk6] oops in load of atyfb
Date: Mon, 10 Jan 2005 12:08:09 -0500 (EST)
Message-ID: <Pine.LNX.3.96.1050110115920.10893A-100000@gatekeeper.tmr.com>
References: <200501100516.20841.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Co3Ba-0004wE-An
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Jan 2005 09:18:34 -0800
Received: from mail.tmr.com ([216.238.38.203] helo=gatekeeper.tmr.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Co3BT-0004o6-TH
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Jan 2005 09:18:32 -0800
In-Reply-To: <200501100516.20841.adaplas@hotpop.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

On Mon, 10 Jan 2005, Antonino A. Daplas wrote:

> On Thursday 06 January 2005 08:56, Andrew Morton wrote:
> > Begin forwarded message:
> >
> > Date: Wed, 5 Jan 2005 16:24:02 -0500 (EST)
> > From: Bill Davidsen <davidsen@tmr.com>
> > To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> > Subject: [2.6.10-bk6] oops in load of atyfb
> >
> >
> > After some hours of trying to get video to the atyfb instead of vga16, I
> > got this. The video= boot option didn't seem to work, loading the module
> > caused an oops.
> >
> > Something borked, out of time to fight with it.
> 
> Have you accidentally enabled CONFIG_FB_ATY_XL_INIT?  If you did, recompile
> with this option off.

That doesn't appear to be the case, but I will attach the config file in
case I did something else ill-advised. I'm having no luck getting FC[123]
to use non-generic framebuffers with 2.6, either on the test machine for
which this build was done, or on my laptop, which would be a world more
fun to use at the hardware 1400x1050 instead of 1024x768.

Hope this will suggest something to you. I add lspci, unfortunately
drag-n-droped, if you can't read it I'll mail an attachment from the
actual machine.

lspci:
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03)
00:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
05)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0e.0 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:0e.1 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:0e.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
00:10.0 Multimedia audio controller: Aureal Semiconductor Vortex 1 (rev
02)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
1X/2X (rev 5c)

Video details:
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
1X/2X (rev 5c) (prog-if 00 [VGA])
        Subsystem: Intel Corp. Xpert 98D AGP 2X
        Flags: bus master, stepping, medium devsel, latency 66, IRQ 11
        Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at 9000 [size=256]
        Memory at f4200000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>

Thanks much for your interest in this! The machine is an old Dell
P-II/350, 160MB ram, running RH7.3 upgraded as 2.5 developed and I had to
fix stuff. Other than the video issue it's been rock solid and in
regular use since 2.5.47 or so.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

From: Louis Garcia <louisg00@bellsouth.net>
Subject: Re: radeonfb and 2.5.66
Date: 25 Mar 2003 18:07:37 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048633657.2513.5.camel@tiger>
References: <Pine.GSO.4.21.0303251607490.22126-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail141.mail.bellsouth.net ([205.152.58.101] helo=imf52bis.bellsouth.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xxVu-0001vc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Mar 2003 15:07:27 -0800
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

When I use video=radeonfb:dfp my monitor just goes into power saving
mode (shuts off). This is what I get in the logs: If someone needs more
info let me know. By the way I'm on a Intel x86 box.

--Lou


Mar 25 17:54:13 tiger kernel: Kernel command line: ro root=/dev/hda6
hdc=ide-scsi video=radeonfb:dfp



Mar 25 17:54:13 tiger kernel: radeonfb_pci_register BEGIN
Mar 25 17:54:13 tiger kernel: radeonfb: ref_clk=2700, ref_div=12,
xclk=23000 defaults
Mar 25 17:54:13 tiger kernel: radeonfb: probed DDR SGRAM 65536k videoram
Mar 25 17:54:13 tiger kernel: radeonfb: detected DFP panel size from
registers: 1280x1024
Mar 25 17:54:13 tiger kernel: radeonfb: ATI Radeon 7500 QW DDR SGRAM 64
MB
Mar 25 17:54:13 tiger kernel: radeonfb: DVI port DFP monitor connected
Mar 25 17:54:13 tiger kernel: radeonfb: CRT port no monitor connected
Mar 25 17:54:13 tiger rpc.statd[1014]: Version 1.0.1 Starting
Mar 25 17:54:13 tiger keytable: Loading keymap:
Mar 25 17:54:13 tiger kernel: radeonfb_pci_register END
Mar 25 17:54:13 tiger kernel: hStart = 680, hEnd = 960, hTotal = 1056
Mar 25 17:54:13 tiger kernel: vStart = 482, vEnd = 501, vTotal = 522
Mar 25 17:54:13 tiger kernel: h_total_disp = 0x4f0083^I   hsync_strt_wid
= 0xa302a2
Mar 25 17:54:13 tiger kernel: v_total_disp = 0x1df0209^I  
vsync_strt_wid = 0x9301e1
Mar 25 17:54:13 tiger kernel: post div = 0x8
Mar 25 17:54:13 tiger kernel: fb_div = 0x59
Mar 25 17:54:13 tiger kernel: ppll_div_3 = 0x30059
Mar 25 17:54:13 tiger kernel: ron = 712, roff = 16464
Mar 25 17:54:13 tiger kernel: vclk_freq = 2503, per = 588
Mar 25 17:54:13 tiger kernel: Console: switching to colour frame buffer
device 80x30
Mar 25 17:54:13 tiger keytable:
Mar 25 17:54:13 tiger kernel: pty: 2048 Unix98 ptys configured



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

From: =?iso-8859-1?q?Marc_Poulhi=E8s?= <marc.poulhies@epfl.ch>
Subject: Re: Fw: [Bugme-new] [Bug 4217] New: radeonfb makes system hang and
 LCD "burn"
Date: Wed, 16 Feb 2005 19:43:04 +0100
Message-ID: <87r7jggxc7.fsf@kataplop.net>
References: <20050215121555.54c63ed2.akpm@osdl.org>
	<1108502142.13394.2.camel@gaston> <87fyzxsdo7.fsf@kataplop.net>
	<1108504143.13376.14.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1U8S-0007fl-MZ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 10:42:52 -0800
Received: from postfix3-1.free.fr ([213.228.0.44])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D1U8P-0002Yy-JO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 10:42:52 -0800
In-Reply-To: <1108504143.13376.14.camel@gaston> (Benjamin Herrenschmidt's
 message of "Wed, 16 Feb 2005 08:49:02 +1100")
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Try building radeonfb in the kernel and booting with
> radeonfb.default_dynclk=-1, let me know if that works. fbdev's in
> modules have always been sort-of dodgy....
>
> The "dynclk" thing has issues, the upstream code from ATI has some bugs
> plus there is something weird going on which I suspect might be a
> miscompile of a bit of code in there. I'll send a patch working around
> that today.
>
> Ben.

Ok, did that. Same result. The only thing displayed is the system
caret. I can see it moving left and right while the system boots and
"displays" the messages (X is working nicely).

I did compile debug support, so I'm including the output.

Tell me if I can test something else,
Thanks very much,

Marc

debug output:

radeonfb (0000:01:00.0): Found 32768k of DDR 64 bits wide videoram
radeonfb (0000:01:00.0): mapped 16384k videoram
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=230.00 Mhz, System=166.00 MHz
radeonfb: PLL min 12000 max 35000
1 chips in connector info
 - chip 1 has 1 connectors
  * connector 0 of type 2 (CRT) : 2300
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
Non-DDC laptop panel detected
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: QDI QD141F1LH01         
radeonfb: detected LVDS panel size from BIOS: 1400x1050
BIOS provided panel power delay: 1500
radeondb: BIOS provided dividers will be used
ref_divider = 6
post_divider = 4
fbk_divider = 48
Scanning BIOS table ...
 320 x 350
 320 x 400
 320 x 400
 320 x 480
 400 x 600
 512 x 384
 640 x 350
 640 x 400
 640 x 475
 640 x 480
 720 x 480
 720 x 576
 800 x 600
 848 x 480
 1024 x 768
 1152 x 864
 1280 x 1024
 1400 x 1050
Found panel in BIOS table:
  hblank: 288
  hOver_plus: 40
  hSync_width: 112
  vblank: 13
  vOver_plus: 0
  vSync_width: 3
  clock: 10800
Setting up default mode based on panel info
radeonfb (0000:01:00.0): ATI Radeon LW 
radeonfb_pci_register END


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

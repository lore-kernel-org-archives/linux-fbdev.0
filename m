From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] GeForce 5200 on rivafb
Date: Mon, 13 Dec 2004 23:51:01 -0800
Message-ID: <7vr7lt8gii.fsf@assigned-by-dhcp.cox.net>
References: <200412120511.31725.adaplas@hotpop.com>
	<7vpt1fu97r.fsf@assigned-by-dhcp.cox.net>
	<200412140452.19873.adaplas@hotpop.com>
	<200412140547.22222.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CeT56-0003TS-Ej
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 22:56:16 -0800
Received: from fed1rmmtao11.cox.net ([68.230.241.28])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CeT56-00049K-2B
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 22:56:16 -0800
In-Reply-To: <200412140547.22222.adaplas@hotpop.com> (Antonino A. Daplas's
 message of "Tue, 14 Dec 2004 05:47:19 +0800")
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
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

>>>>> "AAD" == Antonino A Daplas <adaplas@hotpop.com> writes:

AAD> Can you try this patch and enable nvidiafb-i2c. It adds your monitor model
AAD> to the database of displays with broken edid's and attempts a fix. It
AAD> checks first if the monitor is GTF capable, and if it is, sets the input
AAD> type from digital to analog. (I don't think digital inputs can be GTF
AAD> capable).

AAD> Apply this patch too, I forgot to adjust the checksum.

Thanks as always for a quick help.

With those two patches, your fixup message appears in the boot
log 6 times (is it expected?).  The monitor does not go blank
anymore; it safely defaults to CRTCNumber 0.  Overall, it is as
if I am using your nvidiafb driver without nvidia-i2c ;-).

Boot time kernel message is attached here.

----------------------------------------------------------------

nvidiafb: nVidia device/chipset 10DE0110
nvidiafb: nVidia Corporation NV11 [GeForce2 MX/MX 400]
fbmon: The EDID Block of Manufacturer: VSC Model: 0x5a44 is known to be broken,
fbmon: trying to fix input type
fbmon: The EDID Block of Manufacturer: VSC Model: 0x5a44 is known to be broken,
fbmon: trying to fix input type
nvidiafb: EDID found from BUS1
fbmon: The EDID Block of Manufacturer: VSC Model: 0x5a44 is known to be broken,
fbmon: trying to fix input type
fbmon: The EDID Block of Manufacturer: VSC Model: 0x5a44 is known to be broken,
fbmon: trying to fix input type
========================================
Display Information (EDID)
========================================
   EDID Version 1.2
   Manufacturer: VSC
   Model: 5a44
   Serial#: 2694881440
   Year: 2150 Week 14
   Serial Number: DZ01401434
   Monitor Name: PF775
   Display Characteristics:
      Monitor Operating Limits: From EDID
           H: 30-97KHz V: 50-180Hz DCLK: 200MHz
      Analog Display Input: Input Voltage - 0.714V/0.286V
      Sync: 
      Max H-size in cm: 160
      Max V-size in cm: 160
      Gamma: 2.60
      DPMS: Active yes, Suspend yes, Standby yes
      RGB Color Display
      Chroma
         RedX:     0.627 RedY:     0.342
         GreenX:   0.289 GreenY:   0.605
         BlueX:    0.150 BlueY:    0.070
         WhiteX:   0.283 WhiteY:   0.298
      First DETAILED Timing is preferred
      Display is GTF capable
fbmon: The EDID Block of Manufacturer: VSC Model: 0x5a44 is known to be broken,
fbmon: trying to fix input type
fbmon: The EDID Block of Manufacturer: VSC Model: 0x5a44 is known to be broken,
fbmon: trying to fix input type
   Supported VESA Modes
      720x400@70Hz
      640x480@60Hz
      800x600@72Hz
      800x600@75Hz
      832x624@75Hz
      1024x768@87Hz Interlaced
      1024x768@60Hz
      1024x768@70Hz
      1024x768@75Hz
      1280x1024@75Hz
      1152x870@75Hz
      Manufacturer's mask: 0
   Standard Timings
      640x480@85Hz
      800x600@85Hz
      1528x1146@75Hz
      1280x960@60Hz
      1280x960@85Hz
      1280x1024@85Hz
      1528x1222@60Hz
      1600x1200@75Hz
   Detailed Timings
      94 MHz 1024 1072 1168 1376 768 769 772 808 +HSync +VSync

========================================
nvidiafb: Unable to detect which CRTCNumber...
...Defaulting to CRTCNumber 0
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
Console: switching to colour frame buffer device 128x48
nvidiafb: PCI nVidia NV11 framebuffer (64MB @ 0xD8000000)
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: AGP aperture is 128M @ 0xd0000000





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

From: Mikael Eriksson <miffe-miffe@telia.com>
Subject: Re: Mobility M1 refresh code problem 2.4.26?
Date: Fri, 07 May 2004 09:57:53 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <409B4181.3080301@telia.com>
References: <20040430150627.GB1543@sci.fi> <Pine.LNX.4.44.0404301707110.12865-100000@phoenix.infradead.org> <20040501004059.GD30285@guug.org> <409A91D6.4000508@bitworks.com> <409A98A5.2040809@telia.com> <409AA194.8090609@bitworks.com> <Pine.GSO.4.58.0405062241550.20729@waterleaf.sonytel.be> <409AAA39.8000304@bitworks.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BM0G8-000333-75
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 May 2004 00:59:04 -0700
Received: from av5-2-sn4.m-sp.skanova.net ([81.228.10.111])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BM0G7-0004sc-GG
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 May 2004 00:59:03 -0700
In-Reply-To: <409AAA39.8000304@bitworks.com>
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
To: RSmith@bitworks.com
Cc: geert@linux-m68k.org, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Richard Smith wrote:
> Geert Uytterhoeven wrote:
> 
>> On Thu, 6 May 2004, Richard Smith wrote:
>>
>>> Hmmm... I had GX set.  Unsetting and rebuilding did change things.  the
>>
>>
>>
>> Strange, {en,dis}abling GX should matter for Mach64 GX chips only.
> 
> 
> Could be some randomness in what I'm seeing.  I haven't done it enough 
> times repeatedly to verify it does the same thing every time.
> 
> I rebuilt from a make clean and got the same result.  I enabled DEBUG in 
> the driver now and heres the output.  Can you enable debug and check 
> against your good setup.
> 
> atyfb: using auxiliary register aperture
> atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
> atyfb: BIOS contains driver information table.
> atyfb: colour active matrix monitor detected: Samsung LT141X4-156
> ati kernel:         id=2, 1024x768 pixels, 262144 colours (LT mode)
> ati kernel:         supports 60 Hz refresh rates, default 60 Hz
> ati kernel:         LCD CRTC parameters: 15384 167 127 130 0 17 805 767 
> 769 6
> ati kernel: atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 
> 29.498928 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 125 Mhz XCLK
> ati kernel: BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL 
> DSP_CONFIG DSP_ON_OFF CLOCK_CNTL
> ati kernel: 7333a001 8601200a 10c57a3b e0000c81     02402200 00570628   
> 049e05f8   00400a00
> ati kernel: PLL ac ac 40 4c 87 03 c0 d4 d4 d4 00 f9 80 1b 00 00 0e cf 40 
> 00 50 f6 ac 03 40 00 24 fd 00 00 00 02 06 ac 06 ac 03 24 fd 00
> ati kernel: BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL 
> DSP_CONFIG DSP_ON_OFF
> ati kernel: 7333a001 8601200a 10c57a3b e0000c81     02402200 00570628   
> 049e05f8
> ati kernel: PLL ac ac 41 ec 89 03 c0 d4 d4 d4 00 00 80 1b 00 00 0e cf 40 
> 00 50 b6 ac 10 40 00 24 fd 00 00 00 02 06 ac 06 ac 03 24 fd 00
> ati kernel: Console: switching to colour frame buffer device 128x48
> 
This is what I get:
<6>devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
<6>devfs: boot_options: 0x0
<6>atyfb: using auxiliary register aperture
<6>atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
<6>atyfb: BIOS contains driver information table.
<6>atyfb: colour active matrix monitor detected: Samsung LT141X4-156
<4>        id=2, 1024x768 pixels, 262144 colours (LT mode)
<6>        supports 60 Hz refresh rates, default 60 Hz
<6>        LCD CRTC parameters: 15384 167 127 130 0 17 805 767 769 6
<4>atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 
MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 125 Mhz XCLK
<4>BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG 
DSP_ON_OFF CLOCK_CNTL
<4>7333a001 8601200a 10c57a3b e0000c81     02402200      00570628 
049e05f8   00400a00
<4>PLL ac ac 40 4c 87 03 c0 d4 d4 d4 00 f9 80 1b 00 00 0e cf 40 00 50 f6 
ac 03 40 00 24 fd 00 00 00 02 06 ac 06 ac 03 24 fd 00
<4>BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG 
DSP_ON_OFF
<4>7333a001 8601200a 10c57a3b e0000c81     02402200      00570628   049e05f8
<4>PLL ac ac 41 ec 89 03 c0 d4 d4 d4 00 00 80 1b 00 00 0e cf 40 00 50 b6 
ac 10 40 00 24 fd 00 00 00 02 06 ac 06 ac 03 24 fd 00
<4>Console: switching to colour frame buffer device 80x25

Also XFree reports refresh rate code 7
Btw, which bios version do you have?


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3

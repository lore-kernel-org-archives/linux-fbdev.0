From: Rui Santos <rsantos@grupopie.com>
Subject: Re: radeonfb cannot map FB
Date: Thu, 27 Aug 2009 12:04:58 +0100
Message-ID: <4A96685A.5060404@grupopie.com>
References: <4A92EDDB.6040806@grupopie.com> <1251280465.1379.64.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rsantos@grupopie.com>) id 1MgcnQ-0000DP-Eq
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Aug 2009 11:05:36 +0000
Received: from bipbip.grupopie.com ([195.23.16.24])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MgcnK-0007fN-Sd for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Aug 2009 11:05:36 +0000
In-Reply-To: <1251280465.1379.64.camel@pasglop>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux FB-Devel <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:
> On Mon, 2009-08-24 at 20:45 +0100, Rui Santos wrote:
>   
>> Dear Benjamin Herrenschmidt, dear mailing list subscribers,
>>
>>      I'm trying to load radeonfb for an RV100 QY chipset. Whatever I
>> type in the modprobe I always get:
>>        radeonfb (0000:01:0c.0): cannot map FB
>>        radeonfb: probe of 0000:01:0c.0 failed with error -5
>>     
>
> I suspect your BIOS isn't initializing the secondary card, radeonfb is
> thus unable to use it.
>
> However, you probably don't need radeonfb. X.org should be able to get
> it going as a secondary just fine, but your text consoles will have to
> remain on the intel.
>
> In the long run (though it might already work with latest upstream), the
> new radeon KMS should be able to initialize those.
>   
Hi Ben, sorry for the late reply ( Motherboard crash),

The system I'm trying to setup is an IBM SurePOS 500. It is supposed to
work on a FB console (no X) in order to play some Videos :)
I'm able to use a usb to vga in order to accomplish this but, using the
integrated Radeon was preferable.
So, you're saying that it is probably a BIOS related issue, not
initializing the secondary Video card. Is there anyway I can make sure
of it? If the BIOS is not initializing it properly, I may be able to
contact IBM about it.

Once again, thanks a lot for your help,
> Cheers,
>   
Regards,
> Ben.
>   
Rui

>   
>>     I've tried latest 2.6.27.x and 2.6.30.x kernels. This a secondary
>> video card that I would like to connect a monitor to. The first video
>> card is an Intel 915G, which is working with vesafb.
>>
>>     Here is the output of lspci -vvv
>>     01:0c.0 VGA compatible controller: ATI Technologies Inc Radeon RV100
>> QY [Radeon 7000/VE] (prog-if 00 [VGA controller])
>>             Subsystem: ATI Technologies Inc Device 013b
>>             Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping+ SERR- FastB2B- DisINTx-
>>             Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>>     
>>> TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>       
>>             Interrupt: pin A routed to IRQ 18
>>             Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
>>             Region 1: I/O ports at dc00 [size=256]
>>             Region 2: Memory at fdee0000 (32-bit, non-prefetchable)
>> [size=64K]
>>             [virtual] Expansion ROM at fde00000 [disabled] [size=128K]
>>             Capabilities: [50] Power Management version 2
>>                     Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>             Kernel modules: radeonfb
>>
>>     Can you or anyone give a hint on what I might be doing wrong:
>> modprobe radeonfb mode_option=800x600-16 panel_yres=600
>>     Or could this be some kind of hardware issue ?
>>
>>     Thanks a lot for your help,
>>
>> Regards,
>>
>> Rui Santos
>> http://www.ruisantos.com/
>>
>> Veni, vidi, Linux!
>>
>>     
>
>
>
>
>   


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july

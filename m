From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: FBDEV 2.6.0-test7 updates.
Date: Fri, 17 Oct 2003 15:42:39 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031017224239.38271.qmail@web14912.mail.yahoo.com>
References: <20031016091918.GA1002@casa.fluido.as>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAdP0-0005vI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 15:48:58 -0700
Received: from web14912.mail.yahoo.com ([216.136.225.248])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1AAdM0-000070-Cz
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Oct 2003 15:45:52 -0700
In-Reply-To: <20031016091918.GA1002@casa.fluido.as>
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
Content-Transfer-Encoding: 7bit
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- "Carlo E. Prelz" <fluido@fluido.as> wrote:
> (I did not know how to call it. _Yz did not exist, so I grabbed it. Is
> there any logic in these codes?)

5964 = 59 hex 64 hex  
Convert the PCI ID to ASCII chars

0x59 = Y
0x64 = d

Yd is the right code.

--- "Carlo E. Prelz" <fluido@fluido.as> wrote:
> 	Subject: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
> 	Date: gio, ott 16, 2003 at 12:27:44 +0100
> 
> Quoting James Simmons (jsimmons@infradead.org):
> 
> > I applied it. I also have Ben's new driver avaiable for testing. 
> > The diff I released uses Ben's new driver but in BK I'm stilling using teh 
> > old driver.
> 
> I am the happy owner of a "Club"-branded Radeon9200 video card. Here
> are my experiences using your diff.
> 
> My card has a PCI id of 5964. Here you can read the output of 'lspci
> -vvv' for it:
> 
> --8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5964
> (rev 01) (prog-if 00 [VGA])
>         Subsystem: C.P. Technology Co. Ltd: Unknown device 2073
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 96 (2000ns min), cache line size 08
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
>         Region 1: I/O ports at b800 [size=256]
>         Region 2: Memory at dfef0000 (32-bit, non-prefetchable) [size=64K]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: [58] AGP version 3.0
>                 Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
> HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
>                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW-
> Rate=<none>
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> --8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--
> 
> The only 9200 listed in pci_ids.h had an
> id of 5960. I added a new line, as follows:
> 
> --- pci_ids.h~  2003-10-16 08:26:14.000000000 +0200
> +++ pci_ids.h   2003-10-16 09:12:22.000000000 +0200
> @@ -307,6 +307,7 @@
>  #define PCI_DEVICE_ID_ATI_RADEON_In    0x496e
>  /* Radeon RV280 (9200) */
>  #define PCI_DEVICE_ID_ATI_RADEON_Y_    0x5960
> +#define PCI_DEVICE_ID_ATI_RADEON_Yz    0x5964
>  /* Radeon R300 (9500) */
>  #define PCI_DEVICE_ID_ATI_RADEON_AD    0x4144
>  /* Radeon R300 (9700) */
> 
> (I did not know how to call it. _Yz did not exist, so I grabbed it. Is
> there any logic in these codes?)
> 
> Then I added the new ID to aty/radeon_base.c:
> 
> --- radeon_base.c~      2003-10-16 08:26:13.000000000 +0200
> +++ radeon_base.c       2003-10-16 09:13:18.000000000 +0200
> @@ -153,6 +153,7 @@
>         { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_X6, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, RADEON_RS300},
>         { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_X7, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, RADEON_RS300},
>         { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Y_, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, RADEON_RV280},
> +       { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Yz, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, RADEON_RV280},
>         { 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, radeonfb_pci_table);
> 
> Again, I just blindly duplicated the entry for the other 9200. Now the
> stuff compiled, but if I chose to make a radeonfb module, I got a
> message stating that 
> 
> WARNING: /lib/modules/2.6.0-test7/kernel/drivers/video/aty/radeonfb.ko needs
> unknown symbol release_console_sem
> 
> Well, I compiled the fb stuff in kernel. The card was eventually
> recognized: 
> 
> radeonfb_pci_register BEGIN
> radeonfb: probed DDR SGRAM 131072k videoram
> radeonfb: ref_clk=2700, ref_div=12, xclk=16600 from BIOS
> Starting monitor auto detection...
> radeonfb: Monitor 1 type CRT found
> radeonfb: Monitor 2 type no found
> radeonfb: ATI Radeon Yd 9200 RV280 DDR SGRAM 128 MB
> radeonfb_pci_register END
> 
> (BTW what does "type no" mean? I have a monitor connected to the DVD
> plug, as well as my normal LCD monitor on the VGA plug - both monitors
> show the framebuffer image)
> 
> But, always at 640x480. My adding 
> 
> video=radeonfb:1280x1024-32@60
> 
> to the append line in Lilo did not cause any visible effect. Running
> 'fbset 1280x1024-60' did indeed change the resolution on my two
> monitors (although with wrong number of lines and columns - unpleasant
> but I know how to fix that). But if I then changed to another virtual
> console, both my monitors went black. The LCD one complained that it
> was fed invalid frequencies (103.1 kHz horizontal, 197.8 Hz
> vertical). At this point, changing virtual consoles had no effect
> anymore, and if I typed Ctrl-Alt-Del, the machine would beep (meaning
> it caught the reboot request) but nothing would happen
> thereafter. Only a hard reboot would give me back the machine.
> 
> (There is also this fancy special effect: the cursor is not
> full-white, but with cute fractal-like black pixels inside.)
> 
> What can I do to help debugging this code? (I am not bk-enabled!)
> 
> Carlo
> 
> -- 
>   *         Se la Strada e la sua Virtu' non fossero state messe da parte,
> * K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
>   *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> SourceForge.net hosts over 70,000 Open Source Projects.
> See the people who have HELPED US provide better services:
> Click here: http://sourceforge.net/supporters.php
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com

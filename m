From: Jan Dittmer <jdittmer@ppp0.net>
Subject: Re: no cursor on nvidiafb console in 2.6.14-rc1-mm1
Date: Mon, 19 Sep 2005 20:51:45 +0200
Message-ID: <432F08C1.8010705@ppp0.net>
References: <20050919175116.GA8172@amd64.of.nowhere>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932571AbVISSwR@vger.kernel.org>
In-Reply-To: <20050919175116.GA8172@amd64.of.nowhere>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

jurriaan wrote:
> After updating from 2.6.13-rc4-mm1 to 2.6.14-rc1-mm1 I see no cursor on
> my console.

Me too, 2.6.14-rc1-git4. Didn't try any kernel before with framebuffer,
sorry. No fb options on the kernel command line.

[4294669.750000] nvidiafb: nVidia device/chipset 10DE0250
[4294669.754000] nvidiafb: CRTC0 not found
[4294669.758000] nvidiafb: CRTC1 not found
[4294669.871000] nvidiafb: EDID found from BUS1
[4294669.887000] nvidiafb: CRTC 1 is currently programmed for DFP
[4294669.887000] nvidiafb: Using DFP on CRTC 1
[4294669.887000] Panel size is 1920 x 1200
[4294669.888000] nvidiafb: MTRR set to ON
[4294669.895000] Console: switching to colour frame buffer device 240x75
[4294669.895000] nvidiafb: PCI nVidia NV25 framebuffer (64MB @ 0xD0000000)

# lspci -vv -s 01:00.0
0000:01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti
4600] (rev a3) (prog-if 00 [VGA])
        Subsystem: CardExpert Technology: Unknown device 03ea
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 2: Memory at ddc80000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at dfee0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>

Jan

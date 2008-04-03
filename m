From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: atyfb rmmod & vram crash, 2.6.24, 2.6.25-rc8
Date: Thu, 3 Apr 2008 11:23:36 +0300
Message-ID: <20080403082336.GD16619@sci.fi>
References: <20080402124854.M56647@visp.net.lb>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhKjX-00081B-5h for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Apr 2008 01:23:43 -0700
Received: from smtp6.pp.htv.fi ([213.243.153.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JhKjV-00070q-G5
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Apr 2008 01:23:43 -0700
Content-Disposition: inline
In-Reply-To: <20080402124854.M56647@visp.net.lb>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Denys Fedoryshchenko <denys@visp.net.lb>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, Apr 02, 2008 at 03:54:12PM +0300, Denys Fedoryshchenko wrote:
> VGA card i dont know how much RAM there actually, but lspci here shows lo=
oks
> like 16MB:
> =

> 03:09.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro 215GP=
 (rev
> 5c) (prog-if 00 [VGA controller])
>         Subsystem: ATI Technologies Inc Rage Pro Turbo
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
> Stepping+ SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 66 (2000ns min), Cache Line Size: 32 bytes
>         Interrupt: pin A routed to IRQ 21
>         Region 0: Memory at f0000000 (32-bit, prefetchable) [size=3D16M]

This region is always 16MB regardless of how much actual RAM is on the
card.

> Loading without parameters
> =

> atyfb: using auxiliary register aperture
> atyfb: 3D RAGE PRO (Mach64 GP, PQFP, PCI) [0x4750 rev 0x7c]
> atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
> atyfb: BIOS frequency table:
> atyfb: PCLK_min_freq 984, PCLK_max_freq 23600, ref_freq 2950, ref_divider=
 64
> atyfb: MCLK_pwd 4200, MCLK_max_freq 7500, XCLK_max_freq 10000, SCLK_freq =
5000
> atyfb: 8M SGRAM (1:1), 29.498928 MHz XTAL, 236 MHz PLL, 75 Mhz MCLK, 100 =
MHz XCLK
> atyfb: fb0: ATY Mach64 frame buffer device on PCI
> =

> It detects 8M.
> If i put parameter vram=3D8

The vram paramter takes KB not MB.

Why do you want to override it anyway? It seems to detect the amount of
RAM just fine.

> And most interesting when i do rmmod
> tv1 ~ # rmmod atyfb
> Segmentation fault

Does this only happen after the failure caused by the bad vram parameter?

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace

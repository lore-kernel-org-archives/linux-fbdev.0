From: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Mon, 21 Mar 2005 14:59:36 -0800
Message-ID: <20050321145936.6f742d89.akpm@osdl.org>
References: <Pine.LNX.4.60.0503052355320.12643@poirot.grange>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDVs9-0005IK-5S
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Mar 2005 14:59:45 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DDVs7-0001FQ-D8
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Mar 2005 14:59:45 -0800
In-Reply-To: <Pine.LNX.4.60.0503052355320.12643@poirot.grange>
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
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, jim.hague@acm.org, linux-fbdev-devel@lists.sourceforge.net

Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
>
> Hi
> 
> Worked on 2.6.10-rc2. With 2.6.11 during boot upon switching to fb, text 
> becomes orange, penguins look sick (not sharp). X starts and runs normal 
> (doesn't use fb), switching to vt not possible any more. Disabling 
> fb-console in kernel config fixes VTs. Reverting pm2fb.c fixes the 
> problem.

Guennadi, could you please confirm that

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm1/broken-out/pm2fb-x-and-vt-switching-crash-fix.patch

fixes this one?

Thanks.

> No unusual output in dmesg.
> 
> System: Compaq AP400 with a TI card:
> 
> 01:00.0 VGA compatible controller: Texas Instruments TVP4020 [Permedia 2] (rev 11) (prog-if 00 [VGA])
> 	Subsystem: Elsa AG GLoria Synergy
> 	Flags: bus master, 66Mhz, medium devsel, latency 66, IRQ 22
> 	Memory at 51000000 (32-bit, non-prefetchable) [size=128K]
> 	Memory at 50000000 (32-bit, non-prefetchable) [size=8M]
> 	Memory at 50800000 (32-bit, non-prefetchable) [size=8M]
> 	Expansion ROM at <unassigned> [disabled] [size=64K]
> 	Capabilities: [4c] Power Management version 1
> 	Capabilities: [40] AGP version 1.0
> 
> CPUs: 2 * Pentium II 400MHz full cpuinfo available on request)
> 
> .config (fb / video):
> 
> CONFIG_FB=y
> CONFIG_FB_MODE_HELPERS=y
> # CONFIG_FB_TILEBLITTING is not set
> # CONFIG_FB_CIRRUS is not set
> CONFIG_FB_PM2=y
> CONFIG_FB_PM2_FIFO_DISCONNECT=y
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_VESA is not set
> CONFIG_VIDEO_SELECT=y
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I810 is not set
> # CONFIG_FB_INTEL is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON_OLD is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_VIRTUAL is not set
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> 
> #
> # Logo configuration
> #
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> CONFIG_LOGO_LINUX_CLUT224=y
> # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

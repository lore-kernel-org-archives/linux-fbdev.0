From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Re: Re: atyfb, console, kernel 2.6.14 & Sony Vaio C1VE
Date: Fri, 3 Mar 2006 17:01:23 +0200
Message-ID: <20060303150123.GA27401@sci.fi>
References: <83d4769a9bceb571796228cb5c7534c3@csi.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FFBmi-0001Vm-00
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 03 Mar 2006 07:01:36 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FFBmf-0001Dz-Nv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 03 Mar 2006 07:01:36 -0800
Content-Disposition: inline
In-Reply-To: <83d4769a9bceb571796228cb5c7534c3@csi.com>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

On Fri, Feb 24, 2006 at 08:16:52PM +0000, Fractallyte wrote:
> Hi
>=20
> OK, tried out the 2.6.15.4 kernel.  dmesg:
>=20
> 	atyfb: using auxiliary register aperture
> 	atyfb: 3D RAGE Mobility P/M (Mach64 LR, PCI) [0x4c52 rev 0x64]
> 	atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
> 	atyfb: BIOS frequency table:
> 	atyfb: PCLK_min_freq 984, PCLK_max_freq 23600, ref_freq 2950,=20
> ref_divider 64
> 	atyfb: MCLK_pwd 4200, MCLK_max_freq 8300, XCLK_max_freq 12500,=20
> SCLK_freq 5000
> 	atyfb: BIOS contains driver information table.
> 	atyfb: colour active matrix monitor detected: Sharp
> 	atyfb:        id=3D1, 1024x480 pixels, 262144 colours (LT mode)
> 	atyfb:        supports refresh rates [60], default 60 Hz
> 	atyfb:        LCD CRTC parameters: 42.8044  1024 1048 1184 1344  480=20
> 489 495 525
> 	atyfb:                           : 23618 160 1024 24 136 30 480 9 6
> 	atyfb: 8M SDRAM (1:1), 29.498928 MHz XTAL, 236 MHz PLL, 83 Mhz MCLK,=20
> 125 MHz XCLK
> 	Console: switching to colour frame buffer device 128x30
> 	atyfb: fb0: ATY Mach64 frame buffer device on PCI
>=20
> It's only *seems* to be a success...  The console is correctly set to=20
> 128x30, however the timings are apparently not passed from the BIOS to=20
> the console driver.  From this point on the screen becomes unreadable=20
> and unusable: white blooms from the edges and spreads inward.

IIRC my OmniBook 500 did the same thing in the past. I don't remember=20
what (if anything) I did to fix it. I tried to fiddle around with the=20
BIOS 'video expansion' option and tried passing various modes to atyfb=20
but I just can't reproduce it.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 19 Jan 2014 21:01:29 +0000
Subject: Re: [PATCH 13/15] fbdev: sh-mobile-lcdcfb: Enable driver compilation with COMPILE_TEST
Message-Id: <22423852.GiH1NBjiii@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1427642.pRaH8BtdWn"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <52CD0CBB.3070801@ti.com> <52D8F14A.7030100@ti.com>
In-Reply-To: <52D8F14A.7030100@ti.com>
To: linux-arm-kernel@lists.infradead.org


--nextPart1427642.pRaH8BtdWn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Friday 17 January 2014 11:00:58 Tomi Valkeinen wrote:
> Hi,
> 
> On 2014-01-08 10:30, Tomi Valkeinen wrote:
> > On 2014-01-07 17:15, Laurent Pinchart wrote:
> >> On Wednesday 11 December 2013 13:51:18 Laurent Pinchart wrote:
> >>> Hi Jean-Christophe and Tomi,
> >>> 
> >>> Could you please pick this patch up for v3.14 ?
> >> 
> >> Ping ?
> > 
> > Queued for 3.14.
> 
> I'll drop this patch, as it causes compile break (from kbuild test robot):
> 
> All error/warnings:
> 
>    drivers/built-in.o: In function `sh_mobile_lcdc_pan':
> >> sh_mobile_lcdcfb.c:(.text+0x77373): undefined reference to
> `sh_mobile_meram_cache_update'
>    drivers/built-in.o: In function `sh_mobile_lcdc_start':
> >> sh_mobile_lcdcfb.c:(.text+0x79320): undefined reference to
> `sh_mobile_meram_cache_free'
> >> sh_mobile_lcdcfb.c:(.text+0x79394): undefined reference to
> `sh_mobile_meram_cache_alloc'
> >> sh_mobile_lcdcfb.c:(.text+0x793d4): undefined reference to
> `sh_mobile_meram_cache_update'
>    drivers/built-in.o: In function `sh_mobile_lcdc_stop':
> >> sh_mobile_lcdcfb.c:(.text+0x79616): undefined reference to
> `sh_mobile_meram_cache_free'

The lcdc driver can be compiled without meram support. This is handled by 
conditional compilation in include/video/sh_mobile_meram.h that defines the 
meram functions as stubs when meram support isn't selected.

The problem comes from the combination of FB_SH_MOBILE_MERAM=m and 
FB_SH_MOBILE_LCDC=y. The former makes the meram function non-stubs, while the 
later makes the LCDC driver fail to link, as meram support is then compiled as 
a module.

How do you usually handle this ?

-- 
Regards,

Laurent Pinchart

--nextPart1427642.pRaH8BtdWn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS3D0yAAoJEIkPb2GL7hl1QVwH/1pjxI9ZARzIOQqFcBrqTfBD
7h0AM3pjCJohOinpvsVNZpd/eh8gZHTRPtBdDkSX/puNntiYQcTNsc3176IeSlD2
htrmRVsog6WMbxusiXfmPgBpytRHehL3KH3c5+jlVz/AV6j2JoI0Y9rsFSpfxXvf
ARhnWIzznLASuIa5Zg0+4xbjr7MccIFj1DtfBD0qD6pM5SPEznxNvnFVSaZuAIdS
PCpqVH8SdUvrYhle324I+zLY0CpEv7e4p+FH45KGNWbbnOhHyYNT01rA4r7k0AEf
5Jwq1dJZxomD8VDK5RAkJ8ibt1Q9znWROXOrElkrroefGj7wComXme9FLncq8H8=
=IdMr
-----END PGP SIGNATURE-----

--nextPart1427642.pRaH8BtdWn--


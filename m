From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: ATI problems.
Date: Sat, 8 Nov 2003 19:03:13 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200311081903.14332.alex.kern@gmx.de>
References: <1067871410.3fa66cb249228@www.inforagro.com.br>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AIUuR-0004Bd-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 08 Nov 2003 07:21:55 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AIUuQ-00015o-QX
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 08 Nov 2003 07:21:54 -0800
In-Reply-To: <1067871410.3fa66cb249228@www.inforagro.com.br>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: leandro@inforagro.com.br
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

Am Montag, 3. November 2003 15:56 schrieb leandro@inforagro.com.br:
> Hi all!
>
> I`ve tried to use framebuffer on my machine against 2.6.0-testX kernel
> since some days ago.
>
> Hardware:
>
>    - Intel=AE Pentium III de 700 MHZ
>    - ATI Range - Chipset ATI Range Mobility M1 Graphics
>    - screen TFT 13,3" (LCD)
>
> I already tried using aty, aty128fb, vesafb, but nothing was ok. I also
> tried to use vga=3Dxxx paramter but it didn`t work.I used vesa framebuffe=
r in
> 2.4.xx perfectly.
>
> I`m waint your answer.
>
> Leandro Dorileo

Great one more mach64 user.
So, first, you do not need aty128fb, vesafb should work!
But ATI Rage Mobility M1 will be covered by atyfb driver.

You must get the last fbdev patch from J. Simmons.
Be sure it is the last version, it only includes atyfb change for Mobility.

Applay it on your kernel, I use 2.6.0-test9=20

my .config=20
#
# Graphics support
#
CONFIG_FB=3Dy
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_VIDEO_SELECT is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=3Dy
CONFIG_FB_ATY_CT=3Dy
CONFIG_FB_ATY_GENERIC_LCD=3Dy
# CONFIG_FB_ATY_XL_INIT is not set
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_PCI_CONSOLE=3Dy
CONFIG_FONTS=3Dy
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
CONFIG_LOGO=3Dy
CONFIG_LOGO_LINUX_MONO=3Dy
CONFIG_LOGO_LINUX_VGA16=3Dy
CONFIG_LOGO_LINUX_CLUT224=3Dy

kernel paramater line should be video=3Datyfb:1024x768 if 1024x768 your=20
resolution is.

If You have any troubles,  switches DEBUG macro in drivers/video/aty/
atyfb_base.c on, and post your dmesg and lspci.

Good luck
Alex



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/

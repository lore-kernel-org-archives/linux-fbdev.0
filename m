From: Alexander Stohr <AlexanderS@ati.com>
Subject: RE: [Dri-devel] Linux kernel PCI IDs vs Xfree
Date: Sat, 9 Aug 2003 22:41:01 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <328A30E823B7D511A0BF00065B042A3B0172D768@fgl00exh01.fgl.atitech.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
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
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, dri-devel <dri-devel@lists.sourceforge.net>

all info contained below is my personal opinion,
should be retriveable from several pbulic sources
and it is only accurate to my best knowledge.

> linux/pci_ids.h and xf86PciInfo.h are in disagreement
> for several Rage128 PCI ids. Xfree appears to be
> correct and the kernel file is wrong. This impacts the
> Rage framebuffer driver when loading. 

as long as no one notices or complains
it cant be that big issue. ;-)

> I verified these with two PCI databases.

Which ones? e.g. www.yourvote.com\pci is the database
where the Linux kernel does get its listing.

www.plasma-online.de is another site with a more or
less bigger emphasize on getting even a photo of 
the packages.

> Rage Mobility 128 AGP 4x
> #define PCI_CHIP_RAGE128MF              0x4D46
> #define PCI_DEVICE_ID_ATI_RADEON_LF     0x4d46

this chipset possibly went trough press announcements 
as "Mobility M4, AGP 4x". i dont know the board names
so the "Rage Mobility 128" might match.

0x4d46 is ascii equivalent of "MF", so the 2nd
line sounds odd. Official Radeon-1 is counted 
(to my understanding) as equivalent to a Rage 
in 6th revison, so a 4 cant be a Radeon at all.

> Rage Mobility 128 AGP
> #define PCI_CHIP_RAGE128ML              0x4D4C
> missing

"Mobility M4, AGP 4x"

> Rage 128 SE/4x PCI
> #define PCI_CHIP_RAGE128SE              0x5345
> #define PCI_DEVICE_ID_ATI_RAGE128_RM    0x5345

0x5345 == ASCII "SE"
Rage 128 4x, PCI

> Rage 128 SF/4x AGP 2x
> #define PCI_CHIP_RAGE128SF              0x5346
> #define PCI_DEVICE_ID_ATI_RAGE128_RN    0x5346

0x5346 == ASCII "SF"
Rage 128 4x, AGP 2x

> Rage 128 SG/4x AGP 4x
> #define PCI_CHIP_RAGE128SG              0x5347
> #define PCI_DEVICE_ID_ATI_RAGE128_RO    0x5347

0x5347 == ASCII "SG"
Rage 128 4x, AGP 4x

the 4x in the chip/card name is more of the evolution
stage of the asic than the realized PCI/AGP bus speed.

no idea how that RM trough RO came into the given macros.

> Rage 128 SH/4x
> #define PCI_CHIP_RAGE128SH              0x5348
> missing

0x5348 == ASCII "SH"
dont know if there was ever build such a chip revison.

> Rage 128 SK/4x
> #define PCI_CHIP_RAGE128SK              0x534B
> #define PCI_DEVICE_ID_ATI_RAGE128_RG    0x534b

0x534B == ASCII "SK"
Rage 128 4x, PCI

> Rage 128 SL/4x AGP 2x
> #define PCI_CHIP_RAGE128SL              0x534C
> #define PCI_DEVICE_ID_ATI_RAGE128_RH    0x534c
 
0x534C == ASCII "SL"
Rage 128 4x, AGP 2x

> Rage 128 SM/4x AGP 4x
> #define PCI_CHIP_RAGE128SM              0x534D
> #define PCI_DEVICE_ID_ATI_RAGE128_RI    0x534d

0x534D == ASCII "SM"
Rage 128 4x, AGP 4x

the 4x in the chip/card name is more of the evolution
stage of the asic than the realized PCI/AGP bus speed.

no idea how that RG trough RI came into the given macros.
 
> Rage 128 4x
> #define PCI_CHIP_RAGE128SN              0x534E
> missing

0x534E == ASCII "SN"
dont know if there was ever build such a chip revison.

> Rage 128 Pro Ultra TF
> #define PCI_CHIP_RAGE128TF              0x5446
> #define PCI_DEVICE_ID_ATI_RAGE128_U1    0x5446

0x5446 == ASCII "TF"
AGP 4x.
might have flat panel interface -> possibly laptop.
Rage128 series, cant tell about board name.
I cant tell if the "U1" is the correct chip name
but if considered an integrated design then might fit.

> Rage 128 Pro Ultra TL
> #define PCI_CHIP_RAGE128TL              0x544C
> #define PCI_DEVICE_ID_ATI_RAGE128_U2    0x544C

0x544C == ASCII "TL"
AGP 4x.
might have flat panel interface -> possibly laptop.
Rage128 series, cant tell about board name.
I cant tell if the "U2" is the correct chip name
but if considered an integrated design then might fit.

> Rage 128 Pro Ultra TS
> #define PCI_CHIP_RAGE128TS              0x5453
> missing

0x5453 == ASCII "TS"
Rage128 series, cant tell about board name.
I doubt the Ultra - it could even be a used for a
Rage Fury MAXX board codenamed Aurora (see toms hardware)
and later announced as a dual "RAGE 128 PRO" design.
 
> Rage 128 Pro Ultra TT
> #define PCI_CHIP_RAGE128TT              0x5454
> missing

0x5454 == ASCII "TT"
Rage128 series, cant tell about board name.
I doubt the Ultra - it could even be a used for a
Rage Fury MAXX board codenamed Aurora (see toms hardware)
and later announced as a dual "RAGE 128 PRO" design.
 
> Rage 128 Pro Ultra TU
> #define PCI_CHIP_RAGE128TU              0x5455
> missing

0x5455 == ASCII "TU"
Rage128 series, cant tell about board name.
I doubt the Ultra - it could even be a used for a
Rage Fury MAXX board codenamed Aurora (see toms hardware)
and later announced as a dual "RAGE 128 PRO" design.


as initially written, no one complained for ages,
so there is quite minor interest from users and
maybe not even hardware availabel to developer 
hands to verify those chipsets and boards in the
real world of x86 computer systems anymore.

answered in best way of what i could find about those
historic designs and what the world wide web plus the
known device id encoding rules do tell me and anyone.
anyways thats written on the fly and can be badly false 
but in the hope to contribute to discussion in a 
helpfull way.

Jon, what are you planning to do with that now?
Will your final ratio become a patch against 
the XF86-CVS or the linux kernel sources?
Will you contribute your result to e.g. yourvote.com?

-Alex.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

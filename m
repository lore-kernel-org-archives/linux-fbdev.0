From: jkimble@one.net
Subject: Re: Seg fault on any FB write (Epson
 S1D13A04onColdfire running 2.6.25)
Date: Tue, 11 Nov 2008 13:20:22 -0500 (EST)
Message-ID: <40797.137.237.242.138.1226427622.squirrel@webmail.nuvox.net>
References: <4918E5C3.2090108@one.net><49195726.2060103@cetrtapot.si><43185.137.237.242.42.1226415047.squirrel@webmail.nuvox.net><49199EE3.5090101@cetrtapot.si><20081111195208.e2da189f.kristoffer.ericson@gmail.com><47826.137.237.242.138.1226426531.squirrel@webmail.nuvox.net>
	<20081111201406.7c1babfb.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20081111132022_20466"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jkimble@one.net>) id 1Kzxqp-0007ih-Rx
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 18:20:31 +0000
Received: from smtp-out2.atlngahp.sys.nuvox.net ([70.43.63.19]
	helo=smtp02.atlngahp.sys.nuvox.net)
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Kzxql-0003wq-4t
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 18:20:31 +0000
In-Reply-To: <20081111201406.7c1babfb.kristoffer.ericson@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

------=_20081111132022_20466
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	smtp02.atlngahp.sys.nuvox.net id mABIKMno016923

The 2.6.10 driver is considerably different. There's no platform device
structure. I tried taking the 2.6.10 forward to the 2.6.25 kernel but
found so many differences I thought getting the 2.6.25 driver working
would be easier.

Again, I've never made a patch for it. I've attached the actual driver
code here.

Not to make excuses (but here I go) this is the first foray I've made int=
o
the kernel in any real way so I'm still figuring out the right way to do
things (after I get them to work at all).

Thanks again.


> On Tue, 11 Nov 2008 13:02:11 -0500 (EST)
> jkimble@one.net wrote:
>
>>
>> Sorry, I was hacking around just to get something to work. If you look
>> at
>> the two side by side you'll see that I've not changed that much. The
>> changes are mostly just plugging in my specific info for the panel I'm
>> using.
>>
>> I've not worked with patches much so I'll have to figure out how to do
>> that.
>
> Perhaps you should include the old patch to 2.6.10 since
> we know that worked and take it from there? In theory
> all you should need are the basic mappings and
> perhaps and reg init structure.
>
>>
>>
>> > On Tue, 11 Nov 2008 16:04:03 +0100
>> > Hinko Kocevar <hinko.kocevar@cetrtapot.si> wrote:
>> >
>> >> jkimble@one.net wrote:
>> >> >> James Kimble wrote:
>> >> >
>> >> > /proc/iomem shows:
>> >> >
>> >> > 74000000-74009000 : s1d13a04fb.0
>> >> > 74000000-74009000 : s1d13xxxfb regs
>> >> > 74040000-74068000 : s1d13a04fb.0
>> >> > 74040000-74068000 : s1d13xxxfb mem
>> >>
>> >> I'm not sure if this is correct - two drivers mapped the same regio=
n
>> >> twice !?
>> >> Maybe the experts will shed some light on this..
>> >>
>> >> > f000070c-f000070c : spi-int-mask
>> >> > f0000740-f000075f : spi-int-level
>> >> > f0000a50-f0000a50 : spi-par
>> >> > f0008a00-f0008ab8 : spi-module
>> >> > f0008f00-f0008f20 : MCF548X-i2c
>> >> > f000a000-f000a7ff : mcf548x-flexcan.0
>> >> > f000a000-f000a7ff : mcf548x-flexcan
>> >> > f000a800-f000afff : mcf548x-flexcan.1
>> >> > f000a800-f000afff : mcf548x-flexcan
>> >> > f0020000-f0033000 : fsl-sec1
>> >> > fc000000-ffffffff : physmap-flash.0
>> >> >
>> >>
>> >> I haven't took a long look at your driver, but here is our driver f=
or
>> >> S13706FB that
>> >> we use on our embedded platform. Hope it helps.
>> >
>> > Any chance of getting a patch against s1d13xxxfb?
>> >
>> >>
>> >> Regards,
>> >> Hinko
>> >> --
>> >> Hinko Ko=C4=8Devar, OSS developer
>> >> =C4=8CETRTA POT, d.o.o.
>> >> Planina 3, 4000 Kranj, SI EU
>> >> tel     ++386 (0) 4 280 66 03
>> >> e-mail  hinko.kocevar@cetrtapot.si
>> >> http    www.cetrtapot.si
>> >>
>> >>
>> >> -------------------------------------------------------------------=
------
>> >> This SF.Net email is sponsored by the Moblin Your Move Developer's
>> >> challenge
>> >> Build the coolest Linux based applications with Moblin SDK & win
>> great
>> >> prizes
>> >> Grand prize is a trip for two to an Open Source event anywhere in t=
he
>> >> world
>> >> http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
>> >> _______________________________________________
>> >> Linux-fbdev-devel mailing list
>> >> Linux-fbdev-devel@lists.sourceforge.net
>> >> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>> >
>> >
>> > --
>> > Kristoffer Ericson <kristoffer.ericson@gmail.com>
>> >
>>
>>
>
>
> --
> Kristoffer Ericson <kristoffer.ericson@gmail.com>
>

------=_20081111132022_20466
Content-Type: application/octet-stream; name="s1d13a0x.h"
Content-Disposition: attachment; filename="s1d13a0x.h"
Content-Transfer-Encoding: base64

Lyo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NCioqICBHZW5lcmljIEhlYWRlciBpbmZvcm1hdGlvbiBnZW5lcmF0ZWQgYnkg
MTNBMDRDRkcuRVhFIChCdWlsZCAxNTUpDQoqKiAgQ29weXJpZ2h0IChjKSAyMDAwLDIwMDEgRXBz
b24gUmVzZWFyY2ggYW5kIERldmVsb3BtZW50LCBJbmMuDQoqKiAgQWxsIHJpZ2h0cyByZXNlcnZl
ZC4NCioqDQoqKiAgUGFuZWw6IDMyMHgyNDB4OGJwcCA3MEh6IENvbG9yIDgtQml0IFNUTiwgRm9y
bWF0IDIgKFBDTEs9Ni4yNTBNSHopDQoqKg0KKiogIFRoaXMgZmlsZSBkZWZpbmVzIHRoZSBjb25m
aWd1cmF0aW9uIGVudmlyb25tZW50IGFuZCByZWdpc3RlcnMsDQoqKiAgd2hpY2ggY2FuIGJlIHVz
ZWQgYnkgYW55IHNvZnR3YXJlLCBzdWNoIGFzIGRpc3BsYXkgZHJpdmVycy4NCioqDQoqKiAgTm90
ZTogSWYgeW91IHRyYW5zZmVyIHRoaXMgZmlsZSB0byBhbnkgbm9uLVBDIHN5c3RlbSwgdXNlIEFT
Q0lJDQoqKiAgbW9kZSAobm90IEJJTkFSWSkgdG8gbWFpbnRhaW4gc3lzdGVtLXNwZWNpZmljIGxp
bmUgdGVybWluYXRvcnMuDQoqKj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PSovDQoNCiNkZWZpbmUgUzFEXzEzQTA0DQojZGVm
aW5lIFMxRF9ESVNQTEFZX1dJRFRIICAgICAgICAgICAgICAgMzIwDQojZGVmaW5lIFMxRF9ESVNQ
TEFZX0hFSUdIVCAgICAgICAgICAgICAgMjQwDQojZGVmaW5lIFMxRF9ESVNQTEFZX0JQUCAgICAg
ICAgICAgICAgICAgOA0KI2RlZmluZSBTMURfRElTUExBWV9TQ0FOTElORV9CWVRFUyAgICAgIDMy
MA0KI2RlZmluZSBTMURfRElTUExBWV9GUkFNRV9SQVRFICAgICAgICAgIDcwDQojZGVmaW5lIFMx
RF9ESVNQTEFZX1BDTEsgICAgICAgICAgICAgICAgNjI1MDAwMEwNCiNkZWZpbmUgUzFEX1BIWVNJ
Q0FMX1JFR19BRERSICAgICAgICAgICAweDQ0MDAwMDAwTA0KI2RlZmluZSBTMURfUEhZU0lDQUxf
QkxUX0FERFIgICAgICAgICAgIDB4NDQwNTAwMDBMDQojZGVmaW5lIFMxRF9QSFlTSUNBTF9WTUVN
X0FERFIgICAgICAgICAgMHg0NDA0MDAwMEwNCiNkZWZpbmUgUzFEX1BIWVNJQ0FMX1JFR19TSVpF
ICAgICAgICAgICAzNjg2NEwNCiNkZWZpbmUgUzFEX1BIWVNJQ0FMX1ZNRU1fU0laRSAgICAgICAg
ICAxNjM4NDBMDQojZGVmaW5lIFMxRF9QSFlTSUNBTF9WTUVNX1JFUVVJUkVEICAgICAgNzY4MDBM
DQojZGVmaW5lIFMxRF9QQUxFVFRFX1NJWkUgICAgICAgICAgICAgICAgMjU2DQojZGVmaW5lIFMx
RF9QT1dFUl9ERUxBWV9PRkYgICAgICAgICAgICAgMTIwMA0KI2RlZmluZSBTMURfUE9XRVJfREVM
QVlfT04gICAgICAgICAgICAgIDUwDQojZGVmaW5lIFMxRF9IV0JMVA0KI2RlZmluZSBTMURfU1dC
TFQNCiNkZWZpbmUgUzFEX1JFR1JFU0VSVkVEICAgICAgICAgICAgICAgICAweEYwDQojZGVmaW5l
IFMxRF9SRUdERUxBWU9GRiAgICAgICAgICAgICAgICAgMHhGRA0KI2RlZmluZSBTMURfUkVHREVM
QVlPTiAgICAgICAgICAgICAgICAgIDB4RkUNCg0KI2RlZmluZSBTMURfV1JJVEVfUEFMRVRURShw
LGkscixnLGIpICBcDQogICgoKHZvbGF0aWxlIFMxRF9WQUxVRSopKHApKVsweDE4L3NpemVvZihT
MURfVkFMVUUpXSA9IChTMURfVkFMVUUpKGkpPDwyNCB8IChTMURfVkFMVUUpKHIpPDwxNiB8IChT
MURfVkFMVUUpKGcpPDw4IHwgKGIpKQ0KDQojZGVmaW5lIFMxRF9SRUFEX1BBTEVUVEUocCxpLHIs
ZyxiKSAgXA0KICB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICBTMURf
VkFMVUUgcmVnOyAgICAgICAgICAgICAgICAgICBcDQogICAgKCh2b2xhdGlsZSBTMURfVkFMVUUq
KShwKSlbMHgxQy9zaXplb2YoUzFEX1ZBTFVFKV0gPSAoUzFEX1ZBTFVFKShpKTw8MjQ7IFwNCiAg
ICByZWcgPSAoKHZvbGF0aWxlIFMxRF9WQUxVRSopKHApKVsweDFDL3NpemVvZihTMURfVkFMVUUp
XTsgICAgICAgICAgICAgICAgXA0KICAgIChyKSA9IChyZWc+PjE2KSYweEZGOyAgXA0KICAgIChn
KSA9IChyZWc+PjgpJjB4RkY7ICAgXA0KICAgIChiKSA9IHJlZyYweEZGOyAgICAgICAgXA0KICB9
DQoNCnR5cGVkZWYgdW5zaWduZWQgY2hhciBTMURfSU5ERVg7DQp0eXBlZGVmIHVuc2lnbmVkIGxv
bmcgUzFEX1ZBTFVFOw0KdHlwZWRlZiB1bnNpZ25lZCBjaGFyIFZNRU1fVkFMVUU7DQoNCnR5cGVk
ZWYgc3RydWN0DQp7DQogICAgUzFEX0lOREVYIEluZGV4Ow0KICAgIFMxRF9WQUxVRSBWYWx1ZTsN
Cn0gUzFEX1JFR1M7DQoNCiNkZWZpbmUgUzFEX0lOU1RBTlRJQVRFX1JFR0lTVEVSUyhzY29wZV9w
cmVmaXgsdmFyaWFibGVfbmFtZSkgIFwNCiAgc2NvcGVfcHJlZml4IFMxRF9SRUdTIHZhcmlhYmxl
X25hbWVbXSA9ICAgICAgICAgICAgICAgICAgICAgIFwNCnsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICB7MHgxNCwgMHgw
MDAwMDAwMH0sIC8qIFBvd2VyIFNhdmUgQ29uZmlndXJhdGlvbiBSZWdpc3RlciAgICAgICAgICAg
ICovIFwNCiAgICB7MHg2NCwgMHgwMDAwMDAwMH0sIC8qIEdQSU8gU3RhdHVzIGFuZCBDb250cm9s
IFJlZ2lzdGVyICAgICAgICAgICAgICovIFwNCiAgICB7MHgwNCwgMHgwMDAwMDAwMH0sIC8qIE1l
bW9yeSBDbG9jayBDb25maWd1cmF0aW9uIFJlZ2lzdGVyICAgICAgICAgICovIFwNCiAgICB7MHgw
OCwgMHgwMDAwMDAzMn0sIC8qIFBpeGVsIENsb2NrIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXIgICAg
ICAgICAgICovIFwNCiAgICB7MHgwQywgMHgwMDAwMDBEMH0sIC8qIFBhbmVsIFR5cGUgYW5kIE1P
RCBSYXRlIFJlZ2lzdGVyICAgICAgICAgICAgICovIFwNCiAgICB7MHgxMCwgMHgwMDgwMDAwOH0s
IC8qIERpc3BsYXkgU2V0dGluZ3MgUmVnaXN0ZXIgICAgICAgICAgICAgICAgICAgICovIFwNCiAg
ICB7MHgyMCwgMHgwMDAwMDAyQn0sIC8qIEhvcml6b250YWwgVG90YWwgUmVnaXN0ZXIgICAgICAg
ICAgICAgICAgICAgICovIFwNCiAgICB7MHgyNCwgMHgwMDAwMDAyN30sIC8qIEhvcml6IERpc3Bs
YXkgUGVyaW9kIFJlZ2lzdGVyICAgICAgICAgICAgICAgICovIFwNCiAgICB7MHgyOCwgMHgwMDAw
MDAwMH0sIC8qIEhvcml6IERpc3BsYXkgUGVyaW9kIFN0YXJ0IFBvc2l0aW9uIFJlZ2lzdGVyICov
IFwNCiAgICB7MHgyQywgMHgwMDg3MDE1Nn0sIC8qIEZQTElORSBSZWdpc3RlciAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICovIFwNCiAgICB7MHgzMCwgMHgwMDAwMDBGQX0sIC8qIFZlcnQg
VG90YWwgUmVnaXN0ZXIgICAgICAgICAgICAgICAgICAgICAgICAgICovIFwNCiAgICB7MHgzNCwg
MHgwMDAwMDBFRn0sIC8qIFZlcnQgRGlzcGxheSBQZXJpb2QgUmVnaXN0ZXIgICAgICAgICAgICAg
ICAgICovIFwNCiAgICB7MHgzOCwgMHgwMDAwMDAwMH0sIC8qIFZlcnQgRGlzcGxheSBQZXJpb2Qg
U3RhcnQgUG9zaXRpb24gUmVnaXN0ZXIgICovIFwNCiAgICB7MHgzQywgMHgwMDgwMDAwMH0sIC8q
IEZQRlJBTUUgUmVnaXN0ZXIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovIFwNCiAgICB7
MHg0MCwgMHgwMDAwMDAwMH0sIC8qIE1haW4gV2luZG93IERpc3BsYXkgU3RhcnQgQWRkcmVzcyBS
ZWdpc3RlciAgICovIFwNCiAgICB7MHg0NCwgMHgwMDAwMDA1MH0sIC8qIE1haW4gV2luZG93IExp
bmUgQWRkcmVzcyBPZmZzZXQgUmVnaXN0ZXIgICAgICovIFwNCiAgICB7MHg1MCwgMHgwMDAwMDAw
MH0sIC8qIFBJUCsgV2luZG93IERpc3BsYXkgU3RhcnQgQWRkcmVzcyBSZWdpc3RlciAgICovIFwN
CiAgICB7MHg1NCwgMHgwMDAwMDA1MH0sIC8qIFBJUCsgV2luZG93IExpbmUgQWRkcmVzcyBPZmZz
ZXQgUmVnaXN0ZXIgICAgICovIFwNCiAgICB7MHg1OCwgMHgwMDAwMDAwMH0sIC8qIFBJUCsgV2lu
ZG93IFggUG9zaXRpb25zIFJlZ2lzdGVyICAgICAgICAgICAgICovIFwNCiAgICB7MHg1QywgMHgw
MDAwMDAwMH0sIC8qIFBJUCsgV2luZG93IFkgUG9zaXRpb25zIFJlZ2lzdGVyICAgICAgICAgICAg
ICovIFwNCiAgICB7MHg2MCwgMHgwMDAwMDAwMH0sIC8qIFNwZWNpYWwgUHVycG9zZSBSZWdpc3Rl
ciAgICAgICAgICAgICAgICAgICAgICovIFwNCiAgICB7MHg3MCwgMHgwMDAwMDAwMX0sIC8qIFBX
TSBDbG9jayBDb25maWd1cmF0aW9uIFJlZ2lzdGVyICAgICAgICAgICAgICovIFwNCiAgICB7MHg3
NCwgMHgwMDAwMDAxMH0sIC8qIFBXTU9VVCBEdXR5IEN5Y2xlIFJlZ2lzdGVyICAgICAgICAgICAg
ICAgICAgICovIFwNCiAgICB7MHg4MCwgMHgwMDAwMDAwMH0sIC8qIFNjcmF0Y2ggUGFkIEEgUmVn
aXN0ZXIgICAgICAgICAgICAgICAgICAgICAgICovIFwNCiAgICB7MHg4NCwgMHgwMDAwMDAwMH0s
IC8qIFNjcmF0Y2ggUGFkIEIgUmVnaXN0ZXIgICAgICAgICAgICAgICAgICAgICAgICovIFwNCiAg
ICB7MHg4OCwgMHgwMDAwMDAwMH0sIC8qIFNjcmF0Y2ggUGFkIEMgUmVnaXN0ZXIgICAgICAgICAg
ICAgICAgICAgICAgICovIFwNCiAgICB7MHg2NCwgMHgwODA2MDAwMH0sIC8qIEdQSU8gU3RhdHVz
IGFuZCBDb250cm9sIFJlZ2lzdGVyICAgICAgICAgICAgICovIFwNCiAgICB7MHgxNCwgMHgwMDAw
MDAwMH0sIC8qIFBvd2VyIFNhdmUgQ29uZmlndXJhdGlvbiBSZWdpc3RlciAgICAgICAgICAgICov
IFwNCn0NCg==
------=_20081111132022_20466
Content-Type: text/x-csrc; name="s1d13xxxfb.c"
Content-Disposition: attachment; filename="s1d13xxxfb.c"
Content-Transfer-Encoding: 8bit

    //-----------------------------------------------------------------------------
//  
// linux/drivers/video/epson/s1d13xxxfb.c -- frame buffer driver for Epson
// S1D13xxx series of LCD/CRT/TV controllers.
// 
// Copyright(c) Seiko Epson Corporation 2000-2005.
// All rights reserved.
//
// This file is subject to the terms and conditions of the GNU General Public
// License. See the file COPYING in the main directory of this archive for
// more details.
//
//---------------------------------------------------------------------------- 
//---------------------------------------------------------------------------- 
//
// WARNING: This file uses a chip specific include file. The include file 
// contains all hardware information needed to generate proper timings, color
// depth, screen resolution etc.
//
// This driver supports one of the following Epson CRT/TV/LCD controllers:
//
// S1D13706
// S1D13717
// S1D13A05
//
//-----------------------------------------------------------------------------


#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/string.h>
#include <linux/mm.h>
#include <linux/tty.h>
#include <linux/slab.h>
#include <linux/delay.h>
#include <linux/fb.h>
#include <linux/init.h>
#include <linux/pci.h>
#include <linux/smp_lock.h>

#include "s1d13xxxfb.h"
#include "palette.h"

// S1D13706 
#ifdef CONFIG_FBCON_EPSON_S1D13706 
#endif

// S1D13717
#ifdef CONFIG_FBCON_EPSON_S1D13717
S1D_INSTANTIATE_REGISTERS(static,aS1DRegs);
    #ifdef CONFIG_FBCON_EPSON_RAM_BASED_LCD
    #include "s1d13xxxlcd.h"
    LCD_INSTANTIATE_REGISTERS(static,aLCDRegs);
    #endif
#endif

// S1D13A05
#ifdef CONFIG_FBCON_EPSON_S1D13A05
S1D_INSTANTIATE_REGISTERS(static,aS1DRegs);
#endif

#ifdef CONFIG_FBCON_EPSON_INDIRECT
#include <linux/timer.h>
#include "s1d13xxxfb_indirect.h"
#endif

#ifdef CONFIG_FBCON_EPSON_USB
#include "s1d13xxxfb_usb.h"
#endif



//-----------------------------------------------------------------------------
//
// Local Definitions
// 
//---------------------------------------------------------------------------
typedef struct
{
    unsigned char *VmemAddr;
    volatile unsigned char *RegAddr; 
#ifdef CONFIG_FBCON_EPSON_PCI
    u32 PhysAddr;
#endif
#ifdef CONFIG_FBCON_EPSON_INDIRECT    
    void* fb;
    u32 VirtualVmemAddr;
#endif
#ifdef CONFIG_FBCON_EPSON_2D
    volatile u16* BltAddr;
#endif
    u32 pseudo_palette[16];
}FB_INFO_S1D13xxx;

#ifdef CONFIG_FBCON_EPSON_RAM_BASED_LCD
#define LOOP_LIMIT  1000     // to prevent endless loop
#endif

#if defined(CONFIG_FBCON_EPSON_RAM_BASED_LCD) || defined(CONFIG_FBCON_EPSON_INDIRECT)
// This is the refresh period for updating the display for RAM based LCDs 
// and/or indirect interfaces.  It is set to (1 second / X).  This value can 
// modified by the end-user.  Be aware that decreasing the refresh period
// increases CPU usage as well.
#define VIDEO_REFRESH_PERIOD   HZ/40
#endif

// Some chipset header files do not have S1D_REGDELAYPLL defined.  Use the S1D_REGDELAYON to
// simulate it.
#ifndef S1D_REGDELAYPLL
    #define S1D_REGDELAYPLL S1D_REGDELAYON
#endif

#ifdef CONFIG_FBCON_EPSON_2D
// BitBlit data reg address
#define REG10000_BLT_DATA                  0x10000
#endif



//-----------------------------------------------------------------------------
//
// Function Prototypes 
// 
//-----------------------------------------------------------------------------
int __init s1d13xxxfb_setup(char *options, int *ints);
int __init s1d13xxxfb_init(char*);

unsigned long __init s1d13xxxfb_get_physical_address(void);
static int s1d13xxxfb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue, unsigned transp, struct fb_info *info);
static int s1d13xxxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info);
static int s1d13xxxfb_set_par(struct fb_info *info);

#ifdef CONFIG_FBCON_EPSON_INDIRECT
static int s1d13xxxfb_mmap( struct fb_info *fb, struct file *file, struct vm_area_struct *vma );
static int s1d13xxxfb_set_virtual_vmem(void);
static void s1d13xxxfb_flush_virtual_vmem(void);
#endif

#ifdef CONFIG_FBCON_EPSON_RAM_BASED_LCD
void s1d13xxxfb_transfer_frame(void);
#endif

#if defined(CONFIG_FBCON_EPSON_RAM_BASED_LCD) || defined(CONFIG_FBCON_EPSON_INDIRECT)
void s1d13xxx_refresh_display( unsigned long dummy );
#endif

#ifdef CONFIG_FBCON_EPSON_CLOCK_CHIP
extern int s1d13xxxfb_SetClock(void);
#endif

// 2D HW accelerated functions
#ifdef CONFIG_FBCON_EPSON_2D
extern void s1d13xxxfb_2DEngineInit( volatile u16* bltDataAddr, struct fb_info *info, struct fb_ops *ops );

extern void s1d13xxxfb_fillrect (struct fb_info *info, const struct fb_fillrect *rect);
extern void s1d13xxxfb_copyarea (struct fb_info *info, const struct fb_copyarea *region);
extern void s1d13xxxfb_imageblit (struct fb_info *info, const struct fb_image *image);
extern int  s1d13xxxfb_sync (struct fb_info *info );
#endif

//-----------------------------------------------------------------------------
//
// Local globals
//
//----------------------------------------------------------------------------- 
static struct fb_ops s1d13xxxfb_ops =
{
    .owner          = THIS_MODULE,
    .fb_set_par     = s1d13xxxfb_set_par,
    .fb_check_var   = s1d13xxxfb_check_var,
    .fb_setcolreg   = s1d13xxxfb_setcolreg,
    .fb_fillrect    = cfb_fillrect,
    .fb_copyarea    = cfb_copyarea,
    .fb_imageblit   = cfb_imageblit,
    .fb_cursor      = soft_cursor,
    #ifdef CONFIG_FBCON_EPSON_INDIRECT
    .fb_mmap        = s1d13xxxfb_mmap,
    #endif
};


static struct fb_fix_screeninfo s1d13xxxfb_fix __initdata = 
{
    .id             = "s1d13xxx", 
    .type           = FB_TYPE_PACKED_PIXELS,
    .type_aux       = 0,
    .xpanstep       = 0,
    .ypanstep       = 0,
    .ywrapstep      = 0,
    .mmio_len       = S1D_PHYSICAL_REG_SIZE,
    .smem_len       = S1D_PHYSICAL_VMEM_SIZE,
    .line_length    = S1D_DISPLAY_SCANLINE_BYTES, 
    #ifndef CONFIG_FBCON_EPSON_2D
    .accel          = FB_ACCEL_NONE,
    #else
    .accel          = FB_ACCEL_EPSON_S1D13XXX,
    #endif
};


static struct fb_info   s1d13xxx_fb;
static FB_INFO_S1D13xxx s1d13xxx_info;  

#if defined(CONFIG_FBCON_EPSON_RAM_BASED_LCD) || defined(CONFIG_FBCON_EPSON_INDIRECT) 
struct timer_list s1d13xxx_timer;
#endif



//---------------------------------------------------------------------------- 
// 
// Set a single color register. The values supplied have a 16 bit  
// magnitude.  
// Return != 0 for invalid regno.  
//
// We get called even if we specified that we don't have a programmable palette
// or in direct/true color modes!
//---------------------------------------------------------------------------- 
static int s1d13xxxfb_setcolreg(unsigned regno, unsigned red, unsigned green,
                unsigned blue, unsigned transp, struct fb_info *info) 
{
    if (regno >= S1D_PALETTE_SIZE) 
        return 1; 

#ifdef CONFIG_FBCON_EPSON_INDIRECT
    S1D_INDIRECT_WRITE_PALETTE(regno,red>>8,green>>8,blue>>8); 
#else    
    S1D_WRITE_PALETTE(s1d13xxx_info.RegAddr,regno,red>>8,green>>8,blue>>8);
#endif
    
    switch (info->var.bits_per_pixel) {
        case 16:
            if (regno < 16) 
            {   /* RGB 565 */
                ((u32*)info->pseudo_palette)[regno] = 
                    (red & 0xf800)|((green & 0xfc00) >> 5)|((blue & 0xf800) >> 11); 
            }
            break;
        
        case 32:
            if (regno < 16) 
            {   /* RGB 888 */
                red >>= 8;
                green >>= 8;
                blue >>= 8;
                ((u32*)info->pseudo_palette)[regno] = (red << 16) | (green << 8) | (blue);
            }
            break;
    }
    
    return 0; 
} 


//----------------------------------------------------------------------------- 
// 
// Fill in the 'var' and 'fix' structure. 
//  
//----------------------------------------------------------------------------- 
static int s1d13xxxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
{
    var->xres           = S1D_DISPLAY_WIDTH;     
    var->yres           = S1D_DISPLAY_HEIGHT;
    var->xres_virtual   = var->xres;    
    var->yres_virtual   = var->yres;
    var->xoffset        = var->yoffset = 0;
    var->bits_per_pixel = S1D_DISPLAY_BPP;
    var->grayscale      = 0;
    var->nonstd         = 0;               /* != 0 Non standard pixel format */
    var->activate       = FB_ACTIVATE_NOW; /* see FB_ACTIVATE_*              */
    var->height         = -1;              /* height of picture in mm        */
    var->width          = -1;              /* width of picture in mm         */
    var->accel_flags    = 0;               /* acceleration flags (hints      */
    var->pixclock       = S1D_DISPLAY_PCLK;
    var->right_margin   = 0;
    var->lower_margin   = 0;
    var->hsync_len      = 0;
    var->vsync_len      = 0;
    var->left_margin    = 0;
    var->upper_margin   = 0;
    var->sync           = 0;
    var->vmode          = FB_VMODE_NONINTERLACED;
    var->red.msb_right = var->green.msb_right = var->blue.msb_right = 0;
    var->transp.offset = var->transp.length = var->transp.msb_right = 0;
  
//    switch (info->var.bits_per_pixel)
    switch (S1D_DISPLAY_BPP)
    {
        case 1:
        case 2:
        case 4:
        case 8:
                var->red.offset  = var->green.offset = var->blue.offset = 0;
                var->red.length  = var->green.length = var->blue.length = S1D_DISPLAY_BPP;
                s1d13xxxfb_fix.visual = FB_VISUAL_PSEUDOCOLOR;
                break;	
        case 16:
                var->red.offset     = 11;
                var->red.length     = 5;
                var->green.offset   = 5;
                var->green.length   = 6;
                var->blue.offset    = 0;
                var->blue.length    = 5;
                var->transp.offset  = 0;
                var->transp.length  = 0;
                s1d13xxxfb_fix.visual = FB_VISUAL_TRUECOLOR;
                break;	
        case 32:
                var->red.length = var->green.length = var->blue.length = 8;	
                var->blue.offset    = 0;             
                var->green.offset   = 8;                
                var->red.offset     = 16;  
                var->transp.offset  = 24;
                var->transp.length  = 8;
                s1d13xxxfb_fix.visual = FB_VISUAL_TRUECOLOR;
                break;
        default:
                printk( KERN_WARNING "%dbpp is not supported.\n",
                        info->var.bits_per_pixel );
                return -EINVAL;
    }
 
    return 0;
}  


//----------------------------------------------------------------------------- 
//
// Set the hardware. 
//
//----------------------------------------------------------------------------- 
static int s1d13xxxfb_set_par(struct fb_info *info)
{
    info->fix = s1d13xxxfb_fix; 
        
#ifdef CONFIG_FBCON_EPSON_PCI 
    #ifdef CONFIG_FBCON_EPSON_INDIRECT
    info->fix.smem_start = virt_to_phys((void *)s1d13xxx_info.VirtualVmemAddr);    
    info->fix.mmio_start = s1d13xxx_info.PhysAddr;  // This address is not used in indirect mode
    info->screen_base    = (unsigned char*)s1d13xxx_info.VirtualVmemAddr; 

    #else 
    info->fix.smem_start = (u32)(s1d13xxx_info.PhysAddr+0x200000);
    info->fix.mmio_start = (u32)s1d13xxx_info.RegAddr;
    info->screen_base    = s1d13xxx_info.VmemAddr;
    #endif
#else
    #ifdef CONFIG_FBCON_EPSON_INDIRECT
    info->fix.smem_start = virt_to_phys((void *)s1d13xxx_info.VirtualVmemAddr);
    info->fix.mmio_start = S1D_PHYSICAL_REG_ADDR;   // This address is not used in indirect mode
    info->screen_base    = (unsigned char*)s1d13xxx_info.VirtualVmemAddr;

    #else 
    info->fix.smem_start = (u32)S1D_PHYSICAL_VMEM_ADDR;
    info->fix.mmio_start = (u32)S1D_PHYSICAL_REG_ADDR;
    info->screen_base    = s1d13xxx_info.VmemAddr;
    #endif
#endif

 
#if defined(CONFIG_FBCON_EPSON_RAM_BASED_LCD) || defined(CONFIG_FBCON_EPSON_INDIRECT)
    // Set timer to trigger a refresh of the display
    s1d13xxx_timer.expires = jiffies+VIDEO_REFRESH_PERIOD;
    add_timer(&s1d13xxx_timer);
#endif
    
    return 0;
}

        
#ifdef CONFIG_FBCON_EPSON_INDIRECT
//----------------------------------------------------------------------------
//
// Remaps virtual/shadow video memory buffer from virtual mem space to a physical space
//----------------------------------------------------------------------------
static int s1d13xxxfb_mmap( struct fb_info *fb, struct file *file, struct vm_area_struct *vma )
{
    vma->vm_flags |= VM_RESERVED;
    if( remap_page_range( vma, vma->vm_start, virt_to_phys( (void*)s1d13xxx_info.VirtualVmemAddr ),
        vma->vm_end - vma->vm_start, vma->vm_page_prot ) )
        return -EINVAL;
    // NOTE: remap_page_range will be deprecated in kernel 2.6.11.  The replacement function,
    // remap_pfn_range(), is not introduced until 2.6.10.  This code is written for 2.6.8.
            
    return 0;
}

//----------------------------------------------------------------------------
//
// Allocates virtual video memory buffer to be used with the indirect interface
//----------------------------------------------------------------------------
static int s1d13xxxfb_set_virtual_vmem(void)
{
    u32 order = 0;
    u32 size = S1D_DISPLAY_WIDTH*S1D_DISPLAY_HEIGHT;
    u32 addr;

    while ( size > (PAGE_SIZE * (1 << order)))
        order++;

    s1d13xxx_info.VirtualVmemAddr = __get_free_pages( GFP_KERNEL, order );

    if( s1d13xxx_info.VirtualVmemAddr==0 )
            return 1;

    for( addr=s1d13xxx_info.VirtualVmemAddr; addr<(s1d13xxx_info.VirtualVmemAddr+size); addr+=PAGE_SIZE )
        SetPageReserved( virt_to_page( addr ) );

    return 0;
}

//----------------------------------------------------------------------------
// PRIVATE FUNCTION:
// Flushes the virtual frame buffer to the display frame buffer via Indirect interface
//----------------------------------------------------------------------------
static void s1d13xxxfb_flush_virtual_vmem( void )
{
    u32         size    = S1D_DISPLAY_WIDTH*S1D_DISPLAY_HEIGHT;
    S1D_VALUE*  pSource = (S1D_VALUE*) s1d13xxx_info.VirtualVmemAddr;;
    u32         pDest   = 0;

    // Copy virtual vmem buffer to vmem via indirect interface burst mode write
    s1d13xxxfb_IndirectWriteData( pDest, pSource, size );
}
#endif // CONFIG_FBCON_EPSON_INDIRECT


#ifdef CONFIG_FBCON_EPSON_RAM_BASED_LCD
//----------------------------------------------------------------------------
// PRIVATE FUNCTION:
// Triggers a transfer of 1 frame of data to the LCD interface
//----------------------------------------------------------------------------
void s1d13xxxfb_transfer_frame( void )
{
    u16 timeout=LOOP_LIMIT;
    while( ( s1d13xxxfb_read_reg(REG0038_LCDINTSTATUS) & 0x0001 ) && timeout--);
    {
       // transfer one frame
       s1d13xxxfb_write_reg(REG003A_LCDINTFRAMEXFER, 0x0001);
    }
}
#endif



#if defined(CONFIG_FBCON_EPSON_RAM_BASED_LCD) || defined(CONFIG_FBCON_EPSON_INDIRECT)
//----------------------------------------------------------------------------
// PRIVATE FUNCTION:
// This function updates the display
//----------------------------------------------------------------------------
void s1d13xxx_refresh_display( unsigned long dummy )
{
    #ifdef CONFIG_FBCON_EPSON_INDIRECT
    // Copy virtual vmem buffer to display vmem with indirect interface
    s1d13xxxfb_flush_virtual_vmem();
    #endif
    
    #ifdef CONFIG_FBCON_EPSON_RAM_BASED_LCD
    // Transfer frame to LCD
    s1d13xxxfb_transfer_frame();
    #endif
    
    // Reset the timer
    s1d13xxx_timer.expires = jiffies+VIDEO_REFRESH_PERIOD;
    add_timer(&s1d13xxx_timer);
}
#endif


//----------------------------------------------------------------------------
// Writes S1D_VALUE-sized value to register
//----------------------------------------------------------------------------
void s1d13xxxfb_write_reg(u32 reg, S1D_VALUE val)
{
#ifdef CONFIG_FBCON_EPSON_INDIRECT
    s1d13xxxfb_IndirectWriteReg(reg, val);
#else
    ((S1D_VALUE*)s1d13xxx_info.RegAddr)[reg/sizeof(S1D_VALUE)] = val;
#endif
}


//----------------------------------------------------------------------------
// Writes 16-bit value to register
//----------------------------------------------------------------------------
void s1d13xxxfb_write_reg16(u32 reg, u16 val)
{
#ifdef CONFIG_FBCON_EPSON_INDIRECT
    s1d13xxxfb_IndirectWriteReg(reg, val);
#else
    ((u16*)s1d13xxx_info.RegAddr)[reg/sizeof(u16)] = val;
#endif
}


//----------------------------------------------------------------------------
// Writes 8-bit value to register
//----------------------------------------------------------------------------
void s1d13xxxfb_write_reg8(u32 reg, u8 val)
{
#ifdef CONFIG_FBCON_EPSON_INDIRECT
    s1d13xxxfb_IndirectWriteReg(reg, val);
#else
    ((u8*)s1d13xxx_info.RegAddr)[reg/sizeof(u8)] = val;
#endif
}


//----------------------------------------------------------------------------
// Reads S1D_VALUE-sized value from register
//----------------------------------------------------------------------------
S1D_VALUE s1d13xxxfb_read_reg(u32 reg)
{
#ifdef CONFIG_FBCON_EPSON_INDIRECT
    return (S1D_VALUE)s1d13xxxfb_IndirectReadReg(reg);
#else
    return ((S1D_VALUE*)s1d13xxx_info.RegAddr)[reg/sizeof(S1D_VALUE)];
#endif
}


//----------------------------------------------------------------------------
// Reads 16-bit value from register
//----------------------------------------------------------------------------
u16 s1d13xxxfb_read_reg16(u32 reg)
{
#ifdef CONFIG_FBCON_EPSON_INDIRECT
    return (u16)s1d13xxxfb_IndirectReadReg(reg);
#else
    return ((u16*)s1d13xxx_info.RegAddr)[reg/sizeof(u16)];
#endif
}



//----------------------------------------------------------------------------
// Reads 16-bit value from register
//----------------------------------------------------------------------------
u8 s1d13xxxfb_read_reg8(u32 reg)
{
#ifdef CONFIG_FBCON_EPSON_INDIRECT
    return (u8)s1d13xxxfb_IndirectReadReg(reg);
#else
    return ((u8*)s1d13xxx_info.RegAddr)[reg/sizeof(u8)];
#endif
}

//-----------------------------------------------------------------------------
//
// Detect our PCI bridge adapter card, get the BAR[0]. Card is assumed to be
// enabled.
//
//-----------------------------------------------------------------------------
#ifdef CONFIG_FBCON_EPSON_PCI
static int __init
s1d13xxx_IsOurID(unsigned vID, unsigned dID)
{
    if (vID == 0x10F4 && dID == 0x1300)
        return 1;

    if (vID == 0x14EB)
    {
        if (dID >= 0x0000 && dID < 0x002A)
            return 1;
        if (dID > 0x002A && dID <= 0x002F) 
            return 1;
    }
    return 0;
} 



unsigned long __init s1d13xxxfb_get_physical_address(void)
{
    struct pci_dev *pdev;

    pdev = NULL;

    for(pdev = pci_dev_g(pci_devices.next); pdev != pci_dev_g(&pci_devices); pdev = pci_dev_g(pdev->global_list.next))
    {
        if (s1d13xxx_IsOurID(pdev->vendor,pdev->device))
            return (pci_resource_start(pdev, 0) & PCI_BASE_ADDRESS_MEM_MASK);
    }

    return 0;
}
#endif



//-----------------------------------------------------------------------------
// Initialize the chip and the frame buffer driver.
//-----------------------------------------------------------------------------
int __init s1d13xxxfb_init(char *dummy)
{    
    int i;
    char pixel;
    S1D_INDEX s1dReg;
    S1D_VALUE s1dValue;
    #ifdef CONFIG_FBCON_EPSON_RAM_BASED_LCD
    int timeout = LOOP_LIMIT;
    #endif

#ifdef CONFIG_FBCON_EPSON_PCI    
    unsigned long phAddr = s1d13xxxfb_get_physical_address();
        
    s1d13xxx_info.RegAddr  = (unsigned char*) ioremap(phAddr,S1D_PHYSICAL_REG_SIZE);
    s1d13xxx_info.VmemAddr = (unsigned char*) ioremap_nocache(phAddr+0x200000,S1D_PHYSICAL_VMEM_SIZE);
    s1d13xxx_info.PhysAddr = phAddr;
    #ifdef CONFIG_FBCON_EPSON_2D
    s1d13xxx_info.BltAddr  = (u16*)ioremap(phAddr+REG10000_BLT_DATA+2,0x10000);
    #endif

#else
    s1d13xxx_info.RegAddr  = (unsigned char*) ioremap(S1D_PHYSICAL_REG_ADDR,S1D_PHYSICAL_REG_SIZE);
    s1d13xxx_info.VmemAddr = (unsigned char*) ioremap_nocache(S1D_PHYSICAL_VMEM_ADDR,S1D_PHYSICAL_VMEM_SIZE);
    #ifdef CONFIG_FBCON_EPSON_2D
    s1d13xxx_info.BltAddr  = (u16*)ioremap(S1D_PHYSICAL_BLT_ADDR,0x10000);
    #endif
#endif


    if (!s1d13xxx_info.VmemAddr || !s1d13xxx_info.RegAddr)
    {
        printk("s1d13xxxfb_init: ioremap() returned NULL\n"); 
        return -EINVAL;
    }    

    #ifdef CONFIG_FBCON_EPSON_2D
    if (!s1d13xxx_info.BltAddr)
    {
        printk("s1d13xxxfb_init: ioremap() for 2D space returned NULL\n"); 
        return -EINVAL;
    }    
    #endif

    // Turn 2D BitBLT off 
    s1d13xxxfb_write_reg(0x8000, 0x00000000);
    
#ifdef CONFIG_FBCON_EPSON_INDIRECT
    // Initialize the chip to use Indirect Interface
    s1d13xxxfb_IndirectInit( (u32)s1d13xxx_info.RegAddr );

    // Allocate the virtual video memory
    if(s1d13xxxfb_set_virtual_vmem())
    {
        printk("s1d13xxxfb_init: _get_free_pages() failed.\n");
        return -EINVAL;
    }
#endif

    #ifdef CONFIG_FBCON_EPSON_CLOCK_CHIP
    // Program the chip clock for the S1D13A05 eval board
    if( !s1d13xxxfb_SetClock() )
    {
        printk("s1d13xxxfb_init: cannot set clock chip\n");
        return -EINVAL;
    }
    #endif

    //------------------------------------------------------------------------- 
    // Set the controller registers and initialize LCD
    //------------------------------------------------------------------------- 
    
    // initializing controller registers
    for (i = 0; i < sizeof(aS1DRegs)/sizeof(aS1DRegs[0]); i++)
    {
        s1dReg   = aS1DRegs[i].Index;
        s1dValue = aS1DRegs[i].Value;

        
        #ifdef CONFIG_FBCON_EPSON_RAM_BASED_LCD
        if (s1dReg == REG0034_LCDINTCMD || s1dReg == REG0036_LCDINTPARAM)
        {
            timeout  = LOOP_LIMIT;
            while ((( s1d13xxxfb_read_reg(REG0038_LCDINTSTATUS) & 0x0001) != 0) && timeout--)
                continue;
        }
        #endif

        if ( s1dReg == S1D_REGDELAYOFF || 
             s1dReg == S1D_REGDELAYON  || 
             s1dReg == S1D_REGDELAYPLL )
        {
            mdelay((int)s1dValue);
        }
        else
        {
            s1d13xxxfb_write_reg(s1dReg, s1dValue);
        }
    }    
    
    // initializing LCD
    #ifdef CONFIG_FBCON_EPSON_RAM_BASED_LCD
    for (i = 0; i < sizeof(aLCDRegs)/sizeof(aLCDRegs[0]); i++)
    {
        s1dReg   = aLCDRegs[i].Index;
        s1dValue = aLCDRegs[i].Value;

        if (s1dReg == REG0034_LCDINTCMD || s1dReg == REG0036_LCDINTPARAM)
        {
             timeout= LOOP_LIMIT;
             while ((( s1d13xxxfb_read_reg(REG0038_LCDINTSTATUS) & 0x0001) != 0) && timeout--)
                 continue;
        }

        if (s1dReg == S1D_REGDELAYOFF || s1dReg == S1D_REGDELAYON || s1dReg == S1D_REGDELAYPLL
           )
            mdelay((int)s1dValue);
        else
            s1d13xxxfb_write_reg(s1dReg, s1dValue);
    }
    #else
        // Setup fb_info data structures
        s1d13xxxfb_set_par(&s1d13xxx_fb);

        // Intialize screen memory to uniform color
        for ( i=0; i < ((S1D_DISPLAY_WIDTH*S1D_DISPLAY_HEIGHT)); i++)
        {
            ((VMEM_VALUE *)s1d13xxx_info.VmemAddr)[i] = (unsigned int) 0x01; 
        }

    #endif
 
    //------------------------------------------------------------------------- 
    // Initialize USB
    //-------------------------------------------------------------------------
    #ifdef CONFIG_FBCON_EPSON_USB
    s1d13xxxfb_USBInit();
    #endif
    
    // Set flags for controller supported features        
    s1d13xxx_fb.flags = FBINFO_FLAG_DEFAULT;
    
    //------------------------------------------------------------------------- 
    // Initialize 2D graphics engine
    //------------------------------------------------------------------------- 
    #ifdef CONFIG_FBCON_EPSON_2D
    s1d13xxxfb_2DEngineInit(s1d13xxx_info.BltAddr, &s1d13xxx_fb, &s1d13xxxfb_ops);
    #endif

    // Set the pseudo palette    
    s1d13xxx_fb.pseudo_palette = s1d13xxx_info.pseudo_palette;

    s1d13xxxfb_check_var(&s1d13xxx_fb.var, &s1d13xxx_fb);    
    s1d13xxx_fb.fbops = &s1d13xxxfb_ops;
    s1d13xxx_fb.node = -1;

    
    // Enable display
    s1dValue = s1d13xxxfb_read_reg (0x10);
    s1dValue &= 0xff7fffff; 
    s1d13xxxfb_write_reg(0x10, s1dValue);

#if defined(CONFIG_FBCON_EPSON_RAM_BASED_LCD) || defined(CONFIG_FBCON_EPSON_INDIRECT)
    // Create a timer to trigger a refresh of the displaye
    init_timer(&s1d13xxx_timer);
    s1d13xxx_timer.function = s1d13xxx_refresh_display;
#endif

    if (register_framebuffer(&s1d13xxx_fb) < 0)
        return -EINVAL;

    return 0;
}


//-----------------------------------------------------------------------------
// Parse user speficied options (`video=s1d13xxx:')
// Example: 
// video=s1d13xxx:noaccel
//-----------------------------------------------------------------------------
int __init s1d13xxxfb_setup(char *options, int *ints)
{
    return 0;
}


#ifdef MODULE
//--------------------------------------------------------------------------
//
//   FUNCTION: init_module()                          (FILE: s1d13xxxfb.c)
//
//   PURPOSE:  Memset modularization
//
//   REVISIONS:
//
//   BY  DATE          CHANGE
//   --- ----------    ------
//   HJK 11/05/2007    Reformatted
//
//---------------------------------------------------------------------------
static int __init fb_init(void)
{
    char * dummy;

    s1d13xxxfb_init(dummy);

    return 0;
}



//--------------------------------------------------------------------------
//
//   FUNCTION: cleanup_module()                       (FILE: s1d13xxxfb.c)
//
//   PURPOSE:
//
//   REVISIONS:
//
//   BY  DATE          CHANGE
//   --- ----------    ------
//   HJK 11/05/2007    Reformatted
//
//---------------------------------------------------------------------------
static void __exit fb_cleanup(void)
{
    unregister_framebuffer(&s1d13xxx_fb);
}

module_init(fb_init);
module_exit(fb_cleanup);

#endif

MODULE_AUTHOR("Seiko Epson Corp");
MODULE_DESCRIPTION("Epson S1D13A04 driver");
MODULE_LICENSE("GPL");
------=_20081111132022_20466
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
------=_20081111132022_20466
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

------=_20081111132022_20466--

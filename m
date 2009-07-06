From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: 
 [linux-fbdev-devel][PATCH]fb_pan_display:add x/yoffset check
Date: Mon, 06 Jul 2009 16:12:50 +0200
Message-ID: <4A520662.1030504@gmx.de>
References: <4A4839CB.8020801@freescale.com>
	<20090629103936.GJ9980@sci.fi>	<4A4985C0.2040800@freescale.com>
	<20090703153029.GK9980@sci.fi> <4A4E2DCE.1060706@gmx.de>
	<4A5168D3.3050502@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <FlorianSchandinat@gmx.de>) id 1MNp0v-0002Ew-DY
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Jul 2009 14:17:49 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MNp0u-0004as-Sh for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Jul 2009 14:17:49 +0000
In-Reply-To: <4A5168D3.3050502@freescale.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Kai Jiang <b18973@freescale.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Kai Jiang schrieb:
> Florian Tobias Schandinat wrote:
>> Ville Syrj=E4l=E4 schrieb:
>>>> So here we have to check the whether the x/yoffset is smaller than =

>>>> zero. If the offset is smaller than zero, in the driver, we should =

>>>> not move the virtual screen any more.
>>>
>>> Checking for overflow will catch you buggy application's negative
>>> values too.
>>
>> That's true, but the problem lies in the current implementation first =

>> adding the resolution, which results in small negative [0 to =

>> -resolution] values (=3Dlarge positives) being accepted as they overflow =

>> during add and become small positive values.
>> I'd recommend changing
>>
>> var->yoffset + yres > info->var.yres_virtual ||
>> var->xoffset + info->var.xres > info->var.xres_virtual
>>
>> to
>>
>> var->yoffset > info->var.yres_virtual - yres ||
>> var->xoffset > info->var.xres_virtual - info->var.xres
>>
> I am not sure why do we have these change. Could you give a detail =

> description or an example?

A small program to illustrate it:

#include <stdio.h>
int main()
{
         unsigned int    a =3D -1;
         printf( "%X\n%X\n", a, a+1 );
         return 0;
}

It starts with "-1" in an u32 being represented as "0xFFFFFFFF", which =

would be caught by ">". The problem in the current code is it first adds =

the resolution before comparison and this causes an overflow.
Let's say the virtual resolution matches the real resolution:
yoffset + yres > yres
There the left side is evaluated at first:
(yoffset + yres)
You accept everything that is <=3Dyres. In classical mathematics you would =

say yoffset has to be 0, but unfortunately this codes accept many more =

as it can overflow. You get
yoffset =3D -1:	(yres-1) > yres
offset =3D -yres:	0 > yres
So as you noticed, the current code will not just accept 0 as yoffset, =

but the whole range [-yres..0]. This can be fixed by moving the =

calculation to the right side, where we have trusted values, that do not =

cause an overflow.

Hope this helps.


Greetings,

Florian Tobias Schandinat

---------------------------------------------------------------------------=
---

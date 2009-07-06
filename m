From: Kai Jiang <b18973@freescale.com>
Subject: Re: 
 [linux-fbdev-devel][PATCH]fb_pan_display:add x/yoffset check
Date: Mon, 06 Jul 2009 11:00:35 +0800
Message-ID: <4A5168D3.3050502@freescale.com>
References: <4A4839CB.8020801@freescale.com>
	<20090629103936.GJ9980@sci.fi>	<4A4985C0.2040800@freescale.com>
	<20090703153029.GK9980@sci.fi> <4A4E2DCE.1060706@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Kai.Jiang@freescale.com>) id 1MNeRx-0002mN-Ls
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Jul 2009 03:01:01 +0000
Received: from az33egw02.freescale.net ([192.88.158.103])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNeRr-0002LO-1h
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Jul 2009 03:01:01 +0000
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n6630Zlf000334 for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 5 Jul 2009 20:00:35 -0700 (MST)
Received: from zmy16exf40.fsl.freescale.net (zmy16exf40.ap.freescale.net
	[10.211.3.4])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n6630XRS012835
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 5 Jul 2009 22:00:34 -0500 (CDT)
In-Reply-To: <4A4E2DCE.1060706@gmx.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

Florian Tobias Schandinat wrote:
> Ville Syrj=E4l=E4 schrieb:
>>> So here we have to check the whether the x/yoffset is smaller than =

>>> zero. If the offset is smaller than zero, in the driver, we should =

>>> not move the virtual screen any more.
>>
>> Checking for overflow will catch you buggy application's negative
>> values too.
>
> That's true, but the problem lies in the current implementation first =

> adding the resolution, which results in small negative [0 to =

> -resolution] values (=3Dlarge positives) being accepted as they overflow =

> during add and become small positive values.
> I'd recommend changing
>
> var->yoffset + yres > info->var.yres_virtual ||
> var->xoffset + info->var.xres > info->var.xres_virtual
>
> to
>
> var->yoffset > info->var.yres_virtual - yres ||
> var->xoffset > info->var.xres_virtual - info->var.xres
>
I am not sure why do we have these change. Could you give a detail =

description or an example?
Thanks!

Best Regards,

Kai Jiang



---------------------------------------------------------------------------=
---

From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: 
 [linux-fbdev-devel][PATCH]fb_pan_display:add x/yoffset check
Date: Fri, 03 Jul 2009 18:11:58 +0200
Message-ID: <4A4E2DCE.1060706@gmx.de>
References: <4A4839CB.8020801@freescale.com>
	<20090629103936.GJ9980@sci.fi>	<4A4985C0.2040800@freescale.com>
	<20090703153029.GK9980@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <FlorianSchandinat@gmx.de>) id 1MMlRu-00022x-M8
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Jul 2009 16:17:18 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MMlRn-000153-9J for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Jul 2009 16:17:18 +0000
In-Reply-To: <20090703153029.GK9980@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Kai Jiang <b18973@freescale.com>, linux-fbdev-devel@lists.sourceforge.net

Ville Syrj=E4l=E4 schrieb:
>> So here we have to check the whether the x/yoffset is smaller than zero.=
 If the offset is smaller than zero, in the driver, we should not move the =
virtual screen any more.
> =

> Checking for overflow will catch you buggy application's negative
> values too.

That's true, but the problem lies in the current implementation first =

adding the resolution, which results in small negative [0 to =

-resolution] values (=3Dlarge positives) being accepted as they overflow =

during add and become small positive values.
I'd recommend changing

var->yoffset + yres > info->var.yres_virtual ||
var->xoffset + info->var.xres > info->var.xres_virtual

to

var->yoffset > info->var.yres_virtual - yres ||
var->xoffset > info->var.xres_virtual - info->var.xres


Greetings,

Florian Tobias Schandinat

---------------------------------------------------------------------------=
---

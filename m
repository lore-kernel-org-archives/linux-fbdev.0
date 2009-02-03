From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 1/2] atyfb: fix CONFIG_ namespace
 violations
Date: Tue, 03 Feb 2009 14:23:34 -0800
Message-ID: <4988C3E6.5010508__13679.3832913556$1233700040$gmane$org@oracle.com>
References: <200901310909.n0V99XIZ021497@imap1.linux-foundation.org>
	<4984AC40.8030708@oracle.com>
	<20090131121008.eb7f5ddd.akpm@linux-foundation.org>
	<20090202150002.05838fed.randy.dunlap@oracle.com>
	<Pine.LNX.4.64.0902030907350.15898@anakin>
	<20090203110631.GB22401@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <randy.dunlap@oracle.com>) id 1LUTh3-0003x1-Ob
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Feb 2009 22:24:33 +0000
Received: from acsinet11.oracle.com ([141.146.126.233])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LUTh0-0003nO-RF
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Feb 2009 22:24:33 +0000
In-Reply-To: <20090203110631.GB22401@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>, Randy Dunlap <randy.dunlap@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>linux

Ville Syrj=E4l=E4 wrote:
> On Tue, Feb 03, 2009 at 09:09:38AM +0100, Geert Uytterhoeven wrote:
>> On Mon, 2 Feb 2009, Randy Dunlap wrote:
>>> --- linux-2.6.29-rc3-git3.orig/drivers/video/aty/atyfb_base.c
>>> +++ linux-2.6.29-rc3-git3/drivers/video/aty/atyfb_base.c
>>> @@ -135,7 +135,7 @@
>>>  #if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || \
>>>  defined (CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_FB_ATY_BACKLIGHT)
>>>  static const u32 lt_lcd_regs[] =3D {
>>> -	CONFIG_PANEL_LG,
>>> +	CNFG_PANEL_LG,
>> These were the official names as used in the ATI docs. After these chang=
es, you
>> can no longer easily grep for them.
>>
>> Perhaps it's better to prefix everything with ATI_? yes, I know it's mor=
e work
>> (for the writer), but we want to optimize for the reader, right?

Everything??  not just the CONFIG_* namespace violations?

[If so,] Potentially 3600 changes just in 3 header files, then all of
the corresponding .c files.  No thanks.

How about a note in the header files that explains that CONFIG_* register
names are spelled as "CNFG_*" so that there are not kernel kconfig
namespace conflicts?


> That would be my preference as well.

Care to do it?

-- =

~Randy

---------------------------------------------------------------------------=
---
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(T=
M)
software. With Adobe AIR, Ajax developers can use existing skills and code =
to
build responsive, highly engaging applications that combine the power of lo=
cal
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com

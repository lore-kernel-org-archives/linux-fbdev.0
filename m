From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] radeonfb: fix init/exit section usage
Date: Fri, 07 Jan 2005 13:24:44 -0800
Message-ID: <41DEFE1C.7010108@osdl.org>
References: <41DEE2C7.4030200@osdl.org> <20050107215451.GA16507@dreamland.darkstar.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cn2JG-0003hK-H6
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 Jan 2005 14:10:18 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=fire-1.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Cn2JD-0003GV-HN
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 Jan 2005 14:10:17 -0800
In-Reply-To: <20050107215451.GA16507@dreamland.darkstar.lan>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Kronos <kronos@people.it>
Cc: linux-fbdev-devel@lists.sourceforge.net, benh@dreamland.darkstar.lan, benh@kernel.crashing.org

Kronos wrote:
> Il Fri, Jan 07, 2005 at 11:28:07AM -0800, Randy.Dunlap ha scritto: 
> 
>>Fix 3 instances of calling exit section function from text or init:
>>Error: ./drivers/video/aty/radeon_base.o .text refers to 000029e5 
>>R_386_PC32        .exit.text
>>Error: ./drivers/video/aty/radeon_base.o .text refers to 00002a60 
>>R_386_PC32        .exit.text
>>Error: ./drivers/video/aty/radeon_base.o .init.text refers to 00000192 
>>R_386_PC32        .exit.text
>>
>>Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
>>
>>diffstat:=
>> drivers/video/aty/radeon_base.c |    2 +-
>> 1 files changed, 1 insertion(+), 1 deletion(-)
>>
>>---
> 
> 
>>diff -Naurp ./drivers/video/aty/radeon_base.c~radeonfb_initexit ./drivers/video/aty/radeon_base.c
>>--- ./drivers/video/aty/radeon_base.c~radeonfb_initexit	2005-01-06 21:18:20.920585008 -0800
>>+++ ./drivers/video/aty/radeon_base.c	2005-01-07 10:30:16.661094480 -0800
>>@@ -261,7 +261,7 @@ static struct backlight_controller radeo
>> 
>> #endif /* CONFIG_PPC_OF */
>> 
>>-static void __devexit radeon_unmap_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
>>+static void radeon_unmap_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
>> {
>> 	if (!rinfo->bios_seg)
>> 		return;
> 
> 
> I see that radeon_unmap_ROM is called in radeonfb_pci_register (error
> path). Is this the problem?

Yes.  It was called from radeon_map_ROM() [which is __init]
and from radeonfb_pci_register().

> Oh btw, the maintainer of the new radeonfb is Ben Herrenschmidt, not Ani
> Joshi.

OK, thanks for the info.  Be nice if someone would update
MAINTAINERS with that info...

> Luca

-- 
~Randy


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

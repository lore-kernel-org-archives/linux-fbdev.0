From: Bill Gatliff <bgat@billgatliff.com>
Subject: Problems claiming resources? (PXA, SM501G8)
Date: Mon, 21 May 2007 12:13:00 -0500
Message-ID: <4651D31C.4000407@billgatliff.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HqBVz-0006VO-QR for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 May 2007 10:17:47 -0700
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HqBVz-0001eg-CS
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 May 2007 10:17:47 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Guys:


I'm using an SM501G8 on a PXA270, linux-2.6.21.1 kernel. I'm stuck with 
this at boot:

[ 1.380000] sm501 sm501.0: SM501 At c181e000: Version 050100a0, 4 Mb, IRQ 85
[ 1.410000] sm501 sm501.0: CurrentGate 00021807
[ 1.420000] sm501 sm501.0: CurrentClock 2a1a0a09
[ 1.440000] sm501 sm501.0: PowerModeControl 00000000
[ 1.450000] sm501-fb[0] flags 00000200: 13e80000..13e8ffff
[ 1.470000] sm501-fb[1] flags 00000200: 13f00000..13f4ffff
[ 1.480000] sm501-fb[2] flags 00000200: 10000000..103fffff
[ 1.500000] sm501-fb[3] flags 00000400: 00000055..00000055
[ 1.520000] sm501-fb.0: failed to claim resource 0
[ 1.530000] sm501 sm501.0: error registering sm501-fb (-16)
[ 1.550000] returning 0


My resource definition looks like this:

static struct resource sm501_device_resources[] = {
[0] = {
    .start = PXA_CS4_PHYS,
    .end = PXA_CS4_PHYS + (4 * 1024 * 1024) - 1,
    .flags = IORESOURCE_MEM,
}, [1] = {
    .start = PXA_CS4_PHYS + 0x3e00000,
    .end = PXA_CS4_PHYS + 0x3e0fffff,
    .flags = IORESOURCE_MEM,
}, [2] = {
    .start = IRQ_GPIO(53),
    .end = IRQ_GPIO(53),
    .flags = IORESOURCE_IRQ,
}, };

static struct platform_device sm501_device = {
    .name = "sm501",
    .id = 0,
    .num_resources = ARRAY_SIZE(sm501_device_resources),
    .resource = sm501_device_resources,
};

static struct platform_device *devices[] __initdata = { &sm501_device, };
platform_add_devices(devices, ARRAY_SIZE(devices));


All the above was gleaned from staring at the code in sm501.c, so I'm 
probably doing something wrong.   :)

My theory right now is that I'm not specifying the right ranges for the 
resources. For example, after looking at the code in sm501.c it appears 
as though I'm not supposed to resource _all_ the device's control 
register memory, only a little bit (the code in sm501_register_display() 
appears to grab the rest).  I think I must be still making a mistake 
like that in the above, but I can't seem to find it.

Any suggestions? I'm not registering an "sm501-fb" device, only the 
"sm501" device shown above.


Regards,


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

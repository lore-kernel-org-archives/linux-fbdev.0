From: Manousaridis Angelos <amanous@inaccessnetworks.com>
Subject: no console switching (REPOST, sorry...)
Date: Wed, 12 Nov 2003 12:07:13 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FB20651.5060201@inaccessnetworks.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AJruW-000148-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Nov 2003 02:07:40 -0800
Received: from [212.205.200.118] (helo=inaccessnetworks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AJruB-0002zb-P1
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Nov 2003 02:07:20 -0800
Received: from inaccessnetworks.com (firewall [212.205.200.117])
	by inaccessnetworks.com (8.12.1/8.12.1) with ESMTP id hACA7CJd015489
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Nov 2003 12:07:12 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

I posted this mail yesterday, but I lost some of my mails, so I probably 
lost the replies on this one. If someone bothered to reply, please do so 
again. Thanks ans sorry...
(I tried the archives, but they are are not updated sto frequently)

I forgot to mention that I am using linux kernel 2.4.18 on strongARM.
Here it goes:

************
Hello,

I am trying to implement a framebuffer device without console support. I 
want to display only graphics, no text at all.

Is there a way to avoid the console take over?

I don't have the actuall graphics device yet, so I have created an 
initial version of the driver looking a lot like the vfb device.
I set the dispsw variable of the display structure to fbcon_dummy.
When I load the module I see this:

fbcon_setup: No support for fontwidth 8
fbcon_setup: type 0 (aux 0, depth 8) not supported
Console: switching to colour frame buffer device 80x30
fb0: Teralogic 751 frame buffer device

The module count increases to 63 and I cannot unload the module.

Also, what do I have to put to the owner variable of the fb_ops 
structure? The above happens with this variable se to THIS_MODULE.

If I comment this line causing the owner variable to be undefined, the 
module count does not increase and the module can be unloaded.
But It seems that the device is NOT unregistered. When I load the module 
again, I see this:

fb1: Teralogic 751 frame buffer device

the fb0 is somewhere still defined, and when I try to access it, a page 
fault occurs. Is it wrong to leave the owner variable undefined?
*****************

-- 
Manousaridis Angelos



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/

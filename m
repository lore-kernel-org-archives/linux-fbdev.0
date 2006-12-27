From: Dennis Munsie <dmunsie@cecropia.com>
Subject: Re: intelfb driver on 945GM chipset
Date: Wed, 27 Dec 2006 10:47:16 -0500
Message-ID: <F735BD39-09B9-4E45-90CE-6DF7DDBAE120@cecropia.com>
References: <20061227142314.77170.qmail@web90406.mail.mud.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gzazl-0000XQ-Ix for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Dec 2006 07:47:09 -0800
Received: from mail6.sea5.speakeasy.net ([69.17.117.8])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gzazj-0008Sn-A0
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Dec 2006 07:47:09 -0800
Received: from lex098.cecropia.com (HELO [192.168.3.92])
	(dmunsie@cecropia.com@[63.138.212.98])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail6.sea5.speakeasy.net (qmail-ldap-1.03) with AES128-SHA encrypted
	SMTP for <linux-fbdev-devel@lists.sourceforge.net>;
	27 Dec 2006 15:47:00 -0000
In-Reply-To: <20061227142314.77170.qmail@web90406.mail.mud.yahoo.com>
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

try putting this in instead:

video=intelfb:1024x768@60

that should force it to use the intelfb driver at your desired  
resolution.

dennis

On Dec 27, 2006, at 9:23 AM, rami jiossy wrote:

> Hi;
>
> OS: Linux-2.6.19
>
> I am trying to boot to console with intelfb driver.
>
> my problem is that i don't get the video mode 1024x768 when booting.
> according to intelfb documentation in this case i need to add the  
> vga=[791,...] in ther kernel boot option. and it indeed get me the  
> right resolution but it is vesafb and not intelfb :(
> vesafb is being loaded prior to to intelfb and it causes intelfb to  
> fail on reseving fb region as i see in dmesg.
>
> on the other hand, when i compile the kernel without vesafb, then i  
> don't get the required resolution at all.
>
> what should i do to fix it?
> any help would be appreciated.
>
> thanks
> Rami


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

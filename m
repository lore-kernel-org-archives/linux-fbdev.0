From: Tom Cooksey <thomas.cooksey@nokia.com>
Subject: Userspace blit API
Date: Thu, 4 Dec 2008 09:27:24 +0100
Message-ID: <200812040927.24861.thomas.cooksey@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <thomas.cooksey@nokia.com>) id 1L89TW-00054I-1q
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Dec 2008 08:22:18 +0000
Received: from smtp.nokia.com ([192.100.105.134] helo=mgw-mx09.nokia.com)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L89TT-0007yF-QN
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Dec 2008 08:22:17 +0000
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	mB48LsCC020039 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 4 Dec 2008 02:22:11 -0600
Received: from tomdev.localnet (olwst906.europe.nokia.com [172.24.90.6])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id
	mB48LeGV020826 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 4 Dec 2008 10:21:42 +0200
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I'm a developer working on Qt for Embedded Linux.

We have customers with hardware blitters who want to use them with Qt. 
Currently, this is done by either mmap'ing the device's registers or by adding 
special, device-specific ioctls to their fbdev driver. What would be nice is 
to have a generic blit API as part of fbdev - preferably one we can query to 
ask "Is this kind of blit accelerated?" and drop to pure user-space if it's 
not accelerated. This seems like a pretty common thing to want, which probably 
means there's a very good reason it has not already been implemented. I've 
searched the mailing list archives, Google and Documentation/fb but not found 
a huge amount of information.

Also, how does fbdev fit with the DRM modesetting API? I've had a look at the 
modesetting stuff and it seems to be providing pretty much the same 
functionality?


I apologize if this has been asked & answered before - If it has, would you 
mind digging out a link?


Cheers,

Tom









-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

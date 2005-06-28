From: Richard Purdie <rpurdie@rpsys.net>
Subject: [patch] w100fb platform independence
Date: Tue, 28 Jun 2005 15:51:07 +0100
Message-ID: <1119970267.7542.4.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DnHQg-0007Vz-Uo
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 28 Jun 2005 07:51:14 -0700
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DnHQf-0007u4-04
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 28 Jun 2005 07:51:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.1/8.12.10) with ESMTP id j5SEp8B4017301
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 28 Jun 2005 15:51:08 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 17196-03 for <linux-fbdev-devel@lists.sourceforge.net>;
 Tue, 28 Jun 2005 15:51:08 +0100 (BST)
Received: from max.rpnet.com (max.rpnet.com [192.168.1.15])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.1/8.12.10) with ESMTP id j5SEp6kj017296
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 28 Jun 2005 15:51:06 +0100
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
Content-Type: text/plain; charset="us-ascii"
To: FB-Dev <linux-fbdev-devel@lists.sourceforge.net>

The code w100fb was based on was horribly Sharp Zaurus Corgi specific
and there was little I could do about this as I had no access to
anything else with a w100 in it. There is no real documentation about
this chipset available.

Ian Molton has access to other platforms with the w100 (Toshiba
e-series) and so between us, we've been able to improve the w100fb
driver and make it platform independent. Ian Molton has then added
support for the very similar 3220 and w3200 chipsets.

This driver has been extensively tested and is being used in preference
to the original driver in the Zaurus community. I'd therefore like to
update the mainline code to reflect this.

Initially, I'm just posting a link to the patch as one is quite large
(140kb). I've split the patch into two parts - the first for the w100
core changes and the second to add the corgi support code.

http://www.rpsys.net/openzaurus/patches/w100_core-r0.patch
http://www.rpsys.net/openzaurus/patches/w100_corgi-r0.patch

After any comments I'll cc them in full to the list as I submit them.
There is a slight further complication as the corgi patch is dependent
on some changes I've recently submitted to the input people in the corgi
touchscreen driver...

I apologise for the white space changes in the patch. I did try and keep
them separate but the patches became unmanageable. If this is a major
problem, I can try and separate those changes out again...

Richard



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click

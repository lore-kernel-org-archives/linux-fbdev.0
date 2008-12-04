From: Tom Cooksey <thomas.cooksey@nokia.com>
Subject: Re: Userspace blit API
Date: Thu, 4 Dec 2008 12:03:14 +0100
Message-ID: <200812041203.14163.thomas.cooksey@nokia.com>
References: <200812040927.24861.thomas.cooksey@nokia.com>
	<200812041141.40350.thomas.cooksey@nokia.com>
	<6A0EB0A5-7DFD-413A-B82B-FBD480541E87@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <thomas.cooksey@nokia.com>) id 1L8Bu4-0003ms-16
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Dec 2008 10:57:52 +0000
Received: from smtp.nokia.com ([192.100.122.233] helo=mgw-mx06.nokia.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L8Bu0-00058m-1L
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Dec 2008 10:57:52 +0000
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	mB4AvXbG018642 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 4 Dec 2008 12:57:43 +0200
Received: from tomdev.localnet (olwst906.europe.nokia.com [172.24.90.6])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id
	mB4AvNHP007018 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 4 Dec 2008 12:57:24 +0200
In-Reply-To: <6A0EB0A5-7DFD-413A-B82B-FBD480541E87@pobox.com>
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

On Thursday 04 December 2008 11:43:55 ext Torgeir Veimo wrote:
> On 4 Dec 2008, at 20:41, Tom Cooksey wrote:
> >> Things like current directfb accel won't work with these fbdev
> >> drivers, mapping card regs into userspace won't be allowed.
>
> So directfb would need to use the dri api in order to work with those
> fbdev drivers?

No, I think DirectFB can just work on the fbdev interface they provide - it 
would just have to drop to software fall-backs for everything. However if 
libdrm provided a blit API, it would also be able to use it (maybe X could 
too, not to mention Wayland).





-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

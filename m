From: Torgeir Veimo <torgeir@pobox.com>
Subject: Re: Userspace blit API
Date: Thu, 4 Dec 2008 20:43:55 +1000
Message-ID: <6A0EB0A5-7DFD-413A-B82B-FBD480541E87@pobox.com>
References: <200812040927.24861.thomas.cooksey@nokia.com>
	<21d7e9970812040103n54e877f1qb049bd9cbaf9c794@mail.gmail.com>
	<200812041141.40350.thomas.cooksey@nokia.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <torgeir@pobox.com>) id 1L8Bgh-0000Cc-9k
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Dec 2008 10:44:03 +0000
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]
	helo=sasl.smtp.pobox.com) by 3b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1L8Bgf-0001Pn-Nz
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Dec 2008 10:44:03 +0000
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id
	7F5B484466 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu,  4 Dec 2008 05:44:00 -0500 (EST)
Received: from [192.168.1.12] (unknown [118.208.94.238]) (using TLSv1 with
	cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
	a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C5F2584465
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu,  4 Dec 2008 05:43:59 -0500 (EST)
In-Reply-To: <200812041141.40350.thomas.cooksey@nokia.com>
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


On 4 Dec 2008, at 20:41, Tom Cooksey wrote:

>> Things like current directfb accel won't work with these fbdev
>> drivers, mapping card regs into userspace won't be allowed.


So directfb would need to use the dri api in order to work with those  
fbdev drivers?

-- 
Torgeir Veimo
torgeir@pobox.com





-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

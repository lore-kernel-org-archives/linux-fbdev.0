From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb & fbdev code status
Date: Sun, 16 Nov 2003 18:20:29 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1068967229.4645.64.camel@gaston>
References: <70AC3EE8-17AD-11D8-A894-0003931DDB42@caltech.edu>
	 <1068959152.5157.50.camel@gaston>
	 <EFF3F4D4-1804-11D8-A894-0003931DDB42@caltech.edu>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALHE8-0000vq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 23:21:44 -0800
Received: from griffin-can-au.getin2net.com ([203.43.225.34])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ALHDQ-0000mK-PM
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 15 Nov 2003 23:21:01 -0800
Received: from gaston ([10.100.1.33])
	by griffin-can-au.getin2net.com (8.11.6/8.11.6) with ESMTP id hAG7KqU12031
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 16 Nov 2003 18:20:52 +1100
In-Reply-To: <EFF3F4D4-1804-11D8-A894-0003931DDB42@caltech.edu>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jordan Benjamin <jordanb@caltech.edu>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-11-16 at 18:17, Jordan Benjamin wrote:
> Thanks for a very informative reply. My only other question now is: 
> where can I find the current radeonfb code? I apologize if this should 
> be obvious to me (I do have an excuse though--I'm recovering from 
> throat surgery and on a lot of painkillers!). Thanks,

The up-to-date version of the "new" driver can always be found in
my "powermac" tree which, I suppose, will work just fine on non-pmac
as well and is available either via bk
(bk://ppc.bkbits.net/linuxppc-2.5-benh) or via rsync
(source.mvista.org::linuxppc-2.5-benh)

I think the current fbdev patches have a fairly recent version too,
but I'd prefer if we did the debugging using my tree so I can push
updates along as we find problems

Ben.



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl

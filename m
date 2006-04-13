From: "Paul A. Clarke" <pc@us.ibm.com>
Subject: Re: [Fwd: [PATCH][matroxfb] G450 jittery display
 on ppc systems]
Date: Wed, 12 Apr 2006 19:11:00 -0500
Message-ID: <443D9714.3070300@us.ibm.com>
References: <443D4F18.2070406@us.ibm.com> <443D70A7.8020702@vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FTpQa-0006ki-77
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Apr 2006 17:11:16 -0700
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FTpQY-0006HD-R5
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Apr 2006 17:11:16 -0700
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3D0B1sm007745
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Apr 2006 20:11:01 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3D07VYY150496
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Apr 2006 18:07:31 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3D0B14j005110
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Apr 2006 18:11:01 -0600
In-Reply-To: <443D70A7.8020702@vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, Ian Romanick <idr@us.ibm.com>

Petr Vandrovec wrote:
> Paul A. Clarke wrote:
>> Just a polite nudge on this patch
[...]
> It looks fine to me.  Except that I'd like to know why this has to be 
> done - is it something common to all DVI displays, or something you got 
> hint on from Matrox, or ... ?

I believe it is common to all systems where the initialization code (BIOS, 
FCODE, etc.) doesn't leave the card in a completely viable state.  It's not a 
DVI-specific thing in that I still can't get any DVI signals, but it does appear 
from my tests that this line is the most significant line in the patch:

+                matroxfb_DAC_out(PMINFO M1064_XDVICLKCTRL, 0);

And, I got some hints from Matrox.  :-)
-- 
Regards,
Paul Clarke


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

From: Keith O'Conor <Keith.OConor@cs.tcd.ie>
Subject: Hardware specs?
Date: Wed, 17 Aug 2005 17:00:37 +0100
Message-ID: <43035F25.5000907@cs.tcd.ie>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E5QLn-0008Do-Th
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Aug 2005 09:01:11 -0700
Received: from relay.cs.tcd.ie ([134.226.32.56] helo=smtp.cs.tcd.ie)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E5QLj-00036q-Ol
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Aug 2005 09:01:12 -0700
Received: from smtp.cs.tcd.ie (localhost [127.0.0.1])
	by relay.cs.tcd.ie (Postfix) with ESMTP id 85227AB
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 17 Aug 2005 17:01:02 +0100 (IST)
Received: from [134.226.35.134] (pc1244.cs.tcd.ie [134.226.35.134])
	by smtp.cs.tcd.ie (Postfix) with ESMTP id 6F0A54D
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 17 Aug 2005 17:01:02 +0100 (IST)
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi everyone,
I'm in the position of needing to write a Radeon driver for a new system 
board being built here at our university. I figured my first steps would 
be to try and reproduce the radeonfb driver to change the resolution, 
and go from there.

Up until now I've been only developing graphics applications, so alot of 
these things are new to me - pixel clocks, horizontal timings, PLL, MTRR 
etc.etc.... it's all quite overwhelming. I've been reading as much as I 
can, but there are still big gaps in my understanding - how did everyone 
else get up to speed in this area?

My main problem is that although it's fairly easy to follow the radeonfb 
source and the fb in general, when it comes to what register does what 
I'm completely lost. Did the people who wrote the driver have technical 
specs from ATI telling them which did what? Are the specs openly 
available, only under NDA, or not at all?!

I'd really appreciate any tips anyone could give me on where I should be 
looking.
Thanks,
Keith

-- 

_____________
Keith O'Conor
Image Synthesis Group
Computer Science Department
University of Dublin, Trinity College
http://isg.cs.tcd.ie/keith



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

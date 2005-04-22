From: <evt@texelsoft.com>
Subject: need help - oddness loading asiliantfb as a module
Date: Fri, 22 Apr 2005 10:33:39 -0400
Message-ID: <200504221433.DCJ42236@ms3.netsolmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DOzE8-0005JI-NA
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Apr 2005 07:33:52 -0700
Received: from omr3.netsolmail.com ([216.168.230.164])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DOzE8-0006UL-1t
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Apr 2005 07:33:52 -0700
Received: from ms3.netsolmail.com (IDENT:mirapoint@[216.168.230.176])
	by omr3.netsolmail.com (8.12.10/8.12.10) with ESMTP id j3MEXemo013588
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 22 Apr 2005 10:33:49 -0400 (EDT)
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
To: linux-fbdev-devel@lists.sourceforge.net

I'm loading asiliantfb as a module 
from /etc/init.d/boot.local by: 
 
insmod 
con2fb /dev/fb0 /dev/tty1 
fbset -g 640 480 640 480 8 
 
and sometimes everything works just fine but other times the 
left margin moves about 6 inches to the right. clues? tia. 
 
-evt(Eric van Tassell) 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

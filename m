From: Antonino Daplas <adaplas@pol.net>
Subject: i810/i815 2.5 framebuffer driver
Date: 11 Jun 2002 02:45:48 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1023734576.553.1.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17HU8x-0003Ug-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 10 Jun 2002 11:43:55 -0700
Received: from [205.136.61.115] (cwc115.compass.com.ph [205.136.61.115])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id CAA25479
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Jun 2002 02:43:50 +0800 (PHT)
	(envelope-from adaplas@pol.net)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

Hi,

Hi, I have ported the i810fb to the 2.5 API.  I've tried to follow the
2.5 API as closely as possible and used only the gen_* functions as much
as possible.

The 2.4 i810 framebuffer driver has been posted in
http://www.sourceforge.net/projects/i810fb for sometime and has been
downloaded quite a number of times.  I've also received a number of mail
from people asking me if I should send the driver to be included to the
mainstream kernel.  I tell them it's not ready yet.  Because the driver
is dependent on agpgart, I have to modify the agpgart code just a bit so
agpgart gets loaded before the framebuffer at boot time.

So, I worked around this "misordered" loading by just having the fb
create and use its own agpgart services until the kernel agpgart becomes
available.  Once the kernel agpgart is available, the driver frees its
own and will start using the kernel's.  

I'm hopefully asking for people who have time to review the code and
perhaps give some thoughts on the agpgart thing.  And for those who have
the hardware, to test it as well.    

Thanks in advance.

Tony

PS:  the diff is against linux-2.5.21

http://i810fb.sourceforge.net/linux-2.5.21-i810fb.diff.gz

The actual source is in:

http://i810fb.sourceforge.net/i810fb.tar.gz






_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink

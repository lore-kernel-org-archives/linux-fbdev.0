From: "Wang Fu-min" <fumin@wmail.nsysu.edu.tw>
Subject: about Graphic Engine support
Date: Tue, 22 Mar 2005 18:18:38 +0800
Message-ID: <005e01c52ec8$86b9d630$26b0758c@nsysusdizae8ul>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDgTb-0006uQ-Db
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Mar 2005 02:19:07 -0800
Received: from wamis2.cse.nsysu.edu.tw ([140.117.176.22])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DDgTZ-0000m6-O1
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Mar 2005 02:19:07 -0800
Received: from nsysusdizae8ul (wamis18.cse.nsysu.edu.tw [140.117.176.38])
	by wamis2.cse.nsysu.edu.tw (8.12.11/8.12.9) with SMTP id j2MAIsAK071155
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 22 Mar 2005 18:18:54 +0800 (CST)
	(envelope-from fumin@wmail.nsysu.edu.tw)
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

    This is my first work on framebuffer.

    Now I have a 2D graphic Engine. I want to use it to speedup drawing 2D graph
by inputing data to the framebuffer's physical address directly.

    I have exported the __pa(registered_fb[0]->pixmap.addr) to my custom /proc/fbphy,
and put the physical address to the graphic engine as a destination address. Is it right?
When I do so, the kernel will core dump. So I guess the idea of mine maybe wrong....

Anyway,thanks for your response first!

fumin




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: intelfb stack usage
Date: Fri, 17 Dec 2004 11:17:10 -0800
Message-ID: <41C330B6.8040504@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CfNmT-0008Vh-Op
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Dec 2004 11:28:49 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=fire-1.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CfNmT-0001EK-0w
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Dec 2004 11:28:49 -0800
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

In 2.6.10-rc3-bk6, intelfb_set_par() has the distinction of being
the largest stack user as determined by 'make checkstack':

objdump -d vmlinux $(find . -name '*.ko') | \
perl /mnt/src/linux-2610-rc3-bk6/scripts/checkstack.pl i386
0x00001317 intelfb_set_par:				2404

because it has this large struct on the stack:
	struct intelfb_hwstate hw;
(almost 2400 bytes)

Any suggestions for how to alleviate this large stack usage?

 From a quick look, this is called from fb_ioctl() to fb_set_var()
to fb_set_par().
fb_ioctl() does acquire_console_sem(), so using kmalloc()
here would need to use GFP_ATOMIC...
I can do that if it's desired & acceptable.

-- 
~Randy


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

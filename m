From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Status of radeonfb in 2.5?
Date: Thu, 17 Oct 2002 00:36:12 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021016223613.17897@192.168.4.1>
References: <3DACA222.5030409@netscape.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-4-189.abo.wanadoo.fr ([217.128.74.189] helo=zion.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181uoO-0003jv-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Oct 2002 13:30:36 -0700
In-Reply-To: <3DACA222.5030409@netscape.net>
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
To: Nicholas Wourms <nwourms@netscape.net>, Linux-fbdev-devel@lists.sourceforge.net

>I was curious to know if the maintainer for the radeonfb 
>driver was planning to update it wrt James' recent API 
>changes.  Considiering it is the latest line available, I'd 
>hope that its brokeness will not be permanent ;-).

I've ported radeonfb 0.1.6 to 2.5.42 (available in the linuxppc-2.5
bk tree) and will port it to James latest changes. Ani (the
maintainer) will probably then just use that port.

Ben.



-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm

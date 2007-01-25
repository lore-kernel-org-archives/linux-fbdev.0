From: "Jan Beulich" <jbeulich@novell.com>
Subject: cyblafb selecting VIDEO_SELECT
Date: Thu, 25 Jan 2007 16:22:46 +0000
Message-ID: <45B8E766.76E4.0078.0@novell.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HA7LZ-00058v-RJ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 25 Jan 2007 08:21:09 -0800
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HA7LX-0003iq-6M
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 25 Jan 2007 08:21:09 -0800
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, Knut_Petersen@t-online.de

Hi,

what is the reason for this? I would think that at best, this should be a "depends on"
(if it really needs the functionality which, according to the doc, it doesn't seem like it
does), especially given that it may be entirely unneeded when built as a module.

Thanks, Jan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

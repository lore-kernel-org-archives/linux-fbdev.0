From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: nvidiafb & chipset 0x147
Date: Wed, 07 Dec 2005 18:29:28 +1100
Message-ID: <1133940568.7168.67.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EjtkH-0000n4-K0
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Dec 2005 23:29:45 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EjtkG-0002xA-68
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Dec 2005 23:29:45 -0800
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id jB77PoWG017372
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 7 Dec 2005 01:25:52 -0600
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

While porting over some recent fixes from X "nv" to nvidiafb, I noticed
that in the list of chipets in NVCommonSetup, near the end, we have:

	case 0x0146:
	case 0x0147:
	case 0x0148:

While X "nv" only has 0x146 and 0x148 (not 0x147). Are we certain 0x147 is
actually a mobility chip or is this a mistake we made when porting it ?

Ben.





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

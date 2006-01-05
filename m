From: "Bob Picco" <bob.picco@hp.com>
Subject: ATI X600 on 2.6.15
Date: Wed, 4 Jan 2006 20:42:29 -0500
Message-ID: <20060105014229.GB10726@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EuKA8-0007BL-OG
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Jan 2006 17:43:32 -0800
Received: from atlrel9.hp.com ([156.153.255.214])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EuKA6-0005Wc-Dp
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Jan 2006 17:43:32 -0800
Received: from smtp1.fc.hp.com (smtp1b.fc.hp.com [15.15.136.127])
	by atlrel9.hp.com (Postfix) with ESMTP id 9C41B349FA
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  4 Jan 2006 20:43:21 -0500 (EST)
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: bob.picco@hp.com


I have machine lockups on 2.6.15 with gentoo bits and lastest x11-org
bits. A simple startx with three xterms doesn't even render the fonts
correctly.  Eventually the machine wedges and can't be pinged.
Switching the xorg.conf driver from radeon to vesa works and creates a
reasonable environment. This seems to have manifested itself since
2.6.15-rc1.

The laptop is a Compaq NX9600 with maximum memory and a large disk.

Should anyone care for further data captured from /proc, config, logs
and etc., I'll be glad to forward them along.  I'd also be willing to
debug and/or test whatever suggestions might be made.

thanks,

bob


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

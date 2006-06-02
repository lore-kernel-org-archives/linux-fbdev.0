From: Terence Soh <gopher@singnet.com.sg>
Subject: Spinning wheel animation splashscreen
Date: Fri, 02 Jun 2006 16:09:02 +0800
Message-ID: <447FF21E.8040500@singnet.com.sg>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fm4wH-0005Om-7T for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 01:23:26 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fm4wB-0000mH-5W for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 01:23:19 -0700
Received: from smtp43.singnet.com.sg ([165.21.103.151])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fm4jU-0000ss-DC
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 01:10:14 -0700
Received: from [167.116.151.204] ([63.150.136.42])
	by smtp43.singnet.com.sg (8.13.6/8.13.6) with ESMTP id k5289svS019918
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 2 Jun 2006 16:09:55 +0800
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

Is there any current implementation for animating the splash screen?

Are there any advises for implementing one such as a spinning wheel?

Is it advisable to use the bit_cursor function in bitblit.c to animate 
the screen?

Thanks in advance,
Terence.

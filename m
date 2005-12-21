From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [PATCH 1/1: 2.6.15-rc6] Fix clearing of vertical margins
Date: Wed, 21 Dec 2005 06:48:21 +0100
Message-ID: <43A8ECA5.6000003@t-online.de>
References: <43A7D7B3.6000907@t-online.de> <43A7F2F1.2050900@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eowot-0006Uv-Kj
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 21:47:23 -0800
Received: from mailout05.sul.t-online.com ([194.25.134.82])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eowos-0004k4-Dk
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 21:47:23 -0800
In-Reply-To: <43A7F2F1.2050900@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


>NAK.  The right margin is cleared just once on an fbcon_switch (entire
>yres_virtual). The right margin should remain cleared until another
>fbcon_switch happens so it's not necessary to clear the right margins again.
>
>Tony
>
>  
>

You are right. I hit an internal limit of the cyberblade engine.

cu,
 knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

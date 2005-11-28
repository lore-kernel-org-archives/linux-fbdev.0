From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Detect switching to X?
Date: Mon, 28 Nov 2005 16:27:10 +0800
Message-ID: <438ABF5E.808@gmail.com>
References: <43894E39.9080902@t-online.de> <438A3568.50100@gmail.com> <438A9BA8.3070600@t-online.de> <438AB24C.60405@gmail.com> <438ABBF3.20104@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgeMa-0008Ob-Ln
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Nov 2005 00:27:52 -0800
Received: from xproxy.gmail.com ([66.249.82.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EgeMZ-00037p-EJ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Nov 2005 00:27:52 -0800
Received: by xproxy.gmail.com with SMTP id h29so2006412wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 28 Nov 2005 00:27:49 -0800 (PST)
In-Reply-To: <438ABBF3.20104@t-online.de>
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
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Hi Tony,
> 
> 
> Today framebuffer drivers are limited by the fact that they need to
> leave the graphics
> engine in a state that current and older (but still used) X drivers can
> handle. That
> unreasonable limitation should be removed, and it can be removed by
> those optional
> fb_save_state() and fb_restore_state() hooks.
> 

Okay.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

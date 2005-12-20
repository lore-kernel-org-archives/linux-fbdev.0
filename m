From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/1: 2.6.15-rc6] Fix framebuffer console upside-down ywrap
 scrolling
Date: Tue, 20 Dec 2005 15:56:09 +0800
Message-ID: <43A7B919.3030103@gmail.com>
References: <43A7B031.6070609@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EocMu-0000CM-2V
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Dec 2005 23:57:08 -0800
Received: from xproxy.gmail.com ([66.249.82.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EocMs-00020L-NZ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Dec 2005 23:57:08 -0800
Received: by xproxy.gmail.com with SMTP id s6so952650wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Dec 2005 23:57:05 -0800 (PST)
In-Reply-To: <43A7B031.6070609@t-online.de>
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
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Whenever ywrap scrolling is selected together with 180 degree
> screen rotation, 2.6.15-rc6 and earlier versions are broken.
> fb_pan_display() expects non-negative yoffsets, but
> ud_update_start() calls it with yoffsets down to -(yres - font height).
> This patch transforms yoffset to the correct range 0 ... vyres-1.
> 
> Some obviously unneeded parentheses are removed, too.
> 
> Verified with cyblafb, should be applied before 2.6.15-final
> because  it does fix the framebuffer rotation code introduced
> early in the 2.6.15 release cycle.
> 
> Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>
Acked-by: Antonino Daplas <adaplas@pol.net>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

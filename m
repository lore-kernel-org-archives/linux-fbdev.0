From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: write() to zero length framebuffer -- bug
 report
Date: Tue, 13 Dec 2005 23:36:35 +0800
Message-ID: <439EEA83.90204@gmail.com>
References: <35786B99AB3FDC45A8215724617919736D918C@gbrwgceumf01.eu.xerox.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmCCz-0002uk-Nj
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 07:36:53 -0800
Received: from zproxy.gmail.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EmCCv-0003VC-6m
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 07:36:53 -0800
Received: by zproxy.gmail.com with SMTP id r28so1699082nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 Dec 2005 07:36:46 -0800 (PST)
In-Reply-To: <35786B99AB3FDC45A8215724617919736D918C@gbrwgceumf01.eu.xerox.net>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Jenkins, Clive" <Clive.Jenkins@xerox.com>

Jenkins, Clive wrote:
> In the vanilla 2.4.20 kernel version of fbmem.c, the function
> fb_write() returns zero if the framebuffer size (fix.smem_size)
> is zero, instead of -ENOSPC. This causes a normal user program
> to loop forever.
> 
> Looking at the code for vanilla 2.6.10 and 2.6.11, the situation
> is complicated by the new info.screen_size and kmalloc-ing a
> buffer, but the bug is still there.

Thank you. Will fix.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

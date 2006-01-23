From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH]: Fix SGI O2 Compile error in drivers/video/gbefb.c
Date: Tue, 24 Jan 2006 07:53:04 +0800
Message-ID: <43D56C60.4030402@gmail.com>
References: <20060123203205.GB499@toucan.gentoo.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F1BUI-0001Jf-Um
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Jan 2006 15:52:42 -0800
Received: from xproxy.gmail.com ([66.249.82.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F1BUH-0001RU-VM
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Jan 2006 15:52:43 -0800
Received: by xproxy.gmail.com with SMTP id s6so720311wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 23 Jan 2006 15:52:40 -0800 (PST)
In-Reply-To: <20060123203205.GB499@toucan.gentoo.org>
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
Cc: linux-mips@linux-mips.org, kumba@gentoo.org

Kumba wrote:
> Hi all,
> 
> Around line ~1247 in drivers/video/gbefb.c, gbefb_remove_sysfs uses the wrong parameter, causing an O2 kernel build 
> to break when using this driver.  The attached patch supplies the correct parameter, allowing the build to succeed.
> 

Okay.  Thanks.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

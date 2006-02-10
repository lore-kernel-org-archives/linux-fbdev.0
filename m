From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbdev: Fix typo in fbmem.c
Date: Fri, 10 Feb 2006 23:14:04 +0800
Message-ID: <43ECADBC.2080107@gmail.com>
References: <20060207220627.345107c3.akpm@osdl.org> <20060210145243.GA3581@inferi.kami.home>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F7ZyL-0000bh-8a
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Feb 2006 07:14:09 -0800
Received: from pproxy.gmail.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F7ZyJ-0001vs-JR
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Feb 2006 07:14:09 -0800
Received: by pproxy.gmail.com with SMTP id s49so224550pyc
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Feb 2006 07:14:02 -0800 (PST)
In-Reply-To: <20060210145243.GA3581@inferi.kami.home>
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
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Cc: malattia@linux.it

A typo in fbmem.c prevents recognition of video= parameter.

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
Mattia Dongili wrote:

> On Tue, Feb 07, 2006 at 10:06:27PM -0800, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/
> 
> Hello,
> 
> radeonfb ignores the video= parameter and always run at 1400x1050 (the
> highest available). Things where fine with .16-rc1-mm5.
> I also tried booting with 640x480-32@60 without success.

Try this patch.

Tony

PS: Andrew, maybe this patch should go into your hotfixes?

 fbmem.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 6454a37..3ff1a54 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1569,7 +1569,7 @@ int fb_get_options(char *name, char **op
 	return retval;
 }
 
-#ifdef MODULE
+#ifndef MODULE
 /**
  *	video_setup - process command line options
  *	@options: string of options


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

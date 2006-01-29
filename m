From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbdev: Fix usage of blank value passed to fb_blank
Date: Sun, 29 Jan 2006 10:18:19 +0800
Message-ID: <43DC25EB.1040005@gmail.com>
References: <20060127231314.GA28324@hansmi.ch> <20060127.204645.96477793.davem@davemloft.net> <43DB0839.6010703@gmail.com> <200601282106.21664.ioe-lkml@rameria.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F329m-0006TI-KC
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 Jan 2006 18:19:10 -0800
Received: from xproxy.gmail.com ([66.249.82.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F329m-0001xZ-9y
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 Jan 2006 18:19:10 -0800
Received: by xproxy.gmail.com with SMTP id s8so586024wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 28 Jan 2006 18:19:08 -0800 (PST)
In-Reply-To: <200601282106.21664.ioe-lkml@rameria.de>
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
To: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org, linux-kernel@hansmi.ch

The fb_blank() hook accepts 5 blanking levels which include 1 level designed
for console use only.  Userspace is only aware of 4 levels. Thus, it's
possible for userspace to request VESA_VSYNC_SUSPEND which, in turn, is
interpreted by the fb driver as a request for FB_BLANK_NORMAL. A few drivers
return -EINVAL for this, confusing userspace apps that the driver may not
have VESA blanking support.

Fix by incrementing the blank value by one if the request originated from
userspace.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

Ingo Oeser wrote:
> > May I suggest to hide this implementation detail?
> > 

Yes.  The change will be invisible to drivers.

Unfortunately, this may cause some userland breakage.  X should work.
However, some apps may have been developed that uses the FB_BLANK constants
(DirectFB?).  In these cases, they'll get a deeper blank level instead, so it
probably won't affect them significantly.  A follow up patch that hides the 
FB_BLANK constants may be worthwhile.

 drivers/video/fbmem.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index d2dede6..5bed0fb 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -843,6 +843,19 @@ fb_blank(struct fb_info *info, int blank
 {	
  	int ret = -EINVAL;
 
+	/*
+	 * The framebuffer core supports 5 blanking levels (FB_BLANK), whereas
+	 * VESA defined only 4.  The extra level, FB_BLANK_NORMAL, is a
+	 * console invention and is not related to power management.
+	 * Unfortunately, fb_blank callers, especially X, pass VESA constants
+	 * leading to undefined behavior.
+	 *
+	 * To avoid confusion, fb_blank will assume VESA constants if coming
+	 * from userspace, and FB_BLANK constants if coming from the kernel.
+	 */
+	if (info->flags & FBINFO_MISC_USEREVENT && blank)
+		blank++;
+
  	if (blank > FB_BLANK_POWERDOWN)
  		blank = FB_BLANK_POWERDOWN;
 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Behaviour change of /dev/fb0?
Date: Sat, 15 Apr 2006 08:53:21 +0800
Message-ID: <44404401.3030702@gmail.com>
References: <1145009768.6179.7.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FUZ31-0006mk-6r
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 17:53:59 -0700
Received: from pproxy.gmail.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FUZ30-0005AE-61
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 17:53:59 -0700
Received: by pproxy.gmail.com with SMTP id i49so193728pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Apr 2006 17:53:57 -0700 (PDT)
In-Reply-To: <1145009768.6179.7.camel@localhost.localdomain>
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
Cc: linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

Richard Purdie wrote:
> Ignoring whether this is a good idea or not, under 2.6.15 you could run
> 
> dd if=/dev/zero of=/dev/fb0
> 
> which would clear the framebuffer. It would end up saying "dd: /dev/fb0:
> No space left on device".
> 
> Under 2.6.16 (and a recent git kernel), the same command clears the
> screen but then hangs. Was the change in behaviour intentional? 
> 
> I've noticed this on a couple of ARM based Zaurus handhelds under both
> w100fb and pxafb.
> 

After reading 'man 2 read' more thoroughly, I've adjusted fb_write()'s
return codes  appropriately.  Can you try this patch and let me know if it
fixes your problem.

Tony

fbdev: Fix return error of fb_write()

- return -EFBIG if file offset is past the maximum allowable offset
- return -EFBIG and write to end of framebuffer if size is bigger than the
  framebuffer length
- return -ENOSPC and write to end of framebuffer if size is bigger than the
  framebuffer length - file offset

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbmem.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 944855b..8a643bf 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -669,13 +669,19 @@ fb_write(struct file *file, const char _
 		total_size = info->fix.smem_len;
 
 	if (p > total_size)
-		return 0;
+		return -EFBIG;
 
-	if (count >= total_size)
+	if (count >= total_size) {
+		err = -EFBIG;
 		count = total_size;
+	}
+
+	if (count + p > total_size) {
+		if (!err)
+			err = -ENOSPC;
 
-	if (count + p > total_size)
 		count = total_size - p;
+	}
 
 	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
 			 GFP_KERNEL);


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

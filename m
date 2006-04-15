From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbdev: Fix return error of fb_write
Date: Sat, 15 Apr 2006 13:38:19 +0800
Message-ID: <444086CB.2000700@gmail.com>
References: <1145009768.6179.7.camel@localhost.localdomain>	<44404401.3030702@gmail.com> <20060414213105.09f0dd8d.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FUdUo-0000m1-7O
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 22:38:58 -0700
Received: from pproxy.gmail.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FUdUm-00066X-KK
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 22:38:58 -0700
Received: by pproxy.gmail.com with SMTP id i49so230398pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Apr 2006 22:38:55 -0700 (PDT)
In-Reply-To: <20060414213105.09f0dd8d.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, rpurdie@rpsys.net

Fix return code of fb_write():

If at least 1 byte was transferred to the device, return number of bytes,
otherwise:

    - return -EFBIG - if file offset is past the maximum allowable offset or
      size is greater than framebuffer length
    - return -ENOSPC - if size is greater than framebuffer length - offset

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>> Richard Purdie wrote:
>>
>> - return -EFBIG if file offset is past the maximum allowable offset
> 
> OK.
> 
>> - return -EFBIG and write to end of framebuffer if size is bigger than the
>>   framebuffer length
> 
> We should return the number of bytes written in this case.
> 
>> - return -ENOSPC and write to end of framebuffer if size is bigger than the
>>   framebuffer length - file offset
> 
> Also here.
> 
> 
> If we can transfer _any_ bytes, we should do so, then return the number of
> bytes transferred.  If no bytes were transferrable then we should return
> -Ewhatever.
> 
> 

Okay, here's try #2:

 drivers/video/fbmem.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 944855b..a4b6776 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -669,13 +669,19 @@ fb_write(struct file *file, const char _
 		total_size = info->fix.smem_len;
 
 	if (p > total_size)
-		return 0;
+		return -EFBIG;
 
-	if (count >= total_size)
+	if (count > total_size) {
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
@@ -717,7 +723,7 @@ fb_write(struct file *file, const char _
 
 	kfree(buffer);
 
-	return (err) ? err : cnt;
+	return (cnt) ? cnt : err;
 }
 
 #ifdef CONFIG_KMOD


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

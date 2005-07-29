From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Fw: framebuffer blitting performance loss
  2.6.12 -> 2.6.13-rc3
Date: Fri, 29 Jul 2005 23:42:34 +0800
Message-ID: <42EA4E6A.70907@gmail.com>
References: <20050715033912.1cd9b6c3.akpm@osdl.org>	<200507221158.23454.adaplas@gmail.com> <20050729001735.5934622f.akpm@osdl.org> <42EA430C.2010405@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyX0T-0005Jx-7F
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 08:42:41 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyX0R-0004mb-SZ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 08:42:41 -0700
Received: by wproxy.gmail.com with SMTP id 36so628784wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Jul 2005 08:42:34 -0700 (PDT)
In-Reply-To: <42EA430C.2010405@t-online.de>
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
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

Knut Petersen wrote:
> Hi everybody!
> 
>>> I haven't seen any significant performance penalty, between 
>>> 2.6.12-rc5-mm1
>>> and 2.6.13-rc3-mm1.
>>>
>>> Based on your results, I would pinpoint the culprit to be in
>>> video/console/bitblit.c.  However, the changes there are minor, and 
>>> should not
>>> alter the peformance.
>>>
>>>
>>
>> So.. what happened here?  Is the problem still present in 2.6.13-rc4?
>>
>>
> Yes, the problem still is present in 2.6.13-rc4.
> ================================================

Thank you for your persistence.  I think I know the culprit.  Someone
insisted on using memcpy in fb_pad_aligned_buffer().  I have already
fixed this before, but apparently, the memcpy was brought back.  Try
the attached patch and let me know.

Tony

   fbdev: Replace memcpy with for-loop when preparing bitmap

    Do not use memcpy in fb_pad_aligned_buffer. It is suboptimal because only
    a few bytes are moved at a time. Replace with a for-loop.

    From: Antonino Daplas <adaplas@pol.net>
    Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbmem.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -80,10 +80,12 @@ EXPORT_SYMBOL(fb_get_color_depth);
  */
 void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u32 height)
 {
-	int i;
+	int i, j;
 
 	for (i = height; i--; ) {
-		memcpy(dst, src, s_pitch);
+		/* s_pitch is a few bytes at the most, memcpy is suboptimal */
+		for (j = 0; j < s_pitch; j++)
+			dst[j] = src[j];
 		src += s_pitch;
 		dst += d_pitch;
 	}


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] matroxfb: Color setting fixes fix
Date: Wed, 06 Jun 2007 23:09:13 +0800
Message-ID: <4666CE19.2040802@gmail.com>
References: <46654606.8020900@gmail.com> <4665FA05.6030303@vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hvx8T-0000lo-FZ for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Jun 2007 08:09:21 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hvx8R-0004DO-Gu
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Jun 2007 08:09:21 -0700
Received: by py-out-1112.google.com with SMTP id u77so305459pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 06 Jun 2007 08:09:18 -0700 (PDT)
In-Reply-To: <4665FA05.6030303@vc.cvut.cz>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Remove more code that writes to cmap[16].

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---
Petr Vandrovec wrote:
> Antonino A. Daplas wrote:
>> - the pseudo_palette is only 16 elements long.
>> - do not write to the pseudo_palette if regno (array index) is more
>> than 15
>> - remove code that writes to the 17th entry of the pseudo_palette
>>
>> Signed-off-by: Antonino Daplas <adaplas@gmail.com>
>> ---
>> Petr,
>>
>> Here's another attempt. Let me know if I missed anything.
> 
> You did not run my grep, did you?  matroxfb_cfb[48]_* in matroxfb_accel
> have loop:

Actually I did, but it grep'ed "everything". And I'm not too much of an 
expert with grep.

Here's an incremental patch. Hopefully, this is the end of it

Tony

drivers/video/matrox/matroxfb_accel.c |    2 --
1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/video/matrox/matroxfb_accel.c b/drivers/video/matrox/matroxfb_accel.c
index 209fe69..3660d26 100644
--- a/drivers/video/matrox/matroxfb_accel.c
+++ b/drivers/video/matrox/matroxfb_accel.c
@@ -91,7 +91,6 @@ static inline void matrox_cfb4_pal(u_int
 	for (i = 0; i < 16; i++) {
 		pal[i] = i * 0x11111111U;
 	}
-	pal[i] = 0xFFFFFFFF;
 }
 
 static inline void matrox_cfb8_pal(u_int32_t* pal) {
@@ -100,7 +99,6 @@ static inline void matrox_cfb8_pal(u_int
 	for (i = 0; i < 16; i++) {
 		pal[i] = i * 0x01010101U;
 	}
-	pal[i] = 0x0F0F0F0F;
 }
 
 static void matroxfb_copyarea(struct fb_info* info, const struct fb_copyarea* area);

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

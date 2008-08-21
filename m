From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] fb: metronome printk format warning
Date: Thu, 21 Aug 2008 13:38:36 -0700
Message-ID: <20080821133836.1c880abe.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: frame+buffer@ml.breakpoint.cc, linux-fbdev-devel@lists.sourceforge.net
Cc: jayakumar.lkml@gmail.com, linux-next@vger.kernel.org, akpm <akpm@linux-foundation.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix printk format warning:

linux-next-20080821/drivers/video/metronomefb.c:191: warning: format '%d' expects type 'int', but argument 4 has type 'size_t

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/video/metronomefb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20080821.orig/drivers/video/metronomefb.c
+++ linux-next-20080821/drivers/video/metronomefb.c
@@ -188,7 +188,7 @@ static int __devinit load_waveform(u8 *m
 		epd_frame_table[par->dt].wfm_size = user_wfm_size;
 
 	if (size != epd_frame_table[par->dt].wfm_size) {
-		dev_err(dev, "Error: unexpected size %d != %d\n", size,
+		dev_err(dev, "Error: unexpected size %zu != %d\n", size,
 					epd_frame_table[par->dt].wfm_size);
 		return -EINVAL;
 	}


---
~Randy
Linux Plumbers Conference, 17-19 September 2008, Portland, Oregon USA
http://linuxplumbersconf.org/

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 01 Feb 2012 14:39:10 +0000
Subject: [patch] backlight: lp855x_bl: silence a compiler warning
Message-Id: <20120201143910.GA5359@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Gcc 4.6.2 complains that "end" can be used without being initialized:

drivers/video/backlight/lp855x_bl.c: In function ‘lp855x_init_registers’:
drivers/video/backlight/lp855x_bl.c:78:32: warning: ‘end’ may be used uninitialized in this function [-Wuninitialized]
drivers/video/backlight/lp855x_bl.c:67:12: note: ‘end’ was declared here

I've modified the function to return invalid if we don't recognize the
id string.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index 8f628b8..5e8153d 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -73,6 +73,8 @@ static int lp855x_is_valid_rom_area(struct lp855x *lp, u8 addr)
 	} else if (strstr(id, "lp8556")) {
 		start = EPROM_START;
 		end = EPROM_END;
+	} else {
+		return 0;
 	}
 
 	return (addr >= start && addr <= end) ? 1 : 0;

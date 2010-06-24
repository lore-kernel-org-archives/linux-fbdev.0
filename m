From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Thu, 24 Jun 2010 14:16:37 +0000
Subject: [PATCH] video: simplify strlen()==0 check in fb_get_options()
Message-Id: <1277396186-11921-1-git-send-email-vda.linux@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>, James Simmons <jsimmons@infradead.org>, linux-fbdev@vger.kernel.org, Denys Vlasenko <vda.linux@googlemail.com>
Cc: linux-kernel@vger.kernel.org

Replaced !strlen(str) check with !str[0]. Removed the variable
which was used solely to store strlen result.

Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
---
 drivers/video/fbmem.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 731fce6..a8500c6 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1786,7 +1786,7 @@ static int ofonly __read_mostly;
 int fb_get_options(char *name, char **option)
 {
 	char *opt, *options = NULL;
-	int opt_len, retval = 0;
+	int retval = 0;
 	int name_len = strlen(name), i;
 
 	if (name_len && ofonly && strncmp(name, "offb", 4))
@@ -1796,8 +1796,7 @@ int fb_get_options(char *name, char **option)
 		for (i = 0; i < FB_MAX; i++) {
 			if (video_options[i] = NULL)
 				continue;
-			opt_len = strlen(video_options[i]);
-			if (!opt_len)
+			if (!video_options[i][0])
 				continue;
 			opt = video_options[i];
 			if (!strncmp(name, opt, name_len) &&
-- 
1.6.2.5


From: Adam Jackson <ajax@redhat.com>
Date: Tue, 10 Oct 2017 17:39:56 +0000
Subject: [PATCH] uvesafb: Fix URLs in the documentation
Message-Id: <20171010173956.30884-1-ajax@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Adam Jackson <ajax@redhat.com>
---
 Documentation/fb/uvesafb.txt | 5 +++--
 MAINTAINERS                  | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/fb/uvesafb.txt b/Documentation/fb/uvesafb.txt
index f6362d88763b..aa924196c366 100644
--- a/Documentation/fb/uvesafb.txt
+++ b/Documentation/fb/uvesafb.txt
@@ -15,7 +15,8 @@ than x86.  Check the v86d documentation for a list of currently supported
 arches.
 
 v86d source code can be downloaded from the following website:
-  http://dev.gentoo.org/~spock/projects/uvesafb
+
+  https://github.com/mjanusz/v86d
 
 Please refer to the v86d documentation for detailed configuration and
 installation instructions.
@@ -177,7 +178,7 @@ from the Video BIOS if you set pixclock to 0 in fb_var_screeninfo.
 
 --
  Michal Januszewski <spock@gentoo.org>
- Last updated: 2009-03-30
+ Last updated: 2017-10-10
 
  Documentation of the uvesafb options is loosely based on vesafb.txt.
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 2d3d750b19c0..fd1a7fed4c7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14165,7 +14165,7 @@ S:	Maintained
 UVESAFB DRIVER
 M:	Michal Januszewski <spock@gentoo.org>
 L:	linux-fbdev@vger.kernel.org
-W:	http://dev.gentoo.org/~spock/projects/uvesafb/
+W:	https://github.com/mjanusz/v86d
 S:	Maintained
 F:	Documentation/fb/uvesafb.txt
 F:	drivers/video/fbdev/uvesafb.*
-- 
2.13.5


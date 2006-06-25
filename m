From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbcon: Fix documentation errors
Date: Sun, 25 Jun 2006 18:09:33 +0800
Message-ID: <449E60DD.2000207@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuRag-00069d-MN for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 03:11:42 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FuRag-0005LI-Bl
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 03:11:42 -0700
Received: by py-out-1112.google.com with SMTP id d42so1220481pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Jun 2006 03:11:42 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- Remove deprecated instruction
- Fix typo

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Documentation/fb/fbcon.txt |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/Documentation/fb/fbcon.txt b/Documentation/fb/fbcon.txt
index b7b0a8c..f373df1 100644
--- a/Documentation/fb/fbcon.txt
+++ b/Documentation/fb/fbcon.txt
@@ -214,12 +214,6 @@ restored properly. The following is one 
 
 5. Now to detach fbcon:
 
-	Assuming vtcon1 represents fbcon, then:
-
-       'cat /sys/class/tty/console/backend' and take note of the ID
-
-The above is probably needed only once. Then:
-
        vbetool vbestate restore < <vga state file> && \
        echo 0 > /sys/class/vtconsole/vtcon1/bind
 
@@ -301,7 +295,7 @@ do
   if test -x /sys/class/vtconsole/vtcon$i; then
       if [ `cat /sys/class/vtconsole/vtcon$i/name | grep -c "frame buffer"` \
            = 1 ]; then
-	    if text -x $VBETOOL/vbetool; then
+	    if test -x $VBETOOL/vbetool; then
 	       echo Unbinding vtcon$i
 	       $VBETOOL/vbetool vbestate restore < $VGASTATE
 	       echo 0 > /sys/class/vtconsole/vtcon$i/bind


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

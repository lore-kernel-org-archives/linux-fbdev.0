From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Mon, 22 Apr 2019 13:27:34 +0000
Subject: [PATCH v2 45/79] docs: console.txt: convert docs to ReST and rename to *.rst
Message-Id: <27d8c7ddc7aac8af43152b8f37a23edd2d73bdfc.1555938376.git.mchehab+samsung@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1555938375.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Jiri Slaby <jslaby@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Convert this small file to ReST in preparation for adding it to
the driver-api book.

While this is not part of the driver-api book, mark it as
:orphan:, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../console/{console.txt => console.rst}      | 63 ++++++++++---------
 Documentation/fb/fbcon.rst                    |  4 +-
 drivers/tty/Kconfig                           |  2 +-
 3 files changed, 38 insertions(+), 31 deletions(-)
 rename Documentation/console/{console.txt => console.rst} (80%)

diff --git a/Documentation/console/console.txt b/Documentation/console/console.rst
similarity index 80%
rename from Documentation/console/console.txt
rename to Documentation/console/console.rst
index d73c2ab4beda..b374141b027e 100644
--- a/Documentation/console/console.txt
+++ b/Documentation/console/console.rst
@@ -1,3 +1,6 @@
+:orphan:
+
+======= Console Drivers
 ======= 
@@ -17,25 +20,26 @@ of driver occupying the consoles.) They can only take over the console that is
 occupied by the system driver. In the same token, if the modular driver is
 released by the console, the system driver will take over.
 
-Modular drivers, from the programmer's point of view, have to call:
+Modular drivers, from the programmer's point of view, have to call::
 
 	 do_take_over_console() - load and bind driver to console layer
 	 give_up_console() - unload driver; it will only work if driver
 			     is fully unbound
 
-In newer kernels, the following are also available:
+In newer kernels, the following are also available::
 
 	 do_register_con_driver()
 	 do_unregister_con_driver()
 
 If sysfs is enabled, the contents of /sys/class/vtconsole can be
 examined. This shows the console backends currently registered by the
-system which are named vtcon<n> where <n> is an integer from 0 to 15. Thus:
+system which are named vtcon<n> where <n> is an integer from 0 to 15.
+Thus::
 
        ls /sys/class/vtconsole
        .  ..  vtcon0  vtcon1
 
-Each directory in /sys/class/vtconsole has 3 files:
+Each directory in /sys/class/vtconsole has 3 files::
 
      ls /sys/class/vtconsole/vtcon0
      .  ..  bind  name  uevent
@@ -46,27 +50,29 @@ What do these files signify?
         read, or acts to bind or unbind the driver to the virtual consoles
         when written to. The possible values are:
 
-	0 - means the driver is not bound and if echo'ed, commands the driver
+	0
+	  - means the driver is not bound and if echo'ed, commands the driver
 	    to unbind
 
-        1 - means the driver is bound and if echo'ed, commands the driver to
+        1
+	  - means the driver is bound and if echo'ed, commands the driver to
 	    bind
 
-     2. name - read-only file. Shows the name of the driver in this format:
+     2. name - read-only file. Shows the name of the driver in this format::
 
-	cat /sys/class/vtconsole/vtcon0/name
-	(S) VGA+
+	  cat /sys/class/vtconsole/vtcon0/name
+	  (S) VGA+
 
-	    '(S)' stands for a (S)ystem driver, i.e., it cannot be directly
-	    commanded to bind or unbind
+	      '(S)' stands for a (S)ystem driver, i.e., it cannot be directly
+	      commanded to bind or unbind
 
-	    'VGA+' is the name of the driver
+	      'VGA+' is the name of the driver
 
-	cat /sys/class/vtconsole/vtcon1/name
-	(M) frame buffer device
+	  cat /sys/class/vtconsole/vtcon1/name
+	  (M) frame buffer device
 
-	    In this case, '(M)' stands for a (M)odular driver, one that can be
-	    directly commanded to bind or unbind.
+	      In this case, '(M)' stands for a (M)odular driver, one that can be
+	      directly commanded to bind or unbind.
 
      3. uevent - ignore this file
 
@@ -75,14 +81,17 @@ driver takes over the consoles vacated by the driver. Binding, on the other
 hand, will bind the driver to the consoles that are currently occupied by a
 system driver.
 
-NOTE1: Binding and unbinding must be selected in Kconfig. It's under:
+NOTE1:
+  Binding and unbinding must be selected in Kconfig. It's under::
 
-Device Drivers -> Character devices -> Support for binding and unbinding
-console drivers
+    Device Drivers ->
+	Character devices ->
+		Support for binding and unbinding console drivers
 
-NOTE2: If any of the virtual consoles are in KD_GRAPHICS mode, then binding or
-unbinding will not succeed. An example of an application that sets the console
-to KD_GRAPHICS is X.
+NOTE2:
+  If any of the virtual consoles are in KD_GRAPHICS mode, then binding or
+  unbinding will not succeed. An example of an application that sets the
+  console to KD_GRAPHICS is X.
 
 How useful is this feature? This is very useful for console driver
 developers. By unbinding the driver from the console layer, one can unload the
@@ -92,10 +101,10 @@ framebuffer console to VGA console and vice versa, this feature also makes
 this possible. (NOTE NOTE NOTE: Please read fbcon.txt under Documentation/fb
 for more details.)
 
-Notes for developers:
-==========+Notes for developers
+==========
 
-do_take_over_console() is now broken up into:
+do_take_over_console() is now broken up into::
 
      do_register_con_driver()
      do_bind_con_driver() - private function
@@ -104,7 +113,7 @@ give_up_console() is a wrapper to do_unregister_con_driver(), and a driver must
 be fully unbound for this call to succeed. con_is_bound() will check if the
 driver is bound or not.
 
-Guidelines for console driver writers:
+Guidelines for console driver writers
 ================== 
 In order for binding to and unbinding from the console to properly work,
@@ -140,6 +149,4 @@ The current crop of console drivers should still work correctly, but binding
 and unbinding them may cause problems. With minimal fixes, these drivers can
 be made to work correctly.
 
-=============
 Antonino Daplas <adaplas@pol.net>
-
diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index cfb9f7c38f18..22112718dd5d 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -187,7 +187,7 @@ the hardware. Thus, in a VGA console::
 Assuming the VGA driver can be unloaded, one must first unbind the VGA driver
 from the console layer before unloading the driver.  The VGA driver cannot be
 unloaded if it is still bound to the console layer. (See
-Documentation/console/console.txt for more information).
+Documentation/console/console.rst for more information).
 
 This is more complicated in the case of the framebuffer console (fbcon),
 because fbcon is an intermediate layer between the console and the drivers::
@@ -204,7 +204,7 @@ fbcon. Thus, there is no need to explicitly unbind the fbdev drivers from
 fbcon.
 
 So, how do we unbind fbcon from the console? Part of the answer is in
-Documentation/console/console.txt. To summarize:
+Documentation/console/console.rst. To summarize:
 
 Echo a value to the bind file that represents the framebuffer console
 driver. So assuming vtcon1 represents fbcon, then::
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 957db30b9ecb..c30bfc95e03c 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -94,7 +94,7 @@ config VT_HW_CONSOLE_BINDING
          select the console driver that will serve as the backend for the
          virtual terminals.
 
-	 See <file:Documentation/console/console.txt> for more
+	 See <file:Documentation/console/console.rst> for more
 	 information. For framebuffer console users, please refer to
 	 <file:Documentation/fb/fbcon.rst>.
 
-- 
2.20.1

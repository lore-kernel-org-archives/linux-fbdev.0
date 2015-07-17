From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 17 Jul 2015 13:33:19 +0000
Subject: [PATCH 2/3] Documentation/fb: add documentation for sm712fb
Message-Id: <1437139280-7375-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437139280-7375-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1437139280-7375-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, devel@driverdev.osuosl.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Create the documentation for SM712. Mention all the supported modes and
how to use.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 Documentation/fb/sm712fb.txt | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/fb/sm712fb.txt

diff --git a/Documentation/fb/sm712fb.txt b/Documentation/fb/sm712fb.txt
new file mode 100644
index 0000000..c388442
--- /dev/null
+++ b/Documentation/fb/sm712fb.txt
@@ -0,0 +1,31 @@
+What is sm712fb?
+========+
+This is a graphics framebuffer driver for Silicon Motion SM712 based processors.
+
+How to use it?
+=======
+
+Switching modes is done using the video=sm712fb:... boot parameter.
+
+If you want, for example, enable a resolution of 1280x1024x24bpp you should
+pass to the kernel this command line: "video=sm712fb:0x31B".
+
+You should not compile-in vesafb.
+
+Currently supported video modes are:
+
+[Graphic modes]
+
+bpp | 640x480  800x600  1024x768  1280x1024
+----+--------------------------------------------
+  8 | 0x301    0x303    0x305    0x307
+ 16 | 0x311    0x314    0x317    0x31A
+ 24 | 0x312    0x315    0x318    0x31B
+
+Missing Features
+========
+(alias TODO list)
+
+	* 2D acceleratrion
+	* dual-head support
-- 
1.8.1.2


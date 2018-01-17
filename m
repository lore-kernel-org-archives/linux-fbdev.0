From: Max Staudt <mstaudt@suse.de>
Date: Wed, 17 Jan 2018 20:54:35 +0000
Subject: [RFC PATCH v3 13/13] tools/bootsplash: Add script and data to create sample file
Message-Id: <20180117205435.2860-14-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180117205435.2860-1-mstaudt@suse.de>
In-Reply-To: <20180117205435.2860-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: mstaudt@suse.de, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, philm@manjaro.org, bernhard.rosenkranzer@linaro.org, kernel.max@enpas.org

Also, mention this in the bootsplash documentation.

Signed-off-by: Max Staudt <mstaudt@suse.de>
---
 Documentation/bootsplash.rst       |  10 ++++++
 tools/bootsplash/.gitignore        |   3 ++
 tools/bootsplash/ajax-loader.gif   | Bin 0 -> 3208 bytes
 tools/bootsplash/bootsplash-tux.sh |  66 +++++++++++++++++++++++++++++++++=
++++
 4 files changed, 79 insertions(+)
 create mode 100644 tools/bootsplash/ajax-loader.gif
 create mode 100755 tools/bootsplash/bootsplash-tux.sh

diff --git a/Documentation/bootsplash.rst b/Documentation/bootsplash.rst
index b35aba5093e8..d4f132eca615 100644
--- a/Documentation/bootsplash.rst
+++ b/Documentation/bootsplash.rst
@@ -195,6 +195,16 @@ Hooks - how the bootsplash is integrated
=20
=20
=20
+Crating a bootsplash theme file
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+A simple tool for theme file creation is included in ``tools/bootsplash``.
+
+There is also an example shell script, as an example on how to use the tool
+and in order to generate a reference bootsplash file.
+
+
+
 FAQ: Frequently Asked Questions
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
diff --git a/tools/bootsplash/.gitignore b/tools/bootsplash/.gitignore
index 091b99a17567..5dfced41ba82 100644
--- a/tools/bootsplash/.gitignore
+++ b/tools/bootsplash/.gitignore
@@ -1 +1,4 @@
 bootsplash-packer
+bootsplash
+logo.rgb
+throbber*.rgb
diff --git a/tools/bootsplash/ajax-loader.gif b/tools/bootsplash/ajax-loade=
r.gif
new file mode 100644
index 0000000000000000000000000000000000000000..3288d1035d70bb86517e2c233f1=
a904e41f06b29
GIT binary patch
literal 3208
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
Bt<?Yk

literal 0
HcmV?d00001

diff --git a/tools/bootsplash/bootsplash-tux.sh b/tools/bootsplash/bootspla=
sh-tux.sh
new file mode 100755
index 000000000000..1078f87644b9
--- /dev/null
+++ b/tools/bootsplash/bootsplash-tux.sh
@@ -0,0 +1,66 @@
+#!/bin/bash
+#
+# A simple script to show how to create a bootsplash.
+# Do with it whatever you wish.
+#
+# This needs ImageMagick for the 'convert' and 'identify' tools.
+#
+
+LOGO=3D../../Documentation/logo.gif
+LOGO_WIDTH=3D$(identify $LOGO | cut -d " " -f 3 | cut -d x -f 1)
+LOGO_HEIGHT=3D$(identify $LOGO | cut -d " " -f 3 | cut -d x -f 2)
+
+THROBBER=3Dajax-loader.gif
+THROBBER_WIDTH=3D$(identify $THROBBER | head -1 | cut -d " " -f 3 | \
+						cut -d x -f 1)
+THROBBER_HEIGHT=3D$(identify $THROBBER | head -1 | cut -d " " -f 3 | \
+						 cut -d x -f 2)
+
+convert -alpha remove \
+	-background "#ff3a40" \
+	$LOGO \
+	logo.rgb
+
+convert -alpha remove \
+	-background "#ff3a40" \
+	$THROBBER \
+	throbber%02d.rgb
+
+
+make clean
+make bootsplash-packer
+
+
+# Let's put Tux in the center of an orange background.
+./bootsplash-packer \
+	--bg_red 0xff \
+	--bg_green 0x3a \
+	--bg_blue 0x40 \
+	--frame_ms 48 \
+	--picture \
+	--pic_width $LOGO_WIDTH \
+	--pic_height $LOGO_HEIGHT \
+	--pic_position 0 \
+	--blob logo.rgb \
+	--picture \
+	--pic_width $THROBBER_WIDTH \
+	--pic_height $THROBBER_HEIGHT \
+	--pic_position 0x14 \
+	--pic_position_offset 20 \
+	--pic_anim_type 1 \
+	--pic_anim_loop 0 \
+	--blob throbber00.rgb \
+	--blob throbber01.rgb \
+	--blob throbber02.rgb \
+	--blob throbber03.rgb \
+	--blob throbber04.rgb \
+	--blob throbber05.rgb \
+	--blob throbber06.rgb \
+	--blob throbber07.rgb \
+	--blob throbber08.rgb \
+	--blob throbber09.rgb \
+	--blob throbber10.rgb \
+	--blob throbber11.rgb \
+	bootsplash
+
+rm *.rgb
--=20
2.12.3


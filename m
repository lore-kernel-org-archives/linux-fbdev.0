From: "Justin P. Mattock" <justinmattock@gmail.com>
Date: Sun, 28 Mar 2010 17:43:30 +0000
Subject: [PATCH] Rename imacfb.txt to efifb.txt and change imacfb to efifb.
Message-Id: <1269798210-8664-1-git-send-email-justinmattock@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>

Rename imacfb.txt to efifb.txt since imacfb was moved to
efifb,and change imacfb to efifb.=20
Note:I used git rm for imacfb.txt, but
git renamed this file to efifb.txt after everything was said and
done, not sure if this is correct or not.


Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
---
 Documentation/fb/efifb.txt  |   31 +++++++++++++++++++++++++++++++
 Documentation/fb/imacfb.txt |   31 -------------------------------
 2 files changed, 31 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/fb/efifb.txt
 delete mode 100644 Documentation/fb/imacfb.txt

diff --git a/Documentation/fb/efifb.txt b/Documentation/fb/efifb.txt
new file mode 100644
index 0000000..a59916c
--- /dev/null
+++ b/Documentation/fb/efifb.txt
@@ -0,0 +1,31 @@
+
+What is efifb?
+=3D=3D=3D=3D=3D=3D=3D+
+This is a generic EFI platform driver for Intel based Apple computers.
+efifb is only for EFI booted Intel Macs.
+
+Supported Hardware
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+iMac 17"/20"
+Macbook
+Macbook Pro 15"/17"
+MacMini
+
+How to use it?
+=3D=3D=3D=3D=3D=3D=3D
+
+efifb does not have any kind of autodetection of your machine.
+You have to add the following kernel parameters in your elilo.conf:
+	Macbook :
+		video=EFifb:macbook
+	MacMini :
+		video=EFifb:mini
+	Macbook Pro 15", iMac 17" :
+		video=EFifb:i17
+	Macbook Pro 17", iMac 20" :
+		video=EFifb:i20
+
+--
+Edgar Hucek <gimli@dark-green.com>
diff --git a/Documentation/fb/imacfb.txt b/Documentation/fb/imacfb.txt
deleted file mode 100644
index 316ec9b..0000000
--- a/Documentation/fb/imacfb.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-
-What is imacfb?
-=3D=3D=3D=3D=3D=3D=3D-
-This is a generic EFI platform driver for Intel based Apple computers.
-Imacfb is only for EFI booted Intel Macs.
-
-Supported Hardware
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-iMac 17"/20"
-Macbook
-Macbook Pro 15"/17"
-MacMini
-
-How to use it?
-=3D=3D=3D=3D=3D=3D=3D
-
-Imacfb does not have any kind of autodetection of your machine.
-You have to add the following kernel parameters in your elilo.conf:
-	Macbook :
-		video=3Dimacfb:macbook
-	MacMini :
-		video=3Dimacfb:mini
-	Macbook Pro 15", iMac 17" :
-		video=3Dimacfb:i17
-	Macbook Pro 17", iMac 20" :
-		video=3Dimacfb:i20
-
---
-Edgar Hucek <gimli@dark-green.com>
--=20
1.6.5.GIT


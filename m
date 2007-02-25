From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/9] fbdev: Ignore VESA modes if
	framebuffer is disabled
Date: Sun, 25 Feb 2007 16:54:32 +0800
Message-ID: <1172393672.16179.33.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1115989527=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLFP4-00075W-0n for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 01:10:46 -0800
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HLFP3-0005hh-IU
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 01:10:45 -0800
Received: by py-out-1112.google.com with SMTP id a29so528629pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Feb 2007 01:10:45 -0800 (PST)
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


--===============1115989527==
Content-Type: multipart/alternative; boundary="=-ycRhf/UUNrb9jHHWhRp1"


--=-ycRhf/UUNrb9jHHWhRp1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

If the option vga=<VESA graphics mode> is added to the boot parameter, it will
activate graphics mode, but without any framebuffer support, the user is left
with an unusable display.

Change the behavior such that the user is instead prompted for another  mode
(ala vga=ask).

NOTE: People can always use vbetool to set a graphics mode if this is really
desired, but the number of people doing this approaches zero.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 arch/i386/boot/video.S   |    4 +++-
 arch/x86_64/boot/video.S |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/i386/boot/video.S b/arch/i386/boot/video.S
index 9101969..78573da 100644
--- a/arch/i386/boot/video.S
+++ b/arch/i386/boot/video.S
@@ -496,9 +496,11 @@ mode_set:
 	cmpb	$VIDEO_FIRST_V7>>8, %ah
 	jz	setv7
 	
+#ifdef CONFIG_FB
 	cmpb	$VIDEO_FIRST_VESA>>8, %ah
 	jnc	check_vesa
-	
+#endif
+		
 	orb	%ah, %ah
 	jz	setmenu
 	
diff --git a/arch/x86_64/boot/video.S b/arch/x86_64/boot/video.S
index 6af75a7..d58aa0b 100644
--- a/arch/x86_64/boot/video.S
+++ b/arch/x86_64/boot/video.S
@@ -496,9 +496,11 @@ mode_set:
 	cmpb	$VIDEO_FIRST_V7>>8, %ah
 	jz	setv7
 	
+#ifdef CONFIG_FB
 	cmpb	$VIDEO_FIRST_VESA>>8, %ah
 	jnc	check_vesa
-	
+#endif
+		
 	orb	%ah, %ah
 	jz	setmenu
 	


--=-ycRhf/UUNrb9jHHWhRp1
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.2">
</HEAD>
<BODY>
<PRE>
<!--+GtkHTML:<DATA class="ClueFlow" key="orig" value="0">-->If the option vga=&lt;VESA graphics mode&gt; is added to the boot parameter, it will
activate graphics mode, but without any framebuffer support, the user is left
with an unusable display.

Change the behavior such that the user is instead prompted for another&nbsp; mode
(ala vga=ask).

NOTE: People can always use vbetool to set a graphics mode if this is really
desired, but the number of people doing this approaches zero.

Signed-off-by: Antonino Daplas &lt;<A HREF="mailto:adaplas@pol.net">adaplas@pol.net</A>&gt;
---

 arch/i386/boot/video.S&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 4 +++-
 arch/x86_64/boot/video.S |&nbsp;&nbsp;&nbsp; 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/i386/boot/video.S b/arch/i386/boot/video.S
index 9101969..78573da 100644
--- a/arch/i386/boot/video.S
+++ b/arch/i386/boot/video.S
@@ -496,9 +496,11 @@ mode_set:
 	cmpb	$VIDEO_FIRST_V7&gt;&gt;8, %ah
 	jz	setv7
 	
+#ifdef CONFIG_FB
 	cmpb	$VIDEO_FIRST_VESA&gt;&gt;8, %ah
 	jnc	check_vesa
-	
+#endif
+		
 	orb	%ah, %ah
 	jz	setmenu
 	
diff --git a/arch/x86_64/boot/video.S b/arch/x86_64/boot/video.S
index 6af75a7..d58aa0b 100644
--- a/arch/x86_64/boot/video.S
+++ b/arch/x86_64/boot/video.S
@@ -496,9 +496,11 @@ mode_set:
 	cmpb	$VIDEO_FIRST_V7&gt;&gt;8, %ah
 	jz	setv7
 	
+#ifdef CONFIG_FB
 	cmpb	$VIDEO_FIRST_VESA&gt;&gt;8, %ah
 	jnc	check_vesa
-	
+#endif
+		
 	orb	%ah, %ah
 	jz	setmenu
 	

</PRE>
</BODY>
</HTML>

--=-ycRhf/UUNrb9jHHWhRp1--



--===============1115989527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1115989527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1115989527==--

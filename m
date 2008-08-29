From: Mike Pagano <mpagano@gentoo.org>
Subject: [PATCH] uvesafb: Document mode to mode_option
	parameter change
Date: Fri, 29 Aug 2008 19:01:49 -0400
Message-ID: <200808291901.49603.mpagano@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZCxz-0003oz-GL for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 16:01:19 -0700
Received: from [67.228.218.97] (helo=pima.mpagano.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KZCxy-0001Pl-3W
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 16:01:19 -0700
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: spock@gentoo.org

From: Mike Pagano <mpagano@gentoo.org>

Document the change from the old "mode" parameter to the "mode_option" parameter.

Signed-off-by: Mike Pagano <mpagano@gentoo.org>
---
--- a/Documentation/fb/uvesafb.txt  2008-08-29 18:25:54.000000000 -0400
+++ b/Documentation/fb/uvesafb.txt  2008-08-29 18:26:06.000000000 -0400
@@ -52,7 +52,7 @@ are either given on the kernel command l

  video=uvesafb:1024x768-32,mtrr:3,ywrap (compiled into the kernel)

- # modprobe uvesafb mode=1024x768-32 mtrr=3 scroll=ywrap  (module)
+ # modprobe uvesafb mode_option=1024x768-32 mtrr=3 scroll=ywrap  (module)

 Accepted options:

@@ -105,7 +105,7 @@ vtotal:n
 <mode>  The mode you want to set, in the standard modedb format.  Refer to
         modedb.txt for a detailed description.  When uvesafb is compiled as
         a module, the mode string should be provided as a value of the
-        'mode' option.
+        'mode_option' option.

 vbemode:x
         Force the use of VBE mode x.  The mode will only be set if it's

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

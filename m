From: Guillem Jover <guillem@debian.org>
Subject: [PATCH 6/7] fbset: fix build system
Date: Mon, 9 Oct 2006 05:49:52 +0300
Message-ID: <20061009024952.GF9011@zulo.hadrons.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4VrXvz3cwkc87Wze"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GWmgS-0004r9-QY for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 21:24:08 -0700
Received: from 159.red-81-184-118.user.auna.net ([81.184.118.159]
	helo=pulsar.hadrons.org)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GWmgR-0003eq-W3
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 21:24:08 -0700
Received: from guillem by pulsar.hadrons.org with local (Exim 4.50)
	id 1GWlFn-00069z-L3 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 04:52:31 +0200
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This one fixes the build system by splitting CFLAGS from CC so that
the user can override it from command-line, using DESTDIR so that it
can be installed in a staging area for packaging, splitting the device
creation from the install target and by using the "semi-standard"
INSTALL_foo variables.

Those changes are needed by distributions.

regards,
guillem

--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fbset_06_build.patch"

Index: Makefile
===================================================================
--- Makefile.orig	2006-10-09 04:46:54.000000000 +0300
+++ Makefile	2006-10-09 04:47:13.000000000 +0300
@@ -2,10 +2,14 @@
 # Linux Frame Buffer Device Configuration
 #
 
-CC =		gcc -Wall -O2 -I.
+CC =		gcc
+CFLAGS =	-Wall -O2
 BISON =		bison -d
 FLEX =		flex
 INSTALL =	install
+INSTALL_DIR =	$(INSTALL) -d
+INSTALL_PROGRAM = $(INSTALL) -m 755
+INSTALL_DATA =	$(INSTALL) -m 644
 RM =		rm -f
 
 All:		fbset
@@ -24,18 +28,26 @@ modes.tab.c:	modes.y
 		$(BISON) modes.y
 
 install:	fbset
-		if [ -f /sbin/fbset ]; then rm /sbin/fbset; fi
-		$(INSTALL) fbset /usr/sbin
-		$(INSTALL) fbset.8 /usr/man/man8
-		$(INSTALL) fb.modes.5 /usr/man/man5
-		if [ ! -c /dev/fb0 ]; then mknod /dev/fb0 c 29 0; fi
-		if [ ! -c /dev/fb1 ]; then mknod /dev/fb1 c 29 32; fi
-		if [ ! -c /dev/fb2 ]; then mknod /dev/fb2 c 29 64; fi
-		if [ ! -c /dev/fb3 ]; then mknod /dev/fb3 c 29 96; fi
-		if [ ! -c /dev/fb4 ]; then mknod /dev/fb4 c 29 128; fi
-		if [ ! -c /dev/fb5 ]; then mknod /dev/fb5 c 29 160; fi
-		if [ ! -c /dev/fb6 ]; then mknod /dev/fb6 c 29 192; fi
-		if [ ! -c /dev/fb7 ]; then mknod /dev/fb7 c 29 224; fi
+		$(INSTALL_DIR) $(DESTDIR)/etc
+		$(INSTALL_DATA) etc/fb.modes.ATI $(DESTDIR)/etc/fb.modes
+		$(INSTALL_DIR) $(DESTDIR)/usr/share/man/man5
+		$(INSTALL_DATA) fb.modes.5 $(DESTDIR)/usr/share/man/man5
+		$(INSTALL_DIR) $(DESTDIR)/bin
+		$(INSTALL_PROGRAM) fbset $(DESTDIR)/bin
+		$(INSTALL_DIR) $(DESTDIR)/usr/share/man/man1
+		$(INSTALL_DATA) fbset.8 $(DESTDIR)/usr/share/man/man1/fbset.1
+		$(INSTALL_PROGRAM) modeline2fb $(DESTDIR)/bin
+		$(INSTALL_DATA) modeline2fb.1 $(DESTDIR)/usr/share/man/man1
+
+install-devices:
+		if [ ! -c /dev/fb0 ]; then mknod $(DESTDIR)/dev/fb0 c 29 0; fi
+		if [ ! -c /dev/fb1 ]; then mknod $(DESTDIR)/dev/fb1 c 29 32; fi
+		if [ ! -c /dev/fb2 ]; then mknod $(DESTDIR)/dev/fb2 c 29 64; fi
+		if [ ! -c /dev/fb3 ]; then mknod $(DESTDIR)/dev/fb3 c 29 96; fi
+		if [ ! -c /dev/fb4 ]; then mknod $(DESTDIR)/dev/fb4 c 29 128; fi
+		if [ ! -c /dev/fb5 ]; then mknod $(DESTDIR)/dev/fb5 c 29 160; fi
+		if [ ! -c /dev/fb6 ]; then mknod $(DESTDIR)/dev/fb6 c 29 192; fi
+		if [ ! -c /dev/fb7 ]; then mknod $(DESTDIR)/dev/fb7 c 29 224; fi
 
 clean:
 		$(RM) *.o fbset lex.yy.c modes.tab.c modes.tab.h

--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--4VrXvz3cwkc87Wze--

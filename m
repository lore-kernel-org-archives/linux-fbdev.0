From: jsimmons@pentafluge.infradead.org
Subject: Re: Linux 2.6.7 (stty rows 50 columns 140 reports : No such device
 or address)
Date: Wed, 16 Jun 2004 17:37:42 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0406161728150.14901@pentafluge.infradead.org>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> 
 <20040616095805.GC14936@gemtek.lt>  <40D0432A.1080006@pobox.com>
 <1087395424.5314.2.camel@swoop.gemtek.lt>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BadQY-0004N4-MS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 09:38:18 -0700
Received: from [213.146.154.40] (helo=pentafluge.infradead.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BadQY-00029d-3j
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 09:38:18 -0700
In-Reply-To: <1087395424.5314.2.camel@swoop.gemtek.lt>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, David MacKenzie <djm@gnu.ai.mit.edu>


Actually its a bug in stty itself. stty only sets the row or column at a 
time. So when you do a stty row col it is actually doing TWO mode sets.
One to change the number of rows then another to change the number of 
columns. So to the fbdev driver it looks like this:

640x480 -> 1024x480 -> 1024x768

Now for alot of driver the middle setting doesn't work. So it fails. 
This bug also effects serial consoles as well. I CC the stty maintain so 
he can apply the below patch. It is against the latest GNU core utilites.
It fixes the issue.

--- stty.c.orig	2004-05-07 17:48:51.000000000 -0700
+++ stty.c	2004-05-07 18:00:36.000000000 -0700
@@ -733,6 +733,10 @@
   int speed_was_set;
   int verbose_output;
   int recoverable_output;
+#ifdef TIOCGWINSZ
+  int size_was_set = 0;
+  int cols, rows;
+#endif
   int k;
   int noargs = 1;
   char *file_name = NULL;
@@ -1004,8 +1008,8 @@
 		  usage (EXIT_FAILURE);
 		}
 	      ++k;
-	      set_window_size ((int) integer_arg (argv[k]), -1,
-			       fd, device_name);
+	      rows = integer_arg (argv[k]);
+	      size_was_set = 1;
 	    }
 	  else if (STREQ (argv[k], "cols")
 		   || STREQ (argv[k], "columns"))
@@ -1016,8 +1020,8 @@
 		  usage (EXIT_FAILURE);
 		}
 	      ++k;
-	      set_window_size (-1, (int) integer_arg (argv[k]),
-			       fd, device_name);
+	      cols = integer_arg (argv[k]);
+	      size_was_set = 1;	
 	    }
 	  else if (STREQ (argv[k], "size"))
 	    {
@@ -1063,6 +1067,12 @@
       k++;
     }
 
+#ifdef TIOCGWINSZ
+  if (size_was_set) 
+    {
+      set_window_size (rows, cols, fd, device_name);
+    }
+#endif
   if (require_set_attr)
     {
       struct termios new_mode;


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND

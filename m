From: Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [PATCH] small fix for aty128fb support on ia64
Date: Fri, 14 Mar 2003 13:48:27 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030314214827.GC1037@sgi.com>
References: <Pine.GSO.4.21.0303081540090.8221-100000@vervain.sonytel.be> <Pine.LNX.4.44.0303081510380.28479-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from rj.sgi.com ([192.82.208.96])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18tx2Y-0003B4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Mar 2003 13:48:34 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303081510380.28479-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Here's a patch I had to use on ia64.  The framebuffer worked nicely,
but it looks like X doesn't restore the state correctly when I switch
back to an fb console, so I just got a blank screen.

Maybe you can think of a better way to address the #ifdef issue, it
certainly looks bad...

Thanks,
Jesse


--- linux-2.5.64-ia64-sn/drivers/video/aty128fb.c	Tue Mar  4 19:29:18 2003
+++ linux-2.5.64-ia64/drivers/video/aty128fb.c	Fri Mar 14 12:12:19 2003
@@ -1448,7 +1448,10 @@
 			}
 		}
 #endif /* CONFIG_ALL_PPC */
+#if defined(CONFIG_PMAC_PBOOK) || defined(CONFIG_MTRR) || \
+    defined(CONFIG_ALL_PPC)
 		else
+#endif /* this is getting ugly */
 			mode_option = this_opt;
 	}
 	return 0;
@@ -1709,7 +1712,7 @@
 					"Guessing...\n");
 	else {
 		printk(KERN_INFO "aty128fb: Rage128 BIOS located at "
-				"segment %4.4X\n", (unsigned int)bios_seg);
+				"segment %4.4lX\n", (unsigned long)bios_seg);
 		aty128_get_pllinfo(par, bios_seg);
 	}
 #endif


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en

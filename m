From: Nicolas Boichat <nicolas@boichat.ch>
Subject: Re: Fw: Rivafb I2C problem, new patch
Date: Tue, 13 Jul 2004 23:46:35 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1089755194.6181.47.camel@tom>
References: <20040712163942.672d4047.akpm@osdl.org>
	 <200407130958.15483.adaplas@hotpop.com> <1089712381.6181.20.camel@tom>
	 <200407140452.49585.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xx0dA7ChZzboccNN3rJK"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BkV7Q-0006ui-RH
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jul 2004 14:47:20 -0700
Received: from b1.ovh.net ([213.186.33.51] helo=mail15.ha.ovh.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34)
	id 1BkV7Q-0001Zc-9U
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jul 2004 14:47:20 -0700
In-Reply-To: <200407140452.49585.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: adaplas@pol.net
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net


--=-xx0dA7ChZzboccNN3rJK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

Good idea... it didn't compile. Fixed patch attached.

Best regards,

Nicolas

On Tue, 2004-07-13 at 22:52, Antonino A. Daplas wrote:
> On Tuesday 13 July 2004 17:53, Nicolas Boichat wrote:
> > Hello,
> >
> > Thanks for your answers.
> >
> > I attached a new patch: I deleted the lines that were commented out.
> >
> 
> One thing I forgot, make sure it compiles when CONFIG_FB_RIVA_I2C is
> set or not.
> 
> Tony
> 
> 
> 

--=-xx0dA7ChZzboccNN3rJK
Content-Description: 
Content-Disposition: attachment; filename=riva-2.6.7-mm6-new2.patch
Content-Type: text/x-patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- fbdev.c.old	2004-07-13 02:05:47.000000000 +0200
+++ fbdev.c	2004-07-13 23:34:27.023199272 +0200
@@ -1773,7 +1773,6 @@
 	struct riva_par *par = (struct riva_par *) info->par;
 	int i;
 
-	riva_create_i2c_busses(par);
 	for (i = par->bus; i >= 1; i--) {
 		riva_probe_i2c_connector(par, i, &par->EDID);
 		if (par->EDID) {
@@ -1781,7 +1780,6 @@
 			break;
 		}
 	}
-	riva_delete_i2c_busses(par);
 #endif
 #endif
 }
@@ -1933,6 +1931,10 @@
 	}
 #endif /* CONFIG_MTRR */
 
+#ifdef CONFIG_FB_RIVA_I2C
+	riva_create_i2c_busses((struct riva_par *) info->par);
+#endif
+
 	info->fbops = &riva_fb_ops;
 	info->fix = rivafb_fix;
 	riva_get_EDID(info, pd);
@@ -1961,6 +1963,9 @@
 	return 0;
 
 err_out_iounmap_fb:
+#ifdef CONFIG_FB_RIVA_I2C
+	riva_delete_i2c_busses((struct riva_par *) info->par);
+#endif
 	iounmap(info->screen_base);
 err_out_free_base1:
 	if (default_par->riva.Architecture == NV_ARCH_03) 
@@ -1989,6 +1994,10 @@
 	if (!info)
 		return;
 
+#ifdef CONFIG_FB_RIVA_I2C
+	riva_delete_i2c_busses(par);
+#endif
+
 	unregister_framebuffer(info);
 #ifdef CONFIG_MTRR
 	if (par->mtrr.vram_valid)

--=-xx0dA7ChZzboccNN3rJK--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

From: Nicolas Boichat <nicolas@boichat.ch>
Subject: Re: Fw: Rivafb I2C problem, new patch
Date: Wed, 14 Jul 2004 01:45:54 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1089762354.6185.53.camel@tom>
References: <20040712163942.672d4047.akpm@osdl.org>
	 <200407130958.15483.adaplas@hotpop.com> <1089712381.6181.20.camel@tom>
	 <200407140452.49585.adaplas@hotpop.com> <1089755194.6181.47.camel@tom>
	 <20040713150235.056f6a5c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-AXY3FFOJOhNdZk9usG/a"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BkWyi-000310-1U
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jul 2004 16:46:28 -0700
Received: from b1.ovh.net ([213.186.33.51] helo=mail15.ha.ovh.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34)
	id 1BkWyh-0003LF-F3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jul 2004 16:46:27 -0700
In-Reply-To: <20040713150235.056f6a5c.akpm@osdl.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, greg@kroah.com, linux-fbdev-devel@lists.sourceforge.net


--=-AXY3FFOJOhNdZk9usG/a
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

This should be the last patch, the changelog is at the beginning of the
file.

Best regards,

Nicolas

On Wed, 2004-07-14 at 00:02, Andrew Morton wrote:
> Nicolas Boichat <nicolas@boichat.ch> wrote:
> >
> > Good idea... it didn't compile. Fixed patch attached.
> 
> Please send a complete new patch, with a changelog.
> 
> Thanks.
> 

--=-AXY3FFOJOhNdZk9usG/a
Content-Disposition: attachment; filename=rivafb-i2c-bus-fix.patch
Content-Type: text/x-patch; name=rivafb-i2c-bus-fix.patch
Content-Transfer-Encoding: 7bit

From: Nicolas Boichat <nicolas@boichat.ch>

The I2C busses opened by rivafb were deleted immediately after
reading the EDID, but they should be kept open, so user-space
applications can use them.

They are now deleted when the driver is unloaded.

---

 linux/drivers/video/riva/fbdev.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff -puN linux/drivers/video/riva/fbdev.c.old  linux/drivers/video/riva/fbdev.c
--- linux/drivers/video/riva/fbdev.c.old	2004-07-13 02:05:47.000000000 +0200
+++ linux/drivers/video/riva/fbdev.c	2004-07-13 23:34:27.023199272 +0200
@@ -1773,7 +1773,6 @@ static void riva_get_EDID(struct fb_info
 	struct riva_par *par = (struct riva_par *) info->par;
 	int i;
 
-	riva_create_i2c_busses(par);
 	for (i = par->bus; i >= 1; i--) {
 		riva_probe_i2c_connector(par, i, &par->EDID);
 		if (par->EDID) {
@@ -1781,7 +1780,6 @@ static void riva_get_EDID(struct fb_info
 			break;
 		}
 	}
-	riva_delete_i2c_busses(par);
 #endif
 #endif
 }
@@ -1933,6 +1931,10 @@ static int __devinit rivafb_probe(struct
 	}
 #endif /* CONFIG_MTRR */
 
+#ifdef CONFIG_FB_RIVA_I2C
+	riva_create_i2c_busses((struct riva_par *) info->par);
+#endif
+
 	info->fbops = &riva_fb_ops;
 	info->fix = rivafb_fix;
 	riva_get_EDID(info, pd);
@@ -1961,6 +1963,9 @@ static int __devinit rivafb_probe(struct
 	return 0;
 
 err_out_iounmap_fb:
+#ifdef CONFIG_FB_RIVA_I2C
+	riva_delete_i2c_busses((struct riva_par *) info->par);
+#endif
 	iounmap(info->screen_base);
 err_out_free_base1:
 	if (default_par->riva.Architecture == NV_ARCH_03) 
@@ -1989,6 +1994,10 @@ static void __exit rivafb_remove(struct 
 	if (!info)
 		return;
 
+#ifdef CONFIG_FB_RIVA_I2C
+	riva_delete_i2c_busses(par);
+#endif
+
 	unregister_framebuffer(info);
 #ifdef CONFIG_MTRR
 	if (par->mtrr.vram_valid)

--=-AXY3FFOJOhNdZk9usG/a--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

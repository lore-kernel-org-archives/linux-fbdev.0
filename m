From: Nicolas Boichat <nicolas@boichat.ch>
Subject: Re: Fw: Rivafb I2C problem, new patch
Date: Tue, 13 Jul 2004 11:53:01 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1089712381.6181.20.camel@tom>
References: <20040712163942.672d4047.akpm@osdl.org>
	 <200407130958.15483.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1nrWELDwKAKgamQM1gj4"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BkJys-00053w-Sa
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jul 2004 02:53:46 -0700
Received: from b1.ovh.net ([213.186.33.51] helo=mail15.ha.ovh.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34)
	id 1BkJys-0002uO-9o
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jul 2004 02:53:46 -0700
In-Reply-To: <200407130958.15483.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: adaplas@pol.net, Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net


--=-1nrWELDwKAKgamQM1gj4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

Thanks for your answers.

I attached a new patch: I deleted the lines that were commented out.

Best regards,

Nicolas

On Tue, 2004-07-13 at 03:58, Antonino A. Daplas wrote:
> I'm not the maintainer of rivafb but I added the DDC2 support for it. The bus
> was destroyed because there was no use for it after reading the EDID block,
> and fbdev has no interface (yet) to re-read it again.
> 
> It doesn't matter to me whether the bus is immediately deleted or not, so the
> patch is fine by me.
> 
> Tony 

On Tue, 2004-07-13 at 01:43, Greg KH wrote: 
> Well, you shouldn't comment out those calls, just delete them.
> 
> Other than that, from an i2c standpoint, the patch looks sane, but I
> would check with the maintainer, as there might be some reason they
> delete the bus right after using it.
> 
> thanks,
> 
> greg k-h

--=-1nrWELDwKAKgamQM1gj4
Content-Description: 
Content-Disposition: attachment; filename=riva-2.6.7-mm6-new.patch
Content-Type: text/x-patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- linux/drivers/video/riva/fbdev.c.old	2004-07-13 02:05:47.029754640 +0200
+++ linux/drivers/video/riva/fbdev.c	2004-07-13 02:08:25.945966745 +0200
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
@@ -1933,6 +1931,8 @@
 	}
 #endif /* CONFIG_MTRR */
 
+	riva_create_i2c_busses((struct riva_par *) info->par);
+
 	info->fbops = &riva_fb_ops;
 	info->fix = rivafb_fix;
 	riva_get_EDID(info, pd);
@@ -1961,6 +1961,7 @@
 	return 0;
 
 err_out_iounmap_fb:
+	riva_delete_i2c_busses((struct riva_par *) info->par);
 	iounmap(info->screen_base);
 err_out_free_base1:
 	if (default_par->riva.Architecture == NV_ARCH_03) 
@@ -1989,6 +1990,8 @@
 	if (!info)
 		return;
 
+	riva_delete_i2c_busses(par);
+
 	unregister_framebuffer(info);
 #ifdef CONFIG_MTRR
 	if (par->mtrr.vram_valid)

--=-1nrWELDwKAKgamQM1gj4--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

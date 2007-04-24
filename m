From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Console unregistration questions
Date: Tue, 24 Apr 2007 14:59:29 -0700
Message-ID: <200704241459.29297.jbarnes@virtuousgeek.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgT2z-0005Ya-C3 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Apr 2007 14:59:41 -0700
Received: from outbound-mail-07.bluehost.com ([69.89.17.207])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HgT2y-0000Rr-1d
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Apr 2007 14:59:41 -0700
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
Cc: Dave Airlie <airlied@linux.ie>, Jakob Bornecrantz <wallbraker@gmail.com>

In doing the DRM modesetting work, we've been using the FB layer to manage 
regular FB devices and provide a DRM based console to the user (iow DRM 
owns the PCI device but the FB layer is used as a console and to provide 
the familiar /dev/fb interface to existing software).

However, in doing development we noticed that when we remove the new DRM 
based fb driver, our machines tend to hang.  This appears to be due to 
bugs in console unregistration.

The DRM fb driver's cleanup routine is normal, I think:

int drmfb_remove(struct drm_device *dev, struct drm_framebuffer *fb)
{
	struct fb_info *info = fb->fbdev;
	
	unregister_framebuffer(info);
	framebuffer_release(info);
	/* Unmap framebuffer */
	drm_mem_reg_iounmap(dev, &fb->bo->mem, fb->virtual_base);

	return 0;
}

But since we're using drmfb as a console, the unregister_framebuffer call 
silently fails.  fbcon is builtin to the kernel, so when drmfb exits, 
unregister_framebuffer will end up calling fbcon's fbcon_fb_unregistered() 
function via the notifier chain.  However, when fbcon_fb_unregistered 
calls unregister_con_driver(&fb_con) it ignores the return value, which is 
bad since unregister_con_driver left fbcon's routines active (due to fbcon 
still being bound to the console) even while unregister_framebuffer freed 
their underlying structures.  So when unregister_framebuffer returns, the 
very next console operation causes an oops or worse (I usually see 
hide_cursor->fbcon_cursor die when it tries to get at info->fbcon_par).

However, it doesn't appear that there's a way for fb drivers to unbind 
themselves from the console at unload time, so we have to do it manually.  
Should there be a way to unbind it from driver code?  Maybe by exporting a 
wrapper to unbind_con_driver?  Also, shouldn't callers of 
unregister_con_driver be checking return values?  That would have made 
this bug a lot easier to find at least. :)

Thanks,
Jesse

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

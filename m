From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/3] fbdev: Add framebuffer and
 display update module support for pnx4008
Date: Fri, 30 Jun 2006 20:46:01 -0700
Message-ID: <20060630204601.4f442641.akpm@osdl.org>
References: <44A51257.10804@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FwWQo-0005HC-DO for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 20:46:06 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1FwWQn-0005rZ-55
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 20:46:06 -0700
In-Reply-To: <44A51257.10804@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, gtolstolytkin@ru.mvista.com

+EXPORT_SYMBOL(pnx4008_get_fb_addresses);
+EXPORT_SYMBOL(pnx4008_alloc_dum_channel);
+EXPORT_SYMBOL(pnx4008_free_dum_channel);
+EXPORT_SYMBOL(pnx4008_put_dum_channel_uf);
+EXPORT_SYMBOL(pnx4008_set_dum_channel_sync);
+EXPORT_SYMBOL(pnx4008_set_dum_channel_dirty_detect);
+EXPORT_SYMBOL(pnx4008_get_dum_channel_uf);
+EXPORT_SYMBOL(pnx4008_get_dum_channel_config);
+EXPORT_SYMBOL(pnx4008_force_update_dum_channel);
+EXPORT_SYMBOL(pnx4008_sdum_mmap);
+EXPORT_SYMBOL(pnx4008_set_dum_exit_notification);

Are these all needed??

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

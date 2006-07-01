From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/3] fbdev: Add framebuffer and
 display update module support for pnx4008
Date: Sat, 01 Jul 2006 13:02:09 +0800
Message-ID: <44A601D1.5070107@gmail.com>
References: <44A51257.10804@gmail.com> <20060630204601.4f442641.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FwXcg-0002p6-Gu for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 22:02:26 -0700
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FwXcd-0006N0-V5
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 22:02:26 -0700
Received: by py-out-1112.google.com with SMTP id d42so915533pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 30 Jun 2006 22:02:22 -0700 (PDT)
In-Reply-To: <20060630204601.4f442641.akpm@osdl.org>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, gtolstolytkin@ru.mvista.com

Andrew Morton wrote:
> +EXPORT_SYMBOL(pnx4008_get_fb_addresses);
> +EXPORT_SYMBOL(pnx4008_alloc_dum_channel);
> +EXPORT_SYMBOL(pnx4008_free_dum_channel);
> +EXPORT_SYMBOL(pnx4008_put_dum_channel_uf);
> +EXPORT_SYMBOL(pnx4008_set_dum_channel_sync);
> +EXPORT_SYMBOL(pnx4008_set_dum_channel_dirty_detect);
> +EXPORT_SYMBOL(pnx4008_get_dum_channel_uf);
> +EXPORT_SYMBOL(pnx4008_get_dum_channel_config);
> +EXPORT_SYMBOL(pnx4008_force_update_dum_channel);
> +EXPORT_SYMBOL(pnx4008_sdum_mmap);
> +EXPORT_SYMBOL(pnx4008_set_dum_exit_notification);
> 

The unused exports are enclosed with #if 0/#endif. That was before
EXPORT_SYMBOL_UNUSED went in.

The reason why I asked him if sdum and pnxrgbfb need to be
separate modules. But the intent was to write another driver that
will also use the sdum module.

Tony

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

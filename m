From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 01/17] OMAP: Add TI OMAP framebuffer
	driver
Date: Wed, 27 Jun 2007 14:14:08 +0530
Message-ID: <5d5443650706270144l2d905d2h142617d01f515785@mail.gmail.com>
References: <5d5443650706260533r218c05b1u5d4336015c4a4a9b@mail.gmail.com>
	<20070626165003.GA22389@uranus.ravnborg.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I3T8D-0008QG-EO for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Jun 2007 01:44:09 -0700
Received: from wa-out-1112.google.com ([209.85.146.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I3T8D-0003EL-3K
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Jun 2007 01:44:09 -0700
Received: by wa-out-1112.google.com with SMTP id k22so129777waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 27 Jun 2007 01:44:08 -0700 (PDT)
In-Reply-To: <20070626165003.GA22389@uranus.ravnborg.org>
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
To: Sam Ravnborg <sam@ravnborg.org>
Cc: juha.yrjola@solidboot.com, imre.deak@solidboot.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Hi Sam,

On 6/26/07, Sam Ravnborg <sam@ravnborg.org> wrote:
> diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
> new file mode 100644
> index 0000000..5aa7175
> --- /dev/null
> +++ b/drivers/video/omap/Makefile
> @@ -0,0 +1,10 @@
> +#
> +# Makefile for the new OMAP framebuffer device driver
> +#
> +
> +obj-$(CONFIG_FB_OMAP) += omapfb.o
> +
> +objs-yy := omapfb_main.o
> +
> +omapfb-objs := $(objs-yy)
> +
>
> This looks strangs.
> Please use:
> obj-$(CONFIG_FB_OMAP) += omapfb.o
>
> omapfb-y := omapfb_main.o
>
> Or even better rename your .c file to omapfb.c then
> you only need to use:
> obj-$(CONFIG_FB_OMAP) += omapfb.o
>

Thanx for the review. I will incorporate your suggestions into the
next update of fb patches.

-- 
--Trilok Soni

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

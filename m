From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] radeonfb: Fix debug option
Date: Wed, 13 Feb 2008 07:57:15 +1100
Message-ID: <1202849835.7410.13.camel@pasglop>
References: <20080212102347.6dd7f673@hyperion.delvare>
Reply-To: benh@kernel.crashing.org,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JP2CD-0008Jv-5D for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Feb 2008 12:57:50 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1/uzYRg74LqEjby2dxleH/0f4Zn0RqmrnQ=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JP2CB-0008Rn-0Z
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Feb 2008 12:57:41 -0800
In-Reply-To: <20080212102347.6dd7f673@hyperion.delvare>
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
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


On Tue, 2008-02-12 at 10:23 +0100, Jean Delvare wrote:
> Fix CONFIG_FB_RADEON_DEBUG. DEBUG must be defined before including any
> kernel header, otherwise dev_dbg() resolves to a no-op. Also, when
> debugging is disabled, don't set DEBUG at all instead of setting it to
> 0, to comply with what the kernel headers expect.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Ack.

> ---
> This patch was already sent on:
>  * 2007-11-17
> 
>  drivers/video/aty/radeon_base.c    |    3 ++-
>  drivers/video/aty/radeon_i2c.c     |    3 ++-
>  drivers/video/aty/radeon_monitor.c |    2 +-
>  drivers/video/aty/radeonfb.h       |   12 +++++-------
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> --- linux-2.6.24-rc3.orig/drivers/video/aty/radeonfb.h	2007-10-24 09:59:48.000000000 +0200
> +++ linux-2.6.24-rc3/drivers/video/aty/radeonfb.h	2007-11-17 14:25:49.000000000 +0100
> @@ -1,6 +1,10 @@
>  #ifndef __RADEONFB_H__
>  #define __RADEONFB_H__
>  
> +#ifdef CONFIG_FB_RADEON_DEBUG
> +#define DEBUG		1
> +#endif
> +
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
> @@ -367,13 +371,7 @@ struct radeonfb_info {
>  /*
>   * Debugging stuffs
>   */
> -#ifdef CONFIG_FB_RADEON_DEBUG
> -#define DEBUG		1
> -#else
> -#define DEBUG		0
> -#endif
> -
> -#if DEBUG
> +#ifdef DEBUG
>  #define RTRACE		printk
>  #else
>  #define RTRACE		if(0) printk
> --- linux-2.6.24-rc3.orig/drivers/video/aty/radeon_base.c	2007-10-24 09:59:48.000000000 +0200
> +++ linux-2.6.24-rc3/drivers/video/aty/radeon_base.c	2007-11-17 14:35:06.000000000 +0100
> @@ -52,6 +52,8 @@
>  
>  #define RADEON_VERSION	"0.2.0"
>  
> +#include "radeonfb.h"
> +
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/kernel.h>
> @@ -91,7 +93,6 @@
>  
>  #include "../edid.h" // MOVE THAT TO include/video
>  #include "ati_ids.h"
> -#include "radeonfb.h"		    
>  
>  #define MAX_MAPPED_VRAM	(2048*2048*4)
>  #define MIN_MAPPED_VRAM	(1024*768*1)
> --- linux-2.6.24-rc3.orig/drivers/video/aty/radeon_i2c.c	2007-11-17 10:54:30.000000000 +0100
> +++ linux-2.6.24-rc3/drivers/video/aty/radeon_i2c.c	2007-11-17 14:34:47.000000000 +0100
> @@ -1,3 +1,5 @@
> +#include "radeonfb.h"
> +
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
> @@ -11,7 +13,6 @@
>  #include <asm/io.h>
>  
>  #include <video/radeon.h>
> -#include "radeonfb.h"
>  #include "../edid.h"
>  
>  static void radeon_gpio_setscl(void* data, int state)
> --- linux-2.6.24-rc3.orig/drivers/video/aty/radeon_monitor.c	2007-10-10 09:57:39.000000000 +0200
> +++ linux-2.6.24-rc3/drivers/video/aty/radeon_monitor.c	2007-11-17 15:17:02.000000000 +0100
> @@ -481,7 +481,7 @@ void __devinit radeon_probe_screens(stru
>  		
>  		RTRACE("Starting monitor auto detection...\n");
>  
> -#if DEBUG && defined(CONFIG_FB_RADEON_I2C)
> +#if defined(DEBUG) && defined(CONFIG_FB_RADEON_I2C)
>  		{
>  			u8 *EDIDs[4] = { NULL, NULL, NULL, NULL };
>  			int mon_types[4] = {MT_NONE, MT_NONE, MT_NONE, MT_NONE};
> 
> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

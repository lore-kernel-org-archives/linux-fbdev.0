From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: vga16fb doesn't build on
	powerpc	(vgacon_remap_base)
Date: Wed, 17 Oct 2007 05:31:54 +0800
Message-ID: <1192570314.15588.11.camel@daplas>
References: <20071016191403.GA5962@nineveh.local>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ihu1H-0003Hs-3i for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 16 Oct 2007 14:32:09 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ihu1D-0003nU-DC
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 16 Oct 2007 14:32:05 -0700
Received: by py-out-1112.google.com with SMTP id a25so4030783pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 16 Oct 2007 14:32:02 -0700 (PDT)
In-Reply-To: <20071016191403.GA5962@nineveh.local>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>

On Tue, 2007-10-16 at 15:14 -0400, Joseph Fannin wrote:
> vga16fb is an available config option on powerpc, but it won't link
> with my .config:
> 
>     ERROR: "vgacon_remap_base" [drivers/video/vga16fb.ko] undefined!
> 
> 
> I'm guessing this is because include/asm-powerpc/vga.h declares
> vgacon_remap_base: 
> 
>     extern unsigned long vgacon_remap_base;
> 
> 
> ...but arch/powerpc/kernel/setup_32.c wraps the definition in an #ifdef:
> 
>     #ifdef CONFIG_VGA_CONSOLE

Perhaps #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_FB_VGA16) ?

or

bool VGA_HARDWARE

#if CONFIG_VGA_HARDWARE
    unsigned long vgacon_remap_base;
    EXPORT_SYMBOL(vgacon_remap_base);
#endif

and for the Kconfig entry of vgacon and vga16fb

select VGA_HARDWARE if PPC32
(or depends on (VGA_HARDWARE && PPC32))

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/

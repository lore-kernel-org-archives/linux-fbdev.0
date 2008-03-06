From: "Scott D. Davilla" <davilla@4pi.com>
Subject: Re: reguest for comments regarding an imac_fb
 and efifb unification
Date: Thu, 6 Mar 2008 15:37:33 -0500
Message-ID: <p0623091cc3f5f9111ec0@[192.168.9.5]>
References: <p0623091ac3f5e718e844@[192.168.9.5]>
	<Pine.LNX.4.64.0803062038100.26657@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JXMrD-0002OD-M8 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Mar 2008 12:38:27 -0800
Received: from mx.4pi.com ([24.172.19.59])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JXMrC-0004kU-9J
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Mar 2008 12:38:27 -0800
Received: from [192.168.9.5] (rbl.4pi.com [24.172.19.62])
	by mx.4pi.com (Postfix) with ESMTP id 4D44C3A32349
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu,  6 Mar 2008 15:38:18 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0803062038100.26657@anakin>
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
To: Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

>  > Which brings up the point, is there another more general console
>>  frame buffer that could replace both imac_fb and efifb? It seems that
>>  a generic console framebuffer that assumes a linear video framebuffer
>>  that does not make video bios calls (nor PC bios) and can be
>>  configured by screen_info params or command-line params would be
>>  something that already exists? Is there such a console frame buffer?
>>
>>  I'm willing to pursue this but I want to check the general consensus
>>  about such a venture and possible ramifications that I might not have
>>  considered.
>
>There exist a few more drivers for simple linear video frame buffer
>devices with fixed x,y dimensions:
>   - offb, for Open Firmware based machines,
>   - vesafb, for VBE 2.0 compliant graphic boards.

vesafb would be nice but there is an implied VBE 2.0 compliance which 
includes video bios. I'll force my bootloader to vesafb and see how 
far it gets.

Speaking of VGA, orig_video_isVGA is nicely defined in 
include/linux/screen_info.h along with different values 
(VIDEO_TYPE_MDA to VIDEO_TYPE_EFI) but I've seen other usages where 
orig_video_isVGA is set to zero or one.

This usage is not define in screen_info.h? drivers/char/vga.c uses a 
zero to imply VIDEO_TYPE_EGAC otherwise some type of vga. kexec 
(userland) uses it to imply undefined vga.

As far as I can tell there is no real definition of orig_video_isVGA 
= 0 or orig_video_isVGA = 1 in the code. I crash and burn if 
orig_video_isVGA = 1. What's the story on this?

Scott


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

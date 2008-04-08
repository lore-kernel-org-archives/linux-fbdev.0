From: "arun c" <arun.edarath@gmail.com>
Subject: Re: How to implement rotation for framebuffer?
Date: Tue, 8 Apr 2008 10:33:36 +0530
Message-ID: <c656a4d20804072203u1073a348ob7c167a88956f39e@mail.gmail.com>
References: <c656a4d20804040202g370948e2pa4d70b1f693df2cd@mail.gmail.com>
	<Pine.LNX.4.64.0804041230490.24006@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jj5zd-0001SS-3i for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Apr 2008 22:03:37 -0700
Received: from yw-out-1718.google.com ([74.125.46.154])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jj5zc-0006lB-PH
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Apr 2008 22:03:37 -0700
Received: by yw-out-1718.google.com with SMTP id 4so302398ywq.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 07 Apr 2008 22:03:36 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0804041230490.24006@anakin>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

On Fri, Apr 4, 2008 at 4:04 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, 4 Apr 2008, arun c wrote:
>  > I am working on 2430SDP. SDP has omap2430 as the processor and it's
>  > display controller supports rotation of framebuffer in hardware.
>  >
>  > I will explain the hardware rotation in brief.
>  >
>  > 1) One Physical framebuffer is allocated in memory
>  > 2) This physical address ( as well as width and height) is programmed in the
>  >     VRFB Module (the hardware rotation engine, it stands for virtual rotated
>  >     frame buffer)
>  > 3)Then VRFB gives you 4 addresses ( virtual addresses which are
>  > transparent to applications)
>  >     VBA0      --> Address for 0 degree rotation
>  >     VBA90    --> Address for 90 degree rotation
>  >     VBA180  --> Address for 180 degree rotation
>  >     VBA270  --> Address for 270 degree rotation
>  >
>  > Rotation is achieved like this
>  > Assume you want 90 degree rotation
>  >
>  > Processor writes all picture data to VBA90 space and lcd reads all
>  > data from VBA0 space
>  >
>  > For this kind of implementation i need to change fb_fix_screeninfo
>  > members (smem_start ,smem_len) and fb_info member( screen_base)
>  > dynamically according to degree of rotation.
>
>  Yep, that's correct.
>
>
>  > Please anybody suggest me  good ways to implement this kind of
>  > rotation in my driver or point me to some code so that i can refer and
>  > implement the same.
>
>  Very simple: any change of struct fb_var_screeninfo may cause a change
>  of fb_fix_screeninfo.
>
>  Hence if an application requests to change the rotation angle by
>  changing fb_var_screeninfo.rotate and issuing an FBIOPUT_VSCREENINFO
>  ioctl, you update your fb_fix_screeninfo and fb_info.screen_base.

I was thinking this kind of implementation is not permissible ( I am
very much ignorant about fbdev applications), because i thought
dynamically changing these structure members make applications to
brake.

Could anybody  please suggest me some example code to refer?

Regards,
Arun C


>
>  Gr{oetje,eeting}s,
>
>                                                 Geert

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone

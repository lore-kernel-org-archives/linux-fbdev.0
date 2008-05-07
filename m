From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: pxafb and am200epd question
Date: Wed, 7 May 2008 11:07:53 -0400
Message-ID: <45a44e480805070807x7be5da5q632da9c25c66139a@mail.gmail.com>
References: <45a44e480805060505r2b280717p60d0046e083adf98@mail.gmail.com>
	<E913911567467945BBEB9277E27868B0C1C3CB@msiexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtlFb-0007vx-Mo for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 08:08:12 -0700
Received: from wf-out-1314.google.com ([209.85.200.175])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JtlFQ-0002Ig-NB
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 08:08:06 -0700
Received: by wf-out-1314.google.com with SMTP id 27so303336wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 07 May 2008 08:07:53 -0700 (PDT)
In-Reply-To: <E913911567467945BBEB9277E27868B0C1C3CB@msiexch01.marvell.com>
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
To: Eric Miao <ymiao3@marvell.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, May 6, 2008 at 9:14 PM, Eric Miao <ymiao3@marvell.com> wrote:
>
>  In a long run, I guess the most critical dependency of metronomefb on
>  pxafb is the video memory, while pxafb currently allocates its own
>  video memory (correct me if my understanding is wrong).  For such case
>  pxafb.c should really be modified where its platform data can specify
>  customized video memory location. I'm not sure if this satisfy your
>  requirement.

Hi Eric,

I think you are right. I can make modifications to accommodate this so
that am200epd doesn't result in allocation of its own physical
framebuffer. Here's what I am thinking:

a) am200epd will use set_pxa_fb_info and pxafb_mach_info to pass pxafb
information about modes that it wants. It can pass desired LCCR0..3
settings through the lccr0,1,2,3 entries in pxafb_mach_info.
b) am200epd will find out from metronomefb about the size of the
waveform area that it needs in the framebuffer. It can do this before
it calls set_pxa_fb_info. We can add an entry to pxafb_mach_info like
extra_video_mem. Then pxafb can add that to the calculation of
map_size so that the allocated framebuffer is suitable for am200epd.
c) am200epd will need a way to get access to pxafb's map_cpu. This is
the part that I'm unsure about. Maybe we can add a callback function
entry in pxafb_mach_info that will be called by pxafb once it has
allocated a framebuffer.

Let me know if this sounds reasonable, especially on part c. If you
like it, I will be happy to start writing a patch to do this.

>
>  And indeed what am200epd.c is doing looks quite platform specific, which
>  means it's better to move them into some kind of <platform>.c, and note
>  that manipulating GPARx/GPSRx/GPLRx directly is no longer recommended :)
>

Agreed. I intend to remove that code and switch to the new gpio stuff.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone

From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: fbcon woes with closed source framebuffer
 kernel module
Date: Mon, 19 Sep 2005 07:03:04 +0800
Message-ID: <432DF228.8080206@gmail.com>
References: <196b7d3105091606241b4d2ba4@mail.gmail.com> <196b7d310509160927584f8130@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EH8CC-0005aw-Cd
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Sep 2005 16:03:40 -0700
Received: from zproxy.gmail.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EH8CB-0000T8-F7
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Sep 2005 16:03:40 -0700
Received: by zproxy.gmail.com with SMTP id i11so1007031nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 18 Sep 2005 16:03:33 -0700 (PDT)
In-Reply-To: <196b7d310509160927584f8130@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Lior Balkohen wrote:
 > i don't think so:
> 
> nm head.ko | grep pfb
> 000125bc t pfb_check_var
> 00003a28 d pfb_default
> 00000000 t pfb_fix
> 00012c50 t pfb_pan_display
> 0001edb0 b pfb_pseudo_palette
> 00012798 t pfb_set_par
> 00012af4 t pfb_setcolreg


That's okay, it's probably using the generic functions, cfb_imageblit,
cfb_copyarea, and cfb_fillrect. Check lsmod, or grep for imageblit,
copyarea and fillrect.

> 
>> Check the output of fbset -i and post it here.
> 
> /tmp > ./fbset -i
> 
> mode "720x576-171"
>     # D: 50.000 MHz, H: 54.825 kHz, V: 170.793 Hz
>     geometry 720 576 720 576 8
>     timings 20000 64 64 32 32 64 2
>     laced true
>     rgba 8/16,8/8,8/0,8/24
> endmode
> 
> Frame buffer device information:
>     Name        : Pallas FB
>     Address     : 0xa0901000
>     Size        : 2093056
>     Type        : PACKED PIXELS
>     Visual      : PSEUDOCOLOR
>     XPanStep    : 1
>     YPanStep    : 1
>     YWrapStep   : 1
>     LineLength  : 720
>     Accelerator : No
> 

I don't think this is correct.  It describes RGBA8888 as
pseudocolor (indexed palette).  Try doing an fbset -depth 8
and check the fbset -i output again.  

Tony


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

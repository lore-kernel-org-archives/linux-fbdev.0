From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: fbcon woes with closed source framebuffer
 kernel module
Date: Mon, 19 Sep 2005 17:55:14 +0800
Message-ID: <432E8B02.8000003@gmail.com>
References: <196b7d3105091606241b4d2ba4@mail.gmail.com> <196b7d310509160927584f8130@mail.gmail.com> <432DF228.8080206@gmail.com> <Pine.LNX.4.62.0509190830180.10300@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHINU-0003qt-RZ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Sep 2005 02:56:00 -0700
Received: from zproxy.gmail.com ([64.233.162.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EHINU-0006eV-JI
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Sep 2005 02:56:01 -0700
Received: by zproxy.gmail.com with SMTP id i11so1095799nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Sep 2005 02:55:54 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0509190830180.10300@numbat.sonytel.be>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

Geert Uytterhoeven wrote:
> On Mon, 19 Sep 2005, Antonino A. Daplas wrote:
>> Lior Balkohen wrote:
>>> /tmp > ./fbset -i
>>>
>>> mode "720x576-171"
>>>     # D: 50.000 MHz, H: 54.825 kHz, V: 170.793 Hz
>>>     geometry 720 576 720 576 8
>>>     timings 20000 64 64 32 32 64 2
>>>     laced true
>>>     rgba 8/16,8/8,8/0,8/24
>>> endmode
>>>
>>> Frame buffer device information:
>>>     Name        : Pallas FB
>>>     Address     : 0xa0901000
>>>     Size        : 2093056
>>>     Type        : PACKED PIXELS
>>>     Visual      : PSEUDOCOLOR
>>>     XPanStep    : 1
>>>     YPanStep    : 1
>>>     YWrapStep   : 1
>>>     LineLength  : 720
>>>     Accelerator : No
>> I don't think this is correct.  It describes RGBA8888 as
>> pseudocolor (indexed palette).  Try doing an fbset -depth 8
>> and check the fbset -i output again.  
> 
> But the depth is already 8. And this matches with the LineLength and
> xres_virtual.
> 
> Probably only the rgba bitfields are incorrect.

Yes, but in pseudocolor, the pseudo_palette is not read, so what is
being written to the fb memory are colors 0-15 (which in 32-bit
truecolor will be very light blue on black. This is easy to mistake
as a blank screen).

Tony


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

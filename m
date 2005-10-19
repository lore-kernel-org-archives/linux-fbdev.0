From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [directfb-users] Framebuffer woes...
Date: Wed, 19 Oct 2005 13:01:04 +0800
Message-ID: <4355D310.1060203@gmail.com>
References: <1129687824.25556.32.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ES64u-0004o1-5P
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 22:01:28 -0700
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ES64t-00036U-0H
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 22:01:28 -0700
Received: by zproxy.gmail.com with SMTP id s18so4421nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 22:01:25 -0700 (PDT)
In-Reply-To: <1129687824.25556.32.camel@localhost.localdomain>
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
To: "Nathanael D. Noblet" <nathanael@gnat.ca>
Cc: directfb-users@directfb.org, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Nathanael D. Noblet wrote:
> Hello,
> 
>     Obviously this isn't *directly* a DirectFB problem I'm experience,
> however I'm hoping someone here might have a solution to my problem.
> 
> I have a VIA EPIA board. It has a built in Trident graphics adapter. The
> problem I'm having is that when I try to get it to run, the lcd OSD
> throws up an error message about 'Out Of Range', sometimes blanking the
> screen, sometimes not.
> 
> I have developed a DirectFB application running on a RHEL 3 (kernel 2.4)
> clone machine with the vesafb framebuffer. It works well on that.
> However when I try to boot my 2.6 kernel with the tridentfb kernel I get
> the out of range. Now I tried setting it with identical fbset settings
> same as the vesafb. For example, when vesafb (2.6 OR 2.4 kernel) fbset
> -i gives
> 
> mode "1024x768-76"
>     # D: 78.653 MHz, H: 59.949 kHz, V: 75.694 Hz
>     geometry 1024 768 1024 768 16
>     timings 12714 128 32 16 4 128 4
>     rgba 5/11,6/5,5/0,0/0
> endmode
> 
> Frame buffer device information:
>     Name        : VESA VGA
>     Address     : 0xd9800000
>     Size        : 6291456
>     Type        : PACKED PIXELS
>     Visual      : TRUECOLOR
>     XPanStep    : 0
>     YPanStep    : 0
>     YWrapStep   : 0
>     LineLength  : 2048
>     Accelerator : No
> 
> The only difference I see when using the tridentfb is "YPanStep : 1."
> 
> I've also tried with epiafb found at http://epiafb.sourceforge.net/
> It loads up, but also gives the out of range errors. I even took the
> lines from
> 
> http://sourceforge.net/forum/forum.php?thread_id=756152&forum_id=221920
> 
> 1024x768x24: 
> fbset -t 10582 208 48 36 1 96 3 -g 1024 768 1024 768 24 -hsync high
> -vsync high 
> 800x600x24: 
> fbset -t 17762 152 32 27 1 64 3 -g 800 600 800 600 24 -hsync high -vsync
> high 
> 640x480x24: 
> fbset -t 27778 80 56 25 1 56 3 -g 640 480 640 480 24 -hsync low -vsync
> low 
> 
> All of those (regardless of depth (8,16,24) all produce 'out of range'
> problems.
> 
> I read
> http://www.ibiblio.org/pub/Linux/docs/HOWTO/other-formats/html_single/Framebuffer-HOWTO.html#s18
> 
> and converted the two 1024x768 modelines
> 75.0 1024 1048 1184 1328 768 771 777 806 -hsync -vsync
> 78.8 1024 1040 1136 1312 768 769 772 800 +hsync +vsync
> Which became
> 75: 13333 144 24 136 29 3 6
> 78: 12690 179 16 96 28 1 3
> 
> X Windows on the RHEL 3 kernel 2.4 system is where those came from, and
> works fine.
> 
> Can ANYONE give me any insight into what I should be doing to fix
> this... pleeeeaaaaase? I'm at the end of my rope with this one.
> 

Try booting with video=tridentfb:fp:1024x768@60.  Also post dmesg, lspci -v
and fbset -i.

I'm CC'ing fbdev-devel.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

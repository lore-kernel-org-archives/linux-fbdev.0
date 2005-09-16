From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: fbcon woes with closed source framebuffer
 kernel module
Date: Fri, 16 Sep 2005 21:59:17 +0800
Message-ID: <432ACFB5.8020502@gmail.com>
References: <196b7d3105091606241b4d2ba4@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGGkf-0004YJ-9h
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Sep 2005 06:59:41 -0700
Received: from zproxy.gmail.com ([64.233.162.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EGGke-0004MQ-8E
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Sep 2005 06:59:41 -0700
Received: by zproxy.gmail.com with SMTP id 14so611675nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 Sep 2005 06:59:33 -0700 (PDT)
In-Reply-To: <196b7d3105091606241b4d2ba4@mail.gmail.com>
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
> hi list,
> 
> i got an STB with STB04xxx Digital Set-Top Box Integrated Controller
> from IBM (it's a 250Mhz embedded powerpc CPU).
> 
> the machine runs a 2.6.9 kernel with a closed source framebuffer
> kernel module "fb.ko".
> 
> I can perform lot of ioctls and mmap the framebuffer device, and
> implement a putpixel() to draw something on TV-Output.
> 
> but when i compile framebuffer based console driver "fbcon.ko" and the
> fonts "font.ko" and load those modules on the box, I DO NOT get a VT
> or console login prompt on the TV-output.

Are you sure fbcon is using your framebuffer?  Check lsmod output.
If fbcon is using the driver, and your kernel did not crash, then
that closed source driver is already implementing all the drawing
functions needed by fbcon.

If you don't see any output, then there's a bug somewhere or hopefully
just an incorrect setting.  Check the output of fbset -i and post it here.
An incorrect value in one of the settings can easily lead to a blank
screen.

> 
> what's wrong? or should i implement my own putc, scroll, etc... or

Don't, no use doing this.

> better a terminal for framebuffers like jfbterm, fbiterm???
> 

As a last resort, perhaps.  Why don't you ask IBM?

Tony


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

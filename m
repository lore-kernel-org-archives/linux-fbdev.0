From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 10/12] fbdev: Static pseudocolor with
 depth less than 4 does exist
Date: Sun, 30 Apr 2006 05:42:33 +0800
Message-ID: <4453DDC9.20201@gmail.com>
References: <4452B628.1020001@gmail.com> <Pine.LNX.4.62.0604290935310.4557@pademelon.sonytel.be> <44535D47.5060000@gmail.com> <Pine.LNX.4.62.0604292025410.4557@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZxD0-0002l1-9T
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Apr 2006 14:42:34 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZxD0-0007LX-DI
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Apr 2006 14:42:34 -0700
Received: from pproxy.gmail.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZxCz-0006rI-U1
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Apr 2006 14:42:34 -0700
Received: by pproxy.gmail.com with SMTP id i49so2708162pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 29 Apr 2006 14:42:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0604292025410.4557@pademelon.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, Linux/m68k <linux-m68k@vger.kernel.org>

Geert Uytterhoeven wrote:
> [ linux-mac68k@mac.linux-m68k.org removed as it seems to bounce? ]
> 
> On Sat, 29 Apr 2006, Antonino A. Daplas wrote:
>> Geert Uytterhoeven wrote:
>>> On Sat, 29 Apr 2006, Antonino A. Daplas wrote:
>>>> A static pseudocolor visual with depth less than 4 does exist, so let's
>>>> not accidentally upscale the depth with this configuration
>>> Yes it does, at least on Mac/m68k.
>>>
>>> Now the real question is: why doesn't macfb set FB_VISUAL_STATIC_PSEUDOCOLOR if
>>> there's no macfb_setpalette routine?
>> It should.  The other question is, what to do with static pseudocolor?
>> Do we always assume console colors?  Or do we make drivers fill their own
>> info->cmap entries and not alter the contents when fb_set_cmap() is called?
> 
> I don't think you can always assume console colors. Only the driver (if anyone
> knows at all) knows the palette.
> 
> On the other hand, at least on Mac/m68k the palette is inherited from MacOS.
> It would be possible for the Penguin booter to programs the standard console
> palette under MacOS, just before booting the kernel, but as I don't know much
> about Penguin, I have no idea whether that's currently done.
> 

Making the palette match the console would be the simplest solution.  Otherwise,
we make the drivers export a color map which will be read-only.  Then fbcon and
other clients will just have to alter their palette to best fit the hardware.

Tony


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

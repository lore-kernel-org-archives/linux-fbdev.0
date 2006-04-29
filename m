From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 10/12] fbdev: Static pseudocolor with
 depth less than 4 does exist
Date: Sat, 29 Apr 2006 20:34:15 +0800
Message-ID: <44535D47.5060000@gmail.com>
References: <4452B628.1020001@gmail.com> <Pine.LNX.4.62.0604290935310.4557@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZoeR-0005kw-Mp
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Apr 2006 05:34:19 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZoeR-0004Am-Ha
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Apr 2006 05:34:19 -0700
Received: from xproxy.gmail.com ([66.249.82.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZoeP-00064b-Vx
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Apr 2006 05:34:19 -0700
Received: by xproxy.gmail.com with SMTP id t4so1510085wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 29 Apr 2006 05:34:15 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0604290935310.4557@pademelon.sonytel.be>
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
Cc: Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>, Andrew Morton <akpm@osdl.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

Geert Uytterhoeven wrote:
> On Sat, 29 Apr 2006, Antonino A. Daplas wrote:
>> A static pseudocolor visual with depth less than 4 does exist, so let's
>> not accidentally upscale the depth with this configuration
> 
> Yes it does, at least on Mac/m68k.
> 
> Now the real question is: why doesn't macfb set FB_VISUAL_STATIC_PSEUDOCOLOR if
> there's no macfb_setpalette routine?

It should.  The other question is, what to do with static pseudocolor?
Do we always assume console colors?  Or do we make drivers fill their own
info->cmap entries and not alter the contents when fb_set_cmap() is called?

Also, I made vesafb's visual static_pseudocolor if the mode is not VGA compatible
and the protected mode interface is absent.  Fortunately, the VGA colormap is carried
over to vesafb, so by accident, the console color map coincides with the hardware
CLUT and the logo and console displays correctly.

Tony


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

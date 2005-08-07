From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: CRTC scanout buffer types
Date: Mon, 08 Aug 2005 05:10:21 +0800
Message-ID: <42F678BD.7030008@gmail.com>
References: <9e47339105080513195dee0804@mail.gmail.com>	 <Pine.LNX.4.62.0508071135450.31010@gorilla.sonytel.be> <9e47339105080706414faf1e40@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1sPS-0000B1-2N
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 14:10:18 -0700
Received: from wproxy.gmail.com ([64.233.184.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1sPR-00085m-KD
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 14:10:18 -0700
Received: by wproxy.gmail.com with SMTP id i21so634927wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 14:10:12 -0700 (PDT)
In-Reply-To: <9e47339105080706414faf1e40@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, DRI developer's list <dri-devel@lists.sourceforge.net>

Jon Smirl wrote:
> I'm trying to work out a syntax for the sysfs attribute that will
> control the config. My first idea is to use a alpha/red/blue/green
> syntax. When red is set and blue/green are missing index mode is set.
> When green is set and red/blue are missing gray scale is set.

No, if r.offset = g.offset = b.offset = 0 and
r.len = g.len = b.len = n, then set index mode (pseudocolor).  For grayscale,
check if var.grayscale is set.

> 
> Are there chips that can scanout from buffers not packed at a power of two?

Yes, rgb888 (Intel 810).

> How should I work different color spaces (YCbCr) into this?

Create a new visual FB_VISUAL_YUV, then treat rgb as yuv.

> 
> 4bpp Index = /4
> 4bpp greyscale = //4
> 8bpp Index = /8
> 8bpp RGB 332 = /3/3/2
> 8bpp greyscale = //8
> 16bpp aRGB 1555 = 1/5/5/5
> 16bpp RGB 565 = /5/6/5
> 16bpp aRGB 4444 = 4/4/4/4
> 16bpp aIndex 88 = 8/8
> 24bpp RGB 888 = /8/8/8
> 24bpp aRGB 6666 = 6/6/6/6
> 32bpp aRGB 8888 = 8/8/8/8
> 32bpp aRGB 2:10:10:10 = 2/10/10/10
> 
> How are these packed?

How each pixel is packed in the framebuffer is determined by bpp.
How each color component is packed within the pixel is determined by
{red|green|blue|transp}.{offset|len} 

> 1 bpp monochrome (black = 0 and white = 1 or vice versa)
> 1 bpp indexed
> 2 bpp indexed
> 3 bpp indexed
> 5 bpp indexed
> 6 bpp indexed
> 7 bpp indexed
> 
> These would have the same config, //8, right? You then just control

No, packing is determined by bpp. So 7bpp has 7 bits per pixel.  However
a color depth of 7 with bpp8 has 8 bits per pixel but only 7 significant bits.

> what you write to the byte.
> 8 bpp monochrome (black is all zeroes and white is all ones or vice versa)
> 8 bpp greyscale
> 
> How does this work, is one 24 bit color the key?
> 32 bpp indexed+RGB 888 with color key to enable RGB888
> 

This is directcolor. Each component is indexed.


Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

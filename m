From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: fixing fbdev for various framebuffer configs
Date: Fri, 29 Jul 2005 21:32:11 +0800
Message-ID: <42EA2FDB.8030400@gmail.com>
References: <9e473391050729035370d76cc5@mail.gmail.com>  <42EA16A4.2050709@gmail.com> <9e47339105072904523afe0b9f@mail.gmail.com> <Pine.LNX.4.62.0507291356060.5335@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyUyK-0006vl-H7
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 06:32:20 -0700
Received: from wproxy.gmail.com ([64.233.184.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyUyH-0006jY-9b
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 06:32:20 -0700
Received: by wproxy.gmail.com with SMTP id i3so634514wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Jul 2005 06:32:11 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0507291356060.5335@numbat.sonytel.be>
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
Cc: Jon Smirl <jonsmirl@gmail.com>, "Antonino A. Daplas" <adaplas@hotpop.com>, James Simmons <jsimmons@infradead.org>

Geert Uytterhoeven wrote:
> On Fri, 29 Jul 2005, Jon Smirl wrote:
>> On 7/29/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
>>> Jon Smirl wrote:
>>>> It has been determined that bits per pixel is insuffucient to
>>>> enumerate all the needed fbconfigs. Here are the possible fgconfigs
>>>> from the OpenGL headers:
>>>>
>>>> total bits
>>>> 8     GL_R3_G3_B2
>>>> 8     GL_RGBA2
>>>> 12   GL_RGB4
>>>> 15   GL_RGB5
>>>> 16   GL_R5_G6_B5
>>>> 16   GL_RGBA4
>>>> 16   GL_RGB5_A1
>>>> 24   GL_RGB8
>>>> 30   GL_RGB10
>>>> 32   GL_RGBA8
>>>> 32   GL_RGB10_A2
>>>> 36   GL_RGB12
>>>> 48   GL_RGB16
>>>> 48   GL_RGBA12
>>>> 48   GL_FLOAT_RGB16
>>>> 64   GL_RGBA16
>>>> 64   GL_FLOAT_RGBA16
>>>> 96   GL_FLOAT_RGB32
>>>> 128 GL_FLOAT_RGBA32
>>>>
>>>> We need to be able to set any of these through the fbdev interface. We
>>>> also need to allow for possible future expansion.
>>> To set for example, RGBA16, set {transp|green|red|blue}.len to 16, the
>>> offsets to 0, 16, 32, 48, and bits_per_pixel to 64.  Then let the driver
>>> sort it out.  I don't know what we can do about the FLOAT formats...
>>>
>>>> Ideas on how to adjust the fbdev interface?
>>> Well, no need to adjust the interface.  But it is limited though to
>>> 16 bits per channel.  Redefining them to 32 will break a lot of apps.
> 
> It's only the colormap entries that are limited to 16 bits per color component,
> right? The color components in pixel values can be much larger (up to 2^31 bits
> :-).

Yes, but struct fb_cmap has entries of u16 and this is used by struct
fb_var_screeninfo and by the cmap functions. fb_setcolreg is also passed
with u16 values.  ioctls affected will be FBIO{GET|PUT}_VSCREENINFO ,
FBIO{GET|PUT}CMAP, all used in userspace.

> 
>> My current idea is to get rid of the bit_per_pixel attribute and
>> replace it with config. Config would take strings like 8,8,8 or
>> 5,5,5,1 or 32.,32.,32.
> 
> That's not acceptable. How do you differentiate between RGB888 (without alpha)
> using 24 or 32 bits per pixel?
> 
> Or more general, what with hardware that has unused bits in its pixel values,
> e.g. hardware that has 8 bits per pixel but uses only 1 bit per byte in
> monochrome mode and 4 bits in 16-color mode?

Agree,

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

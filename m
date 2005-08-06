From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Choosing the correct framebuffer configuration
Date: Sun, 07 Aug 2005 01:12:41 +0200
Message-ID: <42F543E9.9030403@vc.cvut.cz>
References: <9e473391050805184756f055ea@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1XqW-0007NM-S5
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Aug 2005 16:12:52 -0700
Received: from mailgw.cvut.cz ([147.32.3.235])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1XqV-0002B4-75
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Aug 2005 16:12:52 -0700
In-Reply-To: <9e473391050805184756f055ea@mail.gmail.com>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Jon Smirl wrote:
> If I understand things correctly the framebuffer config is supposed to
> be controlled by the transp/red/blue/green fields of fb_var_screeninfo
> during check_var. These fields are then combined to compute the
> bits_per_pixel.
> 
> radeonfb is working from the other direction, it starts with bpp and
> then computes ARGB. This looks wrong to me.

It is correct thing to do if you support only one format per depth.

> Radeonfb supports these four configs controlled by setting BPP:
> DST_8BPP = 8BPP indexed
> DST_15BPP = ARGB1555
> DST_16BPP = RGB565
> DST_32BPP = ARGB8888
> 
> The chips actually allow nine configs (maybe more when I get a look at
> the R300 doc). It is ambiguous to set these configs based on BPP since
> there are multiple configs for various BPP. These configs should
> instead be set with the transp/red/blue/green fields.
> 

If you support all of them, I would do:

> 4bpp Index = /4

Use this if bpp==4, ignore rgba.

> 8bpp Index = /8

Use this if bpp==8, ignore rgba.

> 16bpp aRGB 1555 = 1/5/5/5

Use this if bpp==16 and green.length == 5.  For backward compatibility 
you can support bpp=15 with any rgba...

> 16bpp RGB 565 = /5/6/5

Use this if bpp==16 and it is not 1/5/5/5 or 4/4/4/4.

> 16bpp aRGB 4444 = 4/4/4/4

Use this if bpp==16 and green.length == 4.

> 16bpp aIndex 88 = 8/8

I'm afraid that with this format you run out of luck.  I do not think 
infrastructure is able to support this.  API does not have separate 
entry for Index position/width in pseudocolor, and rgb fileds are used 
for reporting DAC width in pseudocolor mode.  Maybe use this when 
nonstd==1 ?  Choosing this format when green.length==8 might trigger 
when 8/24/32bpp videomode is switched to 16bpp by fbset without rgba 
option, so it is probably not good idea to use green.length==8 to select 
this videomode.

> 24bpp RGB 888 = /8/8/8

bpp == 24, any rgba.

> 32bpp aRGB 8888 = 8/8/8/8

bpp == 24, green.length != 10.

> 32bpp aRGB 2:10:10:10 = 2/10/10/10

bpp == 32, green.length == 10.

> What is the best way to fix this? The interesting hidden config is 30b color.
> 
> I can hack it in by using ARGB if BPP is zero and the old scheme if BPP is set.

Apps should be setting both bpp and preferred rgba.  Apps which use 
garbage rgba (f.e. they ask for 32bit 1:5:5:5 when they are switching 
framebuffer from depth == 15 to depth == 32) should get "best" suitable 
format, which I tried to express above by green.length tests (*).  Upon 
successful mode set rgba must be updated with choosen hardware 
configuration.
								Petr

(*) Maybe you could ignore rgba when sum of rgba lengths does not equal 
to bpp.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

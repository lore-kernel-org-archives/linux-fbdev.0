From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: 2.6.7 still garbage upon start
Date: Fri, 18 Jun 2004 09:54:53 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40D29FCD.7020602@winischhofer.net>
References: <40D21E31.5070904@winischhofer.net> <200406180945.06335.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbEEn-0003YV-0M
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 00:56:37 -0700
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BbEEm-0008Ky-AF
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 00:56:36 -0700
In-Reply-To: <200406180945.06335.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas wrote:
> On Friday 18 June 2004 06:41, Thomas Winischhofer wrote:
> 
>> modprobing fbcon still paints a white rectangle. Difference to
>> 2.6.6 is that this rectangle now fills the entire screen instead of
>> a smaller area. As before, text is shown all correctly (painted
>> upon the rectangle), and the white rectangle scrolls up just like
>> text and in the end vanishes.
>> 
> 
> 
> The white screen is the result of fbdev being initialized before
> vgacon is deinitialized.  I can't find a simple solution for this
> except to disable vgacon if fbcon is compiled statically.  Currently
> vgacon is always enabled in X86, so I use this in
> drivers/video/console/Kconfig.
> 
> config VGA_CONSOLE bool "VGA text console" if EMBEDDED || !X86 
> depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC32
> &&	!SPARC64 && !M68K && FRAMEBUFFER_CONSOLE != y


What the heck does vgacon when being deinitialized? Is it supposed to 
write to video memory at this stage? Granted, I haven't looked at the 
vgacon code but that seems a bit strange.


>> Switching to another VT while in X still leaves you with a blank
>> screen and a blinking cursor. If one presses return, the screen
>> contents is restored.
> 
> 
> You mean switching from X to another VT?  At least you just get a
> blank screen, with other drivers, sometimes the machine hangs.


Well, that might be due to the fact that me, myself and I develope both
the X driver as well as the framebuffer driver ;)


> (I have code I'm planning to send for RFC that will notify the
> low-level driver if switching from KD_GRAPHICS->KD_TEXT and vice
> versa or if multiple drivers are mapped to different consoles.
> However, it seems BenH already has code for this so I'm holding the
> submission.  I just can't find BenH's changes in 2.6.7 or -mm.  Hey
> Ben, where is it?)

Perhaps I am being naive, but I don't understand what the problem can 
be. X restores the display mode before initiating the VT change. And a 
VT change should restore the previous screen contents.

Please excuse if these are stupid comments, I lost track of the console 
code I while back.


Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net	       *** http://www.winischhofer.net
twini AT xfree86 DOT org


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND

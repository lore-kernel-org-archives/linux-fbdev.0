From: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: Backlight support
Date: Tue, 30 Nov 2004 16:28:26 -0000
Message-ID: <017c01c4d6f9$a34fc010$0f01a8c0@max>
References: <40ED4FAC.70406@ticino.com> <1089274696.4740.3.camel@localhost><41AB2E71.8080809@imc-berlin.de> <f9d2a5e104112916252c253a2b@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZAsG-0001nT-7v
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Nov 2004 08:29:08 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CZAsF-0008Jg-55
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Nov 2004 08:29:08 -0800
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
Content-Type: text/plain; format="flowed"; charset="us-ascii"; reply-type="original"
To: Russ Dill <russ.dill@gmail.com>, Steven Scholz <steven.scholz@imc-berlin.de>, John Lenz <lenz@cs.wisc.edu>, zap@homelink.ru
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net

John Lenz:
> Perhaps the patch being referred to is the "Backlight and LCD module
> patches" that Andrew Zabolotny and I proposed on lkml?

I think the above patch was nearly there. The issues seemed to be with the
method of associating framebuffer devices with their backlights. I've come
up with a solution to that problem (see below) so that code can be removed
from that patch and that should make it acceptable for mainstream kernel
inclusion.

Russ Dill:
> The driver/bus/device model driver? Probably just no one there with
> the time to spend on it. It be a real help, and would be a good use of
> sysfs (for changing contrast, getting info, etc).

I'm keen to get this sorted out and I agree its an ideal use of sysfs. I'm
still getting up to speed on sysfs though...

Steven Scholz:
> Where can I find the most recent version of your patch?

I've had a discussion with Andrew. I think he's going to find the latest
version of the and post it for inclusion without the problematic parts...
Andrew?

> Excuse me ignorance, but what is "frontlight"?

I think a frontlight shines onto the display and reflects off a reflector at
the back of the LCD. A backlight lights it from the rear. As far as the
sysfs representations go, they'll be essentially identical. You can read a
frontlit display without the light in strong light. The backlit display
always needs the backlight.

My solution for associating backlight drivers with framebuffer drivers is
for the backlight driver to call fb_register_client() and register for fb
events. You can then intercept blanking requests (FB_EVENT_BLANK) which get
passed with an fb_info struct and the new blanking setting. It's entirely up
to the backlight driver how it tells which displays it should be blanking.
For something like my PDA, there is only one framebuffer/LCD to blank but in
other cases you would analyse fb_info. (FB_EVENT_BLANK is destined for
2.6.11)

I propose this discussion should move to linux-fbdev-devel and hopefully
Andrew will provide a sysfs representation we can discuss (maybe with some
comments from lkml).

I have one implementation question though - should backlight drivers be in
the arch folder (arch/arm/mach-pxa in my case) or should
drivers/video/backlights be created? They're all likely to be using
fb_register_client() so maybe the latter would be preferred?

Richard



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

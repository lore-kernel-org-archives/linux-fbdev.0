From: Andrew Zabolotny <zap@homelink.ru>
Subject: Re: Re: Backlight support
Date: Thu, 2 Dec 2004 01:34:37 +0300
Message-ID: <20041202013437.5d63234e.zap@homelink.ru>
References: <40ED4FAC.70406@ticino.com>
	<1089274696.4740.3.camel@localhost>
	<41AB2E71.8080809@imc-berlin.de>
	<f9d2a5e104112916252c253a2b@mail.gmail.com>
	<017c01c4d6f9$a34fc010$0f01a8c0@max>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZd4K-0000jN-Fn
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Dec 2004 14:35:28 -0800
Received: from mail.homelink.ru ([81.9.33.123] helo=eltel.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CZd4G-0001nv-N2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Dec 2004 14:35:28 -0800
In-Reply-To: <017c01c4d6f9$a34fc010$0f01a8c0@max>
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
Cc: rpurdie@rpsys.net, russ.dill@gmail.com, steven.scholz@imc-berlin.de, lenz@cs.wisc.edu

On Tue, 30 Nov 2004 16:28:26 -0000
"Richard Purdie" <rpurdie@rpsys.net> wrote:

> I think the above patch was nearly there. The issues seemed to be with
> the method of associating framebuffer devices with their backlights.
> I've come up with a solution to that problem (see below) so that code
> can be removed from that patch and that should make it acceptable for
> mainstream kernel inclusion.
I confirm that the solution you proposed is quite suitable for the job.
I've already modified the lcd/backlight subsystem, and I have a few
comments;

a) First of all, the implementation of your idea looks quite well
(it's simpler and cleaner than the old method), although initially I
didn't like it (mea culpa). I have removed a lot of now unneeded code
from b/l support, and also it removes a lot of lcd/backlight
maintainance code from the framebuffer drivers(pxafb, sa11xxfb,
mq11xxfb). Last but not least, it removed the class_find_device()
function that was the sticking point in the discussion with gkh.

b) No modification is needed to the existing lcd/backlight drivers
(there are about ten of them in hh.org cvs). I've added just one more
function pointer in the lcd_properties and backlight_properties to a
function that gets a fb_info and examinates if it is the
framebuffer to which the lcd/backlight is attached to. If the function
is NULL, the framebuffer is considered to match (since in PDAs there's
only one framebuffer, this perfectly fits already existing drivers).

c) There's a problem though; if someone will REALLY want to inspect
the fb_info, it would be very helpful to be able to deduce somehow the
'struct device' associated with the framebuffer, since the fb_info
itself doesn't contain anything more useful than the current resolution
and pixel format. Knowing the device (and its position on the parent
bus) the backlight/lcd driver will know exactly what to look at. I've
seen some semi-commented code in 2.6.10 which tells me there are plans
to integrate the fb_info into the sysfs (and, therefore, to add a
class_device somewhere in the fb_info); this will allow also the b/l
drivers to find the associated framebuffer device. Am I correct in my
assumptions?

As soon as handhelds.org will be up, I'll be able to test the code and,
once it'll work, I'll send a patch to linux-fbdev-devel@.

-- 
Greetings,
   Andrew


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

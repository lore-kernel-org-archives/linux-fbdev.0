From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: Backlight support
Date: Thu, 2 Dec 2004 19:08:28 +0800
Message-ID: <200412021908.28861.adaplas@hotpop.com>
References: <40ED4FAC.70406@ticino.com> <017c01c4d6f9$a34fc010$0f01a8c0@max> <20041202013437.5d63234e.zap@homelink.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZopT-000876-Op
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Dec 2004 03:08:55 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CZopS-00070w-JD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Dec 2004 03:08:55 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 115D9AD3711
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  2 Dec 2004 11:08:39 +0000 (UTC)
In-Reply-To: <20041202013437.5d63234e.zap@homelink.ru>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Zabolotny <zap@homelink.ru>
Cc: rpurdie@rpsys.net, russ.dill@gmail.com, steven.scholz@imc-berlin.de, lenz@cs.wisc.edu

On Thursday 02 December 2004 06:34, Andrew Zabolotny wrote:
> On Tue, 30 Nov 2004 16:28:26 -0000
>
> "Richard Purdie" <rpurdie@rpsys.net> wrote:
> > I think the above patch was nearly there. The issues seemed to be with
> > the method of associating framebuffer devices with their backlights.
> > I've come up with a solution to that problem (see below) so that code
> > can be removed from that patch and that should make it acceptable for
> > mainstream kernel inclusion.
>
> I confirm that the solution you proposed is quite suitable for the job.
> I've already modified the lcd/backlight subsystem, and I have a few
> comments;
>
> a) First of all, the implementation of your idea looks quite well
> (it's simpler and cleaner than the old method), although initially I
> didn't like it (mea culpa). I have removed a lot of now unneeded code
> from b/l support, and also it removes a lot of lcd/backlight
> maintainance code from the framebuffer drivers(pxafb, sa11xxfb,
> mq11xxfb). Last but not least, it removed the class_find_device()
> function that was the sticking point in the discussion with gkh.
>
> b) No modification is needed to the existing lcd/backlight drivers
> (there are about ten of them in hh.org cvs). I've added just one more
> function pointer in the lcd_properties and backlight_properties to a
> function that gets a fb_info and examinates if it is the
> framebuffer to which the lcd/backlight is attached to. If the function
> is NULL, the framebuffer is considered to match (since in PDAs there's
> only one framebuffer, this perfectly fits already existing drivers).
>
> c) There's a problem though; if someone will REALLY want to inspect
> the fb_info, it would be very helpful to be able to deduce somehow the
> 'struct device' associated with the framebuffer, since the fb_info

We already have a struct device field in fb_info. It was initially requested
for swsusp2, but I find that it has other uses as well (in userland).

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

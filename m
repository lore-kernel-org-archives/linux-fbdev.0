From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fbdev upstream
Date: Thu, 25 Dec 2003 21:46:12 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1072349172.15476.40.camel@gaston>
References: <3FD6C52C.7090906@undead.cc>  <3FDBB97F.4070207@undead.cc>
	 <1072254049.739.61.camel@gaston>  <3FE9F9C3.20605@undead.cc>
	 <1072305777.15461.13.camel@gaston>  <3FEA3327.6050507@undead.cc>
	 <1072313855.15477.26.camel@gaston>  <3FEA430B.603@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZT11-0001LC-31
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Dec 2003 02:46:51 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AZT10-0006d9-9d
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Dec 2003 02:46:50 -0800
In-Reply-To: <3FEA430B.603@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Then a standard generic way to retrieve this information from the fbdev 
> might be an idea.   At the very least you should get the bare modelist 
> but if the other info is available (manufacturer, model number, serial 
> number, raw edid data) then that can be returned as well.   Again this 
> is 2.7 material.

I think we need the driver to have a "detect displays" method
ultimately, that builds either an identification string, or a
modelist.

If we go to the ID string way, it could be something like

EDID,<EDID data in hex>
APPL,<Apple old style sense code>
FIXD,<fixed mode line>

(the above are random examples coming out of my mind right now)

Or we can have the driver build a modelist. Though if we are going
to move things to userland, it makes sense to move the modelist building
down there as well...

We also want to define some hotplug events for displays

Finally, we need to extend the fbdev API (via sysfs ?) to separate
clearly the physical outputs (and detection of what they are connected
to) from the actual CRTCs and some way to setup the mapping between
outputs and CRTCs (1 CRTC routed to several outputs, 2 CRTCs on
2 different outputs, etc..)

I'm about to implement dual head in radeonfb, and the above is hell,
I want to support mirroring for example, but then, you have only one
/dev/fb entry and 2 different modes ... things like that...  Getting
the user API right isn't simple.

> That's why I'm putting a lot of my stuff into fbcon as it's console 
> related.   Is X the only other system to use fbdev other than fbcon?

No. There is an implementation of Mesa/DRI on top of fbdev (witout X),
there is MacOnLinux virtual machine (running Linux, MacOS or MacOS X)
that uses fbdev, there is directfb, at least...

One thing we discussed a while ago with Jon Smirl was to move the actual
console engine out of the kernel. That's a possibility though may not be
necessary as long as things are properly split. But I'd like to get rid
of the accel ops in the kernel and shove all that in userland libs that
can make use of CCE engines when available etc... and provide more APIs
like surfaces overlay etc.. (useful for full screen set-top-box type
applications).

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

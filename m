From: John Zielinski <grim@undead.cc>
Subject: Re: fbdev upstream
Date: Thu, 25 Dec 2003 11:53:40 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FEB1614.3080606@undead.cc>
References: <3FD6C52C.7090906@undead.cc>  <3FDBB97F.4070207@undead.cc>	 <1072254049.739.61.camel@gaston>  <3FE9F9C3.20605@undead.cc>	 <1072305777.15461.13.camel@gaston>  <3FEA3327.6050507@undead.cc>	 <1072313855.15477.26.camel@gaston>  <3FEA430B.603@undead.cc> <1072349172.15476.40.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZYkH-00011u-BT
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Dec 2003 08:53:57 -0800
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AZYkG-0003Y0-QI
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Dec 2003 08:53:57 -0800
In-Reply-To: <1072349172.15476.40.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>I think we need the driver to have a "detect displays" method
>ultimately, that builds either an identification string, or a
>modelist.
>
>If we go to the ID string way, it could be something like
>
>EDID,<EDID data in hex>
>APPL,<Apple old style sense code>
>FIXD,<fixed mode line>
>
>(the above are random examples coming out of my mind right now)
>
>Or we can have the driver build a modelist. Though if we are going
>to move things to userland, it makes sense to move the modelist building
>down there as well...
>  
>

Sounds good.   That way if fbcon is not being used then userland can 
worry about everything and if it is used it can parse that data and 
generate a good startup mode to use.

>We also want to define some hotplug events for displays
>
>Finally, we need to extend the fbdev API (via sysfs ?) to separate
>clearly the physical outputs (and detection of what they are connected
>to) from the actual CRTCs and some way to setup the mapping between
>outputs and CRTCs (1 CRTC routed to several outputs, 2 CRTCs on
>2 different outputs, etc..)
>
>I'm about to implement dual head in radeonfb, and the above is hell,
>I want to support mirroring for example, but then, you have only one
>/dev/fb entry and 2 different modes ... things like that...  Getting
>the user API right isn't simple.
>  
>

I see what you mean.  Looks like I need to do some research on sysfs and 
get more familiar with it.  I'll help out any way I can.

John




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

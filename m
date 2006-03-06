From: Pavel Machek <pavel@ucw.cz>
Subject: Re: RFC: Backlight Class sysfs attribute behaviour
Date: Mon, 6 Mar 2006 22:44:26 +0100
Message-ID: <20060306214426.GA4701@elf.ucw.cz>
References: <1141571334.6521.38.camel@localhost.localdomain> <440B89AB.3020203@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932375AbWCFVo7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <440B89AB.3020203@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Zabolotny <zap@homelink.ru>, LKML <linux-kernel@vger.kernel.org>

On Po 06-03-06 09:00:27, Antonino A. Daplas wrote:
> Richard Purdie wrote:
> > At present, the backlight class presents two attributes to sysfs,
> > brightness and power. I'm a little confused as to whether these
> > attributes are currently doing the right things.
> > 
> > Taking brightness, at any one time we have several different brightness
> > values:
> > 
> > * User requested brightness (echo y > /sys/class/backlight/xxx/brightness)
> > * Driver determined brightness which accounts for things like FB 
> >   blanking, low battery backlight limiting (an example from corgi_bl), 
> >   user requested power state, device suspend/resume.
> > 
> > The solution might be to have brightness always return the user
> > requested value y and have a new attribute returning the brightness as
> > determined by the driver once it accounts for all the factors it needs
> > to consider. Naming of such an attribute is tricky - "driver_brightness"
> > perthaps?
> 
> Why not just agree on a normal range of values (ie, 0-255), and let the
> driver "denormalize" them?  Thus, a driver that has only 2 levels of
> brightness, will treat 0-127 as 0 and 128-255 as 1, and will return only
> two possible values 0 and 255.

Does not work... how do you set minimum brightness with backlight on
(so that text is visible)?
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...

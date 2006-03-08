From: Andrew Zabolotny <zap@homelink.ru>
Subject: Re: RFC: Backlight Class sysfs attribute behaviour
Date: Wed, 8 Mar 2006 12:48:07 +0300
Message-ID: <20060308124807.6b995cf4.zap@homelink.ru>
References: <1141571334.6521.38.camel@localhost.localdomain>
	<440B89AB.3020203@gmail.com>
	<1141634729.6524.14.camel@localhost.localdomain>
	<20060307000718.0e8b8be3.zap@homelink.ru>
	<1141686307.6524.98.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751171AbWCHJsW@vger.kernel.org>
In-Reply-To: <1141686307.6524.98.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Richard Purdie <rpurdie@rpsys.net>
Cc: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, 06 Mar 2006 23:05:07 +0000
Richard Purdie <rpurdie@rpsys.net> wrote:

> My driver_brightness is really a more generic version of your
> "hw_power" which allows other factors to be taken into consideration
> as well. We may as well have the broader-range solution as it costs
> us nothing.
Ok, your solution seems fine to me. In fact, with the old backend we
don't have guarantees that current hardware state can be read in
general; it just happened to be true for used hardware.

I just would propose to change the prototype of

int (*set_status)(struct backlight_device *, int brightness, int power,
int fb_blank);

to 

int (*set_status)(struct backlight_device *, struct backlight_status *);

This will allow adding new factors without changing the prototype
(thus without breaking old drivers which will simply ignore new added
factors).

I'm also not sure what should return

int (*get_status)(struct backlight_device *);

the brightness or the power status? Maybe it should be:

int (*get_status)(struct backlight_device *, struct backlight_status *);

-- 
Greetings,
   Andrew

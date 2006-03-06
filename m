From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: RFC: Backlight Class sysfs attribute behaviour
Date: Mon, 06 Mar 2006 00:08:54 +0000
Message-ID: <1141603734.6521.85.camel@localhost.localdomain>
References: <1141571334.6521.38.camel@localhost.localdomain>
	 <20060306010909.190f06fe.zap@homelink.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750762AbWCFAJI@vger.kernel.org>
In-Reply-To: <20060306010909.190f06fe.zap@homelink.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Andrew Zabolotny <zap@homelink.ru>
Cc: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 01:09 +0300, Andrew Zabolotny wrote:
> On Sun, 05 Mar 2006 15:08:53 +0000
> Richard Purdie <rpurdie@rpsys.net> wrote:
> 
> > The solution might be to have brightness always return the user
> > requested value y and have a new attribute returning the brightness as
> > determined by the driver once it accounts for all the factors it needs
> > to consider. Naming of such an attribute is tricky -
> > "driver_brightness" perthaps?
> Maybe by analogy to sound card there can be a 'master' control, and one
> 'user' control. But it's not clear how many of these strings you will
> need for every 'real' attribute. Why two and not three? Why three and
> not ten?

I'm just wondering about the name of the single attribute that reflects
the status of the current actual brightness value that the driver has
chosen.

> But I don't think that's a kernel-side problem. I think it would be
> better to have some daemon controlling these attributes (and keeping
> track of as many factors as needed) and programming the final, 'true'
> kernel value. Then a set of user-mode tools could be provided to alter
> them, and a simple API.

If all the events that could influence the backlight were available in
userspace, I'd agree but they're not. There might be a need for a daemon
in userspace for various reasons depending on the application but I'm
not concerned about that.

> Well with power it's simple: LCD is either powered or it's not. After
> resuming the LCD should be always powered on, and the program can then
> turn it back off if it's desired. FB blanking isn't a issue with X11/
> Qtopia, as far as I understand? And finally, the 'user' requested power
> state has to be tracked by the program that does the blanking (say an
> audio player or such).

So the user powers down the LCD, the FB blanking then blanks and
unblanks. What should the current LCD power status be? The LCD should
still be off as far as I can see yet the LCD/backlight class doesn't do
this at present.

I'm beginning to favour a system where backlight drivers only provide
two functions:

int (*set_status)(struct backlight_device *, int brightness, int power, int fb_blank);
int (*get_status)(struct backlight_device *);

set_status passes the user requested brightness and power values along
with the current fb_blanking status to the driver. The driver can then
set the hardware up as appropriate. 

get_status returns the brightness for the current configuration.

The backlight core itself keeps track of the requested power and
brightness values rather than having every backlight driver including
the logic. This has the advantage of keeping behaviour the same and
avoiding subtle logic bugs of which there are several at the moment.

This also means that "echo 31 > brightness; cat brightness" will always
give the expected answer of whatever brightness the user is requesting
and the actual current driver brightness choice is available through
"cat driver_brightness".

Does this seem reasonable?

Richard

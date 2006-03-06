From: Andrew Zabolotny <zap@homelink.ru>
Subject: Re: RFC: Backlight Class sysfs attribute behaviour
Date: Tue, 7 Mar 2006 00:07:18 +0300
Message-ID: <20060307000718.0e8b8be3.zap@homelink.ru>
References: <1141571334.6521.38.camel@localhost.localdomain>
	<440B89AB.3020203@gmail.com>
	<1141634729.6524.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751925AbWCFVuS@vger.kernel.org>
In-Reply-To: <1141634729.6524.14.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Richard Purdie <rpurdie@rpsys.net>
Cc: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, 06 Mar 2006 08:45:28 +0000
Richard Purdie <rpurdie@rpsys.net> wrote:

> * the user supplied power sysfs attribute
> * the user supplied brightness sysfs attribute
> * the current FB blanking state
> * any other driver specific factors
As far I see the only real concern here is the console blanking. So why
not make it just another device state flag, which doesn't influence the
'power' attribute and which isn't visible from user space (what for?).
And the 'real' power state will be computed as "blank && power"
attributes. The entire logic could be hidden in backlight.c so that no
driver will have to be modified for this. Maybe a 'hw_power' or such
would be needed to see the 'real' hardware state (and possibly
modify, if you really really want to).

Is there any need for a broader-range solution here?

-- 
Greetings,
   Andrew

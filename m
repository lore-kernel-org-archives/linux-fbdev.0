From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: RFC: Backlight Class sysfs attribute behaviour
Date: Mon, 06 Mar 2006 09:00:27 +0800
Message-ID: <440B89AB.3020203@gmail.com>
References: <1141571334.6521.38.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FG45e-0006Jv-Vn
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Mar 2006 17:00:46 -0800
Received: from pproxy.gmail.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FG45e-0003Q8-Kc
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Mar 2006 17:00:47 -0800
Received: by pproxy.gmail.com with SMTP id s49so744036pyc
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 05 Mar 2006 17:00:45 -0800 (PST)
In-Reply-To: <1141571334.6521.38.camel@localhost.localdomain>
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
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Zabolotny <zap@homelink.ru>, LKML <linux-kernel@vger.kernel.org>

Richard Purdie wrote:
> At present, the backlight class presents two attributes to sysfs,
> brightness and power. I'm a little confused as to whether these
> attributes are currently doing the right things.
> 
> Taking brightness, at any one time we have several different brightness
> values:
> 
> * User requested brightness (echo y > /sys/class/backlight/xxx/brightness)
> * Driver determined brightness which accounts for things like FB 
>   blanking, low battery backlight limiting (an example from corgi_bl), 
>   user requested power state, device suspend/resume.
> 
> The solution might be to have brightness always return the user
> requested value y and have a new attribute returning the brightness as
> determined by the driver once it accounts for all the factors it needs
> to consider. Naming of such an attribute is tricky - "driver_brightness"
> perthaps?

Why not just agree on a normal range of values (ie, 0-255), and let the
driver "denormalize" them?  Thus, a driver that has only 2 levels of
brightness, will treat 0-127 as 0 and 128-255 as 1, and will return only
two possible values 0 and 255.

If a user requests max brightness (255), and the driver is capable of setting
it, then it returns 255.  But if for some reason it can't (ie low power state),
it returns the current max brightness, normalized, (ie 128 instead of 255 and
because that the scale is 0-255, a value of 128 tells the user that only
half of max brightness was set).

And instead of a new "driver_brightness" attribute, why not just a new
attribute that returns the number of brightness levels?

It's similar for power.  We can agree on a range, 0-255.  The range might be
overkill but is consistent with brightness.  The callback converts the VESA
constants to 0 - 0, 1 - 64, 2 - 128, 3 - 255 and sends the value to the driver.
The driver, denormalizes them to, most probably, on and off (0-127 - on,
128-255 - off).

Tony



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

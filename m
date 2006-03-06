From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: RFC: Backlight Class sysfs attribute behaviour
Date: Mon, 06 Mar 2006 08:45:28 +0000
Message-ID: <1141634729.6524.14.camel@localhost.localdomain>
References: <1141571334.6521.38.camel@localhost.localdomain>
	 <440B89AB.3020203@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FGBLa-00070e-S3
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Mar 2006 00:45:42 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FGBLZ-00020O-Bs
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Mar 2006 00:45:43 -0800
In-Reply-To: <440B89AB.3020203@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Zabolotny <zap@homelink.ru>, LKML <linux-kernel@vger.kernel.org>

On Mon, 2006-03-06 at 09:00 +0800, Antonino A. Daplas wrote:
> Why not just agree on a normal range of values (ie, 0-255), and let the
> driver "denormalize" them?  Thus, a driver that has only 2 levels of
> brightness, will treat 0-127 as 0 and 128-255 as 1, and will return only
> two possible values 0 and 255.
>
> If a user requests max brightness (255), and the driver is capable of setting
> it, then it returns 255.  But if for some reason it can't (ie low power state),
> it returns the current max brightness, normalized, (ie 128 instead of 255 and
> because that the scale is 0-255, a value of 128 tells the user that only
> half of max brightness was set).

We already have a max_brightness attribute and brightness can vary
between 0 and max_brightness (hence avoiding scaling issues which we
leave to userspace).

> And instead of a new "driver_brightness" attribute, why not just a new
> attribute that returns the number of brightness levels?

The idea of the driver_brightness attribute is to separate the user
requested brightness value from the actual brightness value decided by
the driver. The driver determines the real brightness by combining:

* the user supplied power sysfs attribute
* the user supplied brightness sysfs attribute
* the current FB blanking state
* any other driver specific factors

At present, the user specified values through the sysfs attributes can
easily get lost as other factors overwrite it (FB blanking overwrites
user specified power for example). This leads to a class interface with
unpredictable behaviour.

I'm therefore suggesting separation of the values so each attribute
reads and writes in a predicable manner and the actual state determined
by the driver becomes a new readonly sysfs attribute
("driver_brightness" although I'm open to suggestions of a better name).

Richard



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

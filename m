From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 20 Nov 2012 16:11:28 +0000
Subject: Re: [PATCH] video console: add a driver for lcd2s character display
Message-Id: <201211201611.28646.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353416206-3243-1-git-send-email-larsi@wh2.tu-dresden.de> <201211201325.57883.arnd@arndb.de> <201211201521.33726.poeschel@lemonage.de>
In-Reply-To: <201211201521.33726.poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars Poeschel <poeschel@lemonage.de>
Cc: Lars Poeschel <larsi@wh2.tu-dresden.de>, FlorianSchandinat@gmx.de, mathieu.poirier@linaro.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 20 November 2012, Lars Poeschel wrote:
> > 
> > It's better to define the struct consw as a preinitialized
> > 'static const' object, rather than dynamically setting each
> > member.
> 
> I could not find a place to store the drivers private data inside the struct 
> vc_data. I wanted to have the struct consw inside the drivers private data 
> (struct lcd2s_data) to be able to container_of to the drivers private data in 
> the consw.con_* functions. This makes it possible to use more than one actual 
> lcd2s display with the same driver. Otherwise I have to store the struct 
> i2c_client somewhere statically and the driver can control only one display 
> and has to forbid to be probed a second time. Or am I wrong somewhere ?

I believe you can only have one device anyway, because of the way you
register using "take_over_console(&data->consw, LCD2S_FIRST, LCD2S_LAST, 1);"

Whichever lcd2s was last registered gets VC 8 and 9. This is not nice, but
I think it's similar to how all the other VC work. They consequently don't
store per-device data at all, but just have global variables for device
specific data. We generally discourage this behaviour for device drivers,
but I woulnd't expect you to change the way that VC works, so you can just
do the same here.

Things would be different if this was a "console" driver rather than a "vc"
driver.

	Arnd

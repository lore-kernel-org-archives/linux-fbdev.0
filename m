From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Tue, 23 Jul 2013 05:46:53 +0000
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Message-Id: <51EE15FD.2010205@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.44L0.1307211453450.19133-100000@netrider.rowland.org>
 <51ECDE5E.3050104@ti.com> <20130722150458.GA18181@kroah.com>
In-Reply-To: <20130722150458.GA18181@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On Monday 22 July 2013 08:34 PM, Greg KH wrote:
> On Mon, Jul 22, 2013 at 12:55:18PM +0530, Kishon Vijay Abraham I wrote:
>>> 	The issue (or one of the issues) in this discussion is that 
>>> 	Greg does not like the idea of using names or IDs to associate
>>> 	PHYs with controllers, because they are too prone to
>>> 	duplications or other errors.  Pointers are more reliable.
>>>
>>> 	But pointers to what?  Since the only data known to be 
>>> 	available to both the PHY driver and controller driver is the
>>> 	platform data, the obvious answer is a pointer to platform data
>>> 	(either for the PHY or for the controller, or maybe both).
>>
>> hmm.. it's not going to be simple though as the platform device for the PHY and
>> controller can be created in entirely different places. e.g., in some cases the
>> PHY device is a child of some mfd core device (the device will be created in
>> drivers/mfd) and the controller driver (usually) is created in board file. I
>> guess then we have to come up with something to share a pointer in two
>> different files.
> 
> What's wrong with using the platform_data structure that is unique to
> all boards (see include/platform_data/ for examples)?  Isn't that what
> this structure is there for?

Alright. I got some ideas from Alan Stern. I'll use it with platform_data and
repost the series.

Thanks
Kishon

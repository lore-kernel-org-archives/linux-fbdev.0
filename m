From: Alan Stern <stern@rowland.harvard.edu>
Date: Mon, 22 Jul 2013 14:44:39 +0000
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Message-Id: <Pine.LNX.4.44L0.1307221028440.1495-100000@iolanthe.rowland.org>
List-Id: <linux-fbdev.vger.kernel.org>
In-Reply-To: <51ECDE5E.3050104@ti.com>
References: <1374129984-765-2-git-send-email-kishon@ti.com>
In-Reply-To: <1374129984-765-2-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 22 Jul 2013, Kishon Vijay Abraham I wrote:

> > 	The PHY and the controller it is attached to are both physical
> > 	devices.
> > 
> > 	The connection between them is hardwired by the system
> > 	manufacturer and cannot be changed by software.
> > 
> > 	PHYs are generally described by fixed system-specific board
> > 	files or by Device Tree information.  Are they ever discovered
> > 	dynamically?
> 
> No. They are created just like any other platform devices are created.

Okay.  Are PHYs _always_ platform devices?

> > 	Is the same true for the controllers attached to the PHYs?
> > 	If not -- if both a PHY and a controller are discovered 
> > 	dynamically -- how does the kernel know whether they are 
> > 	connected to each other?
> 
> No differences here. Both PHY and controller will have dt information or hwmod
> data using which platform devices will be created.
> > 
> > 	The kernel needs to know which controller is attached to which
> > 	PHY.  Currently this information is represented by name or ID
> > 	strings embedded in platform data.
> 
> right. It's embedded in the platform data of the controller.

It must also be embedded in the PHY's platform data somehow.  
Otherwise, how would the kernel know which PHY to use?

> > 	The PHY's driver (the supplier) uses the platform data to 
> > 	construct a platform_device structure that represents the PHY.  
> 
> Currently the driver assigns static labels (corresponding to the label used in
> the platform data of the controller).
> > 	Until this is done, the controller's driver (the client) cannot 
> > 	use the PHY.
> 
> right.
> > 
> > 	Since there is no parent-child relation between the PHY and the 
> > 	controller, there is no guarantee that the PHY's driver will be
> > 	ready when the controller's driver wants to use it.  A deferred
> > 	probe may be needed.
> 
> right.
> > 
> > 	The issue (or one of the issues) in this discussion is that 
> > 	Greg does not like the idea of using names or IDs to associate
> > 	PHYs with controllers, because they are too prone to
> > 	duplications or other errors.  Pointers are more reliable.
> > 
> > 	But pointers to what?  Since the only data known to be 
> > 	available to both the PHY driver and controller driver is the
> > 	platform data, the obvious answer is a pointer to platform data
> > 	(either for the PHY or for the controller, or maybe both).
> 
> hmm.. it's not going to be simple though as the platform device for the PHY and
> controller can be created in entirely different places. e.g., in some cases the
> PHY device is a child of some mfd core device (the device will be created in
> drivers/mfd) and the controller driver (usually) is created in board file. I
> guess then we have to come up with something to share a pointer in two
> different files.

The ability for two different source files to share a pointer to a data 
item defined in a third source file has been around since long before 
the C language was invented.  :-)

In this case, it doesn't matter where the platform_device structures 
are created or where the driver source code is.  Let's take a simple 
example.  Suppose the system design includes a PHY named "foo".  Then 
the board file could contain:

struct phy_info { ... } phy_foo;
EXPORT_SYMBOL_GPL(phy_foo);

and a header file would contain:

extern struct phy_info phy_foo;

The PHY supplier could then call phy_create(&phy_foo), and the PHY 
client could call phy_find(&phy_foo).  Or something like that; make up 
your own structure tags and function names.

It's still possible to have conflicts, but now two PHYs with the same 
name (or a misspelled name somewhere) will cause an error at link time.

> > Probably some of the details above are wrong; please indicate where I
> > have gone astray.  Also, I'm not clear about the role played by various 
> > APIs.  For example, where does phy_create() fit into this picture?
> 
> phy_create is the API by which the PHY's driver (the supplier) hook into the
> PHY framework. It's like the controller driver will always interact with the
> PHY driver through the PHY framework.

Alan Stern


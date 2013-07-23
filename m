From: Alan Stern <stern@rowland.harvard.edu>
Date: Tue, 23 Jul 2013 21:14:20 +0000
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Message-Id: <Pine.LNX.4.44L0.1307231708020.1304-100000@iolanthe.rowland.org>
List-Id: <linux-fbdev.vger.kernel.org>
In-Reply-To: <1388978.Qc6sFy33oS@flatron>
References: <1374129984-765-2-git-send-email-kishon@ti.com>
In-Reply-To: <1374129984-765-2-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 23 Jul 2013, Tomasz Figa wrote:

> > If you want to keep the phy struct completely separate from the board
> > file, there's an easy way to do it.  Let's say the board file knows
> > about N different PHYs in the system.  Then you define an array of N
> > pointers to phys:
> > 
> > struct phy *(phy_address[N]);
> > 
> > In the platform data for both PHY j and its controller, store
> > &phy_address[j].  The PHY provider passes this cookie to phy_create:
> > 
> > 	cookie = pdev->dev.platform_data;
> > 	ret = phy_create(phy, cookie);
> > 
> > and phy_create simply stores: *cookie = phy.  The PHY consumer does
> > much the same the same thing:
> > 
> > 	cookie = pdev->dev.platform_data;
> > 	phy = phy_get(cookie);
> > 
> > phy_get returns *cookie if it isn't NULL, or an ERR_PTR otherwise.
> 
> OK, this can work. Again, just technically, because it's rather ugly.

There's no reason the phy_address things have to be arrays.  A separate
individual pointer for each PHY would work just as well.

> Where would you want to have those phy_address arrays stored? There are no 
> board files when booting with DT. Not even saying that you don't need to 
> use any hacky schemes like this when you have DT that nicely specifies 
> relations between devices.

If everybody agrees DT has a nice scheme for specifying relations
between devices, why not use that same scheme in the PHY core?

> Anyway, board file should not be considered as a method to exchange data 
> between drivers. It should be used only to pass data from it to drivers, 
> not the other way. Ideally all data in a board file should be marked as 
> const and __init and dropped after system initialization.

The phy_address things don't have to be defined or allocated in the 
board file; they could be set up along with the platform data.

In any case, this was simply meant to be a suggestion to show that it 
is relatively easy to do what you need without using name or ID 
strings.

Alan Stern


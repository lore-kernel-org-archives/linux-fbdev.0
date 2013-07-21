From: Alan Stern <stern@rowland.harvard.edu>
Date: Sun, 21 Jul 2013 02:32:26 +0000
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Message-Id: <Pine.LNX.4.44L0.1307202223430.8250-100000@netrider.rowland.org>
List-Id: <linux-fbdev.vger.kernel.org>
In-Reply-To: <20130720220006.GA7977@kroah.com>
References: <1374129984-765-2-git-send-email-kishon@ti.com>
In-Reply-To: <1374129984-765-2-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, 20 Jul 2013, Greg KH wrote:

> > >>That should be passed using platform data.
> > >
> > >Ick, don't pass strings around, pass pointers.  If you have platform
> > >data you can get to, then put the pointer there, don't use a "name".
> > 
> > I don't think I understood you here :-s We wont have phy pointer
> > when we create the device for the controller no?(it'll be done in
> > board file). Probably I'm missing something.
> 
> Why will you not have that pointer?  You can't rely on the "name" as the
> device id will not match up, so you should be able to rely on the
> pointer being in the structure that the board sets up, right?
> 
> Don't use names, especially as ids can, and will, change, that is going
> to cause big problems.  Use pointers, this is C, we are supposed to be
> doing that :)

Kishon, I think what Greg means is this:  The name you are using must
be stored somewhere in a data structure constructed by the board file,
right?  Or at least, associated with some data structure somehow.  
Otherwise the platform code wouldn't know which PHY hardware
corresponded to a particular name.

Greg's suggestion is that you store the address of that data structure 
in the platform data instead of storing the name string.  Have the 
consumer pass the data structure's address when it calls phy_create, 
instead of passing the name.  Then you don't have to worry about two 
PHYs accidentally ending up with the same name or any other similar 
problems.

Alan Stern


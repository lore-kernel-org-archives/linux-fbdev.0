From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 03 Sep 2013 15:50:30 +0000
Subject: Re: [PATCH v11 0/8] PHY framework
Message-Id: <20130903155030.GA21525@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1377063973-22044-1-git-send-email-kishon@ti.com>
 <521B0E79.6060506@ti.com> <20130827192059.GZ3005@radagast>
 <5225FF63.6080608@ti.com>
In-Reply-To: <5225FF63.6080608@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Sep 03, 2013 at 08:55:23PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> On Wednesday 28 August 2013 12:50 AM, Felipe Balbi wrote:
> > Hi,
> > 
> > On Mon, Aug 26, 2013 at 01:44:49PM +0530, Kishon Vijay Abraham I wrote:
> >> On Wednesday 21 August 2013 11:16 AM, Kishon Vijay Abraham I wrote:
> >>> Added a generic PHY framework that provides a set of APIs for the PHY drivers
> >>> to create/destroy a PHY and APIs for the PHY users to obtain a reference to
> >>> the PHY with or without using phandle.
> >>>
> >>> This framework will be of use only to devices that uses external PHY (PHY
> >>> functionality is not embedded within the controller).
> >>>
> >>> The intention of creating this framework is to bring the phy drivers spread
> >>> all over the Linux kernel to drivers/phy to increase code re-use and to
> >>> increase code maintainability.
> >>>
> >>> Comments to make PHY as bus wasn't done because PHY devices can be part of
> >>> other bus and making a same device attached to multiple bus leads to bad
> >>> design.
> >>>
> >>> If the PHY driver has to send notification on connect/disconnect, the PHY
> >>> driver should make use of the extcon framework. Using this susbsystem
> >>> to use extcon framwork will have to be analysed.
> >>>
> >>> You can find this patch series @
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git testing
> >>
> >> Looks like there are not further comments on this series. Can you take this in
> >> your misc tree?
> > 
> > Do you want me to queue these for you ? There are quite a few users for
> > this framework already and I know of at least 2 others which will show
> > up for v3.13.
> 
> Can you queue this patch series? There are quite a few users already for this
> framework.

It will have to wait for 3.13 as the merge window for new features has
been closed for a week or so.  Sorry, I'll queue this up after 3.12-rc1
is out.

greg k-h

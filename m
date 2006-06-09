From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2/5] VT binding: Add sysfs support
Date: Fri, 9 Jun 2006 15:08:03 -0700
Message-ID: <20060609220803.GB7636@suse.de>
References: <448933D7.6040301@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030553AbWFIWKh@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <448933D7.6040301@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Fri, Jun 09, 2006 at 04:39:51PM +0800, Antonino A. Daplas wrote:
> Add sysfs attributes for binding and unbinding VT console drivers. The
> attributes are located in /sys/class/tty/console and are namely:
> 
>     A. backend - list registered drivers in the following format:
> 
>     "I C: Description"

No, this violates the "one value per file" issue with sysfs.  How do you
know you will not overflow the buffer passed to you?

> 
>     Where: I  = ID number of the driver
>            C  = status of the driver which can be:
> 
> 		S = system driver
> 		B = bound modular driver
> 		U = unbound modular driver
> 
> 	   Description - text description of the driver
> 
>     B. bind - binds a driver to the console layer
> 
>        echo <ID> > /sys/class/tty/console/bind
> 
>     C. unbind - unbinds a driver from the console layer
> 
>        echo <ID> > /sys/class/tty/console/unbind
> 
> The tty layer does nothing to these attributes except create them and punt all
> requests to the VT layer.

Why is this needed?  What is wrong with the current scheme of binding
ttys to the console?

thanks,

greg k-h

From: "Christian Hoffmann" <email@christianhoffmann.info>
Subject: RE: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working onacer ferrari 4005 with radeonfb enabled
Date: Fri, 17 Nov 2006 23:02:34 +0100
Message-ID: <000701c70a94$1d9c2b40$6700a8c0@r2d2>
References: <1163800768.5826.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755961AbWKQWDA@vger.kernel.org>
In-Reply-To: <1163800768.5826.21.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Christian Hoffmann' <chrmhoffmann@gmail.com>
Cc: 'Stuffed Crust' <pizza@shaftnet.org>, "'Rafael J. Wysocki'" <rjw@sisk.pl>, linux-fbdev-devel@lists.sourceforge.net, 'Christian Hoffmann' <Christian.Hoffmann@wallstreetsystems.com>, 'Andrew Morton' <akpm@osdl.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Pavel Machek' <pavel@ucw.cz>

 

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org] 
> Sent: Friday, November 17, 2006 10:59 PM
> To: Christian Hoffmann
> Cc: Stuffed Crust; Rafael J. Wysocki; 
> linux-fbdev-devel@lists.sourceforge.net; Christian Hoffmann; 
> Andrew Morton; LKML; Pavel Machek
> Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume 
> not working onacer ferrari 4005 with radeonfb enabled
> 
> 
> > When I comment out the rinfo->asleep = 0; line, the machine comes 
> > back. So it seems that rinfo struct is still corrupted somehow.
> 
> No, I don't think the rinfo is corrupted, I think the chip is 
> in a state the driver can't cope with. Possibly related to 
> some PCI-Express specific bits or to the memory map.
> 
> At this point, we'll need to do register dumps.

Sorry, but how do I do that? 

Chris

BTW: yes, it's a PCI-express card.

-- 
No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.5.430 / Virus Database: 268.14.6/536 - Release Date: 11/16/2006
3:51 PM
 

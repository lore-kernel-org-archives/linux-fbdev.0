From: James Simmons <jsimmons@infradead.org>
Subject: Re: Newest fbdev patch to go mainline.
Date: Wed, 11 Feb 2004 15:53:37 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0402111553220.21250-100000@phoenix.infradead.org>
References: <20040210190413.A8470@infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040210190413.A8470@infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



I have patches coming later in the day today.


On Tue, 10 Feb 2004, Christoph Hellwig wrote:

> On Tue, Feb 10, 2004 at 05:49:52PM +0000, James Simmons wrote:
> > Thats coming :-) The problem only showes itself with modular drivers 
> > correct. So I will submit patches for those first. I just wanted to polish 
> > off a few really tiny patches fist.
> 
> You just copletly b0rked up lifetime rules.  Please revert the sysfs patch
> and add it back when all drivers are fixed.  
> 
> 

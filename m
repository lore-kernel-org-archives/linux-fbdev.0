From: James Simmons <jsimmons@infradead.org>
Subject: Re: [RFC] add class/video to fb drivers - Take 2
Date: Wed, 20 Aug 2003 22:16:13 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0308202044280.9662-100000@phoenix.infradead.org>
References: <20030820191001.GA4185@kroah.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030820191001.GA4185@kroah.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Ok, here's a smaller version of the patch, that doesn't break any fb
> drivers.  Only those that have a struct device associated with them
> should be changed (and that's just a 1 line addition).  I think it's
> much better because of this.

Nice :-) Will apply tonight. Do you have any issues still with this 
approach. You talked about the issue of dynamically creating the data. Is 
this probnlem still present in this patch.

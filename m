From: James Simmons <jsimmons@infradead.org>
Subject: Re: [RFC] add class/video to fb drivers - Take 2
Date: Wed, 20 Aug 2003 22:28:28 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0308202227490.9662-100000@phoenix.infradead.org>
References: <20030820212626.GA4854@kroah.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030820212626.GA4854@kroah.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Well, it's not "ideal" but it will do for 2.6 to use this patch.  If you
> look at the tty core, it's the same way that currently works.
> 
> Ideally in 2.7 I'd like to convert to have all fb drivers create the
> fb_info structure dynamically, but that's much to big of a change to do
> this late in the 2.6 development cycle.

What is the advantage of creating every fb_info dynamically?

From: James Simmons <jsimmons@infradead.org>
Subject: Re: [STATUS] fbdev api.
Date: Tue, 3 Dec 2002 14:18:59 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0212031417520.10097-100000@maxwell.earthlink.net>
References: <1038918094.1225.18.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1038918094.1225.18.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux console project <linuxconsole-dev@lists.sourceforge.net>


> Attached is a patch against linux-2.5.50 + your fbdev.diff.

Applied :-)

> b.  Another rewrite of fbcon_show_logo() so it's more understandable
> (hopefully).  I also added support for the rest of the visuals, but
> untested yet.
> Not tested:
> static psuedocolor, mono01, and mono10.

I have a mono hga card.

> c.  prevent fbcon module from loading if no fbdev is registered.  Also
> made fbcon module unsafe to unload (for now).  This is optional, of course.

It is a good idea until we have the ability to switch back to text mode.

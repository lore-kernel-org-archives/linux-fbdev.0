From: James Simmons <jsimmons@infradead.org>
Subject: Re: Why moving driver includes ?
Date: Wed, 2 Apr 2003 23:56:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0304022355170.3919-100000@phoenix.infradead.org>
References: <1048857524.12125.2.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1048857524.12125.2.camel@zion.wanadoo.fr>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

> Hi James !
> 
> Why did you move the driver includes to include/video ? What is 
> the reasoning here ?
> 
> For example, drivers/video/radeon.h moved to include/video/radeon.h
> 
> Is this to be able to share register definitions with the DRM drivers ?
> (I doubt this will ever happen as the DRM is rather self contained)

Yes. You never know. The other big reason was so userland could have a 
standard set of hardware header files to program graphics hardware. Now 
SDL and directfb etc can use the same header files.
 

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Framebuffer updates.
Date: 26 Mar 2003 14:16:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1048684571.10476.40.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.44.0303252049550.6228-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303252049550.6228-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Florin Iucha <florin@iucha.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-03-25 at 21:50, James Simmons wrote:

> Try using stty. I see most people will continue to use fbset so I guess I 
> need to patch it up to do the right thing.

Well, I don't like the fbdev magially picking modes like this,
those modes may just not be supported by the display. At least,
fbset allows me to setup the proper timings for 'special'
displays like iMac fixed hoziontal frequency for example.

Ultimately, we really need a "monitor" driver on top of the
fbdev that does DDC/EDID when the low level fbdev can provide
an i2c bus or EDID information via some different way and
that can be tweaked to deal with special monitors when we
know we are using these.

Ben.

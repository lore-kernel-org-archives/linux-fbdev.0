From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Sat, 29 Nov 2008 19:27:24 -0800
Message-ID: <200811291927.25364.david-b@pacbell.net>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com> <200811291447.29932.david-b@pacbell.net> <45a44e480811291504l30ed8101h9ab9b5333fb33f76@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756219AbYK3D1i@vger.kernel.org>
In-Reply-To: <45a44e480811291504l30ed8101h9ab9b5333fb33f76@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Saturday 29 November 2008, Jaya Kumar wrote:
> 	 Given that _bus() isn't appropriate anymore, how does
> "gpio_set_values" and .sets sound and correspondingly gpio_get_values
> and .gets?

Confusingly similar to the single value version:  a single letter.
Far better to use "bitmask" or something similar ...

... also, better to split out discussions of gpio_chip methods
(NOT used by all implementors of the GPIO interfaces) from the
discussion of those interfaces (implemented uniformly on all
platforms that support any of the calls).

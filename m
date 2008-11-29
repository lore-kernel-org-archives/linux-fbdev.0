From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Sun, 30 Nov 2008 07:04:52 +0800
Message-ID: <45a44e480811291504l30ed8101h9ab9b5333fb33f76@mail.gmail.com>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com>
	 <492D125D.5010607@teltonika.lt>
	 <45a44e480811260118v440716bbqa8d37c8b696c148a@mail.gmail.com>
	 <200811291447.29932.david-b@pacbell.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755347AbYK2XFH@vger.kernel.org>
In-Reply-To: <200811291447.29932.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: David Brownell <david-b@pacbell.net>
Cc: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, Nov 30, 2008 at 6:47 AM, David Brownell <david-b@pacbell.net> wrote:
>
> In terms of low level primitives, I've already commented
> that the "read" side is missing.  An additional issue came
> to mind:  the policy of using contiguous bits should not
> be mandated here.  It doesn't need to be, either ... just
> pass a mask of valid bits, along with a mask of values.
>

Agreed. Will implement read side. I think I agree with Eric and you on
the bitmask now. It should not add much complexity, I think. I'll work
on adding it. Given that _bus() isn't appropriate anymore, how does
"gpio_set_values" and .sets sound and correspondingly gpio_get_values
and .gets?

Thanks,
jaya

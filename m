From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Wed, 26 Nov 2008 09:20:51 +0800
Message-ID: <f17812d70811251720u47bec50dt3734f5b2bb0d339@mail.gmail.com>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752531AbYKZBVQ@vger.kernel.org>
In-Reply-To: <12276535632759-git-send-email-jayakumar.lkml@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>, David Brownell <david-b@pacbell.net>, Sam Ravnborg <sam@ravnborg.org>, Jean Delvare <khali@linux-fr.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, Nov 26, 2008 at 6:52 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> Beloved friends,
>
> I would like to request your feedback on the following idea. I hope I have
> made sure to CC all the right people and the right lists! If not, PLEASE
> let me know! I couldn't find a MAINTAINERS entry for gpiolib so I just
> used what I saw in the git log and have also added people and lists that
> I think may be interested.
>
> This is just an RFC. If you all feel it is looking like the right approach
> then I'll clean it up and make it a patch.
>
> Thanks,
> jaya
>
> am300epd was doing 800*600*16*gpio_set_value for each framebuffer transfer
> (it uses 16-pins of gpio as its data bus). I found this caused a wee
> performance limitation. This patch adds an API for gpio_set_value_bus
> which allows users to set batches of consecutive gpio together in a single
> call. I have done a test implementation on gumstix (pxa255) with am300epd
> and it provides a nice improvement in performance.

Using a bit mask will be more generic if the GPIOs are not contiguous.
Yet I still doubt this will be generic enough to be added to gpiolib.
The user of this gpio_set_value_bus() may assume too much about
the internal, e.g. how many GPIOs on the chip and whether these GPIOs
are contiguous or not, and whether this GPIO chip support bitwise
operations.

Let's have a concrete example: what if the user gives a bunch of GPIOs
that crosses the chip boundary, say, GPIO29 - GPIO35 (with each chip
covering 32 GPIOs).

From: Jamey Hicks <jamey.hicks@hp.com>
Subject: Re: Where is place of arch independed companion chips?
Date: Mon, 01 Aug 2005 08:29:35 -0400
Message-ID: <42EE15AF.5050902@hp.com>
References: <42EB6A12.70100@varma-el.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261820AbVHAMaA@vger.kernel.org>
In-Reply-To: <42EB6A12.70100@varma-el.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrey Volkov <avolkov@varma-el.com>
Cc: gregkh@suse.de, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Andrey Volkov wrote:

>Hi Greg,
>
>While I write driver for SM501 CC (which have graphics controller, USB
>MASTER/SLAVE, AC97, UART, SPI  and VIDEO CAPTURE onboard),
>I bumped with next ambiguity:
>Where is a place of this chip's Kconfig/drivers in
>kernel config/drivers tree? May be create new node in drivers subtree?
>Or put it under graphics node (since it's main function of this CC)?
>
>AFAIK, this is not one such multifunctional monster in the world, so
>somebody bumped with this problem again in future.
>
>  
>
Good question.  I was about to submit a patch that created 
drivers/platform because the toplevel driver for MQ11xx is a 
platform_device driver.  Any thoughts on this?

Jamey

From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] Where is place of arch independed companion
 chips?
Date: Sun, 31 Jul 2005 12:40:57 +0800
Message-ID: <42EC5659.7010300@gmail.com>
References: <42EB6A12.70100@varma-el.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261606AbVGaEkv@vger.kernel.org>
In-Reply-To: <42EB6A12.70100@varma-el.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org

Andrey Volkov wrote:
> Hi Greg,
> 
> While I write driver for SM501 CC (which have graphics controller, USB
> MASTER/SLAVE, AC97, UART, SPI  and VIDEO CAPTURE onboard),
> I bumped with next ambiguity:
> Where is a place of this chip's Kconfig/drivers in
> kernel config/drivers tree? May be create new node in drivers subtree?
> Or put it under graphics node (since it's main function of this CC)?

You will have to split your driver (graphics under drivers/video, usb
under drivers/usb, ac97 under sound, video capture under drivers/media,
etc.

Tony

From: Alexander Holler <holler@ahsoftware.de>
Date: Tue, 29 Jan 2013 15:51:48 +0000
Subject: Re: [PATCH 2/3 v2] fb: udlfb: fix hang at disconnect
Message-Id: <5107F014.4030704@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <50F2A310.5010006@ahsoftware.de> <1359139768-32294-1-git-send-email-holler@ahsoftware.de> <1359139768-32294-2-git-send-email-holler@ahsoftware.de> <20130128162238.7fba92fe.akpm@linux-foundation.org> <51071E21.9030008@ahsoftware.de> <5107A5ED.7020009@ahsoftware.de> <5107AE4F.9000809@ahsoftware.de>
In-Reply-To: <5107AE4F.9000809@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Bernie Thompson <bernie@plugable.com>, Steve Glendinning <steve.glendinning@shawell.net>, stable@vger.kernel.org

Am 29.01.2013 12:11, schrieb Alexander Holler:

>
> To explain the problem on shutdown a bit further, I think the following
> happens (usb and driver are statically linked and started by the kernel):
>
> shutdown -> kill signal -> usb stack shuts down -> udlfb waits (forever)
> for a kill or an urb which it doesn't get.

Having a second look at what I've written above, I'm not even sure if 
the kernel sends one or more fatal signals on shutdown at all. I've just 
assumed it because otherwise down_interruptible() wouldn't have worked 
before (it would have stalled on shutdown too (if an urb got missed), 
not only on disconnect).

Sounds like an interesting question I should read about (if/when fatal 
signals are issued by the kernel). ;)

> Maybe the sequence is different if the usb-stack and udlfb are used as a
> module and/or udlfb is used only for X/fb. I'm not sure what actually
> does shut down the usb-stack in such a case, but maybe more than one
> kill signal might be thrown around.

Regards,

Alexander

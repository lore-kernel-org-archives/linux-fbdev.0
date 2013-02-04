From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 04 Feb 2013 19:25:14 +0000
Subject: Re: [PATCH 2/3 v2] fb: udlfb: fix hang at disconnect
Message-Id: <20130204192514.GA32318@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359139768-32294-2-git-send-email-holler@ahsoftware.de>
 <20130128162238.7fba92fe.akpm@linux-foundation.org>
 <51071E21.9030008@ahsoftware.de>
 <5107A5ED.7020009@ahsoftware.de>
 <5107AE4F.9000809@ahsoftware.de>
 <5107F014.4030704@ahsoftware.de>
 <5108329E.2050802@ahsoftware.de>
 <20130204011413.GA6413@kroah.com>
 <510FA409.2080201@ahsoftware.de>
 <51100930.6080405@ahsoftware.de>
In-Reply-To: <51100930.6080405@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Holler <holler@ahsoftware.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Bernie Thompson <bernie@plugable.com>, Steve Glendinning <steve.glendinning@shawell.net>, stable@vger.kernel.org

On Mon, Feb 04, 2013 at 08:17:04PM +0100, Alexander Holler wrote:
> Am 04.02.2013 13:05, schrieb Alexander Holler:
> >Am 04.02.2013 02:14, schrieb Greg KH:
> >
> >>So you are right in that your driver will wait for forever for a
> >>disconnect() to happen, as it will never be called.  I don't understand
> >>the problem that this is causing when it happens.  What's wrong with
> >>udlfb that having the cpu suddently reset as the powerdown happened
> >>without it knowing about it?
> >
> >There is nothing wrong with that. I've just explained why a problem
> >doesn't occur on shutdown but on disconnect (of the device).
> 
> Maybe my explanation before was just to long and I try to explain it
> a bit shorter:
> 
> If a device gets disconnected, the disconnect in udlfb might wait
> forever in down_interruptible() (because it waits for an urb it
> never receives). This even prevents a shutdown afterwards, because
> that down_interruptible() never receives a signal (at shutdown,
> because kernel threads don't get such).

Where was that urb when the disconnect happened?  The USB core should
call your urb callback for any outstanding urbs at that point in time,
with the proper error flag being set, are you handling that properly?

thanks,

greg k-h

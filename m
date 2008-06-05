From: Vitaliy Ivanov <vitalivanov@gmail.com>
Subject: Re: [PATCH resend] Adding dummy release functions to avoid
	warnings.
Date: Thu, 05 Jun 2008 19:32:37 +0300
Message-ID: <1212683557.21310.32.camel@dell1.softservecom.com>
References: <1208306056.15140.13.camel@pcvitaliy>
	 <35fbaa3e0806050239y5987fc33rd349be8d07bc1262@mail.gmail.com>
	 <20080605090725.96da4b75.akpm@linux-foundation.org>
Reply-To: vitalivanov@gmail.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759466AbYFEQ66@vger.kernel.org>
In-Reply-To: <20080605090725.96da4b75.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: torvalds@linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, devzero@web.de, jsun@junsun.net, dwmw2@infradead.org, protasnb@gmail.com, linux-fbdev-devel@lists.sourceforge.net

Andrew,

On Thu, 2008-06-05 at 19:07, Andrew Morton wrote:
> On Thu, 5 Jun 2008 12:39:46 +0300 "Vitaliy Ivanov" <vitalivanov@gmail.com> wrote:
> > Trivial fix for #9690.
> > Added simple release functions that doing nothing.
> > Not sure whether we can leave it as is or to rework using
> > platform_device helpers like platform_device_alloc.
> 
> Please see Documentation/kobject.txt - search for the text
> "mocked mercilessly" :)
> 
> > This approach is used in many drivers.
> > --
> > 
> >  drivers/mtd/maps/physmap.c |    6 ++++++
> 
> Let's mock David too!

Damn. I knew that everything is not so easy here;) Got it. Tnx.

But in such case there are _again_ many drivers that do implement such
fake functions. Again is because when I tried to port some usb driver
there were issues with locking that was not correct but many drivers
worked exactly this incorrect way.

Anyway, tnx for clarifying this.

V.

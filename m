From: Risto Suominen <risto.suominen@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] fb: hide cursor in graphics mode
Date: Thu, 12 Feb 2009 23:12:26 +0200
Message-ID: <46e1c7760902121312o1476e734xc1fc1d6e11ce4d2e@mail.gmail.com>
References: <46e1c7760901230433i3045f273oa109ce97e790bca3@mail.gmail.com>
	 <Pine.LNX.4.64.0901240951110.13803@anakin>
	 <46e1c7760901240109m5a0f3a85p788aa3ce35b49fa9@mail.gmail.com>
	 <Pine.LNX.4.64.0901241425310.13803@anakin>
	 <46e1c7760901240649v1e45bbb1v8c9997f236a3ec4c@mail.gmail.com>
	 <46e1c7760902101337qe239336n9ef2652a47f89aed@mail.gmail.com>
	 <46e1c7760902101350r5a04d076j49cc611a843e6429@mail.gmail.com>
	 <20090211142409.b88c577e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759969AbZBLVMi@vger.kernel.org>
In-Reply-To: <20090211142409.b88c577e.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: geert@linux-m68k.org, adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Krzysztof Helt <krzysztof.h1@poczta.fm>

2009/2/12 Andrew Morton <akpm@linux-foundation.org>:
>> ---
>> The testing is done on kernel version 2.6.18.
>
> That's a truly ancient kernel.  Is the patch needed on current kernels?
> Does it work correctly in current kernels?
>
It does not on 2.6.24. The patch works.

> How does the cursor get re-enabled?
>
I have not thought of that.

> Should we be calling ops->cursor() if fbcon_is_inactive() is true?
>
Maybe we shouldn't, but we must. The situation is that we are ordered
to enter graphics mode and the variable saying 'graphics' is already
set in vt_ioctl.c. fbcon_is_inactive() tests it and returns true.

The question is, whether this function is called later during normal
operation, and how often?

Risto

From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH 04/16] viafb: Retain GEMODE reserved bits
Date: Fri, 09 Apr 2010 22:23:06 +0200
Message-ID: <4BBF8CAA.3090506@gmx.de>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>	<1270746946-12467-5-git-send-email-corbet@lwn.net>	<4BBE99F6.9060300@gmx.de> <20100409135959.381d819a@bike.lwn.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100409135959.381d819a@bike.lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

Hi Jon,

Jonathan Corbet schrieb:
> On Fri, 09 Apr 2010 05:07:34 +0200
> Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> 
>> in your later patch "[PATCH 06/16] viafb: complete support for 
>> VX800/VX855 accelerated framebuffer" you reintroduce initializing those 
>> bits to 0. That's fine but I can't see a reason for preserving this bits 
>> here as it adds useless overhead unless the hardware itself changed some 
>> of those bits and behaves differently according to those bits. 
> 
> Somehow the cost of an additional MMIO read at mode setting time is
> just not going to keep me up at night.

Well it's not only mode setting its for each hardware accelerated 
operation, but...

> I will admit that I've learned to be rather superstitious when it comes
> to messing with reserved bits.  Hardware designers like to hide
> functionality like "bring down the wrath of the gods" behind such
> bits.  The old code preserved them and worked, so I did the same.  I
> don't see any real reason not to keep it.

...if you insist on it its okay with me. I still disagree but its 
nothing I can't live with.

>> Additionally the first 2 bits are not reserved but provide a rotation 
>> where 00 is what we want (no rotation).
> 
> That much is true, yes.  My mistake, will fix.
> 
>> And if you rip code off hw_bitblt_2 it would be better to do the same 
>> with hw_bitblt_1. A quick look reveals that the same function can be 
>> used there (the error message would need to be adjusted but that's minor).
> 
> That had crossed my mind; there is quite a bit of duplicated code
> between those two very long functions.  At the time I was focused on
> making things work, and I didn't want to mess with code that I couldn't
> actually test.  So further cleanup is on my list, but I would prefer to
> defer it for a little bit.

The code (and the spec regarding the reserved bits also) is obviously 
identical so please don't ignore it. If you decide to put it in a 
separate function please do so for both blit engines especially if they 
really do the same as in this case. As you say they are mostly identical 
and that's by design. Please keep them in sync if possible. They exist 
that way to be a stateless and to avoid cluttering if's around.
(no need to say that I'll test those patches on my CLE266 and VX800 as 
soon as they apply cleanly to mainline)


Thanks,

Florian Tobias Schandinat

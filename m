From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH] fb: do not ignore fb_set_par errors
Date: Fri, 21 Aug 2009 19:42:09 +0200
Message-ID: <4A8EDC71.10403@gmx.de>
References: <1250769597-14861-1-git-send-email-FlorianSchandinat@gmx.de>	<1250769597-14861-2-git-send-email-FlorianSchandinat@gmx.de> <20090820153100.eec12070.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753447AbZHURlt@vger.kernel.org>
In-Reply-To: <20090820153100.eec12070.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Andrew Morton schrieb:
> On Thu, 20 Aug 2009 11:59:56 +0000
> Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> 
>> at the moment about half of the framebuffer drivers can return an error
>> code in fb_set_par. Until now it would be silently ignored by fbmem.c
>> and fbcon.c. The following patch fixes fbmem.c to pass it on but I have
>> no idea what the right behaviour in fbcon.c would look like.
>> Any comments?
> 
> Nobody really maintains this code any more and I don't know to whom
> your question should be addressed.  All I can suggest is that you
> decide what is the best path to take, and propose that we take it!  

Okay. I think it's difficult to ensure that we always end up with a 
working console. I assume that this is a very very rare case and as a 
start it should be enough to detect those cases and print an error message.

> Yes, it seems reasonable to me - if we ignore this the machine will
> probably crash later anyway.
> 
> A well-behaved driver should leave the hardware in an unchanged state
> if it's going to return an error (IMO).
> 
> Do you know of any bug reports which are due to this lack of checking?

No, I just hit the problem by thinking about how dynamic errors can be 
handled and looking at some drivers and fbmem.c.

> If you're concerned about the effects of this change, perhaps you
> should add a nice big printk when we decide to error out, so that it
> makes it easier for bug reporters (and responders!) to work out what
> happened?

That's a very good idea. Will add this too and resend the patch.


Thanks,

Florian Tobias Schandinat

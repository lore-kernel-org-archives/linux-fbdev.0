From: David Vrabel <dvrabel@arcom.com>
Subject: Re: [Linux-fbdev-devel] RFC: disallow modular framebuffers
Date: Wed, 02 Mar 2005 11:32:54 +0000
Message-ID: <4225A466.7030301@arcom.com>
References: <20050301024118.GF4021@stusta.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050301024118.GF4021@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> 
> Do modular framebuffers really make sense?

Yes.  e.g., on embedded systems you may not use the display hardware
(and would therefore like to save a bit of memory) but it's convenient
to have only one build of the kernel/modules.

> OK, distributions like to make everything modular, but all the 
> framebuffer drivers I've looked at parse driver specific options in 
> their *_setup function only in the non-modular case.

Not the (new) Geode framebuffer driver -- it uses regular module
parameters for this very reason.

> And most framebuffer drivers contain a module_exit function.
> Is there really any case where this is both reasonable and working?

It's useful for testing if nothing else.  True, the Geode framebuffer
driver won't restore the mode on unload but since the software VGA
emulation on a Geode is less than perfect[*] I would expect people to
not use vgacon and thus there's nothing really to restore.

David Vrabel

[*] I never did work out what happened to the cursor...
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

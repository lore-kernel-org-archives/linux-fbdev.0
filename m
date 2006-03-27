From: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: funny framebuffer fonts on PowerBook with radeonfb
Date: Sun, 26 Mar 2006 20:24:44 -0500
Message-ID: <200603262024.44737.dhazelton@enter.net>
References: <20060327004741.GA19187@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751242AbWC0BYf@vger.kernel.org>
In-Reply-To: <20060327004741.GA19187@MAIL.13thfloor.at>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel ML <linux-kernel@vger.kernel.org>

On Sunday 26 March 2006 19:47, Herbert Poetzl wrote:
> Hey Ben!
>
> 2.6.16 and 2.6.15-something show a funny behaviour
> when using the radeonfb driver (for text mode), they
> kind of twist and break the fonts in various places
> some characters or parts seem to be mirrored like
> '[' becoming ']' but not on character boundary but
> more on N pixels, colors seem to be correct for the
> characters, and sometimes the font is perfectly fine
> for larger runs, e.g. I can read the logon prompt
> fine, but everything I type is garbled ...
>
> just for an example, when I type 'echo "Test"' then
> all characters are mirrored and cut off on the right
> side but the locations are as shown above, on enter
> the T is only a few pixels wide, but the est part is
> written perfectly fine ... this is a new behaviour
> and going back to 2.6.13.3 doesn't show this ...
>
> if there is some testing I can do for you, or when
> you need more info, please let me know. here a few
> details for the machine:

I saw this on an PC with a Radeon 7000/VE that was slowly going bad. I'd 
recommend you run a full diagnostic on the video system memory (if possible) 
and look for errors there. If it isn't the memory (which was the problem on 
my Radeon) then the GPU itself might be going bad.

ShadowWolf

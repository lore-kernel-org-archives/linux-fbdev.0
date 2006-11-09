From: Andrew James Wade <andrew.j.wade@gmail.com>
Subject: Re: 2.6.19-rc4-mm2
Date: Thu, 9 Nov 2006 13:44:45 -0500
Message-ID: <200611091344.47145.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A05C@EXNA.corp.stratus.com>
Reply-To: andrew.j.wade@gmail.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753787AbWKISoy@vger.kernel.org>
In-Reply-To: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A05C@EXNA.corp.stratus.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
Cc: andrew.j.wade@gmail.com, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, Kimball Murray <kimball.murray@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

Hello Charlotte,

     I have just noticed that the garbled X-server mode is different
than what I thought it was. rinfo->depth is 24, but rinfo->bpp is 32.
(measured in radeon_write_mode). I haven't yet thought through the
implications of this. I've been unable to get the display correct, but
I've been trying to fix the wrong mode.
     The console mode is ->depth==8, ->bpp==8, and presumably the same
when it's garbled, but I've been unable to reproduce the problem since
instrumenting the kernel.

On Wednesday 08 November 2006 09:01, Richardson, Charlotte wrote:
> ... Do you think I should submit
> a patch that at least enables 24bpp for the chip I have where it
> definitely does work? I'm sure that is overly restrictive, but I don't
> know which ones work and which are broken at this point.

That sounds like a good idea to me, but I'm not very familiar with the
programming practices here.

...
> If you get a chance before I do, you might look at what Xfree86 does -
> they might have the workaround.

It looks like the X.org radeon driver doesn't support 24bpp.

-ajw

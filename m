From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [PATCH] Intel FB pixel clock calculation fix
Date: Tue, 11 Sep 2007 14:18:57 +0200
Message-ID: <m3veah75u6.fsf@maximus.localdomain>
References: <m3ir6il3wl.fsf@maximus.localdomain>
	<20070910225221.f0eaf22c.akpm@linux-foundation.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964856AbXIKMTW@vger.kernel.org>
In-Reply-To: <20070910225221.f0eaf22c.akpm@linux-foundation.org> (Andrew Morton's message of "Mon, 10 Sep 2007 22:52:21 -0700")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: sylvain.meyer@worldonline.fr, linux-kernel@vger.kernel.org, "Antonino A. Daplas" <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net

Andrew Morton <akpm@linux-foundation.org> writes:

>> Intel framebuffer mis-calculated pixel clocks.

> and... what are the consequences of this miscalculation?  I need to know
> such things so that I can decide whether a change is needed in 2.6.23.  And
> 2.6.22.

The pixel clock (and thus both H and V sync) will be slower than
requested, so if you set the minimum allowed the display may not
sync. In case of really old CRT display it could theoretically
damage it.

I'm using it with PAL TV (using RGB input - SCART connector) and
the bug prevented it from working at all (TV requirements are more
strict and made the bug visible).

I think 2.6.22 would be overkill, .23 - not sure.
-- 
Krzysztof Halasa

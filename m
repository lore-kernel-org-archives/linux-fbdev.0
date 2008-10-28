From: James Cloos <cloos@jhcloos.com>
Subject: Re: radeonfb lockup in .28-rc (bisected)
Date: Mon, 27 Oct 2008 21:50:57 -0400
Message-ID: <m3prllij1j.fsf@lugabout.jhcloos.org>
References: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
	<1225152347.8004.49.camel@pasglop>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752793AbYJ1BwD@vger.kernel.org>
In-Reply-To: <1225152347.8004.49.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Tue, 28 Oct 2008 11:05:47 +1100")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Krzysztof Halasa <khc@pm.waw.pl>, "David S. Miller" <davem@davemloft.net>, linux-fbdev-devel@lists.sourceforge.net

>>>>> "Benjamin" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

Benjamin> Annoying... Either I'm doing something wrong (which is always
Benjamin> possible) or we're hitting yet another fancy ATI bug (the M7
Benjamin> generation is known to be pretty bad in that area).

Yes, M7 does have its idiosyncrasies. :)

Benjamin> First, let's see if it's related to the imageblit. Can you
Benjamin> re-apply the reverted patch and apply this little hack on top
Benjamin> :

I'm starting a compile now.  It'll be a couple of hours until I can
reboot.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6

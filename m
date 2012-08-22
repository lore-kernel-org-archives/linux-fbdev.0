From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 22 Aug 2012 06:44:17 +0000
Subject: Re: [PATCHv3 3/9] serial: vt8500: Add devicetree support for
Message-Id: <201208220644.18059.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345582058-2291-1-git-send-email-linux@prisktech.co.nz>
 <20120821231255.71a7515a@pyramind.ukuu.org.uk>
 <1345617278.7491.4.camel@gitbox>
In-Reply-To: <1345617278.7491.4.camel@gitbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 22 August 2012, Tony Prisk wrote:
> The original patch was very simple, but I revisited it to fix other
> issues and forgot to add the relevant comments.
> 
> Port size is changed to fix a problem - WM8505 actually had 6 uart's
> defined in platform data but the vt8500_ports variable was only 4.
> 
> I have added devicetree port id support as well.

If you do multiple things in one driver, you should normally send multiple
patches as well, each with a description why that change is done.
It may seem silly at first to send out a one-line patch next to a 100-line
patch for the same file, but those cases are actually the ones where it's
most important.

	Arnd

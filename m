From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 10 Apr 2012 14:28:27 +0000
Subject: Re: [PATCH] video:uvesafb: Fix oops that uvesafb try to execute NX-protected page
Message-Id: <20120410152827.3fd489f6@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120327100136.GA3829@udknight>
	<20120327143243.015ecff6@pyramind.ukuu.org.uk>
	<20120328005238.GA3844@udknight>
	<20120401010530.GA4431@udknight>
	<20120410064918.GA7611@udknight>
In-Reply-To: <20120410064918.GA7611@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wang YanQing <udknight@gmail.com>
Cc: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, spock@gentoo.org

> Hi Alan, are you decided to not reply this any? 

I'm not aware of anythign that needs adding to this. Any logic about
whether PCI BIOS methods can be called belongs in the PCI layer, as does
the necessary logic for marking ROMs executable if asked by a driver.

uvesafb isn't the only user of PCI methods that may be affected and the
PCI layer is the place that should export the method to decide this.

That will also then work sanely cross platform - since in general on non
x86 boxes the method can simply return "no"

Alan

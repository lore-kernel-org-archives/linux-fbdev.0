From: James Simmons <jsimmons@infradead.org>
Subject: Re: Patch for review and testing
Date: Tue, 27 Jan 2004 22:59:26 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401272255180.19265-100000@phoenix.infradead.org>
References: <1075241846.5657.222.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlcB9-0004Ev-Au
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Jan 2004 14:59:31 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AlcB8-0001aQ-I0
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Jan 2004 14:59:30 -0800
In-Reply-To: <1075241846.5657.222.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>


> > Then I will remove it.
> 
> Not yet, not until the new version is in. It does work someway with the
> current code. Let me deal with those OF things please.

Sorry. I will leave this alone then. I posted it just case there where 
conflicts with peoples work here. I will wait to send that patch. 
 
> Actually, that may not be a good approach neither... You probably want
> to check that you are indeed dealing with the default VGA device so an
> additional card don't get an unrelated EDID, no ?
> 
> Also, other archs may want to implement this function too. Keep the
> struct device as an argument, check for bus_type before casting to PCI,
> and we should probably, in the x86 PCI code, "remember" the pci_dev of
> the default VGA (if not done already) and compare it on calls to this
> function. (To be completely clean, I also need to know if I'm the
> primary VGA in radeonfb and aty128fb).

I knew this was going to be more complex than I written.

> What about a cmdline option then ? it's too early during boot to check
> for it ? 

Yes. The code is run in real mode before linux is started. 

> vendors will build kernels with or without the CONFIG_ option,
> and people won't change it, so I'm afraid it will be useless... Is the
> BIOS call standard ? 

Yes it is standard. 

> There may be a way to workaround the hang, no ? Or
> it's one of those calls that Windows never uses and are broken in half
> of the BIOSes around ?

I don't know of any work arounds. Its a small precentage but I like to 
make life easier for people. 

P.S.
   Have any idea to know which card is the primary one on intel. I have 
been trying to figure that one out for quite some time.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

From: Jani Monoses <jani@iv.ro>
Subject: Re: Re: new api example or docs ?
Date: Mon, 5 Aug 2002 09:13:25 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020805091325.441ad7de.jani@iv.ro>
References: <20020801151812.GA392@iliana>
	<Pine.LNX.4.44.0208020845050.10247-100000@www.transvirtual.com>
	<20020802165435.GA7822@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iv.ro ([194.105.28.94])
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17bb7U-0000N2-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 04 Aug 2002 23:13:33 -0700
In-Reply-To: <20020802165435.GA7822@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Cc: jsimmons@transvirtual.com, luther@dpt-info.u-strasbg.fr, linux-fbdev-devel@lists.sourceforge.net


> > 
> > No skeletonfb is pretty much up to data. The driver to look at is the 3Dfx
> > driver. Its is the best new api driver.
> 
> Ok i will look at the 3Dfx driver.
I started porting tridentfb this weekend and to me too tdfx seemed the best example to use.

> But when i look at the neofb for example, but it is the same in
> matroxfb, i see that pci_register_driver is called with a structure
> containing the neofb_probe function, which is something absolutely not
> present in the skeletonfb.
that's unrelated to the new fb API.It's the 'new' PCI API which is in 2.4 too
and lets you detect the PCI cards your driver knows about without calling
pci_find_devices & co by instead supplying the probe/remove functions and a PCI id table.
It also help with power management..



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Patch for review and testing
Date: Wed, 28 Jan 2004 09:17:27 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1075241846.5657.222.camel@gaston>
References: <Pine.LNX.4.44.0401272159590.19265-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlbZa-0001Nn-N3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Jan 2004 14:20:42 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AlbZZ-0006U9-WA
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Jan 2004 14:20:42 -0800
In-Reply-To: <Pine.LNX.4.44.0401272159590.19265-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>

On Wed, 2004-01-28 at 09:09, James Simmons wrote:
> > > I like to submit this patch to linus today. Could you test it to see if it 
> > > works on ppcs. 
> > 
> > Well... you didn't update the drivers calling get_EDID_from_OF (I think
> > only rivafb at this point). 
> 
> The patch is against the vanilla tree. In the fbdev-2.5 tree I have to 
> update rivafb for this. Actually I will remove that code from rivafb. 
> 
> > Also, I plan to deprecate that function in
> > fbmon anyway, so don't bother, leave it alone for now. The way the
> > display/EDID infos are laid out in the OF device tree isn't that
> > generic and I'm considering letting each driver has its own version...
> 
> Then I will remove it.

Not yet, not until the new version is in. It does work someway with the
current code. Let me deal with those OF things please.

> That was to make the function generic. Well it doesn't matter as I'm going 
> to remove the OF function so the pci stuff can go away.

Actually, that may not be a good approach neither... You probably want
to check that you are indeed dealing with the default VGA device so an
additional card don't get an unrelated EDID, no ?

Also, other archs may want to implement this function too. Keep the
struct device as an argument, check for bus_type before casting to PCI,
and we should probably, in the x86 PCI code, "remember" the pci_dev of
the default VGA (if not done already) and compare it on calls to this
function. (To be completely clean, I also need to know if I'm the
primary VGA in radeonfb and aty128fb).
 
> > Finally, I don't see the point of submiting things to Linus at this
> > point, especially this patch which isn't critical (and you didn't even
> > submit driver changes for _using_ the new feature). 
> 
> Actually it is. The BIOS calls can hang some intel machines or make 
> booting  up to 5 seconds longer waiting for the data. If this was not the 
> case I wouldn't be submitting it.

What about a cmdline option then ? it's too early during boot to check
for it ? vendors will build kernels with or without the CONFIG_ option,
and people won't change it, so I'm afraid it will be useless... Is the
BIOS call standard ? There may be a way to workaround the hang, no ? Or
it's one of those calls that Windows never uses and are broken in half
of the BIOSes around ?

> > Andrew is the
> > maintainer of current 2.6.x stable, patches have to go to him first,
> > stage in -mm for a while to be tested, and then go to Linus.
> 
> This is just making the code conditional.  I will send another patch in a 
> minute then.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

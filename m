From: Sven LUTHER <luther@dpt-info.u-strasbg.fr>
Subject: Re: Re: new api example or docs ?
Date: Mon, 5 Aug 2002 10:04:11 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020805080411.GA1204@iliana>
References: <20020801151812.GA392@iliana> <Pine.LNX.4.44.0208020845050.10247-100000@www.transvirtual.com> <20020802165435.GA7822@iliana> <20020805091325.441ad7de.jani@iv.ro>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25] helo=mel-rto6.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17bdyj-0004st-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 05 Aug 2002 02:16:41 -0700
Content-Disposition: inline
In-Reply-To: <20020805091325.441ad7de.jani@iv.ro>
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
Content-Transfer-Encoding: 7bit
To: Jani Monoses <jani@iv.ro>
Cc: Sven LUTHER <luther@dpt-info.u-strasbg.fr>, jsimmons@transvirtual.com, linux-fbdev-devel@lists.sourceforge.net

On Mon, Aug 05, 2002 at 09:13:25AM +0000, Jani Monoses wrote:
> 
> > > 
> > > No skeletonfb is pretty much up to data. The driver to look at is the 3Dfx
> > > driver. Its is the best new api driver.
> > 
> > Ok i will look at the 3Dfx driver.
> I started porting tridentfb this weekend and to me too tdfx seemed the best example to use.

Ok (altough it seems romain will have a look at this, so i will probably
let him do it, since i am busy anyway).

> > But when i look at the neofb for example, but it is the same in
> > matroxfb, i see that pci_register_driver is called with a structure
> > containing the neofb_probe function, which is something absolutely not
> > present in the skeletonfb.
> that's unrelated to the new fb API.It's the 'new' PCI API which is in 2.4 too
> and lets you detect the PCI cards your driver knows about without calling
> pci_find_devices & co by instead supplying the probe/remove functions and a PCI id table.
> It also help with power management..

Well, but i thought the skeletonfb was to be used as a model/skeleton/guide
to creating a new framebuffer device.

So it should include this as well, should it not ?

Especially as there is no other documentation around.

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

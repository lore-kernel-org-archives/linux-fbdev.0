From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [ACPI] inappropriate use of in_atomic()
Date: Sat, 12 Mar 2005 11:22:54 +1100
Message-ID: <1110586974.5752.141.camel@gaston>
References: <20050310204006.48286d17.akpm@osdl.org>
	 <20050311091142.GB22415@fi.muni.cz> <20050311014601.166ae43d.akpm@osdl.org>
	 <1110543974.5809.98.camel@gaston>  <20050311161335.1e601da1.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050311161335.1e601da1.akpm@osdl.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, kas@fi.muni.cz, Paul Mackerras <paulus@samba.org>, jt@bougret.hpl.hp.com, javier@tudela.mad.ttd.net, acpi-devel@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net, roland@topspin.com, Linux Kernel list <linux-kernel@vger.kernel.org>

On Fri, 2005-03-11 at 16:13 -0800, Andrew Morton wrote:
> (where'd my cc go?)
> 
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > On Fri, 2005-03-11 at 01:46 -0800, Andrew Morton wrote:
> > > Jan Kasprzak <kas@fi.muni.cz> wrote:
> > > >
> > > > This may be the cause of 
> > > > 
> > > >  http://bugme.osdl.org/show_bug.cgi?id=4150
> > > 
> > > Looks that way, yes.
> > 
> > Note that it would be interesting to fix that (I mean the reliability of
> > is_atomic() or an alternative). I agree it's quite bad to rely on that
> > in practice, but there are a few corner cases where it's useful (like
> > oops handling in fbdev's etc...)
> > 
> 
> That would require that we increment current->something on every
> spin/read/write_lock and decrement it in unlock, even with !CONFIG_PREEMPT.
> 
> iirc, Anton added an option to do that to the ppc64 build, decoupled from
> CONFIG_PREEMPT (which ppc64 doesn't support).

ppc64 _does_ support PREEMPT nowadays :)

> But it's an appreciable amount of overhead.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

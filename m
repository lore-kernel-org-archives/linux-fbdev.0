From: Antonino Daplas <adaplas@pol.net>
Subject: Re: request_mem_region problem ...
Date: 31 Oct 2002 08:34:05 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1036024416.644.23.camel@daplas>
References: <20021030130016.GA1573@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1873Mf-0002yQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Oct 2002 16:39:13 -0800
In-Reply-To: <20021030130016.GA1573@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2002-10-30 at 21:00, Sven Luther wrote:
> Hello, ...
> 
> I have begun porting pm3fb to the new api, well, more exactly i am
> adapting tdfxfb to handle pm3 chips, and will port parts of pm3fb to it
> as i need them.
> 
> I have a problem when loading pm3fb as a module, and that is that
> request_mem_region fails. I know that pm3_fix.mmio_start and
> pm3_fix.mmio_len are correct, but request_mem_region still fails.
> 
> I am still searching the definition of request_mem_region in the source,
> but any help would be most welcome.
> 
> Note, this is with stock 2.5.44.
> 
Try doing a pci_enable_device() before request_mem_region, maybe that
will help.

> Also, if i register the framebuffer, without defining any of the
> fillrect, copyarea and imageblit functions (even the generic ones) i
> suppose it is normal i only get a black screen, isn't it ?
> 
Yes.

Tony




-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en

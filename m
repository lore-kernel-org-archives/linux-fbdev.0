From: Antonino Daplas <adaplas@pol.net>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
	2.5.5[45]
Date: 21 Jan 2003 08:08:06 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043106974.997.11.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301150042470.23774-100000@phoenix.infradead.org>
	<200301182028.33155.rfjak@eircom.net>
	<1042990390.1058.4.camel@localhost.localdomain> 
	<200301201909.10951.rfjak@eircom.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18am7A-0006f4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 20 Jan 2003 16:18:04 -0800
In-Reply-To: <200301201909.10951.rfjak@eircom.net>
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
To: Jak <rfjak@eircom.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-01-21 at 03:09, Jak wrote:
> 
> >  int __init rivafb_init(void)
> >  {
> > -	int err;
> > -	err = pci_module_init(&rivafb_driver);
> > -	if (err)
> > -		return err;
> > -	pci_register_driver(&rivafb_driver);
> > -	return 0;
> > +	return pci_module_init(&rivafb_driver);
> >  }
> >

Hmm, come to think of it, pci_module_init() is old-style.  Using

return (pci_register_driver(&rivafb_driver) > 0) ? 0 : -ENODEV;

instead is better and will allow the rivafb driver to appear in sysfs.
Anyway, pci_module_init() should not be called since
pci_register_driver() already does that for you.  That's what causing
the "Badness" in kobject.

Tony





-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en

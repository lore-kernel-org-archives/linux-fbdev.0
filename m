From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH][RFC] Add support for Epson S1D13806 FB
Date: Mon, 14 Mar 2005 21:13:57 +0800
Message-ID: <200503142113.57518.adaplas@hotpop.com>
References: <20050314130014.55A073658E8@mail.esiee.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DApOq-0008IF-Pt
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 05:14:24 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DApOp-0004ES-Cd
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 05:14:24 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 62EEAFAA297
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Mar 2005 13:14:02 +0000 (UTC)
In-Reply-To: <20050314130014.55A073658E8@mail.esiee.fr>
Content-Disposition: inline
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
To: Thibaut VARENE <varenet@esiee.fr>
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@pol.net>, Ben Dooks <ben-linux-arm@fluff.org>

On Monday 14 March 2005 21:00, Thibaut VARENE wrote:
> > 3. You can use pci_resource_len()/pci_resource_start() instead of
>
> Actually I don't think so: this chip is often found on embedded
> platforms that don't have PCI bus. Hence all the
> platform_device/platform_data glue in the driver. My understanding is
> that pci_resource_* macros are only available when CONFIG_PCI is
> enabled. As far as I can tell from the documentation, there's no PCI
> version of that chip family. That's also the reason why the Kconfig
> option only depends on CONFIG_FB.

Ok then.

>
> > No need, I'll take care of merging the driver.
>
> Thanks! Please let me know if the attached patch is suitable for
> inclusion into mainline :)
>

Should be okay. I'll push it to the mm tree first, and eventually, to
mainline.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

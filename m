From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 18/19] drivers/video: Use PCI_VDEVICE
Date: Fri, 26 Jun 2009 12:54:54 +0300
Message-ID: <20090626095454.GH9980@sci.fi>
References: <cover.1245906151.git.joe@perches.com>
	<198c226b3dfd003881e7f95b3fbbc8d433804b01.1245906153.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <syrjala@sci.fi>) id 1MK89C-0004aE-5w
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Jun 2009 09:55:06 +0000
Received: from smtp4.welho.com ([213.243.153.38])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MK897-0008MD-RR for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Jun 2009 09:55:03 +0000
Content-Disposition: inline
In-Reply-To: <198c226b3dfd003881e7f95b3fbbc8d433804b01.1245906153.git.joe@perches.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Joe Perches <joe@perches.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Winischhofer <thomas@winischhofer.net>, linux-kernel@vger.kernel.org, Petr Vandrovec <vandrove@vc.cvut.cz>, Paul Mackerras <paulus@samba.org>

On Wed, Jun 24, 2009 at 10:13:34PM -0700, Joe Perches wrote:
<snip>
> +	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_TS), rage_128_ultra },
> +	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_TT), rage_128_ultra },
> +	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_TU), rage_128_ultra },
>  	{ 0, }
>  };

Perhaps there should be a PCI_VDDEVICE() or something for this type of
stuff? Would make things even shorter.

Also PCI_VDEVICE() does not use named initializers for some reason.
Might be worth fixing.

It seems your script missed atyfb. It could use PCI_VDEVICE() too.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

---------------------------------------------------------------------------=
---

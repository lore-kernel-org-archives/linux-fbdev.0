From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] Fix colors in mach64 accelerator
Date: Wed, 17 Jun 2009 20:24:18 +0300
Message-ID: <20090617172418.GB9980@sci.fi>
References: <Pine.LNX.4.64.0906170559040.30231@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <syrjala@sci.fi>) id 1MGys8-0000pe-9D
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Jun 2009 17:24:28 +0000
Received: from smtp5.welho.com ([213.243.153.39])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MGys4-00029r-9a for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Jun 2009 17:24:28 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0906170559040.30231@hs20-bc2-1.build.redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, paulus@samba.org

On Wed, Jun 17, 2009 at 06:00:53AM -0400, Mikulas Patocka wrote:
> Use the same color-calculating algorithm as in atyfb_imageblit in this dr=
iver
> or in generic cfb_fillrect.
> =

> This patch fixes bad colors when using an accelerator in 15-bit and 16-bit
> modes.
> =

> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com

Acked-by: Ville Syrjala <syrjala@sci.fi>

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

---------------------------------------------------------------------------=
---
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing =

server and web deployment.
http://p.sf.net/sfu/businessobjects

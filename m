From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Fix 8bpp RGB fields length
Date: Mon, 2 Mar 2009 15:02:02 +0200
Message-ID: <20090302130202.GA6298@sci.fi>
References: <20090301215556.8631c63c.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <syrjala@sci.fi>) id 1Le7me-0003sl-OL
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Mar 2009 13:02:12 +0000
Received: from smtp4.welho.com ([213.243.153.38])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Le7mb-0005ma-Ea for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Mar 2009 13:02:12 +0000
Content-Disposition: inline
In-Reply-To: <20090301215556.8631c63c.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: spock@gentoo.org, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sun, Mar 01, 2009 at 09:55:56PM +0100, Krzysztof Helt wrote:
> Hi,
> =

> I found that some fbdev drivers set RGB field's lengths incorrectly
> to 6 bits. This is incorrect as the field's length says how many bits
> has a color index when using color palette (6 bits =3D 64 colors).

A slight omission in the fbdev API I suppose since the LUT entries are
nearly always 3*8bits wide. VGA being the exception.

> Fix this error in uvesafb by dropping DAC switching to 8 bits =

> completely. Advantage of this approach is making the driver shorter,
> disadvantage is that some color fidelity is lost.

I don't see much point in dropping this. It would reduce the image
quality and it looks like after your first fix this code would amount
to less than a dozen lines. But not my call anyway.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

---------------------------------------------------------------------------=
---
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H

From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] fbdev: workaround for broken X servers
Date: Thu, 4 Nov 2004 05:42:34 +0800
Message-ID: <200411040542.35912.adaplas@hotpop.com>
References: <1099448020.900.25.camel@gaston> <200411032109.29734.adaplas@hotpop.com> <20041103140110.GA4555@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPSvP-0007Cb-TM
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 13:44:15 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPSvO-0004I8-Vh
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 13:44:15 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id A402711A8C8D
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  3 Nov 2004 21:44:05 +0000 (UTC)
In-Reply-To: <20041103140110.GA4555@sci.fi>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net, Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>

On Wednesday 03 November 2004 22:01, Ville Syrj=E4l=E4 wrote:
> On Wed, Nov 03, 2004 at 09:09:29PM +0800, Antonino A. Daplas wrote:
> > On Wednesday 03 November 2004 11:26, Ville Syrj=E4l=E4 wrote:
> > > On Wed, Nov 03, 2004 at 01:13:39PM +1100, Benjamin Herrenschmidt wrot=
e:
> > > > Hi !

> > The above patch won't break console power management as the console cal=
ls
> > fbcon_blank(), not fb_blank().
>
> But fbcon_blank() calls fb_blank() does it not?

I just changed it so it doesn't.  It calls info->fbops->fb_blank().

Tony




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click

From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: latest patch for atyfb
Date: Sat, 16 Oct 2004 19:53:57 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410161953.57973.alex.kern@gmx.de>
References: <200410120024.50968.alex.kern@gmx.de> <20041016001551.GA6854@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIskj-0001Jm-Hc
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 16 Oct 2004 10:54:01 -0700
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CIski-0007oj-J3
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 16 Oct 2004 10:54:01 -0700
In-Reply-To: <20041016001551.GA6854@sci.fi>
Content-Disposition: inline
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
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

Am Samstag, 16. Oktober 2004 02:15 schrieb Ville Syrj=E4l=E4:
> On Tue, Oct 12, 2004 at 12:24:49AM +0200, Alexander Kern wrote:
> > Hi,
> > now against 2.6.9-rc3-mm2. Changed since latest; resync + mtrr patch fr=
om
> > Ville(doesn't work by me, but doesn't broke too).
>
> Do you mean that it should work (in theory) but doesn't?
No, I feel that on my machine I cannot see the difference, because
somebody (BIOS?) register 4 MB WriteCombining area before atyfb even starts.
Naturally add_mtrr(with whole memory, 8 MB) always failed.
Cheers
Alex


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

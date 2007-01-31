From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] matroxfb: another attempt to
	rectify jitter (G450/G550)
Date: Thu, 1 Feb 2007 00:25:00 +0200
Message-ID: <20070131222500.GA16283@sci.fi>
References: <45B55422.4070401@us.ibm.com> <45BC58E9.9020306@vandrovec.name>
	<45BFA90D.5050207@us.ibm.com> <20070131115430.GB5039@sci.fi>
	<45C110F3.10202@us.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HCO4l-00086B-QC for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 14:37:11 -0800
Received: from gw03.mail.saunalahti.fi ([195.197.172.111])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HCNt7-0007PG-35
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 14:25:10 -0800
Content-Disposition: inline
In-Reply-To: <45C110F3.10202@us.ibm.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Petr Vandrovec <petr@vandrovec.name>, jsimmons@infradead.org

On Wed, Jan 31, 2007 at 03:58:11PM -0600, Paul A. Clarke wrote:
> Ville Syrj=E4l=E4 wrote:
> > On Tue, Jan 30, 2007 at 02:22:37PM -0600, Paul A. Clarke wrote:
> > snip...
> >> +				/* DVI PLL preferred for frequencies up to panellink max, standar=
d PLL
> >> otherwise */
> >> +				if (fout >=3D MINFO->max_pixel_clock_panellink) tmp =3D 0;
> >> +				else tmp =3D
> >> +					M1064_XDVICLKCTRL_DVIDATAPATHSEL |
> >> +					M1064_XDVICLKCTRL_C1DVICLKSEL |
> >> +					M1064_XDVICLKCTRL_C1DVICLKEN |
> > =

> > Shouldn't this check which CRTC is driving the DVI?
> =

> If I read the code correctly, I don't see any way this code gets invoked =
for CRTC2.  __g450_setclk() is only called by =

> matroxfb_g450_setclk(), which is in turn called in 8 places:
> - 2 with pll =3D=3D M_VIDEO_PLL (a different case in the enclosing switch)
> - 1 with pll =3D=3D M_SYSTEM_PLL (a different case in the enclosing switc=
h)
> - 3 which if (m->crtc !=3D MATROXFB_SRC_CRTC1) then pll =3D=3D M_VIDEO_PLL
> - 2 with M_PIXEL_PLL_A and M_PIXEL_PLL_B (once each) at init time to set =
legacy VGA clocks with both CRTCs disabled

I see. It seems to always use VIDPLL with CRTC2. So if DVICLK is to be =

used with CRTC2 it apparently needs to be added in the VIDPLL case. =

Hmmm. I wonder if the code even supports CRTC2+DVI because the CRTC2 =

code seems to leave the C2PIXCLK selection to PCICLK if CRTC2 drives DVI =

only. Did you try to map CRTC2 to DVI?

Unfortunately I don't have a TFT so I can't actually test this stuff. =

Probably time to get one... :)

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642

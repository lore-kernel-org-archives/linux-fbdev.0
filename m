From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] matroxfb: another attempt to
	rectify jitter (G450/G550)
Date: Wed, 31 Jan 2007 13:54:30 +0200
Message-ID: <20070131115430.GB5039@sci.fi>
References: <45B55422.4070401@us.ibm.com> <45BC58E9.9020306@vandrovec.name>
	<45BFA90D.5050207@us.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HCE31-0001FD-BV for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 03:54:43 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HCE2w-0003Fo-R0
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 03:54:43 -0800
Content-Disposition: inline
In-Reply-To: <45BFA90D.5050207@us.ibm.com>
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

On Tue, Jan 30, 2007 at 02:22:37PM -0600, Paul A. Clarke wrote:
snip...
> +				/* DVI PLL preferred for frequencies up to panellink max, standard P=
LL
> otherwise */
> +				if (fout >=3D MINFO->max_pixel_clock_panellink) tmp =3D 0;
> +				else tmp =3D
> +					M1064_XDVICLKCTRL_DVIDATAPATHSEL |
> +					M1064_XDVICLKCTRL_C1DVICLKSEL |
> +					M1064_XDVICLKCTRL_C1DVICLKEN |

Shouldn't this check which CRTC is driving the DVI?

> +					M1064_XDVICLKCTRL_DVILOOPCTL |
> +					M1064_XDVICLKCTRL_P1LOOPBWDTCTL;
> +				matroxfb_DAC_out(PMINFO M1064_XDVICLKCTRL,tmp);
>    				matroxfb_DAC_out(PMINFO M1064_XPWRCTRL, xpwrctrl);
> =

>    				matroxfb_DAC_unlock_irqrestore(flags);
> =


-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV

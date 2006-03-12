From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Re: Re: atyfb, console, kernel 2.6.14 & Sony Vaio C1VE
Date: Mon, 13 Mar 2006 00:43:54 +0200
Message-ID: <20060312224354.GA1338@sci.fi>
References: <83d4769a9bceb571796228cb5c7534c3@csi.com> <20060303150123.GA27401@sci.fi> <60b1aebf4e1937a06ebff8cd92a8f4b3@csi.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FIZIA-0001F1-6D
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Mar 2006 14:44:02 -0800
Received: from gw03.mail.saunalahti.fi ([195.197.172.111])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FIZI8-0001xa-JE
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Mar 2006 14:44:02 -0800
Content-Disposition: inline
In-Reply-To: <60b1aebf4e1937a06ebff8cd92a8f4b3@csi.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Fractallyte <fractallyte@csi.com>

On Fri, Mar 03, 2006 at 07:04:24PM +0000, Fractallyte wrote:
>=20
> On 3 Mar 2006, at 15:01, Ville Syrj=E4l=E4 wrote:
>=20
> >>It's only *seems* to be a success...  The console is correctly set to
> >>128x30, however the timings are apparently not passed from the BIOS t=
o
> >>the console driver.  From this point on the screen becomes unreadable
> >>and unusable: white blooms from the edges and spreads inward.
> >
> >IIRC my OmniBook 500 did the same thing in the past. I don't remember
> >what (if anything) I did to fix it. I tried to fiddle around with the
> >BIOS 'video expansion' option and tried passing various modes to atyfb
> >but I just can't reproduce it.
> >
> >--=20
> >Ville Syrj=E4l=E4
> >syrjala@sci.fi
> >http://www.sci.fi/~syrjala/
>=20
> Unfortunately, the BIOS options on a Vaio C1VE are rather limited!  I'm=
=20
> still trying various atyfb options...

I was looking for the OB500 service manual and I stumbled on a HP forum=20
thread discussing similar problems. It seems the "screen going white"=20
problem may be caused by oxidation of the screen cable connectors.

Here is the full thread:
http://forums1.itrc.hp.com/service/forums/questionanswer.do?threadId=3D12=
1645

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

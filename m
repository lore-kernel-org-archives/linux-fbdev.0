From: Jim Hague <jim.hague@acm.org>
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Sat, 28 May 2005 11:46:22 +0100 (BST)
Message-ID: <XFMail.20050528114622.jim.hague@acm.org>
References: <Pine.LNX.4.60.0505280126280.22226@poirot.grange>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbyqA-0001G6-8I
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 May 2005 03:46:50 -0700
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Dbyq8-0001hP-N7
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 May 2005 03:46:50 -0700
In-Reply-To: <Pine.LNX.4.60.0505280126280.22226@poirot.grange>
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
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 27-May-2005 Guennadi Liakhovetski wrote:
>> On Wed, 25 May 2005, Andrew Morton wrote:
>> > Guys, did all these things get fixed up in 2.6.12-rc5?
>>=20
>> At least I don't see the fix we discussed with Jim included. I'll=20
>> test-boot tomorrow. Anyway, I seem to be the only one affected, and=20
>> switching CONFIG_FB_PM2_FIFO_DISCONNECT fixes the problem, so, maybe w=
e=20
>> could just mark this option "dangerous".
>>=20
>> Will (try to) add tomorrow.
>=20
> Confirmed - with CONFIG_FB_PM2_FIFO_DISCONNECT fb is still orange, with=
out=20
> - no problem.

Quick summary from my point of view: Guennadi is the only report of this
problem, though equally he's the only user I know with an Elsa AG GLoria
Synergy. I have not yet managed to work out why this could be happening; =
I had
expected that disabling the card reset that pm2fb does on initialisation =
would
fix matters, leaving the card at its BIOS initialised state. But it doesn=
't,
and sees to cause bad problems.

PM2_FIFO_DISCONNECT doesn't seem to me to bring much to the party. Since =
we now
have an example of it causing breakage, I agree with Guennadi that it sho=
uld be
marked 'dangerous'. I've been away from home/internet connection for some=
 time;
I'm back on Tuesday and I'll submit a patch to do that ASAP.

--=20
Jim Hague - jim.hague@acm.org          Never trust a computer you can't l=
ift.


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=3Doffad-ysdn-ostg-q22=
005

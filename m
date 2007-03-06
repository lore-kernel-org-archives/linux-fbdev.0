From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] atyfb: Replace busy loop with
	mdelay()
Date: Tue, 6 Mar 2007 02:29:43 +0200
Message-ID: <20070306002943.GA9193@sci.fi>
References: <20070222002033.GA26166@sci.fi>
	<20070305155318.23fff053.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HONZC-0003xd-Eq for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 16:30:10 -0800
Received: from gw03.mail.saunalahti.fi ([195.197.172.111])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HONZ8-0002id-Sk
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 16:30:10 -0800
Content-Disposition: inline
In-Reply-To: <20070305155318.23fff053.akpm@linux-foundation.org>
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
Cc: alex.kern@gmx.de, jsimmons@infradead.org, stable@kernel.org, adaplas@gmail.com

On Mon, Mar 05, 2007 at 03:53:18PM -0800, Andrew Morton wrote:
> @@ -614,7 +613,7 @@ static void aty_resume_pll_ct(const stru
>                  * helps for Rage Mobilities that sometimes crash when
>                  * we switch to sclk. (Daniel Mantione, 13-05-2003)
>                  */
> -               for (i=3D0;i<=3D0x1ffff;i++);
> +               udelay(500);

I'm not sure if 500 us is enough. The programmer's guide says you should =

allow 5 ms for the PLL to lock.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
